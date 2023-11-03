import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   if(kIsWeb){
      await Firebase.initializeApp(
         options: const FirebaseOptions(
            apiKey: "AIzaSyDZhhIFlQ2etoRJWKts512YNcrKB44I2Pc",
            appId: "1:996834496339:web:2a18c845acd22293cbdba6",
            messagingSenderId: "996834496339",
            projectId: "instagrame-clone-ef411",
            storageBucket: "instagrame-clone-ef411.appspot.com",),
      );
   }else{
      await Firebase.initializeApp();
   }
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

   // This widget is the root of your application.
   @override
   Widget build(BuildContext context) {
      return MultiProvider(
         providers: [
            ChangeNotifierProvider(create: (_)=>UserProvider(),),
         ],
         child: MaterialApp(
            title: 'Instagram Clone',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(
               scaffoldBackgroundColor: mobileBackgroundColor,
            ),
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                   if(snapshot.connectionState==ConnectionState.active) {
                      if(snapshot.hasData){
                         return const ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout(),);
                      }else if(snapshot.hasError){
                         return Center(child: Text('${snapshot.error}'),);
                      }
                   }
                   if(snapshot.connectionState==ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(color: primaryColor,),);

                   }
                   return const LogInScreen();
                }
            ),
            // home: const LogInScreen(),
         ),
      );
   }
}


