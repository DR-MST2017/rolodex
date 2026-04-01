import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'contact.dart';

typedef AlphabetizedContactMap = SplayTreeMap<String, List<Contact>>;

class ContactGroup {
  // Factory constructor avec tri automatique des contacts
  factory ContactGroup({
    required int id,
    required String label,
    bool permanent = false,
    String? title,
    List<Contact>? contacts,
  }) {
    final contactsCopy = contacts ?? <Contact>[];
    _sortContacts(contactsCopy);
    return ContactGroup._internal(
      id: id,
      label: label,
      permanent: permanent,
      title: title,
      contacts: contactsCopy,
    );
  }

  // Constructeur privé
  ContactGroup._internal({
    required this.id,
    required this.label,
    this.permanent = false,
    String? title,
    List<Contact>? contacts,
  })  : title = title ?? label,
        _contacts = contacts ?? const <Contact>[];

  final int id;
  final bool permanent;
  final String label;
  final String title;
  final List<Contact> _contacts;

  List<Contact> get contacts => _contacts;

  // Retourne une map triée par initiale du nom de famille
  AlphabetizedContactMap get alphabetizedContacts {
    final map = AlphabetizedContactMap();
    for (final contact in _contacts) {
      final initial = contact.lastName[0].toUpperCase();
      if (map.containsKey(initial)) {
        map[initial]!.add(contact);
      } else {
        map[initial] = [contact];
      }
    }
    return map;
  }
}

// Fonction de tri : nom -> prénom -> id
void _sortContacts(List<Contact> contacts) {
  contacts.sort((a, b) {
    final byLast = a.lastName.compareTo(b.lastName);
    if (byLast != 0) return byLast;
    final byFirst = a.firstName.compareTo(b.firstName);
    if (byFirst != 0) return byFirst;
    return a.id.compareTo(b.id);
  });
}

// Données initiales pour les groupes
final allPhone = ContactGroup(
  id: 0,
  permanent: true,
  label: 'All iPhone',
  title: 'iPhone',
  contacts: allContacts.toList(),
);

final friends = ContactGroup(
  id: 1,
  label: 'Friends',
  contacts: [allContacts.elementAt(3)], // exemple: un contact
);

final work = ContactGroup(id: 2, label: 'Work'); // groupe vide

List<ContactGroup> generateSeedData() => [allPhone, friends, work];

// Modèle gérant l'état global via ValueNotifier
class ContactGroupsModel {
  ContactGroupsModel() : _listsNotifier = ValueNotifier(generateSeedData());

  final ValueNotifier<List<ContactGroup>> _listsNotifier;

  ValueNotifier<List<ContactGroup>> get listsNotifier => _listsNotifier;

  List<ContactGroup> get lists => _listsNotifier.value;

  ContactGroup findContactList(int id) => lists[id];

  void dispose() {
    _listsNotifier.dispose();
  }
}