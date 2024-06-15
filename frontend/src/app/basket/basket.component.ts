import { Component, OnInit } from '@angular/core';
import { BasketService } from '../basket.service';
import { BackendService, Product } from '../backend.service';
import { RouterModule, RouterOutlet } from '@angular/router';
import { FormsModule } from '@angular/forms';

export interface ProductItem {
  product: Product;
  quantity: number;
}

@Component({
  selector: 'app-basket',
  standalone: true,
  imports: [RouterOutlet, RouterModule, FormsModule],
  templateUrl: './basket.component.html',
  styleUrl: './basket.component.scss'
})
export class BasketComponent implements OnInit {
  
  public products: ProductItem[] = []; 

  constructor(public basketService: BasketService,
     public backendService: BackendService) {

  }

  ngOnInit(): void {
    const ids = this.basketService.getAll();

    ids.forEach((x) => {
      this.backendService.getProduct(x.id)
        .then((product) => this.products.push({product: product, quantity: x.quantity}))
        .catch((err) => console.error(err));
    });
  }

  remove(product: ProductItem): void {
    this.products = this.products.filter((x) => x !== product);
    this.basketService.removeProduct(product.product.id);
  }

  decrementQuantity(product: ProductItem): void {
    if (product.quantity > 1) {
      product.quantity--;
    }
    else {
      this.remove(product);
    }
  }

  price(product: ProductItem): string {
    return (product.product.price * product.quantity).toFixed(2);
  }

  get totalSum(): string {
    const sum = this.products.reduce((acc, x) => acc + x.product.price * x.quantity, 0);
    return sum.toFixed(2);
  }

  incrementQuantity(product: ProductItem): void {
    product.quantity++;
  }

  checkout(): void {
    this.basketService.order(this.backendService.getId()!, this.products).then(() => this.products = []);
  }
}
