import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3_bloc/cubit/mahasiswa_cubit.dart';
import 'package:tp3_bloc/cubit/mahasiswa_state.dart';
import 'dart:developer' as developer;

class DetailMahasiswaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Mahasiwa'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            BlocBuilder<mahasiswaCubit, mahasiswaModel>(
                buildWhen: (previousState, state) {
              developer.log('${previousState.name}->${state.name}',
                  name: 'log');
              return true;
            }, builder: (context, mahasiswaDetail) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          'Nama: ${mahasiswaDetail.name}',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('NIM: ${mahasiswaDetail.nim}',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text("Jenis Kelamin: ${mahasiswaDetail.jenis_kelamin}",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('Umur: ${mahasiswaDetail.umur} ',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('Asal Kota: ${mahasiswaDetail.asal_kota}',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        ));
  }
}
