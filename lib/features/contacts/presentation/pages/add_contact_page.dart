import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/utils/snackbar.dart';
import '../../../../core/utils/validator.dart';
import '../cubit/contact_cubit.dart';
import '../widgets/app_text_field.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}
class _AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  File? _image;


  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addContact'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
         key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(Icons.camera_alt, size: 28)
                      : null,
                ),
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _nameController,
                label: 'name',
                validator: nameValidator,
              ),


              const SizedBox(height: 10),

              AppTextField(
                controller: _phoneController,
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
                        return;
                      }

                      if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('selectImage'.tr())),
                        );
                        return;
                      }

                      final success = await context.read<ContactCubit>().addContact(
                        _nameController.text.trim(),
                        _phoneController.text.trim(),
                        _image!.path,
                      );

                      if (!context.mounted) return;

                      if (success) {
                        showSnack(context, 'done');

                        Navigator.pop(context);
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