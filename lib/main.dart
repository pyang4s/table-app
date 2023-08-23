import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test23/providers/agent_state_provider.dart';
import 'package:test23/providers/bulk_updates_provider.dart';
import '/pages/homepage.dart';
import 'providers/home_page_provider.dart';

///
/// main method for app and Firebase Initialization
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCpu794PuNI14EcCT-bHXYwKGz4u9kJa44",
          authDomain: "table-app-e7e28.firebaseapp.com",
          databaseURL: "https://table-app-e7e28-default-rtdb.firebaseio.com",
          projectId: "table-app-e7e28",
          storageBucket: "table-app-e7e28.appspot.com",
          messagingSenderId: "990520905461",
          appId: "1:990520905461:web:9429fb847bd0187de73fbc"
      ));

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ChangeNotifierProvider(create: (_) => AgentStateProvider()),
      ChangeNotifierProvider(create: (_) => BulkUpdatesProvider()),
    ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      )
    );
  }
}
