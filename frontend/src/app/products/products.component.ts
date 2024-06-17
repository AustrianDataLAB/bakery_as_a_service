import { Component, OnInit } from '@angular/core';
import { RouterModule, RouterOutlet } from '@angular/router';
import { BackendService, Product } from '../backend.service';
import { BasketService } from '../basket.service';

import { environment } from '../../environments/environment';

@Component({
  selector: 'products-root',
  standalone: true,
  imports: [RouterOutlet, RouterModule],
  templateUrl: './products.component.html',
  styleUrl: './products.component.scss'
})
export class ProductsComponent implements OnInit {
  public apiUrl = environment.API_URL;
  public products: Product[] = [];

  constructor(public backendService: BackendService, public basketService: BasketService) {
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
