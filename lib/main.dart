import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intern_assignment/screens/Details_View.dart';
import 'package:intern_assignment/utils/routes/routes.dart';
import 'package:intern_assignment/utils/routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'model/CategoryAdapter.dart';
import 'screens/Home_View.dart';

Future<void> main() async {
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(CategoryAdapter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.home,
        onGenerateRoute: Routes.generateRoute,
      ),
      designSize: const Size(375, 812),
    );
  }
}

