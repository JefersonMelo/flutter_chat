import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/enums_utils.dart';
import '../../widgets/AppBars/appbar_wd.dart';
import '../configs/user_prefs_config.dart';

class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  late SharedPreferences storage;
  TextEditingController userNameControll = TextEditingController();
  TextEditingController emailControll = TextEditingController();
  TextEditingController heigthControll = TextEditingController();
  bool isPushNotification = false;

  @override
  void initState() {
    super.initState();
    loadingPreferences();
  }

  loadingPreferences() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      userNameControll.text = storage.getString(EnumsPreferencesUtils.keyUserName.name) ?? '';
      emailControll.text = storage.getString(EnumsPreferencesUtils.keyEmail.name) ?? '';
      heigthControll.text = (storage.getDouble(EnumsPreferencesUtils.keyHeigth.name) ?? 0).toString();
      isPushNotification = storage.getBool(EnumsPreferencesUtils.keyPush.name) ?? false;
    });
  }

  void onButtonTapped(BuildContext context) async {
    await storage.setString(EnumsPreferencesUtils.keyUserName.name, userNameControll.text);
    await storage.setString(EnumsPreferencesUtils.keyEmail.name, emailControll.text);
    await storage.setDouble(EnumsPreferencesUtils.keyHeigth.name, double.tryParse(heigthControll.text.replaceAll(',', '.')) ?? 0);
    await storage.setBool(EnumsPreferencesUtils.keyPush.name, isPushNotification);
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(
        title: 'Shared Preferences',
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              controller: userNameControll,
              decoration: const InputDecoration(hintText: 'Nome'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              controller: emailControll,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: heigthControll,
              decoration: const InputDecoration(hintText: 'Altura'),
            ),
          ),
          SwitchListTile(
              title: const Text('Receber Notificações'),
              value: isPushNotification,
              onChanged: (value) {
                setState(() {
                  isPushNotification = value;
                });
              }),
          Consumer<UserPrefsConfig>(
            builder: (context, userPrefs, child) {
              return Column(
                children: [
                  SwitchListTile(
                    title: Text('Tema Escuro'),
                    value: userPrefs.isDarkMode,
                    onChanged: (value) {
                      userPrefs.toggleTheme(value);
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      onButtonTapped(context);
                      userPrefs.getUserValues();
                    },
                    child: const Text('Salvar'),
                  )
                ],
              );
            },
          ),
        ],
      ),
    ));
  }
}
