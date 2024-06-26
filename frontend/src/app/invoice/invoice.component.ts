import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { BackendService, Invoice} from '../backend.service';
import { interval, from, of } from 'rxjs';
import { catchError, switchMap, takeWhile } from 'rxjs/operators';
import { ChangeDetectorRef } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';

@Component({
  selector: 'app-invoice',
  standalone: true,
  imports: [],
  templateUrl: './invoice.component.html',
  styleUrl: './invoice.component.scss'
})
export class InvoiceComponent implements OnInit{
  loading = true;
  invoice: Invoice | undefined;
  safePdfUrl: SafeResourceUrl | undefined;

  constructor(private route: ActivatedRoute, public backendService: BackendService, private cdr: ChangeDetectorRef,     private sanitizer: DomSanitizer) { }
  
  ngOnInit(): void {
    const invoiceId = this.route.snapshot.paramMap.get('id');

    if (invoiceId) {
      interval(1000).pipe(
        switchMap(() => from(this.backendService.getInvoice(invoiceId)).pipe(
          catchError((error) => {
            if (error.status === 404) {
              return of(null); // If error is 404, return null to keep polling
            }
            throw error; // If other error, rethrow to stop polling
          })
        )),
        takeWhile((invoice: Invoice | null) => {
          if (invoice) {
            console.log(invoice);
            this.invoice = invoice;
            this.loading = false;
            this.safePdfUrl = this.sanitizer.bypassSecurityTrustResourceUrl(`data:application/pdf;base64,${invoice.document}`);
            this.cdr.detectChanges();
            return false; // Stop polling
          }
          return true; // Continue polling
        })
      ).subscribe();
    }
  }
}
