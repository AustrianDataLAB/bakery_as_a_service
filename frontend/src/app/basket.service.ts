import { Injectable } from '@angular/core';
import { BackendService, Order, OrderItem, Product } from './backend.service';
import { ProductItem } from './basket/basket.component';
import { BehaviorSubject } from 'rxjs';
import { Router } from '@angular/router';

export interface BasketItem {
  id: string;
  quantity: number;
}

@Injectable({
  providedIn: 'root',
})
export class BasketService {
  private basketItemsSource = new BehaviorSubject<BasketItem[]>(this.loadFromLocalStorage());
  public basketItems$ = this.basketItemsSource.asObservable();

  constructor(public backendService: BackendService, private router: Router) {
    this.basketItemsSource.next(this.loadFromLocalStorage());
  }

  loadFromLocalStorage(): BasketItem[] {
    const item = localStorage.getItem("products");
    return item ? JSON.parse(item) as BasketItem[] : [];
  }

  dumpToLocalStorage(): void {
    localStorage.setItem("products", JSON.stringify(this.basketItemsSource.getValue()));
  }

  updateProducts(value: BasketItem[]): void {
    this.basketItemsSource.next(value);
    this.dumpToLocalStorage();
  }

  addProduct(value: string, quantity: number): void {
    var products = this.basketItemsSource.getValue();
    const existingProductIndex = products.findIndex(product => product.id === value);
    if (existingProductIndex !== -1) {
      products[existingProductIndex].quantity += quantity;
    } else {
      products.push({ id: value, quantity: quantity });
    }
    this.updateProducts(products);
  }

  removeProduct(value: string): void {
    var products = this.basketItemsSource.getValue();
    var index = products.findIndex(product => product.id === value);
    if (index !== -1) {
      products.splice(index, 1);
      this.updateProducts(products);
    }
  }

  async order(customer_id: string, products: ProductItem[]): Promise<Order> {
    var items: any[] = [];

    products.forEach((x) => {
      items.push({
        id: undefined,
        // order_id: order.id!,
        quantity: x.quantity,
        price_per_item: x.product.price,
        product_id: x.product.id
      });
    });

    const order: Order = {
      id: undefined,
      customer_id: customer_id,
      status: "pending",
      total_price: products.reduce((sum, current) => sum + parseFloat(current.product.price + "") * current.quantity, 0),
      date_created: undefined,
    };

    const order_2 = await this.backendService.createOrder(order);
    console.log(order_2);
    this.backendService.createOrderItems(items.map((x_1) => {
      return { order_id: order_2.id!, ...x_1 };
    })).then((_items) => {
      this.clearAll();
    });

    order_2.status = "ordered";

    console.log(order_2);

    const updated_order = this.backendService.updateOrder(order_2);

    this.router.navigate([`/invoice/${order_2.id}`]);

    return updated_order;
  }

  clearAll(): void {
    this.updateProducts([]);
  }

  /**
   * if multiple products of the same kind have been added to the basket then sum the quantities
   */
  summarize(products: BasketItem[]): BasketItem[] {
    let hash: Map<string, number> = new Map();

    products.forEach((product) => {
      if (!hash.has(product.id)) {
        hash.set(product.id, 0);
      }

      hash.set(product.id, hash.get(product.id)! + product.quantity);
    });

    console.log(hash);

    return [...hash.keys()].map((x) => {
      return {
        id: x,
        quantity: hash.get(x)!
      };
    });
  }
}
