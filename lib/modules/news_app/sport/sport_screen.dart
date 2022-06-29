import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/layout/news_app/cubit/cubit.dart';
import 'package:flutter2/layout/news_app/cubit/states.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SportScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list =NewsCubit.get(context).Sports;
        return articlebuilder(list,context);
      },

    );
  }
}
