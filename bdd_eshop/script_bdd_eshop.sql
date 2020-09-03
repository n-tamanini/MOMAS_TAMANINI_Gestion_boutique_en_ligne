/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 10gR2                          */
/* Date de création :  03/09/2020 11:19:04                      */
/*==============================================================*/


alter table CHOISIT
   drop constraint FK_CHOISIT_CHOISIT_VETEMENT;

alter table CHOISIT
   drop constraint FK_CHOISIT_CHOISIT2_UTILISAT;

alter table COMMANDE
   drop constraint FK_COMMANDE_PASSE_UTILISAT;

alter table CONTIENT_COULEUR
   drop constraint FK_CONTIENT_CONTIENT_CATEGORI;

alter table CONTIENT_COULEUR
   drop constraint FK_CONTIENT_CONTIENT2_COULEUR;

alter table CONTIENT_TAILLE
   drop constraint FK_CONTIENT_CONTIENT3_CATEGORI;

alter table CONTIENT_TAILLE
   drop constraint FK_CONTIENT_CONTIENT4_TAILLE;

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

drop index CONTIENT2_FK;

drop index CONTIENT_FK;

drop table CONTIENT_COULEUR cascade constraints;

drop index CONTIENT4_FK;

drop index CONTIENT3_FK;

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
   ID_CATEGORIE         NUMBER(4)                       not null,
   NOM_CATEGORIE        VARCHAR2(30)                    not null,
   constraint PK_CATEGORIE primary key (ID_CATEGORIE)
);

/*==============================================================*/
/* Table : CHOISIT                                              */
/*==============================================================*/
create table CHOISIT  (
   ID_VETEMENT          NUMBER(4)                       not null,
   ID_USER              NUMBER(4)                       not null,
   constraint PK_CHOISIT primary key (ID_VETEMENT, ID_USER)
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
   ID_USER ASC
);

/*==============================================================*/
/* Table : COMMANDE                                             */
/*==============================================================*/
create table COMMANDE  (
   ID_COMMANDE          NUMBER(4)                       not null,
   ID_USER              NUMBER(4)                       not null,
   ETAT_COMMANDE        VARCHAR2(30)                    not null,
   PRIX_COMMANDE        NUMBER                          not null,
   constraint PK_COMMANDE primary key (ID_COMMANDE)
);

/*==============================================================*/
/* Index : PASSE_FK                                             */
/*==============================================================*/
create index PASSE_FK on COMMANDE (
   ID_USER ASC
);

/*==============================================================*/
/* Table : CONTIENT_COULEUR                                     */
/*==============================================================*/
create table CONTIENT_COULEUR  (
   ID_CATEGORIE         NUMBER(4)                       not null,
   ID_COULEUR           NUMBER(4)                       not null,
   constraint PK_CONTIENT_COULEUR primary key (ID_CATEGORIE, ID_COULEUR)
);

/*==============================================================*/
/* Index : CONTIENT_FK                                          */
/*==============================================================*/
create index CONTIENT_FK on CONTIENT_COULEUR (
   ID_CATEGORIE ASC
);

/*==============================================================*/
/* Index : CONTIENT2_FK                                         */
/*==============================================================*/
create index CONTIENT2_FK on CONTIENT_COULEUR (
   ID_COULEUR ASC
);

/*==============================================================*/
/* Table : CONTIENT_TAILLE                                      */
/*==============================================================*/
create table CONTIENT_TAILLE  (
   ID_CATEGORIE         NUMBER(4)                       not null,
   ID_TAILLE            NUMBER(4)                       not null
      constraint CKC_ID_TAILLE_CONTIENT check (ID_TAILLE between 1 and 6),
   constraint PK_CONTIENT_TAILLE primary key (ID_CATEGORIE, ID_TAILLE)
);

/*==============================================================*/
/* Index : CONTIENT3_FK                                         */
/*==============================================================*/
create index CONTIENT3_FK on CONTIENT_TAILLE (
   ID_CATEGORIE ASC
);

/*==============================================================*/
/* Index : CONTIENT4_FK                                         */
/*==============================================================*/
create index CONTIENT4_FK on CONTIENT_TAILLE (
   ID_TAILLE ASC
);

/*==============================================================*/
/* Table : COULEUR                                              */
/*==============================================================*/
create table COULEUR  (
   ID_COULEUR           NUMBER(4)                       not null,
   NOM_COULEUR          VARCHAR2(30),
   constraint PK_COULEUR primary key (ID_COULEUR)
);

/*==============================================================*/
/* Table : EST_COMMANDE                                         */
/*==============================================================*/
create table EST_COMMANDE  (
   ID_VETEMENT          NUMBER(4)                       not null,
   ID_COMMANDE          NUMBER(4)                       not null,
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
   ID_USER              NUMBER(4)                       not null,
   NOM_UTILISATEUR      CHAR(30)                        not null,
   PRENOM               VARCHAR2(30)                    not null,
   ADRESSE              VARCHAR2(80)                    not null,
   EMAIL                VARCHAR2(50)                    not null,
   ATTRIBUT_6           CHAR(10),
   constraint PK_UTILISATEUR primary key (ID_USER)
);

/*==============================================================*/
/* Table : VETEMENT                                             */
/*==============================================================*/
create table VETEMENT  (
   ID_VETEMENT          NUMBER(4)                       not null,
   ID_COULEUR           NUMBER(4)                       not null,
   ID_TAILLE            NUMBER(4)                       not null
      constraint CKC_ID_TAILLE_VETEMENT check (ID_TAILLE between 1 and 6),
   ID_CATEGORIE         NUMBER(4)                       not null,
   NOM_VETEMENT         VARCHAR2(30)                    not null,
   DESCRIPTION          CLOB                            not null,
   PRIX                 NUMBER                          not null,
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
   add constraint FK_CHOISIT_CHOISIT2_UTILISAT foreign key (ID_USER)
      references UTILISATEUR (ID_USER);

alter table COMMANDE
   add constraint FK_COMMANDE_PASSE_UTILISAT foreign key (ID_USER)
      references UTILISATEUR (ID_USER);

alter table CONTIENT_COULEUR
   add constraint FK_CONTIENT_CONTIENT_CATEGORI foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE);

alter table CONTIENT_COULEUR
   add constraint FK_CONTIENT_CONTIENT2_COULEUR foreign key (ID_COULEUR)
      references COULEUR (ID_COULEUR);

alter table CONTIENT_TAILLE
   add constraint FK_CONTIENT_CONTIENT3_CATEGORI foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE);

alter table CONTIENT_TAILLE
   add constraint FK_CONTIENT_CONTIENT4_TAILLE foreign key (ID_TAILLE)
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

