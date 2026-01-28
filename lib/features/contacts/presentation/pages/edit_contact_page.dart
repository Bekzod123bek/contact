import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/utils/snackbar.dart';
import '../../../../core/utils/validator.dart';
import '../../domain/contact.dart';
import '../cubit/contact_cubit.dart';
import '../widgets/app_text_field.dart';

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
              AppTextField(
                controller: _nameCtrl,
                label: 'name',
                validator: nameValidator,
              ),


              const SizedBox(height: 12),

              AppTextField(
                controller: _phoneCtrl,
                label: 'phone',
                keyboardType: TextInputType.phone,
                validator: phoneValidator,
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
                      showSnack(context, 'done');
                      Navigator.pop(context);
                    } else {
                      showSnack(context, 'fail', success: false);
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