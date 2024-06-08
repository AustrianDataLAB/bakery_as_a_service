import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { BackendService } from '../backend.service';
import { Router } from '@angular/router';
import { AlertService } from '../alert.service';
import { AlertComponent } from "../alert/alert.component";
import { CommonModule } from '@angular/common';

interface ErrorResponse {
  errors: Array<{
    message: string;
    extensions: {
      code: string;
    };
  }>;
  response: {};
}

@Component({
    selector: 'app-login',
    standalone: true,
    templateUrl: './login.component.html',
    styleUrl: './login.component.scss',
    imports: [ReactiveFormsModule, AlertComponent, CommonModule]
})
export class LoginComponent {
  constructor(public backendService: BackendService, public router: Router, public alertService: AlertService) {

  }

  protected loginForm = new FormGroup({
    email: new FormControl('', [Validators.required, Validators.email]),
    password: new FormControl('', [Validators.required])
  })

  showDangerAlert(message: string) {
    this.alertService.showAlert({
      message: `<strong>Error!</strong> ${message}`,
      type: 'danger',
      icon: '<i class="bi bi-exclamation-triangle-fill"></i>',
      timeout: 5000
    });
  }

  async onSubmit(){
    if (this.loginForm.valid)
    {
      console.log(this.loginForm.value);
      try {
        const data = await this.backendService.login(this.loginForm.value.email!, this.loginForm.value.password!);
        console.log(data);
        localStorage.setItem('user', JSON.stringify(data));
        this.router.navigateByUrl('/shop')
      }
      catch (error) {
        // converting the error of type unknown to ErrorResponse in order to access the error message
        const errorResponse = error as ErrorResponse;
        const errorMessage = errorResponse.errors?.[0]?.message || 'An unknown error occurred.';
        this.showDangerAlert(errorMessage);
      }
      

    }
    else
    {
      this.showDangerAlert('Invalid form data. Please check your email and password.');
    }
  }
}
