/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 10gR2                          */
/* Date de création :  04/09/2020 16:18:55                      */
/*==============================================================*/


alter table CHOISIT
   drop constraint FK_CHOISIT_CHOISIT_VETEMENT;

alter table CHOISIT
   drop constraint FK_CHOISIT_CHOISIT2_UTILISAT;

alter table COMMANDE
   drop constraint FK_COMMANDE_PASSE_UTILISAT;

alter table CONTIENT_COULEUR
   drop constraint FK_CONTIENT_COULEUR;

alter table CONTIENT_COULEUR
   drop constraint FK_CONTIENT_CONTIENT__COULEUR;

alter table CONTIENT_TAILLE
   drop constraint FK_CONTIENT_CONTIENT__CATEGORI;

alter table CONTIENT_TAILLE
   drop constraint FK_CONTIENT_CONTIENT__TAILLE;

alter table EST_COMMANDE
   drop constraint FK_EST_COMM_EST_COMMA_VETEMENT;

alter table EST_COMMANDE
   drop constraint FK_EST_COMM_EST_COMMA_COMMANDE;

alter table VETEMENT
   drop constraint FK_VETEMENT_APPARTIEN_CATEGORI;

alter table VETEMENT
   drop constraint FK_VETEMENT_EST_ASSOC_COULEUR;

alter table VETEMENT
   drop constraint FK_VETEMENT_EST_DECLI_TAILLE;

drop table CATEGORIE cascade constraints;

drop index CHOISIT2_FK;

drop index CHOISIT_FK;

drop table CHOISIT cascade constraints;

drop index PASSE_FK;

drop table COMMANDE cascade constraints;

drop index CONTIENT_COULEUR2_FK;

drop index CONTIENT_COULEUR_FK;

drop table CONTIENT_COULEUR cascade constraints;

drop index CONTIENT_TAILLE2_FK;

drop index CONTIENT_TAILLE_FK;

drop table CONTIENT_TAILLE cascade constraints;

drop table COULEUR cascade constraints;

drop index EST_COMMANDE2_FK;

drop index EST_COMMANDE_FK;

drop table EST_COMMANDE cascade constraints;

drop table TAILLE cascade constraints;

drop table UTILISATEUR cascade constraints;

drop index EST_DECLINE_EN_FK;

drop index EST_ASSOCIE_A_FK;

drop index APPARTIENT_A_FK;

drop table VETEMENT cascade constraints;

/*==============================================================*/
/* Table : CATEGORIE                                            */
/*==============================================================*/
create table CATEGORIE  (
   ID_CATEGORIE         NUMBER(4)                       not null
      constraint CKC_ID_CATEGORIE_CATEGORI check (ID_CATEGORIE >= 1),
   NOM_CATEGORIE        VARCHAR2(30)                    not null,
   constraint PK_CATEGORIE primary key (ID_CATEGORIE)
);

/*==============================================================*/
/* Table : CHOISIT                                              */
/*==============================================================*/
create table CHOISIT  (
   ID_VETEMENT          NUMBER(4)                       not null
      constraint CKC_ID_VETEMENT_CHOISIT check (ID_VETEMENT >= 1),
   ID_UTILISATEUR       NUMBER(4)                       not null
      constraint CKC_ID_UTILISATEUR_CHOISIT check (ID_UTILISATEUR >= 1),
   constraint PK_CHOISIT primary key (ID_VETEMENT, ID_UTILISATEUR)
);

/*==============================================================*/
/* Index : CHOISIT_FK                                           */
/*==============================================================*/
create index CHOISIT_FK on CHOISIT (
   ID_VETEMENT ASC
);

/*==============================================================*/
/* Index : CHOISIT2_FK                                          */
/*==============================================================*/
create index CHOISIT2_FK on CHOISIT (
   ID_UTILISATEUR ASC
);

/*==============================================================*/
/* Table : COMMANDE                                             */
/*==============================================================*/
create table COMMANDE  (
   ID_COMMANDE          NUMBER(4)                       not null
      constraint CKC_ID_COMMANDE_COMMANDE check (ID_COMMANDE >= 1),
   ID_UTILISATEUR       NUMBER(4)                       not null
      constraint CKC_ID_UTILISATEUR_COMMANDE check (ID_UTILISATEUR >= 1),
   ETAT_COMMANDE        VARCHAR2(30)                    not null,
   PRIX_COMMANDE        NUMBER                          not null
      constraint CKC_PRIX_COMMANDE_COMMANDE check (PRIX_COMMANDE between 2 and 2000),
   QUANTITE_COMMANDEE   NUMBER                          not null
      constraint CKC_QUANTITE_COMMANDE_COMMANDE check (QUANTITE_COMMANDEE between 1 and 20),
   constraint PK_COMMANDE primary key (ID_COMMANDE)
);

/*==============================================================*/
/* Index : PASSE_FK                                             */
/*==============================================================*/
create index PASSE_FK on COMMANDE (
   ID_UTILISATEUR ASC
);

/*==============================================================*/
/* Table : CONTIENT_COULEUR                                     */
/*==============================================================*/
create table CONTIENT_COULEUR  (
   CATEGORIE_ID         NUMBER(4)                       not null
      constraint CKC_CATEGORIE_ID_CONTIENT check (CATEGORIE_ID >= 1),
   ID_COULEUR           NUMBER(4)                       not null
      constraint CKC_ID_COULEUR_CONTIENT check (ID_COULEUR >= 1),
   constraint PK_CONTIENT_COULEUR primary key (CATEGORIE_ID, ID_COULEUR)
);

/*==============================================================*/
/* Index : CONTIENT_COULEUR_FK                                  */
/*==============================================================*/
create index CONTIENT_COULEUR_FK on CONTIENT_COULEUR (
   CATEGORIE_ID ASC
);

/*==============================================================*/
/* Index : CONTIENT_COULEUR2_FK                                 */
/*==============================================================*/
create index CONTIENT_COULEUR2_FK on CONTIENT_COULEUR (
   ID_COULEUR ASC
);

/*==============================================================*/
/* Table : CONTIENT_TAILLE                                      */
/*==============================================================*/
create table CONTIENT_TAILLE  (
   ID_CATEGORIE         NUMBER(4)                       not null
      constraint CKC_ID_CATEGORIE_CONTIENT check (ID_CATEGORIE >= 1),
   ID_TAILLE            NUMBER(4)                       not null
      constraint CKC_ID_TAILLE_CONTIENT check (ID_TAILLE between 1 and 6),
   constraint PK_CONTIENT_TAILLE primary key (ID_CATEGORIE, ID_TAILLE)
);

/*==============================================================*/
/* Index : CONTIENT_TAILLE_FK                                   */
/*==============================================================*/
create index CONTIENT_TAILLE_FK on CONTIENT_TAILLE (
   ID_CATEGORIE ASC
);

/*==============================================================*/
/* Index : CONTIENT_TAILLE2_FK                                  */
/*==============================================================*/
create index CONTIENT_TAILLE2_FK on CONTIENT_TAILLE (
   ID_TAILLE ASC
);

/*==============================================================*/
/* Table : COULEUR                                              */
/*==============================================================*/
create table COULEUR  (
   ID_COULEUR           NUMBER(4)                       not null
      constraint CKC_ID_COULEUR_COULEUR check (ID_COULEUR >= 1),
   NOM_COULEUR          VARCHAR2(30),
   constraint PK_COULEUR primary key (ID_COULEUR)
);

/*==============================================================*/
/* Table : EST_COMMANDE                                         */
/*==============================================================*/
create table EST_COMMANDE  (
   ID_VETEMENT          NUMBER(4)                       not null
      constraint CKC_ID_VETEMENT_EST_COMM check (ID_VETEMENT >= 1),
   ID_COMMANDE          NUMBER(4)                       not null
      constraint CKC_ID_COMMANDE_EST_COMM check (ID_COMMANDE >= 1),
   constraint PK_EST_COMMANDE primary key (ID_VETEMENT, ID_COMMANDE)
);

/*==============================================================*/
/* Index : EST_COMMANDE_FK                                      */
/*==============================================================*/
create index EST_COMMANDE_FK on EST_COMMANDE (
   ID_VETEMENT ASC
);

/*==============================================================*/
/* Index : EST_COMMANDE2_FK                                     */
/*==============================================================*/
create index EST_COMMANDE2_FK on EST_COMMANDE (
   ID_COMMANDE ASC
);

/*==============================================================*/
/* Table : TAILLE                                               */
/*==============================================================*/
create table TAILLE  (
   ID_TAILLE            NUMBER(4)                       not null
      constraint CKC_ID_TAILLE_TAILLE check (ID_TAILLE between 1 and 6),
   NOM_TAILLE           VARCHAR2(30)                    not null,
   constraint PK_TAILLE primary key (ID_TAILLE)
);

/*==============================================================*/
/* Table : UTILISATEUR                                          */
/*==============================================================*/
create table UTILISATEUR  (
   ID_UTILISATEUR       NUMBER(4)                       not null
      constraint CKC_ID_UTILISATEUR_UTILISAT check (ID_UTILISATEUR >= 1),
   NOM_UTILISATEUR      CHAR(30)                        not null,
   PRENOM_UTILISATEUR   VARCHAR2(30)                    not null,
   ADRESSE_UTILISATEUR  VARCHAR2(80)                    not null,
   EMAIL_UTILISATEUR    VARCHAR2(50)                    not null,
   constraint PK_UTILISATEUR primary key (ID_UTILISATEUR)
);

/*==============================================================*/
/* Table : VETEMENT                                             */
/*==============================================================*/
create table VETEMENT  (
   ID_VETEMENT          NUMBER(4)                       not null
      constraint CKC_ID_VETEMENT_VETEMENT check (ID_VETEMENT >= 1),
   ID_COULEUR           NUMBER(4)                       not null
      constraint CKC_ID_COULEUR_VETEMENT check (ID_COULEUR >= 1),
   ID_TAILLE            NUMBER(4)                       not null
      constraint CKC_ID_TAILLE_VETEMENT check (ID_TAILLE between 1 and 6),
   ID_CATEGORIE         NUMBER(4)                       not null
      constraint CKC_ID_CATEGORIE_VETEMENT check (ID_CATEGORIE >= 1),
   NOM_VETEMENT         VARCHAR2(30)                    not null,
   DESCRIPTION_VETEMENT CLOB                            not null,
   PRIX_VETEMENT        NUMBER                          not null
      constraint CKC_PRIX_VETEMENT_VETEMENT check (PRIX_VETEMENT between 2 and 300),
   QUANTITE_VETEMENT    NUMBER(4)                       not null
      constraint CKC_QUANTITE_VETEMENT_VETEMENT check (QUANTITE_VETEMENT >= 0),
   constraint PK_VETEMENT primary key (ID_VETEMENT)
);

/*==============================================================*/
/* Index : APPARTIENT_A_FK                                      */
/*==============================================================*/
create index APPARTIENT_A_FK on VETEMENT (
   ID_CATEGORIE ASC
);

/*==============================================================*/
/* Index : EST_ASSOCIE_A_FK                                     */
/*==============================================================*/
create index EST_ASSOCIE_A_FK on VETEMENT (
   ID_COULEUR ASC
);

/*==============================================================*/
/* Index : EST_DECLINE_EN_FK                                    */
/*==============================================================*/
create index EST_DECLINE_EN_FK on VETEMENT (
   ID_TAILLE ASC
);

alter table CHOISIT
   add constraint FK_CHOISIT_CHOISIT_VETEMENT foreign key (ID_VETEMENT)
      references VETEMENT (ID_VETEMENT);

alter table CHOISIT
   add constraint FK_CHOISIT_CHOISIT2_UTILISAT foreign key (ID_UTILISATEUR)
      references UTILISATEUR (ID_UTILISATEUR);

alter table COMMANDE
   add constraint FK_COMMANDE_PASSE_UTILISAT foreign key (ID_UTILISATEUR)
      references UTILISATEUR (ID_UTILISATEUR);

alter table CONTIENT_COULEUR
   add constraint FK_CONTIENT_COULEUR foreign key (CATEGORIE_ID)
      references CATEGORIE (ID_CATEGORIE);

alter table CONTIENT_COULEUR
   add constraint FK_CONTIENT_CONTIENT__COULEUR foreign key (ID_COULEUR)
      references COULEUR (ID_COULEUR);

alter table CONTIENT_TAILLE
   add constraint FK_CONTIENT_CONTIENT__CATEGORI foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE);

alter table CONTIENT_TAILLE
   add constraint FK_CONTIENT_CONTIENT__TAILLE foreign key (ID_TAILLE)
      references TAILLE (ID_TAILLE);

alter table EST_COMMANDE
   add constraint FK_EST_COMM_EST_COMMA_VETEMENT foreign key (ID_VETEMENT)
      references VETEMENT (ID_VETEMENT);

alter table EST_COMMANDE
   add constraint FK_EST_COMM_EST_COMMA_COMMANDE foreign key (ID_COMMANDE)
      references COMMANDE (ID_COMMANDE);

alter table VETEMENT
   add constraint FK_VETEMENT_APPARTIEN_CATEGORI foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE);

alter table VETEMENT
   add constraint FK_VETEMENT_EST_ASSOC_COULEUR foreign key (ID_COULEUR)
      references COULEUR (ID_COULEUR);

alter table VETEMENT
   add constraint FK_VETEMENT_EST_DECLI_TAILLE foreign key (ID_TAILLE)
      references TAILLE (ID_TAILLE);

