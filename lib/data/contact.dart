class Contact {
  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.suffix,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? suffix;

  @override
  String toString() => '$firstName $lastName';
}

// Génération de 51 contacts couvrant toutes les lettres A-Z
Set<Contact> generateContacts() {
  final contacts = <Contact>[];
  int id = 0;

  // Liste de prénoms et noms pour chaque lettre
  final names = {
    'A': ['Alice', 'Anderson'],
    'B': ['Bob', 'Brown'],
    'C': ['Charlie', 'Clark'],
    'D': ['David', 'Davis'],
    'E': ['Emma', 'Evans'],
    'F': ['Frank', 'Foster'],
    'G': ['Grace', 'Green'],
    'H': ['Hank', 'Harris'],
    'I': ['Ivy', 'Ingram'],
    'J': ['John', 'Johnson'],
    'K': ['Kate', 'King'],
    'L': ['Liam', 'Lewis'],
    'M': ['Mia', 'Miller'],
    'N': ['Noah', 'Nelson'],
    'O': ['Olivia', 'Owens'],
    'P': ['Paul', 'Parker'],
    'Q': ['Quinn', 'Quinn'],
    'R': ['Rachel', 'Roberts'],
    'S': ['Sam', 'Smith'],
    'T': ['Tina', 'Taylor'],
    'U': ['Uma', 'Underwood'],
    'V': ['Victor', 'Vaughn'],
    'W': ['Wendy', 'Wilson'],
    'X': ['Xavier', 'Xiong'],
    'Y': ['Yara', 'Young'],
    'Z': ['Zoe', 'Zimmerman'],
  };

  // Ajoute un contact pour chaque lettre
  for (var entry in names.entries) {
    contacts.add(Contact(
      id: id++,
      firstName: entry.value[0],
      lastName: entry.value[1],
    ));
  }

  // Complète jusqu'à 51 contacts avec des variantes
  final extraNames = [
    ['Daniel', 'Higgins', null, 'Jr.'],
    ['Emily', 'Parker', null, null],
    ['Michael', 'Johnson', null, 'Sr.'],
    ['Sarah', 'Connor', null, null],
    ['James', 'Bond', null, null],
    ['Lucas', 'Miller', null, null],
    ['Amelia', 'Wilson', null, null],
    ['Ethan', 'Brown', null, null],
    ['Sophia', 'Davis', null, null],
    ['Mason', 'Taylor', null, null],
    ['Isabella', 'Clark', null, null],
    ['Logan', 'Lewis', null, null],
    ['Ava', 'Roberts', null, null],
    ['Elijah', 'King', null, null],
    ['Oliver', 'Scott', null, null],
    ['Charlotte', 'Adams', null, null],
    ['Benjamin', 'Baker', null, null],
    ['Evelyn', 'Gonzalez', null, null],
    ['Alexander', 'Nelson', null, null],
    ['Mia', 'Carter', null, null],
    ['William', 'Mitchell', null, null],
    ['Sofia', 'Perez', null, null],
    ['James', 'Roberts', null, 'II'],
    ['Emma', 'Thompson', null, null],
    ['Liam', 'White', null, null],
  ];

  for (var extra in extraNames) {
    if (contacts.length >= 51) break;
    contacts.add(Contact(
      id: id++,
      firstName: extra[0] as String,
      lastName: extra[1] as String,
      middleName: extra[2] as String?,
      suffix: extra[3] as String?,
    ));
  }

  return contacts.toSet(); // Set garantit l'unicité
}

// Contacts d'exemple (utilisés dans le TP)
final johnAppleseed = Contact(id: 0, firstName: 'John', lastName: 'Appleseed');
final kateBell = Contact(id: 1, firstName: 'Kate', lastName: 'Bell');
final danielHiggins = Contact(id: 3, firstName: 'Daniel', lastName: 'Higgins', suffix: 'Jr.');
final hankZakroff = Contact(id: 5, firstName: 'Hank', middleName: 'M.', lastName: 'Zakroff');
// ... d'autres contacts spécifiques si nécessaire

final Set<Contact> allContacts = generateContacts();