import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { BackendService } from '../backend.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [ReactiveFormsModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss'
})
export class LoginComponent {
  constructor(public backendService: BackendService, public router: Router) {

  }

  protected loginForm = new FormGroup({
    email: new FormControl('', [Validators.required, Validators.email]),
    password: new FormControl('', [Validators.required])
  })

  async onSubmit(){
    if(this.loginForm.valid){
      console.log(this.loginForm.value);
      const data = await this.backendService.login(this.loginForm.value.email!, this.loginForm.value.password!);
      console.log(data);
      localStorage.setItem('user', JSON.stringify(data));
      this.router.navigate(['/shop'])
    }
  }
}
