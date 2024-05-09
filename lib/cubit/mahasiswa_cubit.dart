import 'package:tp3_bloc/cubit/mahasiswa_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class mahasiswaCubit extends Cubit<mahasiswaModel> {
  String url = "http://127.0.0.1:8000/detil_mahasiswa/";
  mahasiswaCubit()
      : super(mahasiswaModel(
            id: "",
            name: "",
            nim: "",
            jenis_kelamin: "",
            umur: "",
            asal_kota: ""));

  void setFromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String name = json['name'];
    String nim = json['nim'];
    String jenis_kelamin = json['jenis_kelamin'];
    String umur = json['umur'];
    String asal_kota = json['asal_kota'];
    emit(mahasiswaModel(
        id: id,
        name: name,
        nim: nim,
        jenis_kelamin: jenis_kelamin,
        umur: umur,
        asal_kota: asal_kota));
  }

  void fetchData(String id) async {
    final response = await http.get(Uri.parse(url + id));
    if (response.statusCode == 200) {
      //sukses
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}
