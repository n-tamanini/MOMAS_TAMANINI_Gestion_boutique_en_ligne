import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
    providedIn: 'root'
})
export class ApiService {
    PHP_API_SERVER = "http://localhost/backend_eshop";

    constructor(private httpClient: HttpClient) { }

    getCategories(): Observable<Categorie[]> {
        return this.httpClient.get<Categorie[]>(`${this.PHP_API_SERVER}/categorie.php`);
    }

    getDeclinaisons(): Observable<Declinaison[]> {
        return this.httpClient.get<Declinaison[]>(`${this.PHP_API_SERVER}/declinaison/all.php`);
    }

    getTailles(): Observable<Taille[]> {
        return this.httpClient.get<Taille[]>(`${this.PHP_API_SERVER}/taille/all.php`);
    }

    getCouleurs(): Observable<Couleur[]> {
        return this.httpClient.get<Couleur[]>(`${this.PHP_API_SERVER}/couleur/all.php`);
    }
}

export class Categorie {
    id_categorie: number;
    nom_categorie: string;
}

export class Taille {
    id_taille: number;
    nom_taille: string;
}

export class Couleur {
    id_couleur: number;
    nom_couleur: string;
}

export class Declinaison {
    id_declinaison: number;
    couleur: {
        id_couleur:number;
        nom_couleur:string;
    }
    vetement: {
        id_vetement: number;
        nom_vetement: string;
        description_vetement: string;
        categorie: {
            id_categorie:number;
            nom_categorie:string;
        }
    }
    taille: {
        id_taille:number;
        nom_taille:string;
    }
    id_vetement: number;
    prix_declinaison: number;
    quantite_declinaison: number;
}







