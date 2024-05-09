import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3_bloc/cubit/daftar_mahasiswa_cubit.dart';
import 'package:tp3_bloc/cubit/mahasiswa_cubit.dart';
import 'package:tp3_bloc/cubit/mahasiswa_state.dart';
import 'dart:developer' as developer;

import 'package:tp3_bloc/page/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Daftar Mahasiswa',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Selamat datang di Halaman Daftar Mahasiswa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<mahasiswaListCubit>().fetchData();
                  },
                  child: Text('Tampilkan Daftar Mahasiswa'),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<mahasiswaListCubit, List<mahasiswaModel>>(
                    buildWhen: (previousState, state) {
                      developer.log(
                          '${previousState[0].name}->${state[0].name}',
                          name: 'log');
                      return true;
                    },
                    builder: (context, mahasiswaList) {
                      return ListView.builder(
                        itemCount: mahasiswaList.length,
                        itemBuilder: (context, index) {
                          if (mahasiswaList[0].name != "") {
                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      context.read<mahasiswaCubit>().fetchData(mahasiswaList[index].id);
                                      return DetailMahasiswaPage();
                                    }),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                                        width: 50,
                                        height: 50,
                                      ),
                                      SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mahasiswaList[index].name,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 4),
                                          Text(mahasiswaList[index].nim),
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_forward),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox.shrink(); // Return an empty SizedBox if no data is available
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
