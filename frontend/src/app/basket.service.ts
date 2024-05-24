import { Injectable } from '@angular/core';
import { BackendService, Order, OrderItem, Product } from './backend.service';

@Injectable({
  providedIn: 'root',
})
export class BasketService {
  constructor(public backendService: BackendService) {

  }

  getAll(): string[] {
      const item = localStorage.getItem("products");

      return item ? JSON.parse(item) : []; 
  }

  replaceAll(value: Product[]): void {
    localStorage.setItem("products", JSON.stringify(value.map((x) => x.id)));
  }

  replaceAllStrings(value: string[]): void {
    localStorage.setItem("products", JSON.stringify(value));
  }

  addProduct(value: string): void {
    var products = this.getAll();
    products.push(value);
    this.replaceAllStrings(products);
  }

  removeProduct(value: string): void {
    const item = localStorage.getItem("products");
    var products = JSON.parse(item!);

    const index = products.indexOf(value);
    products.splice(index, 1);

    localStorage.setItem("products", JSON.stringify(products));
  }

  order(customer_id: string, products: Product[]): void {
    const order: Order = {
      id: undefined,
      customer_id: customer_id,
      status: "ordered",
      total_price: products.reduce((sum, current) => sum + parseFloat(current.price + ""), 0),
      date_created: undefined,
    };

    var items: OrderItem[] = [];

    this.backendService.createOrder(order)
      .then((order) => {
        console.log(order)

        products.forEach((product) => {
          items.push({
            id: undefined,
            order_id: order.id!,
            quantity: 1,
            price_per_item: product.price,
            product_id: product.id
          });
        });

        this.backendService.createOrderItems(items)
    });
  }

  clearAll(): void {
    this.replaceAll([]);
  }
}
