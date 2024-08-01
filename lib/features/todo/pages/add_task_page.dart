import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/features/todo/controllers/dates/dates_provider.dart';
import 'package:todo/features/todo/controllers/todo/todo_provider.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/spacers.dart';
import '../../onboarding/widgets/custom_otn_button.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final scheduleDate = ref.watch(dateStateProvider);
    final startTime = ref.watch(startTimeStateProvider);
    final endTime = ref.watch(finishTimeStateProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const HeightSpacer(20),
            CustomTextField(
              controller: title,
              hintText: "Add title",
              hintStyle: appStyle(16, Constants.kGreyLight, FontWeight.w600),
            ),
            const HeightSpacer(20),
            CustomTextField(
              controller: desc,
              hintText: "Add description",
              hintStyle: appStyle(16, Constants.kGreyLight, FontWeight.w600),
            ),
            const HeightSpacer(20),
            CustomOtnButton(
              text: scheduleDate == ""
                  ? "Set Date"
                  : scheduleDate.substring(0, 10),
              height: 52.h,
              width: Constants.kWidth,
              color: Constants.kLight,
              backgroundColor: Constants.kBlueLight,
              onTap: () {
                picker.DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  theme: const picker.DatePickerTheme(
                    doneStyle: TextStyle(
                      color: Constants.kGreen,
                      fontSize: 16,
                    ),
                  ),
                  onConfirm: (date) {
                    ref
                        .read(dateStateProvider.notifier)
                        .setStart(date.toString());
                  },
                  currentTime: DateTime.now(),
                  locale: picker.LocaleType.en,
                );
              },
            ),
            const HeightSpacer(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtnButton(
                  text: startTime == ""
                      ? "Start Time"
                      : startTime.substring(10, 16),
                  height: 52.h,
                  width: Constants.kWidth * .4,
                  color: Constants.kLight,
                  backgroundColor: Constants.kBlueLight,
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        ref
                            .read(startTimeStateProvider.notifier)
                            .setStart(date.toString());
                      },
                    );
                  },
                ),
                CustomOtnButton(
                  text: endTime == "" ? "End Time" : endTime.substring(10, 16),
                  height: 52.h,
                  width: Constants.kWidth * .4,
                  color: Constants.kLight,
                  backgroundColor: Constants.kBlueLight,
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        ref
                            .read(finishTimeStateProvider.notifier)
                            .setStart(date.toString());
                      },
                    );
                  },
                ),
              ],
            ),
            const HeightSpacer(20),
            CustomOtnButton(
              text: "Submit",
              height: 52.h,
              width: Constants.kWidth,
              color: Constants.kLight,
              backgroundColor: Constants.kGreen,
              onTap: () {
                if (title.text.isNotEmpty &&
                    desc.text.isNotEmpty &&
                    scheduleDate.isNotEmpty &&
                    startTime.isNotEmpty &&
                    endTime.isNotEmpty) {
                  TaskModel task = TaskModel(
                    title: title.text,
                    desc: desc.text,
                    isCompleted: 0,
                    date: scheduleDate,
                    startTime: startTime.substring(10, 16),
                    endTime: endTime.substring(10, 16),
                    remind: 0,
                    repeat: "yes",
                  );
                  ref.read(todoStateProvider.notifier).addItem(task);
                  ref.read(finishTimeStateProvider.notifier).setStart('');
                  ref.read(startTimeStateProvider.notifier).setStart('');
                  ref.read(dateStateProvider.notifier).setStart('');
                  Navigator.pop(context);
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
