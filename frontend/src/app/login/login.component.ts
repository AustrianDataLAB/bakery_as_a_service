import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { BackendService } from '../backend.service';
import { Router } from '@angular/router';
import { AlertService } from '../alert.service';
import { AlertComponent } from "../alert/alert.component";
import { CommonModule } from '@angular/common';

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

  showSuccessAlert() {
    this.alertService.showAlert({
      message: '<strong>Success!</strong> This is a success alert with an icon.',
      type: 'success',
      icon: '<i class="bi bi-check-circle"></i>',
      timeout: 3000
    });
  }

  showDangerAlert() {
    this.alertService.showAlert({
      message: '<strong>Error!</strong> Form is not valid!',
      type: 'danger',
      icon: '<i class="bi bi-exclamation-triangle-fill"></i>',
      timeout: 5000
    });
  }

  async onSubmit(){
    if(this.loginForm.valid){
      console.log(this.loginForm.value);
      const data = await this.backendService.login(this.loginForm.value.email!, this.loginForm.value.password!);
      console.log(data);
      localStorage.setItem('user', JSON.stringify(data));
      this.router.navigateByUrl('/shop')
    }
    else{
      console.log('Form is invalid');
      this.showDangerAlert();
    }
  }
}
