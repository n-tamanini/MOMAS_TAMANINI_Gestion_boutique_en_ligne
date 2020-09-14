import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { fuseAnimations } from '@fuse/animations';
import { ApiService, Categorie, Declinaison } from '../../api.service';
import { FuseConfigService } from '@fuse/services/config.service';


@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
  animations: fuseAnimations,
  encapsulation: ViewEncapsulation.None
})
export class DashboardComponent implements OnInit {

  categories: Categorie[];
  declinaisons: Declinaison[];

  constructor
    (
      private apiService: ApiService,
      private _fuseConfigService: FuseConfigService,
  ) {
    // Configure the layout
    this._fuseConfigService.config = {
      layout: {
        navbar: {
          hidden: false
        },
        toolbar: {
          hidden: true
        },
        footer: {
          hidden: true
        },
        sidepanel: {
          hidden: true
        }
      }
    };
  }

  ngOnInit() {
    this.apiService.getCategories().subscribe((categories: Categorie[]) => {
      this.categories = categories;
      console.log(this.categories);
    });

    this.apiService.getDeclinaisons().subscribe((declinaisons: Declinaison[]) => {
      this.declinaisons = declinaisons;
      console.log(this.declinaisons);
    });
  }
}






/*
  createOrUpdatePolicy(form){
    if(this.selectedPolicy && this.selectedPolicy.id){
      form.value.id = this.selectedPolicy.id;
      this.apiService.updatePolicy(form.value).subscribe((policy: Policy)=>{
        console.log("Policy updated" , policy);
      });
    }
    else{

      this.apiService.createPolicy(form.value).subscribe((policy: Policy)=>{
        console.log("Policy created, ", policy);
      });
    }

  }

  selectPolicy(policy: Policy){
    this.selectedPolicy = policy;
  }

  deletePolicy(id){
    this.apiService.deletePolicy(id).subscribe((policy: Policy)=>{
      console.log("Policy deleted, ", policy);
    });
  }
*/

