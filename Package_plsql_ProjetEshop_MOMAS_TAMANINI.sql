
-----------------------PACKAGE----------------------------

--Package bloc A

create or replace PACKAGE UTILISATEUR_PACKAGE AS 

FUNCTION UTILISATEURinserer(userId IN number, userLastName IN VARCHAR2, userFirstName IN VARCHAR2, userAddress IN VARCHAR2, userEmail IN VARCHAR2 , userPassword IN VARCHAR2)
return NUMBER ;
FUNCTION UTILISATEURtotal
return NUMBER;

PROCEDURE UTILISATEURsupprimer(userId IN number);
PROCEDURE UTILISATEURmodifierMotDePasse(userId IN number, userPassword IN VARCHAR2);
PROCEDURE UTILISATEURmodifierNom(userId IN number, userLastName IN VARCHAR2, userFirstName IN VARCHAR2);
PROCEDURE UTILISATEURlister;
PROCEDURE UTILISATEURdepensesUtilisateurs;
PROCEDURE UTILISATEURCommandeDeclinaison(idDeclinaison IN NUMBER);
PROCEDURE UTILISATEURCommandeAnnulee;

END UTILISATEUR_PACKAGE;


-- Package body bloc A

--Spécification des traitement avec des packages PLSQL (Modèle de traitements)
--. Choisir parmi vos tables deux d’entres (A et B) elles sur lesquelles les fonctions suivantes 
--vont être spécifiées puis implémentées :


--Sur la table A, définir un package plsql ayant le nom de la dite table:

CREATE OR REPLACE
PACKAGE BODY UTILISATEUR_PACKAGE AS

-- - ajouter une nouvelle occurence à A : fonction Ainserer;

FUNCTION UTILISATEURinserer(userId IN number, userLastName IN VARCHAR2, userFirstName IN VARCHAR2, userAddress IN VARCHAR2, userEmail IN VARCHAR2 , userPassword IN VARCHAR2)
return NUMBER AS
BEGIN
INSERT INTO UTILISATEUR
VALUES(userId, userLastName, userFirstName, userAddress, userEmail, userPassword);
RETURN (userId);
END UTILISATEURinserer;


-- - supprimer une occurrence à A (Attention : les enregistrements liés dans B doivent 
--aussi être supprimés) : fonction Asupprimer;

PROCEDURE UTILISATEURsupprimer(userId IN number) IS
BEGIN
DELETE FROM UTILISATEUR
WHERE ID_UTILISATEUR = userId; 
END UTILISATEURsupprimer;


-- - modifier des informations sur de A : fonction AmodifierF1, AmodifierF2 
--(texte requêtes correspondantes plus haut);

PROCEDURE UTILISATEURmodifierMotDePasse(userId IN number, userPassword IN VARCHAR2) IS
BEGIN
UPDATE UTILISATEUR
SET MDP_UTILISATEUR = userPassword
WHERE ID_UTILISATEUR = userId; 
END UTILISATEURmodifierMotDePasse;

PROCEDURE UTILISATEURmodifierNom(userId IN number, userLastName IN VARCHAR2, userFirstName IN VARCHAR2) IS
BEGIN
UPDATE UTILISATEUR
SET NOM_UTILISATEUR = userLastName, PRENOM_UTILISATEUR = userFirstName 
WHERE ID_UTILISATEUR = userId; 
END UTILISATEURmodifierNom;


-- - lister toutes les occurrences de A: fonction Alister;

PROCEDURE UTILISATEURlister IS

CURSOR user_list IS SELECT *
FROM UTILISATEUR;

userId UTILISATEUR.ID_UTILISATEUR%TYPE;
userLastName UTILISATEUR.NOM_UTILISATEUR%TYPE;
userFirstName UTILISATEUR.PRENOM_UTILISATEUR%TYPE;
userAddress UTILISATEUR.ADRESSE_UTILISATEUR%TYPE;
userEmail UTILISATEUR.EMAIL_UTILISATEUR%TYPE;
userPassword UTILISATEUR.MDP_UTILISATEUR%TYPE;
BEGIN
OPEN user_list;
LOOP
FETCH user_list INTO userId,userLastName,userFirstName,userAddress,userEmail,userPassword;
DBMS_OUTPUT.PUT_LINE(userId || ' - ' || userLastName || ' - ' || userFirstName || ' - ' || userAddress ||' - ' || userEmail ||' - ' || userPassword);
END LOOP;
END UTILISATEURlister;

-- - fournir le nombre total des occurrences de A : fonction Atotal ;

FUNCTION UTILISATEURtotal
return NUMBER IS total NUMBER;
BEGIN
SELECT COUNT(*) INTO total
FROM UTILISATEUR;
RETURN (total);
END UTILISATEURtotal;


-- - Proposer aussi 3 fonctions avec des requêtes de consultation impliquant 2 ou 3 
-- tables au moins (jointure, groupe, tri) : fonction Af1, Af2, Af3. f1, f2, f3 sont
-- des noms à définir AmodifierF2 (texte requêtes correspondantes plus haut);

PROCEDURE UTILISATEURdepensesUtilisateurs IS

CURSOR depenseUtilisateur IS 
SELECT UTILISATEUR.NOM_UTILISATEUR, UTILISATEUR.PRENOM_UTILISATEUR, SUM(COMMANDE.PRIX_COMMANDE)
FROM UTILISATEUR 
JOIN COMMANDE ON COMMANDE.ID_UTILISATEUR = UTILISATEUR.ID_UTILISATEUR
GROUP BY UTILISATEUR.ID_UTILISATEUR;

userLastName UTILISATEUR.NOM_UTILISATEUR%TYPE;
userFirstName UTILISATEUR.PRENOM_UTILISATEUR%TYPE;
sommeCommandes COMMANDE.PRIX_COMMANDE%TYPE;

BEGIN
OPEN depenseUtilisateur;
LOOP
FETCH depenseUtilisateur INTO userLastName,userFirstName,sommeCommandes;
DBMS_OUTPUT.PUT_LINE(userLastName || ' - ' || userFirstName || ' : ' || sommeCommandes);
END LOOP;
END UTILISATEURdepensesUtilisateurs;

PROCEDURE UTILISATEURCommandeDeclinaison(idDeclinaison IN NUMBER) IS
CURSOR user_list IS 
SELECT UTILISATEUR.*
FROM UTILISATEUR
JOIN COMMANDE ON COMMANDE.ID_UTILISATEUR = UTILISATEUR.ID_UTILISATEUR
JOIN EST_COMMANDE ON EST_COMMANDE.ID_COMMANDE = COMMANDE.ID_COMMANDE
WHERE EST_COMMANDE.ID_DECLINAISON = idDeclinaison;

userId UTILISATEUR.ID_UTILISATEUR%TYPE;
userLastName UTILISATEUR.NOM_UTILISATEUR%TYPE;
userFirstName UTILISATEUR.PRENOM_UTILISATEUR%TYPE;
userAddress UTILISATEUR.ADRESSE_UTILISATEUR%TYPE;
userEmail UTILISATEUR.EMAIL_UTILISATEUR%TYPE;
userPassword UTILISATEUR.MDP_UTILISATEUR%TYPE;
BEGIN
OPEN user_list;
LOOP
FETCH user_list INTO userId,userLastName,userFirstName,userAddress,userEmail,userPassword;
DBMS_OUTPUT.PUT_LINE(userId || ' - ' || userLastName || ' - ' || userFirstName || ' - ' || userAddress ||' - ' || userEmail ||' - ' || userPassword);
END LOOP;
END UTILISATEURCommandeDeclinaison;

PROCEDURE UTILISATEURCommandeAnnulee IS
CURSOR user_list IS SELECT UTILISATEUR.*
FROM UTILISATEUR
JOIN COMMANDE ON COMMANDE.ID_UTILISATEUR = UTILISATEUR.ID_UTILISATEUR
WHERE COMMANDE.ETAT_COMMANDE = 'Annulee';

userId UTILISATEUR.ID_UTILISATEUR%TYPE;
userLastName UTILISATEUR.NOM_UTILISATEUR%TYPE;
userFirstName UTILISATEUR.PRENOM_UTILISATEUR%TYPE;
userAddress UTILISATEUR.ADRESSE_UTILISATEUR%TYPE;
userEmail UTILISATEUR.EMAIL_UTILISATEUR%TYPE;
userPassword UTILISATEUR.MDP_UTILISATEUR%TYPE;
BEGIN
OPEN user_list;
LOOP
FETCH user_list INTO userId,userLastName,userFirstName,userAddress,userEmail,userPassword;
DBMS_OUTPUT.PUT_LINE(userId || ' - ' || userLastName || ' - ' || userFirstName || ' - ' || userAddress ||' - ' || userEmail ||' - ' || userPassword);
END LOOP;
END UTILISATEURCommandeAnnulee;


END UTILISATEUR_PACKAGE;




--Package du bloc B

CREATE OR REPLACE PACKAGE COMMANDE_PACKAGE AS 

FUNCTION COMMANDEinserer(commandeId IN number, userId IN NUMBER, etatCommande IN VARCHAR2, prixCommande IN number)
return NUMBER ;
PROCEDURE COMMANDEsupprimer(commandeId IN number);
PROCEDURE COMMANDEmodifierPrixCommande(commandeId IN number, prixCommande IN NUMBER);
PROCEDURE COMMANDEmodifierEtatCommande(commandeId IN number, etatCommande IN VARCHAR2);
PROCEDURE COMMANDElister(userId IN number);

END COMMANDE_PACKAGE;


-- Package body du bloc B

--Sur la table B, définir un package plsql ayant le nom de la dite table:
CREATE OR REPLACE 
PACKAGE BODY COMMANDE_PACKAGE AS


FUNCTION COMMANDEinserer(commandeId IN number, userId IN NUMBER, etatCommande IN VARCHAR2, prixCommande IN number) 
return NUMBER AS
BEGIN
INSERT INTO COMMANDE
VALUES(commandeId, userId, etatCommande, prixCommande);
RETURN (commandeId);
END COMMANDEinserer;

-- supprimer une occurrence à B : fonction Bsupprimer;
PROCEDURE COMMANDEsupprimer(commandeId IN number) IS
BEGIN
DELETE FROM COMMANDE
WHERE ID_COMMANDE = commandeId; 
END COMMANDEsupprimer;
-- modifier des informations sur de B : fonction BmodifierF1, BmodifierF2

PROCEDURE COMMANDEmodifierPrixCommande(commandeId IN number, prixCommande IN NUMBER) IS
BEGIN
UPDATE COMMANDE
SET PRIX_COMMANDE = prixCommande
WHERE ID_COMMANDE = commandeId; 
END COMMANDEmodifierPrixCommande;

PROCEDURE COMMANDEmodifierEtatCommande(commandeId IN number, etatCommande IN VARCHAR2) IS
BEGIN
UPDATE COMMANDE
SET ETAT_COMMANDE = etatCommande 
WHERE ID_COMMANDE = commandeId; 
END COMMANDEmodifierEtatCommande;

-- lister toutes les occurrences de B pour une occurrence de A donnée: fonction Blister

PROCEDURE COMMANDElister(userId IN NUMBER ) IS

CURSOR commande_list IS SELECT COMMANDE.ID_COMMANDE, COMMANDE.ETAT_COMMANDE, COMMANDE.PRIX_COMMANDE
FROM COMMANDE
JOIN UTILISATEUR ON UTILISATEUR.ID_UTILISATEUR = COMMANDE.ID_UTILISATEUR
WHERE UTILISATEUR.ID_UTILISATEUR =  userId; 

commandeId COMMANDE.ID_COMMANDE%TYPE;
commandeEtatCommande COMMANDE.ETAT_COMMANDE%TYPE;
commandePrixCommande COMMANDE.PRIX_COMMANDE%TYPE;
BEGIN
OPEN commande_list; 
LOOP
FETCH commande_list INTO commandeId, commandeEtatCommande, commandePrixCommande;
              DBMS_OUTPUT.PUT_LINE(commandeId || ' - ' || commandeEtatCommande || ' - ' || commandePrixCommande);        
END LOOP;
END COMMANDElister;

END COMMANDE_PACKAGE;



------------------------TRIGGER---------------------------

CREATE OR REPLACE TRIGGER INSERTUSERTRIGGER 
AFTER INSERT ON UTILISATEUR
FOR EACH ROW
BEGIN
  dbms_output.put_line( 'insertion de l''utilisateur n° ' || To_char( :NEW.id_utilisateur )|| ' -> ' || :NEW.nom_utilisateur || :NEW.prenom_utilisateur ) ;
END;



CREATE OR REPLACE TRIGGER USERDELETE_TRIGGER 
BEFORE DELETE ON UTILISATEUR
FOR EACH ROW
DECLARE 
nb_commande NUMBER;
BEGIN
  SELECT COUNT(*) INTO nb_commande 
  FROM COMMANDE
  WHERE COMMANDE.ID_UTILISATEUR = :OLD.ID_UTILISATEUR;
  IF (nb_commande > 0) THEN 
  raise_application_error(-20111,'garder information');
  END IF;
END;


