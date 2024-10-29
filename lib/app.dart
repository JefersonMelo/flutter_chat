import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/splash_screem_page.dart';
import 'configs/user_prefs_config.dart';
import 'configs/logged_config.dart';
import 'pages/home_page.dart';
import 'services/counter_service.dart';
import 'utils/enums_utils.dart';
import 'configs/custom_theme_config.dart';

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
  String appStatus = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appStatus = state.toString().split('.')[1];
    if (state == AppLifecycleState.paused) {
      _removeLoginStatus();
    }
  }

  Future<void> _removeLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(EnumsPreferencesUtils.keyLoggedIn.name);
  }

  void restartApp() {
    setState(() => key = UniqueKey());
  }

  @override
  Widget build(BuildContext bc) {
    Intl.defaultLocale = 'pt_BR';
    CustomThemeConfig custonTheme = CustomThemeConfig();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoggedConfig>(create: (_) => LoggedConfig()),
        ChangeNotifierProvider<CounterService>(create: (_) => CounterService()),
        ChangeNotifierProvider<UserPrefsConfig>(create: (_) => UserPrefsConfig()),
      ],
      child: Consumer<UserPrefsConfig>(
        builder: (context, userPreferences, widget) {
          final statusLoggedIn = context.watch<LoggedConfig>();
          return MaterialApp(
            title: 'Flutter Template',
            debugShowCheckedModeBanner: false,
            locale: const Locale('pt'),
            theme: userPreferences.isDarkMode ? custonTheme.darkTheme : custonTheme.lightTheme,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'UK')],
            home: statusLoggedIn.isLoggedIn ? HomePage(title: 'Contador Page') : SplashScreemPage(),
          );
        },
      ),
    );
  }
}
