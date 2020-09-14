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
    /*
    createPolicy(policy: Policy): Observable<Policy> {
        return this.httpClient.post<Policy>(`${this.PHP_API_SERVER}/create.php`, policy);
    }

    updatePolicy(policy: Policy) {
        return this.httpClient.put<Policy>(`${this.PHP_API_SERVER}/update.php`, policy);
    }

    deletePolicy(id: number) {
        return this.httpClient.delete<Policy>(`${this.PHP_API_SERVER}/delete.php/?id=${id}`);
    }
    */

}

export class Categorie {
    id_categorie: number;
    nom_categorie: string;
}

export class Declinaison {
    id_declinaison: number;
    id_couleur: number;
    id_vetement: number;
    id_taille: number;
    prix_declinaison: number;
    quantite_declinaison: number;

}





