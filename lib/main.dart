import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_ever_young/Network/Local/cache_helper.dart';
import 'package:for_ever_young/cubit/cubit.dart';
import 'package:for_ever_young/cubit/states.dart';
import 'package:for_ever_young/layout/for_ever_young_layout.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';
import 'package:for_ever_young/shared/colors_and_themes/themes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init(); // Initialize SharedPreferences

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark ?? false));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForEverYoungCubit()..changeAppMode(fromShared: isDark),
      child: BlocBuilder<ForEverYoungCubit, ForEverYoungStates>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                scrolledUnderElevation: 0,
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                iconTheme: IconThemeData(
                  color: buttonColor,
                ),
                titleTextStyle: TextStyle(
                  color: lightTextColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                centerTitle: true,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: buttonColor,
                unselectedItemColor: Colors.black,
                elevation: 0,
                unselectedLabelStyle: TextStyle(
                    color: Colors.grey[400]
                ),
                backgroundColor: Colors.white, // Soft light grey for a smooth transition
              ),
              iconTheme: IconThemeData(
                color: buttonColor,
              ),
              textTheme: TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: lightTextColor,
                ),
                bodyMedium: TextStyle(
                  fontSize: 30.0,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  color: lightTextColor,
                ),
                bodySmall: TextStyle(
                  fontSize: 20.0,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  color: lightTextColor,
                ),
              ),
              fontFamily: 'MainFont',
            ),
            darkTheme: darkTheme,
            themeMode: ForEverYoungCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child:  const ForEverYoungLayout(),
            ),
              // child: ForEverYoungLayout(),
            );
        },
      ),
    );
  }
}