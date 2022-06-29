import 'package:flutter/material.dart';
import 'package:flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:flutter2/layout/shop_app/cubit/states.dart';
import 'package:flutter2/models/shop_app/Categories_model.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CateogriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
          itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context,index)=>MyDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }
  Widget buildCatItem( dataModel model) =>  Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image!,),
          height: 80.0,
          width: 80.0,
          fit: BoxFit.cover,),
        SizedBox(width: 10.0,),
        Text(model.name!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:TextStyle(

          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
      ],
    ),
  );

}
