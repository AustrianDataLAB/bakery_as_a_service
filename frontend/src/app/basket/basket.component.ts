import { Component, OnInit } from '@angular/core';
import { BasketService } from '../basket.service';
import { BackendService, Product } from '../backend.service';

@Component({
  selector: 'app-basket',
  standalone: true,
  imports: [],
  templateUrl: './basket.component.html',
  styleUrl: './basket.component.scss'
})
export class BasketComponent implements OnInit {
  products: Product[] = []; 

  constructor(public basketService: BasketService,
     public backendService: BackendService) {

  }

  ngOnInit(): void {
    const ids = this.basketService.getAll();

    ids.forEach((x) => {
      this.backendService.getProduct(x)
        .then((product) => this.products.push(product))
        .catch((err) => console.error(err));
    });
  }
}
