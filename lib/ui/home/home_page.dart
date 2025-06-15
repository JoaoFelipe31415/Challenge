import 'package:challenge/ui/home/cubit/home_page_cubit.dart';
import 'package:challenge/ui/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void listener(BuildContext context, HomeState state) {
    if (state is Error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error),
          action: SnackBarAction(
            label: 'Tente novamente',
            onPressed: () => context.read<HomePageCubit>().reset(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomePageCubit, HomeState>(
        listener: (context, state) => listener(context, state),
        listenWhen: (previous, current) => current is Error,
        builder: (context, state) {
          if (state is Initial) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Digite a palavra",
                      ),
                      controller: context.read<HomePageCubit>().controller,
                    ),
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed:
                              () => context.read<HomePageCubit>().getInput(),
                          child: Text(
                            state.hasFile
                                ? "Arquivo carregado"
                                : 'Selecione um arquivo',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomePageCubit>().countWord();
                          },
                          child: Text("Executar algoritmo"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is Success) {
            final count = state.count;
            return Center(
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${count.toString()} ocorrências!'),
                  ElevatedButton(
                    onPressed: context.read<HomePageCubit>().reset,
                    child: Text("Resetar"),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: ElevatedButton(
              onPressed: context.read<HomePageCubit>().reset,
              child: Text("Voltar"),
            ),
          );
        },
      ),
    );
  }
}
