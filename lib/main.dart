import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wazaaf/components/bloc_observer.dart';
import 'package:wazaaf/modules/news/cubit/cubit.dart';
import 'package:wazaaf/modules/news/news_layout.dart';
import 'package:wazaaf/modules/to_do/cubit/cubit.dart';
import 'package:wazaaf/modules/to_do/cubit/states.dart';
import 'package:wazaaf/network/local/cache_helper.dart';
import 'package:wazaaf/network/remote/dio_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // sure that methods will be called before runApp
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //NewsCubit()..getBusiness()..getScience()..getSports(),
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NewsCubit()..getBusiness()..getScience()..getSports()),
          BlocProvider(create: (BuildContext context) => AppCubit(),),
        ],
        child: BlocConsumer<AppCubit,AppStates>(
            listener: (context,state){},
            builder: (context,state){
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
                theme: ThemeData(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.deepOrange,
                    secondary: Colors.deepOrange,
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: Colors.deepOrange,
                  appBarTheme: const AppBarTheme(
                    titleSpacing: 20.0,
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    actionsIconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    unselectedIconTheme: IconThemeData(
                      color: Colors.grey,
                    ),
                    elevation: 20.0,
                    backgroundColor: Colors.white,
                  ),
                  floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange,
                  ),
                ),
                darkTheme: ThemeData(
                  colorScheme: const ColorScheme.dark(
                    primary: Colors.deepOrange,
                    secondary: Colors.deepOrange,
                  ),
                  scaffoldBackgroundColor: HexColor('0A0A0A'),
                  primarySwatch: Colors.deepOrange,
                  appBarTheme: AppBarTheme(
                    backgroundColor: HexColor('0A0A0A'),
                    elevation: 0.0,
                    actionsIconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('0A0A0A'),
                      statusBarIconBrightness: Brightness.light,
                    ),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    unselectedIconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    elevation: 20.0,
                    backgroundColor: HexColor('0A0A0A'),
                  ),
                  floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange,
                  ),
                ),
                home: const NewsLayout(),
                //Directionality: TextDirection.rtl,
                //Converting app to right direction(arabic)
              );
            },
          ),
      );
  }
}