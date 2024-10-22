import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'pages/splash_screem_page.dart';
import 'utils/enums_utils.dart';
import 'configs/custom_theme_config.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(EnumsPreferencesUtils.keyDarkMode.name, _isDarkMode);
    notifyListeners();
  }
}

class App extends StatefulWidget {
  const App({super.key});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_AppState>()!.restartApp();
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  Key key = UniqueKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadingSharedPreferences();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _removeLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(EnumsPreferencesUtils.keyLoggedIn.name);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _removeLoginStatus();
    }
  }

  void restartApp() {
    setState(() => key = UniqueKey());
  }

  Future<SharedPreferences> loadingSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_BR';
    CustomThemeConfig custonTheme = CustomThemeConfig();
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final prefs = snapshot.data;
          final isDarkMode = prefs!.getBool(EnumsPreferencesUtils.keyDarkMode.name) ?? false;
          final isLoggedIn = prefs.getBool(EnumsPreferencesUtils.keyLoggedIn.name) ?? false;
          debugPrint(isLoggedIn.toString());
          return ChangeNotifierProvider(
            create: (context) => ThemeProvider().._isDarkMode = isDarkMode,
            child: KeyedSubtree(
              key: key,
              child: MaterialApp(
                title: 'Flutter Template',
                debugShowCheckedModeBanner: false,
                locale: const Locale('pt'),
                theme: isDarkMode ? custonTheme.darkTheme : custonTheme.lightTheme,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'UK')],
                home: isLoggedIn ? HomePage(title: 'Contador Page') : SplashScreemPage(),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
