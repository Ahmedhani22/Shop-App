import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:flutter2/layout/shop_app/cubit/states.dart';
import 'package:flutter2/models/shop_app/Favorites_Model.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter2/shared/style/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
      builder: (context,state){
        return ConditionalBuilderRec(
          condition: state is !ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index)=>buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
              separatorBuilder: (context, index)=> MyDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length),
          fallback: (context)=> CircularProgressIndicator(),

        );
      },

    );
  }

}