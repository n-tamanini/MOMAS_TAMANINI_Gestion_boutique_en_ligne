/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  10/09/2020 13:20:52                      */
/*==============================================================*/


drop table if exists CATEGORIE;

drop table if exists CHOISIT;

drop table if exists COMMANDE;

drop table if exists COULEUR;

drop table if exists DECLINAISON_VETEMENT;

drop table if exists EST_COMMANDE;

drop table if exists TAILLE;

drop table if exists UTILISATEUR;

drop table if exists VETEMENT;

/*==============================================================*/
/* Table : CATEGORIE                                            */
/*==============================================================*/
create table CATEGORIE
(
   ID_CATEGORIE         numeric(4,0) not null,
   NOM_CATEGORIE        varchar(30) not null,
   primary key (ID_CATEGORIE)
);

/*==============================================================*/
/* Table : CHOISIT                                              */
/*==============================================================*/
create table CHOISIT
(
   ID_DECLINAISON       numeric(4,0) not null,
   ID_UTILISATEUR       numeric(4,0) not null,
   primary key (ID_DECLINAISON, ID_UTILISATEUR)
);

/*==============================================================*/
/* Table : COMMANDE                                             */
/*==============================================================*/
create table COMMANDE
(
   ID_COMMANDE          numeric(4,0) not null,
   ID_UTILISATEUR       numeric(4,0) not null,
   ETAT_COMMANDE        varchar(30) not null,
   PRIX_COMMANDE        decimal not null,
   primary key (ID_COMMANDE)
);

/*==============================================================*/
/* Table : COULEUR                                              */
/*==============================================================*/
create table COULEUR
(
   ID_COULEUR           numeric(4,0) not null,
   NOM_COULEUR          varchar(30),
   primary key (ID_COULEUR)
);

/*==============================================================*/
/* Table : DECLINAISON_VETEMENT                                 */
/*==============================================================*/
create table DECLINAISON_VETEMENT
(
   ID_DECLINAISON       numeric(4,0) not null,
   ID_COULEUR           numeric(4,0) not null,
   ID_VETEMENT          numeric(4,0) not null,
   ID_TAILLE            numeric(4,0) not null,
   PRIX_DECLINAISON     decimal not null,
   QUANTITE_DECLINAISON numeric(4,0) not null,
   primary key (ID_DECLINAISON)
);

/*==============================================================*/
/* Table : EST_COMMANDE                                         */
/*==============================================================*/
create table EST_COMMANDE
(
   ID_DECLINAISON       numeric(4,0) not null,
   ID_COMMANDE          numeric(4,0) not null,
   QUANTITE_COMMANDEE   numeric(3,0),
   primary key (ID_DECLINAISON, ID_COMMANDE)
);

/*==============================================================*/
/* Table : TAILLE                                               */
/*==============================================================*/
create table TAILLE
(
   ID_TAILLE            numeric(4,0) not null,
   NOM_TAILLE           varchar(30) not null,
   primary key (ID_TAILLE)
);

/*==============================================================*/
/* Table : UTILISATEUR                                          */
/*==============================================================*/
create table UTILISATEUR
(
   ID_UTILISATEUR       numeric(4,0) not null,
   NOM_UTILISATEUR      char(30) not null,
   PRENOM_UTILISATEUR   varchar(30) not null,
   ADRESSE_UTILISATEUR  varchar(80) not null,
   EMAIL_UTILISATEUR    varchar(50) not null,
   MDP_UTILISATEUR      varchar(30) not null,
   primary key (ID_UTILISATEUR)
);

/*==============================================================*/
/* Table : VETEMENT                                             */
/*==============================================================*/
create table VETEMENT
(
   ID_VETEMENT          numeric(4,0) not null,
   ID_CATEGORIE         numeric(4,0) not null,
   NOM_VETEMENT         varchar(30) not null,
   DESCRIPTION_VETEMENT longtext not null,
   primary key (ID_VETEMENT)
);

alter table CHOISIT add constraint FK_CHOISIT foreign key (ID_DECLINAISON)
      references DECLINAISON_VETEMENT (ID_DECLINAISON) on delete restrict on update restrict;

alter table CHOISIT add constraint FK_CHOISIT2 foreign key (ID_UTILISATEUR)
      references UTILISATEUR (ID_UTILISATEUR) on delete restrict on update restrict;

alter table COMMANDE add constraint FK_PASSE foreign key (ID_UTILISATEUR)
      references UTILISATEUR (ID_UTILISATEUR) on delete restrict on update restrict;

alter table DECLINAISON_VETEMENT add constraint FK_EST_DECLINE foreign key (ID_VETEMENT)
      references VETEMENT (ID_VETEMENT) on delete restrict on update restrict;

alter table DECLINAISON_VETEMENT add constraint FK_EST_DECLINE_EN foreign key (ID_TAILLE)
      references TAILLE (ID_TAILLE) on delete restrict on update restrict;

alter table DECLINAISON_VETEMENT add constraint FK_SE_DECLINE_EN foreign key (ID_COULEUR)
      references COULEUR (ID_COULEUR) on delete restrict on update restrict;

alter table EST_COMMANDE add constraint FK_EST_COMMANDE foreign key (ID_DECLINAISON)
      references DECLINAISON_VETEMENT (ID_DECLINAISON) on delete restrict on update restrict;

alter table EST_COMMANDE add constraint FK_EST_COMMANDE2 foreign key (ID_COMMANDE)
      references COMMANDE (ID_COMMANDE) on delete restrict on update restrict;

alter table VETEMENT add constraint FK_APPARTIENT_A foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE) on delete restrict on update restrict;

