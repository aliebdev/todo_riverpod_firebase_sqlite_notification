import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../common/models/task_model.dart';
import '../controllers/todo/todo_provider.dart';
import '../pages/add_task_page.dart';
import 'todo_tile.dart';

class TodayTasks extends ConsumerWidget {
  const TodayTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(todoStateProvider);
    String today = ref.read(todoStateProvider.notifier).getToday();
    var todayList = listData
        .where(
          (element) =>
              element.isCompleted == 0 && element.date!.contains(today),
        )
        .toList();

    return ListView.builder(
      itemCount: todayList.length,
      itemBuilder: (BuildContext context, int index) {
        final data = todayList.elementAt(index);
        final isCompleted =
            ref.read(todoStateProvider.notifier).getStatus(data);
        final color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          title: data.title,
          description: data.desc,
          start: data.startTime,
          end: data.endTime,
          color: color,
          switcher: Switch(
            value: isCompleted,
            onChanged: (value) {
              ref.read(todoStateProvider.notifier).markAsCompleted(data);
            },
          ),
          delete: () {
            ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
          },
          editWidget: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskPage(task: data),
                ),
              );
            },
            child: const Icon(
              MaterialCommunityIcons.circle_edit_outline,
            ),
          ),
        );
      },
    );
  }
}
