import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/contact.dart';

class ContactRemoteDataSource {
  final _db = FirebaseFirestore.instance;

  Stream<List<Contact>> getContacts() {
    return _db.collection('contacts').snapshots().map(
          (snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return Contact(
            id: doc.id,
            name: data['name'],
            phone: data['phone'],
            imagePath: data['imagePath'], // local path
          );
        }).toList();
      },
    );
  }

  Future<void> addContact(String name, String phone, String imagePath) async {
    await _db.collection('contacts').add({
      'name': name,
      'phone': phone,
      'imagePath': imagePath,
    });
  }

  Future<void> updateContact(String id, String name, String phone) async {
    await _db.collection('contacts').doc(id).update({
      'name': name,
      'phone': phone,
    });
  }

  Future<void> deleteContact(String id) async {
    await _db.collection('contacts').doc(id).delete();
  }
}
