import { Injectable } from '@angular/core';
import { createDirectus, rest, authentication, readItems, readItem } from '@directus/sdk';

export interface Product {
  id: string;
  name: string;
  description: string;
  price: number;
}

interface Schema {
  products: Product[];
}

@Injectable({
  providedIn: 'root'
})
export class BackendService {
  client = createDirectus<Schema>('http://localhost:8055') //TODO: read from env
    .with(rest())
    .with(authentication());

  constructor() { }

  async login(email: string, password: string) {
    return this.client.login(email, password);
  }

  async getAllProducts(): Promise<Product[]> {
    return this.client.request(readItems('products'));
  }

  async getProduct(id: string) : Promise<Product> {
    return this.client.request(readItem('products', id));
  }
}
