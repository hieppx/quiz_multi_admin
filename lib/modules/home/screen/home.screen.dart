import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_multi_admin/modules/home/screen/course.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/widget/responsive/responsive_container.dart';
import '../../../common/widget/text_field.dart';
import '../../../generated/l10n.dart';
import '../provider/home.provider.dart';
import '../widgets/dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeModel _model = HomeModel();

  int? role = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getInt('role');
    });
    _model.getCourse();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ResponsiveContainer(
      large: HomeScreen(
        model: _model,
        width: width * 0.3,
        isSmall: false,
        count: 3,
        height: height,
        isMedium: false,
        role: role!,
      ),
      small: HomeScreen(
        model: _model,
        width: width * 0.5,
        isSmall: true,
        count: 3,
        height: height,
        isMedium: false,
        role: role!,
      ),
      medium: HomeScreen(
        model: _model,
        width: width * 0.5,
        isSmall: false,
        count: 3,
        height: height,
        isMedium: true,
        role: role!,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {super.key,
      required this.model,
      required this.width,
      required this.isSmall,
      required this.count,
      required this.height,
      required this.isMedium,
      required this.role});
  final HomeModel model;
  final double width;
  final bool isSmall;
  final int count;
  final double height;
  final bool isMedium;
  final int role;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BasicTextField(
                controller: model.searchCourse,
                width: width,
                onChange: model.onSearch,
                label: S.of(context).searchCourse,
                icon: const Icon(
                  Icons.search,
                  color: Color(0xff3564ce),
                ),
              ),
              role == 0
                  ? AddButton(
                      model: model,
                    )
                  : Container()
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: ChangeNotifierProvider(
                create: (_) => model,
                builder: (context, widgets) =>
                    Consumer<HomeModel>(builder: (context, value, child) {
                      return value.course.isNotEmpty
                          ? isSmall
                              ? _buildSmall(context, value)
                              : _buildLarge(context, value)
                          : value.course.isEmpty &&
                                  value.searchCourse.text.isNotEmpty
                              ? const Center(
                                  child: Text('Không có khóa học này!'))
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                    })),
          )),
        ],
      ),
    ));
  }

  Widget _buildSmall(BuildContext context, HomeModel value) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: value.course.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
                height: height * 0.2,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff4570d2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.1,
                        width: height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white)),
                        child: Icon(
                          value.course[index].active == 1
                              ? Icons.online_prediction_sharp
                              : Icons.link_off_sharp,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '${value.course[index].title}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                model.initTitleCourse(
                                    value.course[index].title ?? '');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CoursePage(
                                              title:
                                                  value.course[index].title ??
                                                      '',
                                              model: model,
                                              id: value.course[index].id ?? '',
                                              active:
                                                  value.course[index].active ??
                                                      0,
                                              role: role,
                                            )));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.greenAccent,
                                size: isMedium == true ? 20 : 25,
                              )),
                          role == 0
                              ? DeleteButton(
                                  model: model,
                                  size: isMedium == true ? 20 : 25,
                                  title: value.course[index].title ?? '',
                                )
                              : Container(),
                          const Spacer(),
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
  }

  Widget _buildLarge(BuildContext context, HomeModel value) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 30,
            mainAxisSpacing: 10,
            childAspectRatio: isMedium == true ? 3 / 1.5 : 3 / 1.1),
        padding: const EdgeInsets.all(8),
        itemCount: value.course.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff4570d2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: height * 0.08,
                      width: height * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white)),
                      child: Icon(
                        value.course[index].active == 1
                            ? Icons.online_prediction_sharp
                            : Icons.link_off_sharp,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        '${value.course[index].title}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              model.initTitleCourse(
                                  value.course[index].title ?? '');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CoursePage(
                                            title:
                                                value.course[index].title ?? '',
                                            model: model,
                                            id: value.course[index].id ?? '',
                                            active:
                                                value.course[index].active ?? 0,
                                            role: role,
                                          )));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.greenAccent,
                              size: isMedium == true ? 20 : 25,
                            )),
                        role == 0
                            ? DeleteButton(
                                model: model,
                                size: isMedium == true ? 20 : 25,
                                title: value.course[index].title ?? '',
                              )
                            : Container(),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                )),
          );
        });
  }
}
