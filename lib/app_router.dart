import 'package:go_router/go_router.dart';

import 'features/contacts/domain/contact.dart';
import 'features/contacts/presentation/pages/add_contact_page.dart';
import 'features/contacts/presentation/pages/contact_list_page.dart';
import 'features/contacts/presentation/pages/edit_contact_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'list',
      builder: (context, state) => const ContactListPage(),
    ),
    GoRoute(
      path: '/add',
      name: 'add',
      builder: (context, state) => const AddContactPage(),
    ),
    GoRoute(
      path: '/edit',
      name: 'edit',
      builder: (context, state) {
        final contact = state.extra as Contact;
        return EditContactPage(contact: contact);
      },
    ),
  ],
);
