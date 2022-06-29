import 'package:flutter2/models/shop_app/change_favorit_model.dart';
import 'package:flutter2/models/shop_app/login_model.dart';

abstract class ShopStates{}
class ShopInitiialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  final String error;

  ShopErrorHomeDataState(this.error);

}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{
  final String error;

  ShopErrorCategoriesState(this.error);
}
class ShopSuccessChangeFavoritesState extends ShopStates
{
  late final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopChangeFavoritesState extends ShopStates{

}
class ShopErrorChangeFavoritesState extends ShopStates{
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{
  final String error;

  ShopErrorGetFavoritesState(this.error);
}

class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);

}
class ShopErrorUserDataState extends ShopStates{
  final String error;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdataUserState extends ShopStates{}
class ShopSuccessUpdataUserState extends ShopStates{
  final ShopLoginModel loginModel;
  ShopSuccessUpdataUserState(this.loginModel);

}
class ShopErrorUpdataUserState extends ShopStates{
  final String error;

  ShopErrorUpdataUserState(this.error);
}



