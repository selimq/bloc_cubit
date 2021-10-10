import 'package:bloc_cubit/view/cats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsCubit extends Cubit<CatsState> {
  CatsCubit() : super(const CatsInitial());
  Future<void> getCats() async {
    try {
      emit(const CatsLoading());
      await Future.delayed(const Duration(milliseconds: 699));
      final response = await Future.value(["a", "b", "c"]);
      emit(CatsCompleted(response));
    } catch (_) {
      emit(const CatsError("Error"));
    }
  }

  Future<void> removeCats() async {
    try {
      emit(const CatsLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const CatsInitial());
    } catch (_) {
      emit(const CatsError("Error"));
    }
  }
}
