import { Component } from '@angular/core';
import { RouterModule, RouterOutlet } from '@angular/router';
import { BackendService } from './backend.service';
import { OnInit } from '@angular/core';
import { BasketService } from './basket.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, RouterModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent implements OnInit {

  isLoggedIn: boolean = false;
  productsInBasket: number = 0;

  constructor(private backendService: BackendService, private basketService: BasketService) { }

  ngOnInit() {
    this.backendService.loggedIn.subscribe((loggedIn) => {
      this.isLoggedIn = loggedIn;
    });

    this.basketService.basketItems$.subscribe((items) => {
      this.productsInBasket = items.length;
    });
  }

  logout() {
    this.backendService.logout();
  }
}
