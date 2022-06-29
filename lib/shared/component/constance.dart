import 'package:flutter2/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter2/shared/network/local/cash_helper.dart';

void SignOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String ? token ='';
