import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_latest/providers/user_provider.dart';
import 'package:flutter_instagram_latest/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_latest/responsive/responsive_layout_screen.dart';
import 'package:flutter_instagram_latest/responsive/web_screen_layout.dart';
import 'package:flutter_instagram_latest/screens/login_screen.dart';
import 'package:flutter_instagram_latest/screens/signup_screen.dart';
import 'package:flutter_instagram_latest/utils/colors.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider(),),
      ],
      child: MaterialApp(
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
      //   home:const ResponsiveLayout(mobileScrenLayout: MobileScreenLayout(),
      //     webScreenLayout: WebScreenLayout(),),
      // );
        //Method 1: Using StreamBuilder() for a method. 1. Uising id token changes
        // 1. FIrebaseAuth.instance.idTokenChanges():
        // 2. FirebaseAuth.instace.userChanges() while updating passworrd, it provides benefits.
        // 3. AuthStateChagnes
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.hasData){
                  // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                  return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  );
                }
                else if(snapshot.hasError){
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                }
                }
            if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
            ),
            );
      }

            return const LoginScreen();

      }
      )
      ),
    );
  }
}