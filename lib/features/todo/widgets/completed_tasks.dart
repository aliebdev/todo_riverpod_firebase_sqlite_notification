import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../common/models/task_model.dart';
import '../../../common/utils/constants.dart';
import '../controllers/todo/todo_provider.dart';
import 'todo_tile.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(todoStateProvider);
    final lastMonth = ref.read(todoStateProvider.notifier).lastMonth();
    var completedList = listData
        .where(
          (element) =>
              element.isCompleted == 1 ||
              lastMonth.contains(
                element.date!.substring(0, 10),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: completedList.length,
      itemBuilder: (BuildContext context, int index) {
        final data = completedList.elementAt(index);
        final color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          title: data.title,
          description: data.desc,
          start: data.startTime,
          end: data.endTime,
          color: color,
          switcher: const Icon(
            AntDesign.checkcircle,
            color: Constants.kGreen,
          ),
          delete: () {
            ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
          },
          // editWidget: GestureDetector(
          //   onTap: () {},
          //   child: const Icon(
          //     MaterialCommunityIcons.circle_edit_outline,
          //   ),
          // ),
        );
      },
    );
  }
}
