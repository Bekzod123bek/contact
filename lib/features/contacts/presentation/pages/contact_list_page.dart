import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../main.dart';
import '../cubit/contact_cubit.dart';
import '../cubit/contact_state.dart';
import '../../domain/contact.dart';

import 'add_contact_page.dart';
import 'edit_contact_page.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contacts'.tr()),
        actions: [
          // 🌍 LANGUAGE
          TextButton(
            onPressed: () {
              context.setLocale(const Locale('en'));
            },
            child: const Text('EN', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              context.setLocale(const Locale('uz'));
            },
            child: const Text('UZ', style: TextStyle(color: Colors.white)),
          ),

          // 🌙 THEME
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              MyApp.of(context).toggleTheme();
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddContactPage()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          if (state.contacts.isEmpty) {
            return Center(
              child: Text('noContacts'.tr()),
            );
          }

          return ListView.builder(
            itemCount: state.contacts.length,
            itemBuilder: (context, index) {
              final Contact c = state.contacts[index];

              final hasImage =
                  c.imagePath.isNotEmpty && File(c.imagePath).existsSync();

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                  hasImage ? FileImage(File(c.imagePath)) : null,
                  child: !hasImage ? const Icon(Icons.person) : null,
                ),
                title: Text(c.name),
                subtitle: Text(c.phone),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditContactPage(contact: c),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context.read<ContactCubit>().deleteContact(c.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
