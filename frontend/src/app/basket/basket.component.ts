import { Component, OnInit } from '@angular/core';
import { BasketService } from '../basket.service';
import { BackendService, Product } from '../backend.service';
import { RouterModule, RouterOutlet } from '@angular/router';

export interface ProductItem {
  product: Product;
  quantity: number;
}

@Component({
  selector: 'app-basket',
  standalone: true,
  imports: [RouterOutlet, RouterModule],
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

  checkout(): void {
    this.basketService.order(this.backendService.getId()!, this.products).then(() => this.products = []);
  }
}
