import { Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { ProductsComponent } from './products.component';
import { BasketComponent } from './basket/basket.component';

export const routes: Routes = [
    { path: '', redirectTo: '/login', pathMatch: 'full' },
    { path: 'login', component: LoginComponent },
    { path: 'shop', component: ProductsComponent },
    { path: 'cart', component: BasketComponent }
];
