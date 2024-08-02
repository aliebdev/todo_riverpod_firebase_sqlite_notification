// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/features/todo/controllers/dates/dates_provider.dart';
import 'package:todo/features/todo/controllers/todo/todo_provider.dart';

import '../../../common/helpers/notification_helper.dart';
import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/spacers.dart';
import '../../onboarding/widgets/custom_otn_button.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({
    super.key,
    this.task,
  });

  final TaskModel? task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  late TextEditingController titleController;
  late TextEditingController descController;

  List<int> notification = [];
  late NotificationsHelper notifierHelper;
  late NotificationsHelper controller;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task?.title);
    descController = TextEditingController(text: widget.task?.desc);

    notifierHelper = NotificationsHelper(ref);
    Future.delayed(Duration.zero, () {
      controller = NotificationsHelper(ref);
    });
    notifierHelper.init();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

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
              controller: titleController,
              hintText: "Add title",
              hintStyle: appStyle(16, Constants.kGreyLight, FontWeight.w600),
            ),
            const HeightSpacer(20),
            CustomTextField(
              controller: descController,
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
                        notification = ref
                            .read(startTimeStateProvider.notifier)
                            .dates(date);
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
                if (titleController.text.isNotEmpty &&
                    descController.text.isNotEmpty &&
                    scheduleDate.isNotEmpty &&
                    startTime.isNotEmpty &&
                    endTime.isNotEmpty) {
                  final TaskModel newTask = TaskModel(
                    id: widget.task?.id,
                    title: titleController.text,
                    desc: descController.text,
                    isCompleted: 0,
                    date: scheduleDate,
                    startTime: startTime.substring(10, 16),
                    endTime: endTime.substring(10, 16),
                    remind: 0,
                    repeat: "yes",
                  );
                  if (widget.task == null) {
                    ref.read(todoStateProvider.notifier).addItem(newTask);
                  } else {
                    ref.read(todoStateProvider.notifier).updateItem(newTask);
                  }
                  notifierHelper.scheduleNotification(
                    notification[0],
                    notification[1],
                    notification[2],
                    notification[3],
                    newTask,
                  );
                  // ref.read(finishTimeStateProvider.notifier).setStart('');
                  // ref.read(startTimeStateProvider.notifier).setStart('');
                  // ref.read(dateStateProvider.notifier).setStart('');
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
