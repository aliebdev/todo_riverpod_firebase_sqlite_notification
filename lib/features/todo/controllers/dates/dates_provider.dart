import 'package:riverpod_annotation/riverpod_annotation.dart';

part "dates_provider.g.dart";

@riverpod
class DateState extends _$DateState {
  @override
  String build() {
    return "";
  }

  void setStart(String newState) {
    state = newState;
  }
}

@riverpod
class StartTimeState extends _$StartTimeState {
  @override
  String build() {
    return "";
  }

  void setStart(String newState) {
    state = newState;
  }

  List<int> dates(DateTime startDate) {
    final now = DateTime.now();

    final differences = startDate.difference(now);

    int days = differences.inDays;
    int hours = differences.inHours % 24;
    int minutes = differences.inDays % 60;
    int seconds = differences.inDays % 60;

    return [days, hours, minutes, seconds];
  }
}

@riverpod
class FinishTimeState extends _$FinishTimeState {
  @override
  String build() {
    return "";
  }

  void setStart(String newState) {
    state = newState;
  }
}
