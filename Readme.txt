################################
	   BACKEND
################################

Pour la partie backend de notre site, nous avons utilisé WAMP.

INSTRUCTIONS POUR INSTALLER LA PARTIE BACKEND :

--> Copiez le dossier "backend_eshop" dans le répertoire www de WAMP et lancez Wampserver.

################################
	   FRONTEND
################################

Pour la partie front-end de notre site, nous avons choisi d'utiliser le framework Angular.

INSTRUCTIONS POUR DEPLOYER NOTRE SITE EN LOCAL :

1. Installer NodeJS (version 12.18.3 LTS)
--> https://nodejs.org

2. Dans l'invite de commandes windows, rendez-vous dans le dossier "frontend_eshop" et executez les commandes suivantes : 

> npm install -g @angular/cli
> npm install
> ng serve

La dernière commande déploiera le site sur le port 4200. 
--> Ouvrez un navigateur et entrez l'url suivante : http://localhost:4200