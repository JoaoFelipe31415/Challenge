import 'package:challenge/config/dependecies.dart';
import 'package:challenge/ui/home/cubit/home_page_cubit.dart';
import 'package:challenge/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupInjector();
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => injector.get<HomePageCubit>(),
        child: HomePage(),
      ),
    ),
  );
}
