import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/contact_remote_datasource.dart';
import 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  final ContactRemoteDataSource remote;

  ContactCubit(this.remote) : super(ContactState());

  void loadContacts() {
    remote.getContacts().listen((contacts) {
      emit(state.copyWith(contacts: contacts));
    });
  }

  Future<void> addContact(String name, String phone, String imagePath) async {
    await remote.addContact(name, phone, imagePath);
  }

  Future<void> updateContact(String id, String name, String phone) async {
    await remote.updateContact(id, name, phone);
  }

  Future<void> deleteContact(String id) async {
    await remote.deleteContact(id);
  }
}
