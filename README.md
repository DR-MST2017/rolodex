# rolodex

Compte Rendu TP Flutter — UI Avancée Cupertino & ValueNotifier
Nom : Med Salah Tlili
Classe : IAM1 – 2025/2026
Durée : 2h30
Sujet : Rolodex – Application de gestion de contacts avec design iOS
________________________________________
1. Objectif du TP
•	Créer une application Flutter avec interface iOS (CupertinoApp). 
•	Comprendre l’usage des widgets Cupertino : CupertinoPageScaffold, CupertinoNavigationBar, CupertinoButton, CupertinoTextField. 
•	Créer et gérer les modèles de données (Contact et ContactGroup). 
•	Gérer l’état global léger avec ValueNotifier et reconstruire l’UI avec ValueListenableBuilder. 
•	Structurer un projet Flutter propre : data/, screens/, theme/. 
________________________________________
2. Structure du projet
lib/
 ├── main.dart          // Point d’entrée de l’application
 ├── data/              // Modèles et données (Contact, ContactGroup)
 │    ├── contact.dart
 │    └── contact_group.dart
 ├── screens/           // Widgets d’écran (Page principale)
 └── theme/             // CupertinoThemeData, couleurs et styles
•	data/ : aucune dépendance UI, uniquement Dart pur. 
•	screens/ : interface complète par écran. 
•	theme/ : centralisation du style et adaptation clair/sombre. 
________________________________________
3. Mise en place de l’application
3.1 main.dart
import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact_group.dart';

final contactGroupsModel = ContactGroupsModel();

void main() {
  runApp(const RolodexApp());
}

class RolodexApp extends StatelessWidget {
  const RolodexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Rolodex',
      theme: const CupertinoThemeData(
        barBackgroundColor: CupertinoDynamicColor.withBrightness(
          color: Color(0xFFF9F9F9),
          darkColor: Color(0xFF1D1D1D),
        ),
      ),
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Rolodex'),
        ),
        child: ValueListenableBuilder<List<ContactGroup>>(
          valueListenable: contactGroupsModel.listsNotifier,
          builder: (context, groups, child) {
            return ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                return CupertinoListTile(
                  title: Text(group.label),
                  subtitle: Text('${group.contacts.length} contacts'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
Capture écran suggérée : l’interface affichant les 3 groupes (All iPhone, Friends, Work).
________________________________________
4. Modèles de données
4.1 Contact
•	Classe pure Dart représentant un contact. 
•	Contient : id, firstName, lastName, middleName (optionnel), suffix (optionnel). 
class Contact {
  Contact({required this.id, required this.firstName, required this.lastName, this.middleName, this.suffix});
  final int id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? suffix;
}
•	Un Set<Contact> est utilisé pour garantir l’unicité des contacts. 
________________________________________
4.2 ContactGroup
•	Groupe de contacts avec tri automatique (factory constructor). 
•	Getter calculé alphabetizedContacts → SplayTreeMap trié par initiale. 
AlphabetizedContactMap get alphabetizedContacts {
  final map = AlphabetizedContactMap();
  for (final contact in _contacts) {
    final initial = contact.lastName[0].toUpperCase();
    map[initial] = map.containsKey(initial) ? [...map[initial]!, contact] : [contact];
  }
  return map;
}
•	Permet un affichage trié de A → Z dans l’UI. 
________________________________________
5. Gestion d’état avec ValueNotifier
•	ContactGroupsModel encapsule la liste des groupes dans un ValueNotifier. 
•	La modification des données déclenche automatiquement la reconstruction de l’UI via ValueListenableBuilder. 
final ValueNotifier<List<ContactGroup>> _listsNotifier = ValueNotifier(generateSeedData());
ValueNotifier<List<ContactGroup>> get listsNotifier => _listsNotifier;
Capture écran suggérée : montrer la mise à jour automatique si on ajoute un contact à un groupe (facultatif).
________________________________________
6. Widgets Cupertino utilisés
Widget	Rôle
CupertinoApp	Racine de l’application, style iOS
CupertinoPageScaffold	Scaffold iOS avec navigationBar et body
CupertinoNavigationBar	Barre de navigation centrée
CupertinoButton	Bouton style iOS
CupertinoTextField	Champ de saisie iOS
CupertinoListTile	Ligne de liste iOS
ValueListenableBuilder	Reconstruit l’UI automatiquement sur changement d’état
________________________________________
7. Résultat attendu
•	Application affiche 3 groupes de contacts : 
1.	All iPhone → 51 contacts 
2.	Friends → 1 contact 
3.	Work → 0 contact 
•	Interface iOS même sur Android ou Web. 
•	Couleur de la barre de navigation change automatiquement avec le mode clair/sombre du système. 
Capture écran suggérée : interface en mode clair et mode sombre.
________________________________________
8. Questions de réflexion
•	Quelle différence entre ValueListenableBuilder et ListenableBuilder ? 
•	Que se passe-t-il si ContactGroup est créé sans contacts ? 
•	Pourquoi utiliser un Set pour les contacts ? 
________________________________________
9. Conclusion
•	Le TP a permis de : 
o	Maîtriser le style iOS (Cupertino) sur Flutter. 
o	Créer et gérer des modèles de données Dart (Contact, ContactGroup). 
o	Gérer l’état global avec ValueNotifier. 
o	Structurer correctement un projet Flutter avec data/, screens/, theme/. 
•	Base solide pour les prochains TP sur layouts adaptatifs, Slivers et navigation. 


Affichage après running :
<img width="945" height="298" alt="image" src="https://github.com/user-attachments/assets/cffc7816-c8a8-4e21-919d-0b620878a44e" />
1. Introduction

Dans ce TP, nous avons étudié le concept de Responsive Design dans Flutter.
L'objectif principal est de créer une interface utilisateur capable de s'adapter automatiquement à différentes tailles d’écran comme les smartphones, les tablettes et les ordinateurs.

Pour cela, nous avons utilisé plusieurs concepts importants :

LayoutBuilder
BoxConstraints
Breakpoints
Row / Expanded / SizedBox
SafeArea

Nous avons implémenté un layout adaptatif pour l'application Rolodex qui affiche une liste de groupes de contacts et les contacts associés.

2. Objectifs du TP

Les objectifs de ce TP sont :

Comprendre le fonctionnement du widget LayoutBuilder.
Comprendre la classe BoxConstraints et son rôle dans le système de layout Flutter.
Définir des breakpoints pour adapter l’interface selon la largeur de l’écran.
Créer un layout avec sidebar et panneau de détail pour les grands écrans.
Gérer l’état de sélection d’une liste de contacts avec StatefulWidget.
Structurer l’application en plusieurs fichiers dans le dossier screens.
3. Notions Théoriques
3.1 Responsive Design

Une application Flutter peut fonctionner sur plusieurs types d’écrans :

Type d’écran	Largeur	Layout
Téléphone	< 600 px	Navigation simple
Tablette / Desktop	> 600 px	Sidebar + détail

Dans ce TP nous avons utilisé le breakpoint suivant :

const largeScreenMinWidth = 600.0;

Ce seuil permet de distinguer les petits écrans des grands écrans.

3.2 LayoutBuilder

Le widget LayoutBuilder permet de connaître l’espace disponible pour un widget.

Exemple :

LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return LargeLayout();
    } else {
      return MobileLayout();
    }
  },
);

Contrairement à MediaQuery, LayoutBuilder donne la taille réelle disponible pour le widget.

3.3 BoxConstraints

La classe BoxConstraints contient les contraintes de taille d’un widget.

Propriétés principales :

Propriété	Description
maxWidth	largeur maximale
maxHeight	hauteur maximale
minWidth	largeur minimale
minHeight	hauteur minimale

Ces contraintes permettent à Flutter de calculer la taille des widgets dans l’interface.

4. Architecture du Projet

Pour organiser l’application, nous avons créé un dossier :

lib/screens

Il contient les fichiers suivants :

screens
│
├── adaptive_layout.dart
├── contact_groups.dart
└── contacts.dart
Rôle de chaque fichier
Fichier	Rôle
contact_groups.dart	affiche les groupes de contacts
contacts.dart	affiche les contacts d’un groupe
adaptive_layout.dart	choisit le layout selon la largeur
5. Implémentation
5.1 ContactGroupsPage

Cette page affiche la liste des groupes de contacts.

class ContactGroupsPage extends StatelessWidget {
  const ContactGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: Center(
        child: Text('Groupes de contacts — a implementer'),
      ),
    );
  }
}
5.2 ContactListsPage

Cette page affiche les contacts d’un groupe sélectionné.

class ContactListsPage extends StatelessWidget {
  const ContactListsPage({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: Center(
        child: Text('Liste de contacts — a implementer'),
      ),
    );
  }
}
5.3 AdaptiveLayout

Le widget AdaptiveLayout est responsable du choix du layout.

Il utilise LayoutBuilder pour détecter la largeur disponible.

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}
Etat de sélection
int selectedListId = 0;

Lorsque l’utilisateur sélectionne un groupe :

void _onContactListSelected(int listId) {
  setState(() {
    selectedListId = listId;
  });
}
6. Layout Grand Ecran

Pour les écrans supérieurs à 600 px, nous utilisons une Row composée de :

une sidebar fixe
un séparateur
un panneau détail flexible
Row(
 children: [

   SizedBox(
     width: 320,
     child: ContactGroupsPage(),
   ),

   Container(
     width: 1,
     color: CupertinoColors.separator,
   ),

   Expanded(
     child: ContactListsPage(listId: selectedListId),
   ),
 ],
)
Rôle des widgets
Widget	Fonction
SizedBox	sidebar largeur fixe
Container	séparateur
Expanded	panneau détail flexible
7. Test de l’Application

Pour tester le comportement adaptatif :

Lancer l’application :
flutter run -d chrome
Activer le mode responsive dans Chrome DevTools.
Résultat
Largeur écran	Résultat
< 600 px	ContactGroupsPage seul
> 600 px	Sidebar + panneau détail

Le changement de layout est automatique et instantané.

8. Extension Possible

Une amélioration consiste à ajouter un troisième layout pour les très grands écrans :

> 1200 px

Layout possible :

Groupes | Contacts | Détails du contact

Cela créerait une interface à trois colonnes adaptée au desktop.

9. Conclusion

Dans ce TP nous avons appris à créer une interface adaptative avec Flutter.

Les notions principales étudiées sont :

LayoutBuilder
BoxConstraints
Responsive design
Breakpoints
Row + Expanded
Gestion d’état avec StatefulWidget

Grâce à ces techniques, l’application Rolodex peut fonctionner correctement sur smartphone, tablette et ordinateur.
<img width="1897" height="852" alt="Capture d’écran 2026-04-01 154657" src="https://github.com/user-attachments/assets/2aad9977-8088-4436-9950-1c81798cf693" />
<img width="1918" height="913" alt="Capture d&#39;écran 2026-04-01 154613" src="https://github.com/user-attachments/assets/01723598-568d-4c29-844a-589cc5a29221" />




 
