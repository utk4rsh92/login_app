import 'package:http/http.dart' as http;
import 'User.dart';
class Services{

 static const String url = 'https://api.unsplash.com/photos/?page=10&client_id=A2E06HZ2vgC_2EzZH8XgBQogSxinp1bmMQhKlCVTMiw';
 static Future<List<User>> getUsers() async{
   try{
     final response =  await http.get(Uri.parse(url));
     if(200 == response.statusCode){
        final List<User> users = userFromJson(response.body);
        return users;
     }
     else{
       return List<User>();
     }

   }catch(e){
     // ignore: deprecated_member_use
     return List<User>();
   }
 }

}