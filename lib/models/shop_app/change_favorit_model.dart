class ChangeFavoritesModel
{
  bool ?status ;
  String ? message;

  ChangeFavoritesModel.forJson(Map<String , dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}