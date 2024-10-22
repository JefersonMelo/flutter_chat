import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app.dart';
import '../pages/login_page.dart';
import '../pages/shared_preferences_page.dart';
import '../shared/app_images.dart';
import '../utils/enums_utils.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key, required this.imagePath, required this.userName, required this.email});
  final String userName;
  final String email;
  final String imagePath;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    late SharedPreferences prefs;
    String pathImage = AppImages.iconImg;

    Future<void> removeLoginStatus() async {
      prefs = await SharedPreferences.getInstance();
      prefs.remove(EnumsPreferencesUtils.keyLoggedIn.name);
    }

    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext bc) {
                  return Wrap(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text('Camera'),
                        onTap: () async {
                          Navigator.pop(context);
                          final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                          if (photo != null) {
                            await Gal.putImage(photo.path);
                          }
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.photo_album),
                        title: const Text('Galeria'),
                        onTap: () async {
                          Navigator.pop(context);
                          XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          prefs = await SharedPreferences.getInstance();
                          if (image != null) {
                            prefs.setString(EnumsPreferencesUtils.keyPathImage.name, image.path.toString());
                            pathImage = image.path.toString();
                          }
                          setState(() {
                            App.restartApp(context);
                          });
                        },
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            },
            child: UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: (widget.imagePath.isEmpty)
                    ? Image.asset(
                        pathImage,
                        fit: BoxFit.contain,
                      )
                    : Image.file(
                        File(widget.imagePath),
                        fit: BoxFit.contain,
                      ),
              ),
              accountName: Text(widget.userName),
              accountEmail: Text(widget.email),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text('Shared Preferences'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (builder) => const SharedPreferencesPage()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.screen_search_desktop_outlined),
            title: const Text('url launcher'),
            onTap: () async {
              await launchUrl(Uri.parse('https://www.google.com/'));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              showDialog(
                context: context,
                builder: (builder) {
                  return AlertDialog(
                    title: const Text('Template Flutter'),
                    content: const Wrap(
                      children: [
                        Text('Realmente Deseja Sair?'),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Não')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            removeLoginStatus();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const LoginPage()));
                          },
                          child: const Text('Sim')),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
