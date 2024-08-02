import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../../common/widgets/spacers.dart';
import '../controllers/todo/todo_provider.dart';
import '../widgets/completed_tasks.dart';
import '../widgets/day_after_tomorrow.dart';
import '../widgets/today_tasks.dart';
import '../widgets/tomorrow_list.dart';
import 'add_task_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final search = TextEditingController();
  late final TabController tabController = TabController(
    length: 2,
    vsync: this,
  );

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Dashboard",
                      style: appStyle(18, Constants.kLight, FontWeight.bold),
                    ),
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Constants.kLight,
                        borderRadius: BorderRadius.circular(Constants.kRadius),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddTaskPage(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.add,
                          color: Constants.kBkDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const HeightSpacer(20),
              CustomTextField(
                controller: search,
                hintText: "Search",
                prefixIcon: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: null,
                    child: const Icon(
                      AntDesign.search1,
                      color: Constants.kGreyLight,
                    ),
                  ),
                ),
                suffixIcon: const Icon(
                  FontAwesome.sliders,
                  color: Constants.kGreyLight,
                ),
              ),
              const HeightSpacer(15),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            // const HeightSpacer(25),
            Row(
              children: [
                const Icon(
                  FontAwesome.tasks,
                  size: 20,
                  color: Constants.kLight,
                ),
                // const WidthSpacer(20),
                const SizedBox(width: 10),
                ReusableText(
                  text: "Today's Task",
                  style: appStyle(
                    18,
                    Constants.kLight,
                    FontWeight.bold,
                  ),
                ),
              ],
            ),
            const HeightSpacer(25),
            Container(
              decoration: BoxDecoration(
                color: Constants.kLight,
                borderRadius: BorderRadius.circular(Constants.kRadius),
              ),
              child: TabBar(
                controller: tabController,
                labelPadding: EdgeInsets.zero,
                isScrollable: false,
                // labelColor: Constants.kBlueLight,
                labelStyle: appStyle(24, Constants.kLight, FontWeight.w700),
                unselectedLabelColor: Constants.kBkDark,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  color: Constants.kGreyLight,
                  borderRadius: BorderRadius.circular(Constants.kRadius),
                ),
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: Constants.kWidth * .5,
                      child: Center(
                        child: ReusableText(
                          text: "Pending",
                          style: appStyle(
                            16,
                            null,
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.only(left: 30.h),
                      width: Constants.kWidth * .5,
                      child: Center(
                        child: ReusableText(
                          text: "Complete",
                          style: appStyle(
                            16,
                            null,
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const HeightSpacer(20),
            SizedBox(
              height: Constants.kHeight * .3,
              width: Constants.kWidth,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Constants.kRadius),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      color: Constants.kBkLight,
                      height: Constants.kHeight * .3,
                      child: const TodayTasks(),
                    ),
                    Container(
                      color: Constants.kBkLight,
                      height: Constants.kHeight * .3,
                      child: const CompletedTasks(),
                    ),
                  ],
                ),
              ),
            ),
            const HeightSpacer(20),
            const TomorrowList(),
            const HeightSpacer(20),
            const DayAfterTomorrow(),
          ],
        ),
      ),
    );
  }
}
