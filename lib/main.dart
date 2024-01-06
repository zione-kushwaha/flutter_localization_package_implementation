import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:language_changes/l10n/providers/controller.dart';
import 'package:language_changes/navigation.dart';
import 'package:language_changes/screen2.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

enum Language { English, Nepali }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => language_controller()),
      ],
      child: Consumer<language_controller>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en'),
              Locale('ne'),
            ],
            locale: provider.Get_app_locale ?? Locale('en'),
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences sp;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
        centerTitle: true,
      
        actions: [
          PopupMenuButton<Language>(
            onSelected: (Language val) async {
              Provider.of<language_controller>(context, listen: false)
                  .change_language(Locale(val == Language.English ? 'en' : 'ne'));

              // Update shared preferences
              await sp.setString('language_code', val == Language.English ? 'en' : 'ne');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Language>>[
              const PopupMenuItem<Language>(
                value: Language.English,
                child: Text('English'),
              ),
              const PopupMenuItem<Language>(
                value: Language.Nepali,
                child: Text('Nepali'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: ElevatedButton(
            onPressed: (){
                   Navigator.push(context, createRoute(screen2())); 
            },
            child: Text(AppLocalizations.of(context)!.navigate_to_screen_2)),)
        ],
      ),
    );
  }

}
