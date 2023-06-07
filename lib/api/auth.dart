import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, dynamic>> register(String name, String email,
      String password, String location, int phone) async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8000/api/auth/register"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "phone_number": phone,
        "location": location,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Failure
      throw Exception('Failed to sign up');
    }
  }
}






 /*String url = "http://10.0.2.2:8000/api/auth/register";

      var data = {
        "name": fullname.text,
        "email": email.text,
        "password": password.text,
        "phone_number": phone.text,
        "location": location.text,
      };
      var bodyy = json.encode(data);
      var urlParse = Uri.parse(url);
      Response response = await http.post(urlParse,
          body: bodyy, headers: {"Content-Type": "application/json"});
      String dataa = response.body;
      var jsondataa = json.decode(dataa);
      print(response.statusCode);
      print(jsondataa);
      if (response.statusCode == 200) {
        print("success");
        sharedPreferences.setString('token', jsondataa['token']);

        String? token = sharedPreferences.getString('token');

        print(token);
        ShowSnackBar.showSnackBar(text: "Registered Successfully");
        CircleAvatar(
                            radius: 48,
                            backgroundColor: AppColors.white,
                            backgroundImage: AssetImage(AppImages.user),
                          ), CircleAvatar(
                            radius: 48,
                            backgroundColor: AppColors.white,
                            backgroundImage: AssetImage(AppImages.user),
                          ),
      } else {
        ShowSnackBar.errorSnackBar(text: "Error");
      }
    }


  )
}
*/