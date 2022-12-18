import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_multi_admin/common/widget/responsive/responsive_container.dart';
import 'package:quiz_multi_admin/modules/home/provider/home.provider.dart';
import 'package:quiz_multi_admin/modules/home/provider/question.provider.dart';
import 'package:quiz_multi_admin/modules/home/widgets/dialog.dart';
import '../../../common/widget/text_field.dart';
import '../../../generated/l10n.dart';

class CoursePage extends StatefulWidget {
  const CoursePage(
      {super.key,
      required this.title,
      required this.model,
      required this.id,
      required this.active,
      required this.role});
  final String title;
  final HomeModel model;
  final String id;
  final int active;
  final int role;

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  QuestionModel questionModel = QuestionModel();
  bool? active;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    setState(() {
      active = widget.active == 1 ? true : false;
    });
    questionModel.getQuestion(widget.title);
  }

  setActive() {
    setState(() {
      active = !active!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
      small: CourseScreen(
        title: widget.title,
        onBack: onBack,
        width: width,
        isSmall: true,
        model: widget.model,
        id: widget.id,
        active: active!,
        setActive: setActive,
        questionModel: questionModel,
        isMedium: false,
        role: widget.role,
      ),
      large: CourseScreen(
        title: widget.title,
        onBack: onBack,
        width: width,
        isSmall: false,
        model: widget.model,
        id: widget.id,
        active: active!,
        setActive: setActive,
        questionModel: questionModel,
        isMedium: false,
        role: widget.role,
      ),
      medium: CourseScreen(
        title: widget.title,
        onBack: onBack,
        width: width,
        isSmall: false,
        model: widget.model,
        id: widget.id,
        active: active!,
        setActive: setActive,
        questionModel: questionModel,
        isMedium: true,
        role: widget.role,
      ),
    );
  }

  void onBack() {
    Navigator.of(context).pop();
  }
}

class CourseScreen extends StatelessWidget {
  const CourseScreen(
      {super.key,
      required this.title,
      required this.onBack,
      required this.width,
      required this.isSmall,
      required this.model,
      required this.id,
      required this.active,
      required this.setActive,
      required this.questionModel,
      required this.isMedium,
      required this.role});
  final String title;
  final Function onBack;
  final double width;
  final bool isSmall;
  final HomeModel model;
  final String id;
  final bool active;
  final Function setActive;
  final QuestionModel questionModel;
  final bool isMedium;
  final int role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            onBack.call();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              isSmall == false
                  ? Text(
                      S.of(context).courseManagement,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              isSmall == true
                  ? _courseSmall(
                      context,
                    )
                  : _courseLarge(
                      context,
                    ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: QuestionScreen(
                    model: questionModel,
                    isSmall: isSmall,
                    isMedium: isMedium,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _courseSmall(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BasicTextField(
                controller: model.editingCourse!,
                width: width * 0.5,
                icon: const Icon(Icons.title)),
            const Spacer(),
            active == true
                ? IconButton(
                    onPressed: () {
                      setActive.call();
                    },
                    icon: const Icon(
                      Icons.online_prediction_sharp,
                      color: Color(0xff3564ce),
                      size: 40,
                    ))
                : IconButton(
                    onPressed: () {
                      setActive.call();
                    },
                    icon: const Icon(
                      Icons.link_off_sharp,
                      color: Colors.purple,
                      size: 35,
                    )),
            IconButton(
                onPressed: () {
                  model.updateCourse(title, active == true ? '1' : '0');
                },
                icon: const Icon(
                  Icons.save,
                  size: 35,
                  color: Colors.green,
                )),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            BasicTextField(
              width: width * 0.5,
              controller: questionModel.searchQuestion,
              onChange: questionModel.onSearch,
              label: S.of(context).searchQuestion,
              icon: const Icon(
                Icons.search,
                color: Color(0xff3564ce),
              ),
            ),
            const Spacer(),
            AddQuestion(
              model: questionModel,
              title: title,
            )
          ],
        ),
      ],
    );
  }

  Widget _courseLarge(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicTextField(
          controller: questionModel.searchQuestion,
          onChange: questionModel.onSearch,
          width: width * 0.3,
          label: S.of(context).searchQuestion,
          icon: const Icon(
            Icons.search,
            color: Color(0xff3564ce),
          ),
        ),
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            const SizedBox(
              width: 10,
            ),
            AddQuestion(
              model: questionModel,
              title: title,
            )
          ],
        ),
        const Spacer(),
        role == 0
            ? BasicTextField(
                controller: model.editingCourse!,
                width: width * 0.3,
                icon: const Icon(Icons.title))
            : Container(),
        role == 0
            ? active == true
                ? IconButton(
                    onPressed: () {
                      setActive.call();
                    },
                    icon: const Icon(
                      Icons.online_prediction_sharp,
                      color: Color(0xff3564ce),
                      size: 40,
                    ))
                : IconButton(
                    onPressed: () {
                      setActive.call();
                    },
                    icon: const Icon(
                      Icons.link_off_sharp,
                      color: Colors.purple,
                      size: 40,
                    ))
            : Container(),
        const SizedBox(
          width: 20,
        ),
        role == 0
            ? IconButton(
                onPressed: () {
                  model.updateCourse(title, active == true ? '1' : '0');
                },
                icon: const Icon(
                  Icons.save,
                  size: 40,
                  color: Colors.green,
                ))
            : Container()
      ],
    );
  }
}

class QuestionScreen extends StatelessWidget {
  const QuestionScreen(
      {super.key,
      required this.model,
      required this.isSmall,
      required this.isMedium});
  final QuestionModel model;
  final bool isSmall;
  final bool isMedium;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_) => model,
      builder: (context, widgets) =>
          Consumer<QuestionModel>(builder: ((context, value, child) {
        return value.question.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                itemCount: value.question.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isSmall
                        ? 1
                        : isMedium
                            ? 2
                            : 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 4.0,
                    childAspectRatio: isSmall
                        ? 1 / 0.8
                        : isMedium
                            ? 1 / 0.75
                            : 1 / 1),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      model.setValueController(
                          value.question[index].content ?? '',
                          value.question[index].options![0],
                          value.question[index].options![1],
                          value.question[index].options![2],
                          value.question[index].options![3],
                          value.question[index].answerIndex ?? 0);
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Center(
                                    child: Text(S
                                        .of(context)
                                        .labelUpdate
                                        .toUpperCase())),
                                content: UpdateQuestion(
                                  model: model,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(S.of(context).exit),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      model.updateQuestion(
                                          value.question[index].content ?? '');
                                      Navigator.pop(context);
                                    },
                                    child: Text(S.of(context).labelUpdate),
                                  ),
                                ],
                              ));
                    },
                    onLongPress: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Center(
                              child: Text(S
                                  .of(context)
                                  .alertDeleteQuestion
                                  .toUpperCase())),
                          content: Text(value.question[index].content ?? ''),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(S.of(context).exit),
                            ),
                            TextButton(
                              onPressed: () {
                                model.deleteQuestion(
                                    value.question[index].content ?? '');
                                Navigator.pop(context);
                              },
                              child: Text(S.of(context).delete),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasicTextField(
                          controller: controller,
                          width: isMedium == false && isSmall == true
                              ? width
                              : width * 0.4,
                          enabled: false,
                          label: '${value.question[index].content}',
                          icon: const Icon(Icons.question_mark),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        BasicTextField(
                          controller: controller,
                          width: isMedium == false && isSmall == true
                              ? width
                              : width * 0.4,
                          enabled: false,
                          label: value.question[index].options![0],
                          icon: Icon(
                            Icons.looks_one,
                            color: value.question[index].answerIndex == 0
                                ? Colors.green
                                : null,
                          ),
                        ),
                        BasicTextField(
                          controller: controller,
                          width: isMedium == false && isSmall == true
                              ? width
                              : width * 0.4,
                          enabled: false,
                          label: value.question[index].options![1],
                          icon: Icon(
                            Icons.looks_two,
                            color: value.question[index].answerIndex == 1
                                ? Colors.green
                                : null,
                          ),
                        ),
                        BasicTextField(
                          controller: controller,
                          width: isMedium == false && isSmall == true
                              ? width
                              : width * 0.4,
                          enabled: false,
                          label: value.question[index].options![2],
                          icon: Icon(
                            Icons.looks_3,
                            color: value.question[index].answerIndex == 2
                                ? Colors.green
                                : null,
                          ),
                        ),
                        BasicTextField(
                          controller: controller,
                          width: isMedium == false && isSmall == true
                              ? width
                              : width * 0.4,
                          enabled: false,
                          label: value.question[index].options![3],
                          icon: Icon(
                            Icons.looks_4,
                            color: value.question[index].answerIndex == 3
                                ? Colors.green
                                : null,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Text(S.of(context).noQuestion),
              );
      })),
    );
  }
}
