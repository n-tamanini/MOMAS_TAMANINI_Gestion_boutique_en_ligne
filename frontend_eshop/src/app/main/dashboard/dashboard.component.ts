import { Component, OnInit } from '@angular/core';
import { ApiService, Categorie } from '../../api.service';
import { FuseConfigService } from '@fuse/services/config.service';


@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  categories:  Categorie[];
  //selectedPolicy:  Policy  = { id :  null , number:null, amount:  null};

  constructor
  (
    private apiService: ApiService,
    private _fuseConfigService: FuseConfigService,
) 
{
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
    this.apiService.readCategories().subscribe((categories: Categorie[])=>{
      this.categories = categories;
      console.log(this.categories);
    })
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
  
}