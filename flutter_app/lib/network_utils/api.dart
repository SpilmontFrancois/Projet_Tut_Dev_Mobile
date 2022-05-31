import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://192.168.1.106:8000/api';
  String token = '';

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!);
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  postData(apiUrl, {data}) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    if (data == null) {
      return await http.post(Uri.parse(fullUrl), headers: _setHeaders());
    } else {
      return await http.post(Uri.parse(fullUrl),
          body: jsonEncode(data), headers: _setHeaders());
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        if (token != '') 'Authorization': 'Bearer $token'
      };
}
