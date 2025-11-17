import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // TODO: Pass firebase options here for web/other environments if needed
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BabyCare Tracker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FirebaseInitChecker(),
    );
  }
}

/// Widget that checks and confirms Firebase connection
class FirebaseInitChecker extends StatefulWidget {
  const FirebaseInitChecker({Key? key}) : super(key: key);

  @override
  State<FirebaseInitChecker> createState() => _FirebaseInitCheckerState();
}

class _FirebaseInitCheckerState extends State<FirebaseInitChecker> {
  late Future<void> _firebaseFuture;

  @override
  void initState() {
    super.initState();
    _firebaseFuture = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(title: const Text('Firebase Connected!')),
            body: const Center(
              child: Text(
                'Firebase initialized successfully 🎉',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Firebase Error')),
            body: Center(
              child: Text(
                'Firebase error: \n\n'
                'details: \n${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

// Root feature folders (to be implemented):
// data/, logic/, presentation/, core/, injection/
