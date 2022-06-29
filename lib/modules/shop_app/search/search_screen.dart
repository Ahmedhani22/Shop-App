import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:flutter2/modules/news_app/search/search_screen.dart';
import 'package:flutter2/modules/shop_app/search/cubit.dart';
import 'package:flutter2/modules/shop_app/search/states.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var SearchControllre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: [SystemUiOverlay.bottom]);
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: SearchControllre,
                        type: TextInputType.text,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                            {
                              return 'enter text to search';
                            }
                        },
                        onSubmit: (text){
                          SearchCubit.get(context).searh(text);
                        },
                        label: 'Search',
                        prefix: Icons.search,
                      ),
                      SizedBox(height: 10.0,),
                      if(state is SearchShopLoadinglStates)
                      LinearProgressIndicator(),
                      SizedBox(height: 10.0,),
                      if(state is SearchShopSuccessStates)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index)=>buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice : false),
                            separatorBuilder: (context, index)=> MyDivider(),
                            itemCount: SearchCubit.get(context).model!.data!.data!.length),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
