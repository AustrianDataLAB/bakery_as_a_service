import { Injectable } from '@angular/core';
import { BackendService, Order, OrderItem, Product } from './backend.service';
import { ProductItem } from './basket/basket.component';

export interface BasketItem {
  id: string;
  quantity: number;
}

@Injectable({
  providedIn: 'root',
})
export class BasketService {
  constructor(public backendService: BackendService) {

  }

  getAll(): BasketItem[] {
    const item = localStorage.getItem("products");

    return item ? JSON.parse(item) : [];
  }

  replaceAll(value: Product[]): void {
    localStorage.setItem("products", JSON.stringify(value.map((x) => x.id)));
  }

  replaceAllStrings(value: BasketItem[]): void {
    localStorage.setItem("products", JSON.stringify(value));
  }

  addProduct(value: string, quantity: number): void {
    var products = this.getAll();
    products.push({ id: value, quantity: quantity });
    products = this.summarise(products);
    this.replaceAllStrings(products);
  }

  removeProduct(value: string): void {
    const item = localStorage.getItem("products");
    var products: BasketItem[] = JSON.parse(item!);

    var index = -1;
    for (let i = 0; i < products.length; i++) {
      if (products[i].id == value) {
        index = i;
        break;
      }
    }

    products.splice(index, 1);

    localStorage.setItem("products", JSON.stringify(products));
  }

  order(customer_id: string, products: ProductItem[]): Promise<void> {
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
      status: "ordered",
      total_price: products.reduce((sum, current) => sum + parseFloat(current.product.price + "") * current.quantity, 0),
      date_created: undefined,
    };

    return this.backendService.createOrder(order)
      .then((order) => {
        console.log(order)
        this.backendService.createOrderItems(items.map((x) => {
          return { order_id: order.id!, ...x };
        })).then((_items) => {
          this.clearAll();
        });
      });
  }

  clearAll(): void {
    this.replaceAll([]);
  }

  /**
   * if multiple products of the same kind have been added to the basket then sum the quantities
   */
  summarise(products: BasketItem[]): BasketItem[] {
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
