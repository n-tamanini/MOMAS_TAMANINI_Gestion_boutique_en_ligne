import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DashboardComponent } from './dashboard.component';
import { MatIconModule } from '@angular/material';
import { MatButtonModule } from '@angular/material/button';
import { RouterModule } from '@angular/router';
import { MatMenuModule } from '@angular/material/menu';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from  '@angular/forms';
import { MatSelectModule } from '@angular/material/select';
import { FuseWidgetModule } from '@fuse/components/widget/widget.module';

const routes = [
  { path: 'dashboard', component: DashboardComponent }
];

@NgModule({

  declarations: [DashboardComponent],
  imports: [
    CommonModule,
    RouterModule.forChild(routes),
    HttpClientModule, 
    FormsModule,
    MatIconModule,
    MatMenuModule,
    MatSelectModule,
    MatButtonModule,
    FuseWidgetModule
  ]
})
export class DashboardModule { }
