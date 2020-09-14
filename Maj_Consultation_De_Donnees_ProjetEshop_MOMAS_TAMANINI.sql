/*REQUETES DE MISE A JOUR*/

-- 2 requêtes impliquant 1 table :

-- Réduction de 10% sur tous les vêtements
UPDATE declinaison_vetement SET prix_declinaison =  prix_declinaison * 0.90;

-- Réduction de 20% sur tous les vêtements dont le prix est supérieur à 80€
UPDATE declinaison_vetement SET prix_declinaison =  prix_declinaison * 0.80 WHERE prix_declinaison >= 80;

-- 2 requêtes impliquant 2 tables : 

-- Reduction de 20% sur tous les vetements dont la taille est égale à XXL
UPDATE declinaison_vetement dv JOIN taille t ON dv.id_taille = t.id_taille SET dv.prix_declinaison = v.prix_declinaison * 0.80 WHERE t.nom_taille = 'XXL' ; -- FONCTIONNE PAS

-- Augmentation de 5% sur les vetements rouges
UPDATE declinaison_vetement dv JOIN couleur c ON dv.id_couleur= c.id_couleur SET dv.prix_declinaison = dv.prix_declinaison * 1.05 WHERE dv.nom_couleur = 'Rouge' ; -- FONCTIONNE PAS

-- 2 requêtes impliquant plus de 2 tables :

-- Augmentation de 5% sur les vetements rouges et de taille
UPDATE declinaison_vetement dv JOIN couleur c ON dv.id_couleur= c.id_couleur JOIN taille t ON dv.id_taille = t.id_taille SET dv.prix_declinaison = v.prix_declinaison * 1.05 WHERE c.nom_couleur = 'Rouge' AND t.nom_taille = 'S' ; -- FONCTIONNE PAS

-- Réduction de 5€ pour les vêtements rouges de taille M avec un prix supérieur à 9€--
UPDATE declinaison_vetement dv JOIN couleur c ON dv.id_couleur= c.id_couleur JOIN taille t ON dv.id_taille = t.id_taille SET dv.prix_declinaison = dv.prix_declinaison - 5 WHERE dv.prix_declinaison > 9 AND c.nom_couleur = 'Rouge' AND t.nom_taille = 'M' ; -- FONCTIONNE PAS


/*REQUETES DE SUPPRESSION*/

-- 2 requêtes impliquant 1 table :

-- Supprimer une ligne de la table declinaison_vetement (suppression d'un vêtement)
DELETE FROM declinaison_vetement WHERE id_declinaison = 1; -- FONCTIONNE PAS

-- Supprimer toutes les vêtements dont le prix est supérieur à 50€
DELETE FROM declinaison_vetement WHERE prix_declinaison > 50; -- FONCTIONNE PAS

-- 2 requêtes impliquant 2 tables:

-- Supprimer toutes les commandes d'un utilisateur
DELETE FROM commande JOIN utilisateur ON utilisateur.id_utilisateur = commande.id_utilisateur WHERE utilisateur.id_utilisateur = 5; -- FONCTIONNE PAS

-- Supprimer tous les vêtements dont la taille est 'M'
DELETE FROM declinaison_vetement JOIN taille ON declinaison_vetement.id_taille = taille.id_taille WHERE taille.nom_taille = 'M'; -- FONCTIONNE PAS

-- 2 requêtes impliquant plus de 2 tables :

-- Supprimer tous les vêtements dont la catégorie est "T-shirt" 
DELETE FROM declinaison_vetement JOIN vetement ON declinaison_vetement.id_vetement = vetement.id_vetement JOIN categorie ON vetement.id_categorie = categorie.id_categorie WHERE categorie.nom_categorie = 'T-shirt'; -- FONCTIONNE PAS

--Supprimer les commandes contenant un vêtement dans la catégorie 'Pantalon'
DELETE FROM commande JOIN est_commande ON commande.id_commande = est_commande.id_commande JOIN declinaison_vetement ON est_commande.id_declinaison = declinaison_vetement.id_declinaison JOIN vetement ON declinaison_vetement.id_vetement = vetement.id_vetement JOIN categorie ON vetement.id_categorie = categorie.id_categorie WHERE categorie.nom_categorie = 'Pantalon'; -- FONCTIONNE PAS

/*DESCRIPTION TEXTUELLES DES REQUETES DE CONSULTATION*/

-- 5 requêtes impliquant 1 table dont 1 avec un group By et une avec un Order By:

-- Trier les vêtements par ordre croissant du prix
SELECT id_declinaison, prix_declinaison FROM declinaison_vetement ORDER BY prix_declinaison; 

-- Regrouper les vetements de quantité disponible par couleur
SELECT id_couleur, COUNT(*) FROM declinaison_vetement GROUP BY id_couleur HAVING quantite_declinaison > 0; -- FONCTIONNE PAS

-- Filtrer les vêtements par gamme de prix. Ici c'est entre 20 et 40€.
SELECT * FROM declinaison_vetement WHERE prix_declinaison BETWEEN 20 AND 40;

-- Lister les vêtements dont le prix est inférieur à 30€.
SELECT * FROM declinaison_vetement WHERE prix_declinaison < 31;

-- Lister les vêtements dont le prix est égal à 30€.
SELECT * FROM declinaison_vetement WHERE prix_declinaison = 30;


-- 5 requêtes impliquant 2 tables avec jointures internes dont 1 externe + 1 group by + 1 tri : 

-- Donner le prix des commandes regroupées par utilisateur (GROUP BY)
SELECT utilisateur.id_utilisateur, SUM(commande.prix_commande) FROM utilisateur JOIN commande ON utilisateur.id_utilisateur = commande.id_utilisateur GROUP BY utilisateur.id_utilisateur;

-- Donner la liste des utilisateurs avec les commandes qui leurs sont associées. Si un utilisateur n'a jamais commandé, on affiche quand même son nom
SELECT prenom_utilisateur, nom_utilisateur, id_commande FROM utilisateur LEFT OUTER JOIN commande ON utilisateur.id_utilisateur = commande.id_utilisateur;

-- Donner la liste des déclinaisons de vêtements de taille 'M'
SELECT id_declinaison, nom_taille FROM declinaison_vetement JOIN taille ON declinaison_vetement.id_taille = taille.id_taille WHERE taille.nom_taille = 'M';

-- Donner la liste des déclinaisons de vêtements de couleur rouge
SELECT id_declinaison, nom_couleur FROM declinaison_vetement JOIN couleur ON declinaison_vetement.id_couleur = couleur.id_couleur WHERE couleur.nom_couleur = 'Rouge';

-- Donner la liste des vêtements de catégorie 'Pantalon'
SELECT nom_vetement, nom_categorie FROM vetement JOIN categorie ON vetement.id_categorie = categorie.id_categorie WHERE categorie.nom_categorie = 'Pantalon'; 

--Trier les vêtements par catégorie

-- 5 requêtes impliquant plus de 2 tables avec jointures internes dont 1 externe + 1 group by + 1 tri :

-- Donner la liste des utilisateurs et de la ou des commande(s) contenant ayant vêtement de taille S que ces utilisateurs ont passé.
SELECT prenom_utilisateur, nom_utilisateur, commande.id_commande FROM utilisateur JOIN commande ON utilisateur.id_utilisateur = commande.id_utilisateur JOIN est_commande ON commande.id_commande = est_commande.id_commande JOIN declinaison_vetement ON est_commande.id_declinaison = declinaison_vetement.id_declinaison JOIN taille ON declinaison_vetement.id_taille = taille.id_taille WHERE taille.nom_taille = 'S';

-- Donner la liste des déclinaisons de vêtements dont la catégorie est 'T-Shirt' triés par prix décroissants
SELECT id_declinaison, nom_vetement, prix_declinaison, quantite_declinaison FROM declinaison_vetement JOIN vetement ON declinaison_vetement.id_vetement = vetement.id_vetement JOIN categorie ON vetement.id_categorie = categorie.id_categorie WHERE nom_categorie='T-Shirt' ORDER BY prix_declinaison DESC;

-- Donner la liste des déclinaisons de vêtements dont la taille est S et la couleur est noir
SELECT id_declinaison, nom_taille, nom_couleur FROM declinaison_vetement JOIN taille ON declinaison_vetement.id_taille = taille.id_taille JOIN couleur ON declinaison_vetement.id_couleur = couleur.id_couleur WHERE nom_taille = 'S' AND nom_couleur='Noir'; 

-- Donner le nom et la catégorie des vêtements étant associés à des déclinaisons. Si un vêtement n'est associé à aucune déclinaison, le nom et la catégorie de ce vêtement sont quand même affichés.
SELECT nom_categorie, nom_vetement, id_declinaison FROM vetement LEFT OUTER JOIN categorie ON vetement.id_categorie = categorie.id_categorie LEFT OUTER JOIN declinaison_vetement ON vetement.id_vetement = declinaison_vetement.id_vetement;

-- Donner la valeur marchande du stock de vêtements par catégorie trié par valeur marchande décroissante
SELECT categorie.nom_categorie, SUM(declinaison_vetement.prix_declinaison)"Valeur marchande du stock par catégorie" FROM vetement JOIN categorie ON vetement.id_categorie = categorie.id_categorie JOIN declinaison_vetement ON vetement.id_vetement = declinaison_vetement.id_vetement GROUP BY categorie.nom_categorie ORDER BY SUM(declinaison_vetement.prix_declinaison) DESC;






