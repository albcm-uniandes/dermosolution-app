import 'package:dermosolution_app/src/features/configuration/form_configuration.dart';
import 'package:dermosolution_app/src/features/dermatological_profile/dermatological_profile.dart';
import 'package:dermosolution_app/src/features/login/presentation/screens/login_screen.dart';
import 'package:dermosolution_app/src/features/medical_case/presentation/screens/case_creation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main()  async{
  try{
    await dotenv.load();
  } on Error catch(_){
    print(_);
  }
    runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DermoSolution',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const <Locale>[Locale('en'), Locale('es')],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'perfil_dermatologico': (context) => const DermatologicalProfile(),
      },
      home: const LoginScreen(),
    );
  }
}

