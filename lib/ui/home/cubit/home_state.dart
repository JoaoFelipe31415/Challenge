import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.initial({@Default(false) bool hasFile}) = Initial;
  const factory HomeState.loading() = Loading;
  const factory HomeState.success({required int count, required String word}) =
      Success;
  const factory HomeState.error({required String error}) = Error;
}
