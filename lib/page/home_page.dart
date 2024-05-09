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
          foregroundColor: Colors.blue,
          title: Text(
            'My App',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    Text(
                        'NIM 1, NAMA 1; NIM 2, NAMA 2; Saya berjanji tidak akan berbuat curang data atau membantu orang lain berbuat curang'),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<mahasiswaListCubit>().fetchData();
                      },
                      child: Text('Reload Daftar Mahasiswa'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    BlocBuilder<mahasiswaListCubit, List<mahasiswaModel>>(
                        buildWhen: (previousState, state) {
                      developer.log(
                          '${previousState[0].name}->${state[0].name}',
                          name: 'log');
                      return true;
                    }, builder: (context, mahasiswaList) {
                      return Container(
                        height: 500,
                        child: ListView.builder(
                          itemCount: mahasiswaList.length,
                          itemBuilder: (context, index) {
                            if (mahasiswaList[0].name != "") {
                              return ListTile(
                                  leading: Image.network(
                                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                                  title: Text(mahasiswaList[index].name),
                                  subtitle: Text(mahasiswaList[index].nim),
                                  trailing: Icon(Icons.more_vert_rounded),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      context
                                          .read<mahasiswaCubit>()
                                          .fetchData(mahasiswaList[index].id);
                                      return DetailMahasiswaPage();
                                    }));
                                  });
                            }
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
