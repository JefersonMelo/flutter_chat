import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/enums_utils.dart';
import '../widgets/AppBars/appbar_wd.dart';
import '../widgets/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<int> _counter;
  int _externalCounter = 0;
  final String keyCounter = 'counter';
  String userName = '';
  String email = '';
  String imagePath = '';

  final Future<SharedPreferencesWithCache> _prefs = SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: <String>{'counter'},
    ),
  );

  Future<void> _incrementCounter() async {
    final SharedPreferencesWithCache prefs = await _prefs;
    final int counter = (prefs.getInt(keyCounter) ?? 0) + 1;
    setState(() {
      _counter = prefs.setInt(keyCounter, counter).then((_) {
        return counter;
      });
    });
  }

  Future<void> _getExternalCounter() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final int counter = await (prefs.getInt('externalCounter')) ?? 0;
    setState(() {
      _externalCounter = counter;
    });
  }

  Future<void> getUserValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    imagePath = prefs.getString(EnumsPreferencesUtils.keyPathImage.name) ?? '';
    userName = prefs.getString(EnumsPreferencesUtils.keyUserName.name) ?? '';
    email = prefs.getString(EnumsPreferencesUtils.keyEmail.name) ?? '';

    // prefs.remove(EnumsPreferencesUtils.keyPathImage.name);
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferencesWithCache prefs) {
      return prefs.getInt(keyCounter) ?? 0;
    });
    _getExternalCounter();
    getUserValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Contador'),
      drawer: DrawerWidget(imagePath: imagePath, userName: userName, email: email),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<int>(
                future: _counter,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          'Button tapped ${snapshot.data ?? 0 + _externalCounter} time${(snapshot.data ?? 0 + _externalCounter) == 1 ? '' : 's'}.\n\n'
                          'This should persist across restarts.',
                        );
                      }
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
