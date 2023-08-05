import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/presentation/blocs/notification/notications_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select(
          (NoticationsBloc bloc) => Text("${bloc.state.status}"),
        ),
        actions: [
          IconButton(onPressed: () {
            context.read<NoticationsBloc>().requestPermission();
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
