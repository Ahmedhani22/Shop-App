import 'package:flutter2/modules/shop_app/search/states.dart';
import 'package:flutter2/shared/component/constance.dart';
import 'package:flutter2/shared/network/end_points.dart';
import 'package:flutter2/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchShopInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void searh(text) {
    emit(SearchShopLoadinglStates());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchShopSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SearchShopErrorStates());
    });
  }
}
