/*REQUETES DE MISE A JOUR*/

-- 2 requêtes impliquant 1 table :

-- Réduction de 10% sur tous les vêtements
UPDATE declinaison_vetement SET prix_declinaison =  prix_declinaison * 0.90;

-- Réduction de 20% sur tous les vêtements dont le prix est supérieur à 80€
UPDATE declinaison_vetement SET prix_declinaison =  prix_declinaison * 0.80 WHERE prix_declinaison >= 80;

-- 2 requêtes impliquant 2 tables : 

-- Reduction de 20% sur tous les vetements dont la taille est égale à XXL
UPDATE declinaison_vetement dv
JOIN taille t ON dv.id_taille = t.id_taille 
SET dv.prix_declinaison = v.prix_declinaison * 0.80 
WHERE t.nom_taille = 'XXL' ;

-- Augmentation de 5% sur les vetements rouges
UPDATE declinaison_vetement dv
JOIN couleur c ON dv.id_couleur= c.id_couleur  
SET dv.prix_declinaison = dv.prix_declinaison * 1.05 
WHERE dv.nom_couleur = 'Rouge' ;

-- 2 requêtes impliquant plus de 2 tables :

-- Augmentation de 5% sur les vetements rouges et de taille
UPDATE declinaison_vetement dv
    JOIN couleur c ON dv.id_couleur= c.id_couleur  
    JOIN taille t ON dv.id_taille = t.id_taille 
	SET dv.prix_declinaison = v.prix_declinaison * 1.05 
	WHERE   c.nom_couleur = 'Rouge'
	AND t.nom_taille = 'S' ;

-- Réduction de 5€ pour les vêtements rouges de taille M avec un prix supérieur à 9€--
UPDATE declinaison_vetement dv
    JOIN couleur c ON dv.id_couleur= c.id_couleur  
    JOIN taille t ON dv.id_taille = t.id_taille 
	SET dv.prix_declinaison = dv.prix_declinaison - 5 
	WHERE dv.prix_declinaison > 9 
	AND c.nom_couleur = 'ROUGE'
	AND t.nom_taille = 'M' ;


/*REQUETES DE SUPPRESSION*/

-- 2 requêtes impliquant 1 table :

-- Supprimer une ligne de la table declinaison_vetement (suppression d'un vêtement)
DELETE FROM declinaison_vetement WHERE id_declinaison = 1;

-- Supprimer toutes les vêtements dont le prix est supérieur à 50€
DELETE FROM declinaison_vetement WHERE prix_declinaison > 50;

-- 2 requêtes impliquant 2 tables:

-- Supprimer toutes les commandes d'un utilisateur
DELETE FROM commande 
	JOIN utilisateur ON utilisateur.id_utilisateur = commande.id_utilisateur 
	WHERE utilisateur.id_utilisateur = 5;

-- Supprimer tous les vêtements dont la taille est 'M'
DELETE FROM declinaison_vetement
	JOIN taille ON declinaison_vetement.id_taille = taille.id_taille
	WHERE taille.nom_taille = 'M';

-- 2 requêtes impliquant plus de 2 tables :

-- Supprimer tous les vêtements dont la catégorie est "T-shirt" 
DELETE FROM declinaison_vetement
	JOIN vetement ON declinaison_vetement.id_vetement = vetement.id_vetement
	JOIN categorie ON vetement.id_categorie = categorie.id_categorie
	WHERE categorie.nom_categorie = 'T-shirt';

--Supprimer les commandes contenant un vêtement dans la catégorie 'Pantalon'
DELETE FROM commande
	JOIN est_commande ON commande.id_commande = est_commande.id_commande
	JOIN declinaison_vetement ON est_commande.id_declinaison = declinaison_vetement.id_declinaison
	JOIN vetement ON declinaison_vetement.id_vetement = vetement.id_vetement
    JOIN categorie ON vetement.id_categorie = categorie.id_categorie
    WHERE categorie.nom_categorie = 'Pantalon';

/*DESCRIPTION TEXTUELLES DES REQUETES DE CONSULTATION*/

-- 5 requêtes impliquant 1 table dont 1 avec un group By et une avec un Order By:

-- Trier les vêtements par ordre croissant du prix
SELECT nom_declinaison, prix_declinaison 
FROM declinaison_vetement ORDER BY prix_declinaison; 

-- Regrouper les vetements de quantité disponible par couleur
SELECT id_couleur, COUNT(*) 
FROM declinaison_vetement GROUP BY id_couleur 
HAVING quantite_declinaison > 0;

-- Filtrer les vêtements par gamme de prix. Ici c'est entre 20 et 40€.
SELECT * 
FROM declinaison_vetement
WHERE prix_declinaison BETWEEN 20 AND 40;

-- Lister les vêtements dont le prix est inférieur à 30€.
SELECT *
FROM declinaison_vetement 
WHERE prix_declinaison < 31;

-- Lister les vêtements dont le prix est égal à 30€.
SELECT * 
FROM declinaison_vetement 
WHERE prix_declinaison = 30;


-- 5 requêtes impliquant 2 tables avec jointures internes dont 1 externe + 1 group by + 1 tri : 

-- Donner le prix des commande regroupé par chaque utilisateur (GROUP BY)

SELECT utilisateur.id_utilisateur, SUM(commande.prix_commande) 
FROM utilisateur
JOIN commande ON utilisateur.id_utilisateur = commande.id_utilisateur
GROUP BY utilisateur.id_utilisateur

--Donner la liste d'id des vêtements et leur prix qui ont une couleur couleur rouge. Pour ceux qui n'ont pas de couleur rouge, leur nom sera simplement affiché.

SELECT 	id_vetement, nom_couleur 
FROM déclinaison RIGHT OUTER JOIN couleur ON declinaison.id-couleur = couleur.id_couleur;


--Trier les vêtements par catégorie

5 requêtes impliquant plus de 2 tables avec jointures internes dont 1 externe + 1 group by + 1 tri :






