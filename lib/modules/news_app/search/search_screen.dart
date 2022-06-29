import 'package:flutter/material.dart';
import 'package:flutter2/layout/news_app/cubit/cubit.dart';
import 'package:flutter2/layout/news_app/cubit/states.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var list =NewsCubit.get(context).search;
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Search must be not empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search,
                    onChange: (value)
                    {
                      NewsCubit.get(context).GetSearch(value);
                    }
                ),
              ),
              Expanded(child: articlebuilder(list, context, isSearch : true,))
            ],
          ),
        );
      },
    );
  }
}
