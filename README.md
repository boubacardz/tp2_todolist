# TP2 – Gestionnaire de Tâches (To-Do List)

## Description

Ce projet consiste à développer une application Flutter simple de **gestion de tâches (To-Do List)**. L’application permettra à l’utilisateur d’ajouter, d’afficher et de supprimer des tâches de manière dynamique.

---

## Objectifs pédagogiques

À la fin de ce TP, l’apprenant sera capable de :

- Créer un `StatefulWidget`.
- Créer un formulaire avec des `TextField`.
- Ajouter et supprimer dynamiquement des éléments dans une liste.
- Utiliser `setState()` pour mettre à jour l’interface utilisateur.
- Comprendre la logique d’une liste interactive avec Flutter.
- Afficher une image associée à chaque tâche.

---

## Contexte

Vous allez créer une application simple de gestion de tâches. L’utilisateur pourra :

- Ajouter une tâche avec un **titre** et une **description**.
- Visualiser la liste des tâches.
- Supprimer une tâche en un clic.

---

## Prérequis

- Flutter installé et configuré correctement.
- Un émulateur Android ou un appareil physique fonctionnel.

---

## Étapes de réalisation

### 1. Création du projet

```bash
flutter create tp2_todolist
cd tp2_todolist
flutter run
```

---

### 2. Création de la page principale

- Créer une `HomePage` en tant que `StatefulWidget`.
- Dans `_HomePageState`, créer une **liste vide de tâches**.
- Chaque tâche sera représentée par un `Map` contenant :
    - `title`
    - `description`

---

### 3. Gestion des assets

- Créer le dossier suivant dans le projet :

```text
assets/images
```

- Ajouter une image nommée `task.png` (icône de tâche ou checklist).
- Déclarer cette image dans le fichier `pubspec.yaml` :

```yaml
flutter:
  assets:
    - assets/images/task.png
```

---

### 4. Création du formulaire d’ajout

- Utiliser un `AlertDialog` pour l’ajout d’une tâche.
- Champs du formulaire :
    - **Titre**
    - **Description**
- Ajouter un bouton **"Ajouter"** pour valider la saisie.

---

### 5. Affichage dynamique de la liste

- Utiliser `ListView.builder` pour afficher les tâches.
- Chaque tâche doit être affichée dans un `Card` contenant :
    - L’image `task.png`.
    - Le titre de la tâche.
    - La description de la tâche.

---

## Résultat attendu

À la fin du TP, l’application doit permettre :

- L’ajout dynamique de tâches.
- L’affichage immédiat des nouvelles tâches.
- La suppression d’une tâche de la liste.
- Une interface simple et claire respectant les bonnes pratiques Flutter.

---

## Ressources utiles

- [Lab : Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook : Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Documentation officielle Flutter](https://docs.flutter.dev/)
- [boubacard](https://Linktr.ee/boubacardz)

