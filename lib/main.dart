import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter2/layout/news_app/cubit/cubit.dart';
import 'package:flutter2/layout/news_app/cubit/states.dart';
import 'package:flutter2/layout/news_app/news_layout.dart';
import 'package:flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:flutter2/layout/shop_app/shop_app_layout.dart';
import 'package:flutter2/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter2/modules/shop_app/on_boarding/on_boarding_screen.dart';

//import 'package:flutter2/modules/counter/counter_screen.dart';
import 'package:flutter2/shared/bloc_observer.dart';
import 'package:flutter2/shared/component/constance.dart';
import 'package:flutter2/shared/cubit/cubit.dart';
import 'package:flutter2/shared/cubit/states.dart';
import 'package:flutter2/shared/network/local/cash_helper.dart';
import 'package:flutter2/shared/network/remote/dio_helper.dart';
import 'package:flutter2/shared/style/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/utils/utils.dart';

//import 'layout/todo_app/todo_layout.dart';

void main() {
  //السطر دا بيتاكد ان كل حاجه هنا خلصت وبعدين يفتح  الابليكيشن يعني runapp
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () async {
      DioHelper.init();
      await CacheHelper.init();
      var isDark = CacheHelper.getData(key: 'isDark') ?? false;
      Widget widget;
      var onBoarding = CacheHelper.getData(key: 'onBoarding');
       token = CacheHelper.getData(key: 'token');
       print('token is ${token}');

      if (onBoarding != null) {
        if (token != null) {
          widget = ShopLayout();
        } else {
          widget = ShopLoginScreen();
        }
      } else {
        widget = OnBoardingScreen();
      }

      runApp(MyApp(isDark, widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  late final bool isDark;
  late final Widget startWidget;

  MyApp(this.isDark, this.startWidget);

  // constructor
  // build

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..GetBusiness()),
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesModel()..getFavoritesData()..getUserData()),
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..ChangaAppModa(
                fromShared: isDark,
              ))
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
