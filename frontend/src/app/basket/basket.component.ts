import { Component, OnInit } from '@angular/core';
import { BasketService } from '../basket.service';
import { BackendService, Product } from '../backend.service';
import { RouterModule, RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-basket',
  standalone: true,
  imports: [RouterOutlet, RouterModule],
  templateUrl: './basket.component.html',
  styleUrl: './basket.component.scss'
})
export class BasketComponent implements OnInit {
  public products: Product[] = []; 

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
