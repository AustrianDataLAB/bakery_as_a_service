import { Injectable } from '@angular/core';
import { createDirectus, rest, authentication, readItems, readItem, createItem, createItems } from '@directus/sdk';
import { BehaviorSubject } from 'rxjs';

export interface Product {
  id: string;
  name: string;
  description: string;
  price: number;
}

export interface Order {
  id: number | undefined;
  customer_id: string;
  status: string;
  total_price: number;
  date_created: Date | undefined;
}

export interface OrderItem {
  id: string | undefined;
  order_id: number;
  quantity: number;
  price_per_item: number;
  product_id: string;
}

interface Schema {
  Products: Product[];
  Orders: Order[];
  Order_Items: OrderItem[];
}

@Injectable({
  providedIn: 'root'
})
export class BackendService {
  client = createDirectus<Schema>('http://localhost:8055') //TODO: read from env
    .with(rest())
    .with(authentication());

  public loggedIn = new BehaviorSubject<boolean>(this.checkIfLoggedIn());

  get isLoggedIn() {
    return this.loggedIn.asObservable();
  }

  constructor() { }

  setAuth(): boolean {
    const auth = localStorage.getItem('user');

    if(auth != null) {
      const token = JSON.parse(auth)['access_token']; 
      this.client.setToken(token);
      return true;
    } 

    return false;
  }

  getId(): string | undefined {
      const auth = localStorage.getItem('user');

      if(auth != null) {
        return this.parseJwt(JSON.parse(auth)['access_token']).id; 
      } 

      return undefined;
    }

  parseJwt (token: string) {
    return JSON.parse(atob(token.split('.')[1]).toString());
  }

  async login(email: string, password: string) {
    const response = await this.client.login(email, password);
    
    localStorage.setItem('user', JSON.stringify(response));
    
    this.loggedIn.next(true);
    
    return response;
  }

  async logout() {
    this.client.logout();
    localStorage.removeItem('user');
    this.loggedIn.next(false);
  }

  checkIfLoggedIn(): boolean {
    const auth = localStorage.getItem('user');
    if (auth != null) {
      const token = JSON.parse(auth)['access_token'];
      const decodedToken = this.parseJwt(token);
      const currentTime = Math.floor(Date.now() / 1000); // Current time in seconds
      if (decodedToken.exp > currentTime) {
        return true; // Token is not expired
      }
    }
    return false; // No token or token is expired
  }

  async createOrder(order: Order): Promise<Order> {
    this.setAuth();
    return this.client.request(createItem( "Orders", order ));
  }

  async createOrderItems(orders: OrderItem[]): Promise<OrderItem[]> {
    this.setAuth();
    return this.client.request(createItems( "Order_Items", orders ));
  }

  async getAllProducts(): Promise<Product[]> {
    this.setAuth();
    return this.client.request(readItems("Products"));
  }

  async getProduct(id: string) : Promise<Product> {
    this.setAuth();
    return this.client.request(readItem("Products", id));
  }
}
