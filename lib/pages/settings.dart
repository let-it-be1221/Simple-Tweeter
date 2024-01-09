import 'dart:io';

import 'package:demo2_form/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = ref.watch(userProvider).user.name;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
    // Pick an image.
                  final XFile? pickedImage = await picker.pickImage(
                      source: ImageSource.gallery, requestFullMetadata: false);
                  if (pickedImage != null) {
                    ref
                        .read(userProvider.notifier)
                        .updateImage(File(pickedImage.path));
                  }
                },
                child: CircleAvatar(
                  radius: 100,
                  foregroundImage:
                      NetworkImage(ref.read(userProvider).user.profilePic),
                ),
              ),
              Center(
                child: Text("Tap Image To Change"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Input Your Name'),
              ),
              TextButton(
                  onPressed: () {
                    ref
                        .watch(userProvider.notifier)
                        .updateName(_nameController.text);
                  },
                  child: Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}
