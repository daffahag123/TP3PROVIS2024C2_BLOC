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
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: mahasiswaList.length,
                        itemBuilder: (context, index) {
                          if (mahasiswaList[0].name != "") {
                            return Card(
                              elevation: 3,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      context.read<mahasiswaCubit>().fetchData(mahasiswaList[index].id);
                                      return DetailMahasiswaPage();
                                    }),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 12),
                                    Expanded( // Wrap the Image widget with Expanded
                                      child: Image.network(
                                        'https://cdn.icon-icons.com/icons2/1879/PNG/512/iconfinder-3-avatar-2754579_120516.png',
                                        fit: BoxFit.cover, // Ensure the image covers the available space
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      mahasiswaList[index].name,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(mahasiswaList[index].nim),
                                    SizedBox(height: 8),
                                  ],
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
