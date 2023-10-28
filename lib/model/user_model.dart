class UserModel{
  late String name;
  late String email;


  UserModel.fromJson(Map data){
    name= data['name'];
    email= data['email'];
  }
}


