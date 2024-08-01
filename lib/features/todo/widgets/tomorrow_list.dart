import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../common/widgets/xpansion_tile.dart';
import '../controllers/todo/todo_provider.dart';
import '../controllers/xpansion_provider.dart';
import 'todo_tile.dart';

class TomorrowList extends ConsumerWidget {
  const TomorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    final color = ref.read(todoStateProvider.notifier).getRandomColor();
    String tomorrow = ref.read(todoStateProvider.notifier).getTomorrow();

    var tomorrowTasks = todos.where(
      (element) => element.date!.contains(tomorrow),
    );
    return XpansionTile(
      text: "Tomorrow's Task",
      text2: "Tomorrow's tasks are shown here",
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
        for (final todo in tomorrowTasks)
          TodoTile(
            title: todo.title,
            description: todo.desc,
            color: color,
            start: todo.startTime,
            end: todo.endTime,
            editWidget: GestureDetector(
              onTap: () {},
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
