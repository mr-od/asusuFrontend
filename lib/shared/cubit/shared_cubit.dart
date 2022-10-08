import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cache/cache_shared.dart';

part 'shared_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit() : super(SharedInitial());

  static SharedCubit get(context) => BlocProvider.of(context);
  bool? isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark!;
      CacheHelper.putBoolean(key: 'isDark', value: isDark!).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
