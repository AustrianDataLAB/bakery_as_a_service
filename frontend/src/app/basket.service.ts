import { Injectable } from '@angular/core';
import { Product } from './backend.service';

@Injectable({
  providedIn: 'root',
})
export class BasketService {
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

  clearAll(): void {
    this.replaceAll([]);
  }
}
