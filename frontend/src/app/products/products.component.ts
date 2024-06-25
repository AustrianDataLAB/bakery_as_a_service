import {Component, Inject, OnInit} from '@angular/core';
import { RouterModule, RouterOutlet } from '@angular/router';
import { BackendService, Product } from '../backend.service';
import { BasketService } from '../basket.service';

import {Config, CONFIG_TOKEN} from "../config/config";

@Component({
  selector: 'products-root',
  standalone: true,
  imports: [RouterOutlet, RouterModule],
  templateUrl: './products.component.html',
  styleUrl: './products.component.scss'
})
export class ProductsComponent implements OnInit {
  public apiUrl = this.config.apiUrl;
  public products: Product[] = [];

  constructor(public backendService: BackendService, public basketService: BasketService,
              @Inject(CONFIG_TOKEN) private readonly config: Config) {
  }

  ngOnInit(): void {
    this.backendService.getAllProducts()
      .then((products) => {
        this.products = products;
        console.log(products);
      })
      .catch((err) => console.error(err));
  }

  add(product: Product, quantity: number, event: MouseEvent): void {
    const button = event.target as HTMLElement;
    button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>';

    setTimeout(() => {
      button.innerHTML = '<i class="bi bi-cart-plus"></i> Add to cart';
    }, 200);

    this.basketService.addProduct(product.id, quantity);
  }
}
