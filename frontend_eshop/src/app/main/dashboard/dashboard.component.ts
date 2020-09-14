import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { fuseAnimations } from '@fuse/animations';
import { ApiService, Categorie, Couleur, Declinaison, Taille } from '../../api.service';
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
  tailles: Taille[];
  couleurs: Couleur[];

  selectedCategorie: Categorie;
  selectedTaille: Taille;
  selectedCouleur: Couleur;

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
      this.selectedCategorie = this.categories[0];
      console.log(this.categories);
    });

    this.apiService.getTailles().subscribe((tailles: Taille[]) => {
      this.tailles = tailles;
      this.selectedTaille = this.tailles[0];
      console.log(this.tailles);
    });

    this.apiService.getCouleurs().subscribe((couleurs: Couleur[]) => {
      this.couleurs = couleurs;
      this.selectedCouleur = this.couleurs[0];
      console.log(this.couleurs);
    });

    this.apiService.getDeclinaisons().subscribe((declinaisons: Declinaison[]) => {
      this.declinaisons = declinaisons;
      console.log(this.declinaisons);
    });


  }

  onCategorieSelection(index_categorie: number) {
    this.selectedCategorie = this.categories[index_categorie];
  }

  onTailleSelection(index_taille: number){
    this.selectedTaille = this.tailles[index_taille];
  }

  onCouleurSelection(index_couleur: number){
    this.selectedCouleur = this.couleurs[index_couleur];
  }
}


