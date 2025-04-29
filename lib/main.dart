
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/tampoAdminUI.dart';

const firebaseOptionA = FirebaseOptions(
  apiKey: "AIzaSyDkButqRfTtXCfWbuPy5QG45_ysJy7rjuc",
  projectId: "tampo-app",
  messagingSenderId: "890500275772",
  appId: "1:890500275772:web:74cf8d7c7970428964ed39",
);
// apiKey: "AIzaSyAbdD1RrXXpGbayjnL5lNGvgpi7KMfTnYo",
// authDomain: "test-4afce.firebaseapp.com",
// databaseURL: "https://test-4afce-default-rtdb.firebaseio.com",
// projectId: "test-4afce",
// storageBucket: "test-4afce.appspot.com",
// messagingSenderId: "913774720474",
// appId: "1:913774720474:web:89f39a13ac5ac5fd7cbce3",
// measurementId: "G-XD7B748E6C");

const firebaseOptionB = FirebaseOptions(
    apiKey: "AIzaSyBIOhk_5EyQAoOt6l6FD12T9auXjyoaRWM",
    authDomain: "fir-d952a.firebaseapp.com",
    databaseURL: "https://fir-d952a-default-rtdb.firebaseio.com",
    projectId: "fir-d952a",
    storageBucket: "fir-d952a.appspot.com",
    messagingSenderId: "999374962386",
    appId: "1:999374962386:web:8f5ed115f6ce84241b770b",
    measurementId: "G-KTG4EVRNVP");

const firebaseOptionC = FirebaseOptions(
  apiKey: "AIzaSyCVMGNS9VHoojgT0dvANvJbHXW_yz_gYHQ",
  authDomain: "location-b7d16.firebaseapp.com",
  projectId: "location-b7d16",
  storageBucket: "location-b7d16.appspot.com",
  messagingSenderId: "883182709181",
  appId: "1:883182709181:web:94384b4c7ed3705f298ad4",
  measurementId: "G-KXDHLQBGS4",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for all 3 apps
  final appA =
      await Firebase.initializeApp(options:FirebaseOptions(
  apiKey: "AIzaSyDkButqRfTtXCfWbuPy5QG45_ysJy7rjuc",
  projectId: "tampo-app",
  messagingSenderId: "890500275772",
  appId: "1:890500275772:web:74cf8d7c7970428964ed39",
));
  final appB =
      await Firebase.initializeApp(name: 'appB', options: firebaseOptionB);
  final appC =
      await Firebase.initializeApp(name: 'appC', options: firebaseOptionC);

  runApp(
    ProviderScope(
      child: MyApp(appA: appA, appB: appB, appC: appC),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseApp appA;
  final FirebaseApp appB;
  final FirebaseApp appC;

  const MyApp({
    super.key,
    required this.appA,
    required this.appB,
    required this.appC,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Admin Panel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TampoAdminUI(
        appA:appC ,
        appB: appB,
      ),
    );
  }
}
