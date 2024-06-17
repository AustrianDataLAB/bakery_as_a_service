import { Component, OnInit } from '@angular/core';
import { BasketService, BasketItem } from '../basket.service';
import { BackendService, Product } from '../backend.service';
import { RouterModule, RouterOutlet } from '@angular/router';
import { FormsModule } from '@angular/forms';

import { environment } from '../../environments/environment';

export interface ProductItem {
  product: Product;
  quantity: number;
}

@Component({
  selector: 'app-basket',
  standalone: true,
  imports: [RouterOutlet, RouterModule, FormsModule],
  templateUrl: './basket.component.html',
  styleUrls: ['./basket.component.scss']
})
export class BasketComponent implements OnInit {
  public apiUrl = environment.API_URL;
  public products: ProductItem[] = [];

  constructor(public basketService: BasketService, public backendService: BackendService) {}

  async ngOnInit(): Promise<void> {
    const ids = this.basketService.loadFromLocalStorage();
    for (const x of ids) {
      try {
        const product = await this.backendService.getProduct(x.id);
        this.products.push({ product: product, quantity: x.quantity });
      } catch (err) {
        console.error(err);
      }
    }
  }

  remove(product: ProductItem): void {
    this.products = this.products.filter((x) => x !== product);
    this.basketService.removeProduct(product.product.id);
  }

  decrementQuantity(product: ProductItem): void {
    if (product.quantity > 1) {
      product.quantity--;
    } else {
      this.remove(product);
    }
    this.basketService.updateProducts(this.toBasketItems(this.products));
  }

  setQuantity(product: ProductItem, quantity: number): void {
    product.quantity = Math.max(quantity, 1);
    this.basketService.updateProducts(this.toBasketItems(this.products));
  }

  toBasketItems(products: ProductItem[]): BasketItem[] {
    return products.map((x) => ({ id: x.product.id, quantity: x.quantity }));
  }

  price(product: ProductItem): string {
    return (product.product.price * product.quantity).toFixed(2);
  }

  get totalSum(): string {
    return this.products.reduce((acc, x) => acc + x.product.price * x.quantity, 0).toFixed(2);
  }

  incrementQuantity(product: ProductItem): void {
    product.quantity++;
    this.basketService.updateProducts(this.toBasketItems(this.products));
  }

  async checkout(): Promise<void> {
    await this.basketService.order(this.backendService.getId()!, this.products);
    this.products = [];
  }
}