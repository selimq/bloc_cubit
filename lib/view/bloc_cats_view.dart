import 'package:bloc_cubit/view/cats_cubit.dart';
import 'package:bloc_cubit/view/cats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCatsView extends StatefulWidget {
  const BlocCatsView({Key? key}) : super(key: key);

  @override
  _BlocCatsViewState createState() => _BlocCatsViewState();
}

class _BlocCatsViewState extends State<BlocCatsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatsCubit(),
      child: Scaffold(
          appBar: appBar(),
          body: BlocConsumer<CatsCubit, CatsState>(
            listener: (context, state) {
              if (state is CatsError) {
                Scaffold.of(context)
                    // ignore: deprecated_member_use
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is CatsInitial) {
                return Center(
                  child: Column(
                    children: [
                      const Text("Welcome"),
                      ElevatedButton(
                        child: const Icon(Icons.clear),
                        onPressed: () {
                          context.read<CatsCubit>().getCats();
                        },
                      ),
                    ],
                  ),
                );
              } else if (state is CatsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CatsCompleted) {
                return Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          context.read<CatsCubit>().removeCats();
                        },
                        child: Text("dsd")),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.response.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Container(
                                color:
                                    index % 2 == 0 ? Colors.red : Colors.blue,
                                width: 333,
                                height: 100,
                                child: Text(state.response[index])),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                final err = state as CatsError;
                return Text(err.message);
              }
            },
          )
          // floatingActionButton:
          ),
    );
  }

  AppBar appBar() => AppBar(title: const Text("Cubit-Bloc"));
}
