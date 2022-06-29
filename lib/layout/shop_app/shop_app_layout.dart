import 'package:flutter/material.dart';
import 'package:flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:flutter2/layout/shop_app/cubit/states.dart';
import 'package:flutter2/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter2/modules/shop_app/search/search_screen.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter2/shared/network/local/cash_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, ShopSearchScreen());
              }, icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [

              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'favorite'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings'),
            ],
          ),

        );

    }


    );
  }
}
