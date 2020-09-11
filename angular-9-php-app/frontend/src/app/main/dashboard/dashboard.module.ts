import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DashboardComponent } from './dashboard.component';
import { RouterModule } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from  '@angular/forms';

const routes = [
  { path: 'dashboard', component: DashboardComponent }
];

@NgModule({

  declarations: [DashboardComponent],
  imports: [
    CommonModule,
    RouterModule.forChild(routes),
    HttpClientModule, 
    FormsModule
  ]
})
export class DashboardModule { }
