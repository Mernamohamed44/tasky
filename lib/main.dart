import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/app/caching/shared_prefs.dart';
import 'package:tasky/app/dependancy_injection/dependancy_injection.dart';
import 'package:tasky/features/onboarding/presentation/screen/onboarding_screen_view.dart';
import 'package:tasky/features/tasks/presentation/screens/home_screen.dart';

import 'app/bloc_observer/bloc_observer.dart';
import 'app/helper/navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Caching.init(),
    setupGetIt(),
  ]);

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Caching.get(key: "access_token");
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'tasky',
        debugShowCheckedModeBanner: false,
        home: user != null ? const HomeView() : const OnBoardingView(),
      ),
    );
  }
}
