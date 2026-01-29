import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/dialogs.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../../main.dart';
import '../cubit/contact_cubit.dart';
import '../cubit/contact_state.dart';
import '../../domain/contact.dart';

import '../widgets/language_switcher.dart';


class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contacts'.tr()),
        actions: [
          const LanguageSwitcher(),
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
        onPressed: () =>
          context.pushNamed('add'),

        child: const Icon(Icons.add),
      ),

      body: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {


          if (state.contacts.isEmpty) {
            return Center(child: Text('noContacts'.tr()));
          }

          return ListView.builder(
            itemCount: state.contacts.length,
            itemBuilder: (context, index) {
              final Contact c = state.contacts[index];

              final hasImage =
                  c.imagePath.isNotEmpty && File(c.imagePath).existsSync();

              return ListTile(
                onTap: () =>
                  context.pushNamed('edit',extra: c),

                leading: CircleAvatar(
                  backgroundImage: hasImage
                      ? FileImage(File(c.imagePath))
                      : null,
                  child: !hasImage ? const Icon(Icons.person) : null,
                ),
                title: Text(c.name),
                subtitle: Text(c.phone),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    if (!await confirmDelete(context)) return;

                    // Delete
                    final success =
                    await context.read<ContactCubit>().deleteContact(c.id);

                    if (!context.mounted) return;

                    showSnack(
                      context,
                      success ? 'delete' : 'error',
                      success: success,
                    );
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
