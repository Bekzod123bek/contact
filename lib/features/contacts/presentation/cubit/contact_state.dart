import '../../domain/contact.dart';

class ContactState {
  final List<Contact> contacts;
  final bool loading;

  ContactState({
    this.contacts = const [],
    this.loading = false,
  });

  ContactState copyWith({
    List<Contact>? contacts,
    bool? loading,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      loading: loading ?? this.loading,
    );
  }
}
