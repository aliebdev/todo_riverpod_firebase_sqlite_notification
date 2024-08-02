import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../common/widgets/xpansion_tile.dart';
import '../controllers/todo/todo_provider.dart';
import '../controllers/xpansion_provider.dart';
import '../pages/add_task_page.dart';
import 'todo_tile.dart';

class DayAfterTomorrow extends ConsumerWidget {
  const DayAfterTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    final color = ref.read(todoStateProvider.notifier).getRandomColor();
    String daysAfter = ref.read(todoStateProvider.notifier).getDayAfter();

    var daysAfterTasks = todos.where(
      (element) => element.date!.contains(daysAfter),
    );
    return XpansionTile(
      text: DateTime.now()
          .add(const Duration(days: 2))
          .toString()
          .substring(5, 10),
      text2: "Day after tomorrow tasks",
      onExpansionChanged: (bool expaned) {
        ref.read(xpansionStateProvider.notifier).setStart(!expaned);
      },
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: ref.watch(xpansionStateProvider)
            ? const Icon(
                AntDesign.circledown,
                // color: Constants.kLight,
              )
            : const Icon(
                AntDesign.closecircleo,
                // color: Constants.kBlueLight,
              ),
      ),
      children: [
        for (final todo in daysAfterTasks)
          TodoTile(
            title: todo.title,
            description: todo.desc,
            color: color,
            start: todo.startTime,
            end: todo.endTime,
            editWidget: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskPage(task: todo),
                  ),
                );
              },
              child: const Icon(MaterialCommunityIcons.circle_edit_outline),
            ),
            delete: () {
              ref.read(todoStateProvider.notifier).deleteTodo(todo.id ?? 0);
            },
          ),
      ],
    );
  }
}
