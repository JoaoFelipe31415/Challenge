import 'package:challenge/data/repositories/file_repository.dart';
import 'package:challenge/ui/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomeState> {
  HomePageCubit(this.repository) : super(HomeState.initial());
  final FileRepository repository;
  List<String>? _matriz;
  final controller = TextEditingController();

  List<String>? get matriz => _matriz;

  void getInput() async {
    _matriz = await repository.getFile();
    if (_matriz != null) {
      emit(HomeState.initial(hasFile: true));
      return;
    }
    emit(HomeState.initial());
  }

  void countWord() {
    emit(HomeState.loading());
    if (_matriz == null) {
      emit(HomeState.error(error: "Arquivo não carregado"));
    } else if (controller.text.isEmpty) {
      emit(HomeState.error(error: "Digite uma palavra"));
      return;
    }
    final result = repository.countWord(controller.text, _matriz!);
    emit(HomeState.success(count: result, word: controller.text));
  }

  void reset() {
    _matriz = null;
    controller.clear();
    emit(HomeState.initial());
  }
}
