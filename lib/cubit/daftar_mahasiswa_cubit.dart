import 'package:tp3_bloc/cubit/mahasiswa_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class mahasiswaListCubit extends Cubit<List<mahasiswaModel>> {
  String url = "http://127.0.0.1:8000/daftar_mahasiswa";
  mahasiswaListCubit()
      : super([
          mahasiswaModel(
              id: "",
              name: "",
              nim: "",
              jenis_kelamin: "",
              umur: "",
              asal_kota: "")
        ]);

  //map dari json ke atribut
  void setFromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['data'];
    List<mahasiswaModel> mahasiswaList = data
        .map((e) => mahasiswaModel(
            id: e['id'],
            name: e['name'],
            nim: e['nim'],
            jenis_kelamin: e['jenis_kelamin'],
            umur: e['umur'],
            asal_kota: e['asal_kota']))
        .toList();
    emit(mahasiswaList);
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //sukses
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}
