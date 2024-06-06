import { Component, OnInit } from '@angular/core';
import { AlertService, Alert } from '../alert.service';
import { NgbAlertModule } from '@ng-bootstrap/ng-bootstrap';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-alert',
  imports: [NgbAlertModule, CommonModule],
  standalone: true,
  templateUrl: './alert.component.html',
  styleUrls: ['./alert.component.scss']
})
export class AlertComponent implements OnInit {
  alerts: Alert[] = [];

  constructor(private alertService: AlertService) {}

  ngOnInit(): void {
    this.alertService.alerts$.subscribe(alerts => {
      this.alerts = alerts;
    });
  }

  closeAlert(alert: Alert) {
    this.alertService.removeAlert(alert);
  }
}
