# Archivé. Répo mis à jour sur GitLab https://gitlab.com/ungdev/sia/openshift-s2i-yarn
# S2I Yarn

## Prise en main

Yarn est un gestionnaire de dépendances alternatif à npm.
Cette image permet de construire une application yarn à partir des sources
L'image est surtout très utile pour le déploiement d'images sur OpenShift.


## Comment construire l'application ?

### En local

Il y a 2 options pour récupérer l'image de construction de l'application
La récupérer sur le Docker Hub ou la construire depuis les sources

#### Récupération depuis le Docker Hub
```
docker pull ungdev/s2i-yarn
```

#### Construction depuis les sources
```
git clone https://github.com/ungdev/s2i-yarn
cd s2i-yarn
echo 'FROM node:alpine' > Dockerfile
cat Dockerfile.template >> Dockerfile
docker build -t ungdev/s2i-yarn .
```

Ensuite, il n'y a plus qu'a construire l'image de l'application
```
s2i build <source code path/URL> s2i-yarn <application image>
docker run <application image>
```

### Sur OpenShift
Pour déployer l'application sur un projet OpenShift, il suffit d'exécuter
```
oc new-app ungdev/s2i-yarn~<URL du repository>
```

### Qu'est-ce que l'image exécute
```
yarn
yarn build
yarn start
```

### Mettre en place le cache des dépendances
Pour pouvoir accélérer la construction des applications, il est possible de mettre en cache les dépendances.

Pour se faire, il suffit de préciser dans la commande `s2i build` le drapeau `--incrementale=true`

### Variables d'environnement utilisées
```
NODE_ENV=production
```

### Composition des fichiers
| Fichiers            | Description                                                  |
|---------------------|--------------------------------------------------------------|
| Dockerfile          | Définit l'image de base                                      |
| bin/assemble        | Script qui construit l'application                           |
| bin/usage           | Script qui affiche l'usage de l'image                        |
| bin/run             | Script qui démarre l'application                             |
| bin/save-artifacts  | Script pour mettre en cache les dépendences                  |

