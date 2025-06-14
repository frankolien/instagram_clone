import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/responsive/mobile_screen_layout.dart';
import 'package:flutter_application_1/responsive/responsive_layout_screen.dart';
import 'package:flutter_application_1/responsive/web_screen_layout.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBn7_i7WVTbEnUoAaWQL_-MTBGNZJx0RUI",
        appId: "1:502117131481:web:1ca23a83b834bb6fc48ac8",
        messagingSenderId: "1234567890",
        projectId: "your-project-id",
        storageBucket: "instagram-flutter-868dd.firebasestorage.app",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        
      ],
      child: MaterialApp(
        title: 'Instagram clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor
          ),
          home: StreamBuilder(
            
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayoutScreen(
                    mobileScreenLayout: MobileScreenLayout(), 
                    webScreenLayout: WebScreenLayout()
                    );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
              }else {
              // Optionally sign out the user if Firestore doc is missing
              FirebaseAuth.instance.signOut();
              return const LoginScreen();
            }
              
              // While waiting for the connection to complete, show a loading indicator
              if(snapshot.connectionState == ConnectionState.waiting){
                 return const Center(child: CircularProgressIndicator(
                color: primaryColor,
              ));
              }
              return const LoginScreen();
            }, 
            
            
          ),
      ),
    ); 
  }
} 