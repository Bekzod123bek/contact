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

  Future<bool> addContact(String name, String phone, String imagePath) async {
    try {
      await remote.addContact(name, phone, imagePath);
      return true; // success
    } catch (e) {
      return false; // eror
    }
  }

  Future<bool> updateContact(String id, String name, String phone) async {
    try {
      await remote.updateContact(id, name, phone);
      return true;
    } catch (_) {
      return false;
    }
  }


  Future<bool> deleteContact(String id) async {
    try {
      await remote.deleteContact(id);
      return true;
    } catch (_) {
      return false;
    }

  }
}