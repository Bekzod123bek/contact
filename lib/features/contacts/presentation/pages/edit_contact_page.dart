import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../domain/contact.dart';
import '../cubit/contact_cubit.dart';

class EditContactPage extends StatefulWidget {
  final Contact contact;

  const EditContactPage({
    super.key,
    required this.contact,
  });

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}
class _EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;


  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.contact.name);
    _phoneCtrl = TextEditingController(text: widget.contact.phone);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('editContact'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'enterName'.tr(); // Ism kiriting
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'onlyText'.tr(); // Faqat harf
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'name'.tr(),
                ),
              ),


              const SizedBox(height: 12),

              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'enterPhone'.tr(); // Telefon kiriting
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'onlyNumber'.tr(); // Faqat raqam
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'phone'.tr(),
                ),
              ),


              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return; // ❌ xato bo‘lsa saqlamaydi
                    }

                    final success =
                    await context.read<ContactCubit>().updateContact(
                      widget.contact.id,
                      _nameCtrl.text.trim(),
                      _phoneCtrl.text.trim(),
                    );

                    if (!context.mounted) return;

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('done'.tr()),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('fail'.tr()),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },

                  child: Text('save'.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}