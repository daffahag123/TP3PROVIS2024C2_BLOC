import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3_bloc/cubit/daftar_mahasiswa_cubit.dart';
import 'package:tp3_bloc/cubit/mahasiswa_cubit.dart';
import 'package:tp3_bloc/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<mahasiswaListCubit>(
            create: (context) => mahasiswaListCubit(),
          ),
          BlocProvider<mahasiswaCubit>(
            create: (context) => mahasiswaCubit(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}