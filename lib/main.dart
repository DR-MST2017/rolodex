import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact_group.dart';

// État global de l'application
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
          color: Color(0xFFF9F9F9),   // mode clair
          darkColor: Color(0xFF1D1D1D), // mode sombre
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