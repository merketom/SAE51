# SAE 52 – Automatisation de la création de machines VirtualBox

**Auteurs :** Tom MERKEL & Mickaël DAMERVAL  
**Date :** 11 Septembre 2025  

## Résumé
Ce projet a pour but d’automatiser la création, la gestion et la suppression de machines virtuelles VirtualBox grâce à un script Bash (`genMV.sh`).  
Le script permet de créer une VM Debian avec des caractéristiques prédéfinies, de lister les machines et leurs métadonnées, de les démarrer, de les arrêter ou de les supprimer.  
Un système de vérification empêche la duplication des noms de VM et enregistre des métadonnées (date de création, utilisateur).  
Ce travail s’inscrit dans la démarche d’infrastructure automatisée et reproductible.

## Utilisation

Le script `genMV.sh` prend **deux arguments** :  
- `arg1` → action à effectuer  
- `arg2` → nom de la machine (sauf pour la liste optionelle)

## Actions disponibles :
- `L` → Liste les VM.  
   - `./genMV.sh L` → liste toutes les VM avec leurs métadonnées.  
   - `./genMV.sh L NOM_VM` → affiche uniquement les informations de `NOM_VM`.  
- `N NOM_VM` → Crée une nouvelle VM Debian avec l'obligation de la nommer sinon cela affiche une erreur.   
- `S NOM_VM` → Supprime une VM (désenregistrement + suppression disque).  
- `D NOM_VM` → Démarre une VM.  
- `A NOM_VM` → Arrête une VM.  

### Exemple :  
```bash
./genMV.sh N TestVM
./genMV.sh D TestVM
./genMV.sh A TestVM
./genMV.sh S TestVM
./genMV.sh L
```

## Limites & problèmes rencontrés

- Le script est prévu uniquement pour Linux/Bash.
- Le script ne gère pas encore l’installation automatique (PXE ou preseed), ce qui est une extension optionnelle du sujet.
- En cas de plantage de VirtualBox, certaines commandes vboxmanage peuvent échouer.

## Améliorations possibles

- Ajout d’une option H (help) pour afficher les commandes disponibles.
- Ajout d’options pour personnaliser la RAM et la taille disque via arguments.

