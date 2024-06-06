import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

export interface Alert {
  type: string;
  message: string;
  icon?: string;
  timeout?: number;
}

@Injectable({
  providedIn: 'root'
})
export class AlertService {
  private alertSubject = new BehaviorSubject<Alert[]>([]);
  alerts$ = this.alertSubject.asObservable();

  private alerts: Alert[] = [];

  constructor() {}

  showAlert(alert: Alert) {
    this.alerts.push(alert);
    this.alertSubject.next(this.alerts);
    if (alert.timeout) {
      setTimeout(() => this.removeAlert(alert), alert.timeout);
    }
  }

  removeAlert(alert: Alert) {
    setTimeout(() => {
      this.alerts = this.alerts.filter(a => a !== alert);
      this.alertSubject.next(this.alerts);
    }, 300); // Adjust the delay to match the CSS transition duration if any
  }
}
