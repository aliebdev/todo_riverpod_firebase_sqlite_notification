import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/routes/routes.dart';
import 'package:todo/features/auth/controllers/user_controller.dart';
import 'package:todo/features/onboarding/pages/on_boarding_page.dart';
import 'package:todo/firebase_options.dart';

import 'common/utils/constants.dart';
import 'features/todo/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    final users = ref.watch(userProvider);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 825),
      minTextAdapt: true,
      builder: (context, child) {
        return DynamicColorBuilder(
            builder: (lightColorScheme, darkColorScheme) {
          return MaterialApp(
            title: "Todo",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Constants.kBkDark,
              colorScheme: lightColorScheme ?? defaultLightColorScheme,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Constants.kBkDark,
              colorScheme: darkColorScheme ?? defaultDarkColorScheme,
              useMaterial3: true,
            ),
            themeMode: ThemeMode.dark,
            home: users.isEmpty ? const OnBoardingPage() : const HomePage(),
            onGenerateRoute: Routes.onGenerateRoute,
          );
        });
      },
    );
  }
}
