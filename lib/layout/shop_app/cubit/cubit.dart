import 'package:flutter/material.dart';
import 'package:flutter2/layout/shop_app/cubit/states.dart';
import 'package:flutter2/models/shop_app/Categories_model.dart';
import 'package:flutter2/models/shop_app/Favorites_Model.dart';
import 'package:flutter2/models/shop_app/change_favorit_model.dart';
import 'package:flutter2/models/shop_app/home_model.dart';
import 'package:flutter2/models/shop_app/login_model.dart';
import 'package:flutter2/modules/shop_app/cateogries/cateogries_screen.dart';
import 'package:flutter2/modules/shop_app/favorites/favorites_screen.dart';
import 'package:flutter2/modules/shop_app/products/products_screen.dart';
import 'package:flutter2/modules/shop_app/settings/setting_screen.dart';
import 'package:flutter2/shared/component/constance.dart';
import 'package:flutter2/shared/network/end_points.dart';
import 'package:flutter2/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitiialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
        print(favorites.toString());
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(ShopErrorHomeDataState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesModel() {
    DioHelper.getData(
      url: Get_Category,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(ShopErrorCategoriesState(error));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void ChangeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
   emit(ShopChangeFavoritesState());
    DioHelper.postData
      (
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    )
    .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.forJson(value.data);
      print(value.data);

      if(!changeFavoritesModel!.status!)
        {
          favorites[productId] = !favorites[productId]!;
        }else{
        getFavoritesData();
      }
    emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
    emit(ShopErrorChangeFavoritesState(error));
    });
  }


  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    )
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState(error.toString()));
      print(error.toString());
    });
  }

  ShopLoginModel ? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    )
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUserDataState(error.toString()));
      print(error.toString());
    });
  }

  void getUpdataUser({
  required String name,
    required String email,
    required String phone,
}) {
    emit(ShopLoadingUpdataUserState());
    DioHelper.putData(url: UPDATA_PROFILE, data: {
      'name':name,
      'email':email,
      'phone':phone,
    },token: token)
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);

      emit(ShopSuccessUpdataUserState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUpdataUserState(error.toString()));
      print(error.toString());
    });
  }
}
