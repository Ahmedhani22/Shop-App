class CategoriesModel
{
  bool ? status;
  categoriesDataModel ? data;

  CategoriesModel.fromJson(Map<String , dynamic>json)
  {
    status = json['status'];
     data = categoriesDataModel.fromJson(json['data']);
  }
}

class categoriesDataModel
{
  int ? currentPage;
  List<dataModel> data=[];

  categoriesDataModel.fromJson(Map<String , dynamic>json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element)
        {
          data.add(dataModel.fromJson(element));
        }
    );

  }
}

class dataModel
{
  int ? id;
  String ? name;
  String ? image;

  dataModel.fromJson(Map<String , dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}