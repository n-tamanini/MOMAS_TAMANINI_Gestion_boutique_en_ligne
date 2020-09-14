/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 10gR2                          */
/* Date de création :  10/09/2020 10:24:43                      */
/*==============================================================*/


alter table CHOISIT
   drop constraint FK_CHOISIT_CHOISIT_DECLINAI;

alter table CHOISIT
   drop constraint FK_CHOISIT_CHOISIT2_UTILISAT;

alter table COMMANDE
   drop constraint FK_COMMANDE_PASSE_UTILISAT;

alter table DECLINAISON_VETEMENT
   drop constraint FK_DECLINAI_EST_DECLI_VETEMENT;

alter table DECLINAISON_VETEMENT
   drop constraint FK_DECLINAI_EST_DECLI_TAILLE;

alter table DECLINAISON_VETEMENT
   drop constraint FK_DECLINAI_SE_DECLIN_COULEUR;

alter table EST_COMMANDE
   drop constraint FK_EST_COMM_EST_COMMA_DECLINAI;

alter table EST_COMMANDE
   drop constraint FK_EST_COMM_EST_COMMA_COMMANDE;

alter table VETEMENT
   drop constraint FK_VETEMENT_APPARTIEN_CATEGORI;

drop table CATEGORIE cascade constraints;

drop index CHOISIT2_FK;

drop index CHOISIT_FK;

drop table CHOISIT cascade constraints;

drop index PASSE_FK;

drop table COMMANDE cascade constraints;

drop table COULEUR cascade constraints;

drop index EST_DECLINE_FK;

drop index SE_DECLINE_EN_FK;

drop index EST_DECLINE_EN_FK;

drop table DECLINAISON_VETEMENT cascade constraints;

drop index EST_COMMANDE2_FK;

drop index EST_COMMANDE_FK;

drop table EST_COMMANDE cascade constraints;

drop table TAILLE cascade constraints;

drop table UTILISATEUR cascade constraints;

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
   ID_DECLINAISON       NUMBER(4)                       not null
      constraint CKC_ID_DECLINAISON_CHOISIT check (ID_DECLINAISON >= 1),
   ID_UTILISATEUR       NUMBER(4)                       not null
      constraint CKC_ID_UTILISATEUR_CHOISIT check (ID_UTILISATEUR >= 1),
   constraint PK_CHOISIT primary key (ID_DECLINAISON, ID_UTILISATEUR)
);

/*==============================================================*/
/* Index : CHOISIT_FK                                           */
/*==============================================================*/
create index CHOISIT_FK on CHOISIT (
   ID_DECLINAISON ASC

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
   constraint PK_COMMANDE primary key (ID_COMMANDE)
);

/*==============================================================*/
/* Index : PASSE_FK                                             */
/*==============================================================*/
create index PASSE_FK on COMMANDE (
   ID_UTILISATEUR ASC
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
/* Table : DECLINAISON_VETEMENT                                 */
/*==============================================================*/
create table DECLINAISON_VETEMENT  (
   ID_DECLINAISON       NUMBER(4)                       not null
      constraint CKC_ID_DECLINAISON_DECLINAI check (ID_DECLINAISON >= 1),
   ID_COULEUR           NUMBER(4)                       not null
      constraint CKC_ID_COULEUR_DECLINAI check (ID_COULEUR >= 1),
   ID_VETEMENT          NUMBER(4)                       not null
      constraint CKC_ID_VETEMENT_DECLINAI check (ID_VETEMENT >= 1),
   ID_TAILLE            NUMBER(4)                       not null
      constraint CKC_ID_TAILLE_DECLINAI check (ID_TAILLE between 1 and 6),
   PRIX_DECLINAISON     NUMBER                          not null
      constraint CKC_PRIX_DECLINAISON_DECLINAI check (PRIX_DECLINAISON between 2 and 300),
   QUANTITE_DECLINAISON NUMBER(4)                       not null
      constraint CKC_QUANTITE_DECLINAI_DECLINAI check (QUANTITE_DECLINAISON >= 0),
   constraint PK_DECLINAISON_VETEMENT primary key (ID_DECLINAISON)
);

/*==============================================================*/
/* Index : EST_DECLINE_EN_FK                                    */
/*==============================================================*/
create index EST_DECLINE_EN_FK on DECLINAISON_VETEMENT (
   ID_TAILLE ASC
);

/*==============================================================*/
/* Index : SE_DECLINE_EN_FK                                     */
/*==============================================================*/
create index SE_DECLINE_EN_FK on DECLINAISON_VETEMENT (
   ID_COULEUR ASC
);

/*==============================================================*/
/* Index : EST_DECLINE_FK                                       */
/*==============================================================*/
create index EST_DECLINE_FK on DECLINAISON_VETEMENT (
   ID_VETEMENT ASC
);

/*==============================================================*/
/* Table : EST_COMMANDE                                         */
/*==============================================================*/
create table EST_COMMANDE  (
   ID_DECLINAISON       NUMBER(4)                       not null
      constraint CKC_ID_DECLINAISON_EST_COMM check (ID_DECLINAISON >= 1),
   ID_COMMANDE          NUMBER(4)                       not null
      constraint CKC_ID_COMMANDE_EST_COMM check (ID_COMMANDE >= 1),
   QUANTITE_COMMANDEE   NUMBER(3)                      
      constraint CKC_QUANTITE_COMMANDE_EST_COMM check (QUANTITE_COMMANDEE is null or (QUANTITE_COMMANDEE between 1 and 20)),
   constraint PK_EST_COMMANDE primary key (ID_DECLINAISON, ID_COMMANDE)
);

/*==============================================================*/
/* Index : EST_COMMANDE_FK                                      */
/*==============================================================*/
create index EST_COMMANDE_FK on EST_COMMANDE (
   ID_DECLINAISON ASC
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
   MDP_UTILISATEUR      VARCHAR2(30)                    not null,
   constraint PK_UTILISATEUR primary key (ID_UTILISATEUR)
);

/*==============================================================*/
/* Table : VETEMENT                                             */
/*==============================================================*/
create table VETEMENT  (
   ID_VETEMENT          NUMBER(4)                       not null
      constraint CKC_ID_VETEMENT_VETEMENT check (ID_VETEMENT >= 1),
   ID_CATEGORIE         NUMBER(4)                       not null
      constraint CKC_ID_CATEGORIE_VETEMENT check (ID_CATEGORIE >= 1),
   NOM_VETEMENT         VARCHAR2(30)                    not null,
   DESCRIPTION_VETEMENT CLOB                            not null,
   constraint PK_VETEMENT primary key (ID_VETEMENT)
);

/*==============================================================*/
/* Index : APPARTIENT_A_FK                                      */
/*==============================================================*/
create index APPARTIENT_A_FK on VETEMENT (
   ID_CATEGORIE ASC
);

alter table CHOISIT
   add constraint FK_CHOISIT_CHOISIT_DECLINAI foreign key (ID_DECLINAISON)
      references DECLINAISON_VETEMENT (ID_DECLINAISON)
      on delete cascade;

alter table CHOISIT
   add constraint FK_CHOISIT_CHOISIT2_UTILISAT foreign key (ID_UTILISATEUR)
      references UTILISATEUR (ID_UTILISATEUR)
      on delete cascade;

alter table COMMANDE
   add constraint FK_COMMANDE_PASSE_UTILISAT foreign key (ID_UTILISATEUR)
      references UTILISATEUR (ID_UTILISATEUR)
      on delete cascade;

alter table DECLINAISON_VETEMENT
   add constraint FK_DECLINAI_EST_DECLI_VETEMENT foreign key (ID_VETEMENT)
      references VETEMENT (ID_VETEMENT)
      on delete cascade;

alter table DECLINAISON_VETEMENT
   add constraint FK_DECLINAI_EST_DECLI_TAILLE foreign key (ID_TAILLE)
      references TAILLE (ID_TAILLE)
      on delete cascade;

alter table DECLINAISON_VETEMENT
   add constraint FK_DECLINAI_SE_DECLIN_COULEUR foreign key (ID_COULEUR)
      references COULEUR (ID_COULEUR)
      on delete cascade;

alter table EST_COMMANDE
   add constraint FK_EST_COMM_EST_COMMA_DECLINAI foreign key (ID_DECLINAISON)
      references DECLINAISON_VETEMENT (ID_DECLINAISON)
      on delete cascade;

alter table EST_COMMANDE
   add constraint FK_EST_COMM_EST_COMMA_COMMANDE foreign key (ID_COMMANDE)
      references COMMANDE (ID_COMMANDE)
      on delete cascade;

alter table VETEMENT
   add constraint FK_VETEMENT_APPARTIEN_CATEGORI foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE)
      on delete cascade;

