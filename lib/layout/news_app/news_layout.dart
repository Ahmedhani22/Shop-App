import 'package:flutter/material.dart';
import 'package:flutter2/layout/news_app/cubit/cubit.dart';
import 'package:flutter2/layout/news_app/cubit/states.dart';
import 'package:flutter2/modules/news_app/search/search_screen.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter2/shared/cubit/cubit.dart';
import 'package:flutter2/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: ((context, NewsStates state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen(),);
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).ChangaAppModa();
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: cubit.Screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.ChangeBottomNavBar(index);
            },
            currentIndex: cubit.currentindex,
            items: cubit.BottomItem,
          ),
        );
      }),
    );
  }
}
