import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/helpers/db_helper.dart';
import 'package:todo/common/models/user_model.dart';

final userProvider =
    StateNotifierProvider<UserState, List<UserModel>>((ref) => UserState());

class UserState extends StateNotifier<List<UserModel>> {
  UserState() : super([]);

  void refresh() async {
    final data = await DBHelper.getUsers();
    state = data
        .map(
          (e) => UserModel.fromMap(e),
        )
        .toList();
  }
}
