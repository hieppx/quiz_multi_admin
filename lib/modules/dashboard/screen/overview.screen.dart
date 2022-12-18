import 'package:flutter/material.dart';
import 'package:quiz_multi_admin/common/widget/responsive/responsive_container.dart';
import 'package:quiz_multi_admin/common/widget/text_field.dart';
import 'package:quiz_multi_admin/modules/dashboard/provider/overview.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/l10n.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  final OverviewModel _model = OverviewModel();

  @override
  void initState() {
    super.initState();
    init();
  }

  List<String>? listOverview = [];

  init() async {
    final prefs = await SharedPreferences.getInstance();
    await _model.getOverview();
    setState(() {
      listOverview = prefs.getStringList('listOverView');
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
      small: OverviewScreen(
        isSmall: true,
        overviewList: listOverview!,
        width: width * 0.8,
        isMedium: false,
      ),
      large: OverviewScreen(
        isSmall: false,
        overviewList: listOverview!,
        width: width * 0.25,
        isMedium: false,
      ),
      medium: OverviewScreen(
        isSmall: false,
        overviewList: listOverview!,
        width: width * 0.25,
        isMedium: true,
      ),
    );
  }
}

class OverviewScreen extends StatelessWidget {
  const OverviewScreen(
      {super.key,
      required this.isSmall,
      required this.overviewList,
      required this.width,
      required this.isMedium});
  final bool isSmall;
  final List<String> overviewList;
  final double width;
  final bool isMedium;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            isSmall != true && isMedium != true
                ? Text(
                    S.of(context).overview,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  )
                : Container(),
            isSmall != true && isMedium != true
                ? const SizedBox(
                    height: 30,
                  )
                : Container(),
            isSmall == true
                ? Expanded(
                    child: SingleChildScrollView(child: _buildSmall(context)))
                : _buildLarge(context)
          ],
        ),
      ),
    );
  }

  Widget _buildSmall(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return overviewList.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).totalAdmin,
                style: const TextStyle(fontSize: 15, color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              BasicTextField(
                width: width,
                label: overviewList[0],
                controller: controller,
                enabled: false,
                icon: const Icon(
                  Icons.account_circle,
                  color: Color(0xff3564ce),
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                S.of(context).totalUsers,
                style: const TextStyle(fontSize: 15, color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              BasicTextField(
                width: width,
                label: overviewList[1],
                controller: controller,
                enabled: false,
                icon: const Icon(
                  Icons.account_circle,
                  color: Color(0xff3564ce),
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                S.of(context).totalCourses,
                style: const TextStyle(fontSize: 15, color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              BasicTextField(
                width: width,
                label: overviewList[2],
                controller: controller,
                enabled: false,
                icon: const Icon(
                  Icons.school,
                  color: Color(0xff3564ce),
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                S.of(context).totalQuestions,
                style: const TextStyle(fontSize: 15, color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              BasicTextField(
                width: width,
                label: overviewList[3],
                controller: controller,
                enabled: false,
                icon: const Icon(
                  Icons.question_mark,
                  color: Color(0xff3564ce),
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                S.of(context).courseBest,
                style: const TextStyle(fontSize: 15, color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              BasicTextField(
                width: width,
                label: overviewList[4],
                controller: controller,
                enabled: false,
                icon: const Icon(
                  Icons.favorite,
                  color: Color(0xff3564ce),
                  size: 20,
                ),
              ),
            ],
          )
        : Container();
  }

  Widget _buildLarge(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return overviewList.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).totalAdmin,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BasicTextField(
                        width: width,
                        label: overviewList[0],
                        controller: controller,
                        enabled: false,
                        icon: const Icon(
                          Icons.account_circle,
                          color: Color(0xff3564ce),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).totalUsers,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BasicTextField(
                        width: width,
                        label: overviewList[1],
                        controller: controller,
                        enabled: false,
                        icon: const Icon(
                          Icons.account_circle,
                          color: Color(0xff3564ce),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).totalCourses,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BasicTextField(
                        width: width,
                        label: overviewList[2],
                        controller: controller,
                        enabled: false,
                        icon: const Icon(
                          Icons.school,
                          color: Color(0xff3564ce),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).totalQuestions,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BasicTextField(
                        width: width,
                        label: overviewList[3],
                        controller: controller,
                        enabled: false,
                        icon: const Icon(
                          Icons.question_mark,
                          color: Color(0xff3564ce),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).courseBest,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BasicTextField(
                        width: width,
                        label: overviewList[4],
                        controller: controller,
                        enabled: false,
                        icon: const Icon(
                          Icons.favorite,
                          color: Color(0xff3564ce),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width,
                  )
                ],
              )
            ],
          )
        : Container();
  }
}
