import 'package:flutter/material.dart';
import 'package:quiz_multi_admin/common/widget/text_field.dart';
import 'package:quiz_multi_admin/modules/home/provider/home.provider.dart';
import 'package:quiz_multi_admin/modules/home/provider/question.provider.dart';

import '../../../generated/l10n.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.model});
  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title:
                  Center(child: Text(S.of(context).insertCourse.toUpperCase())),
              content: SizedBox(
                  height: 100,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).titleCourse,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BasicTextField(
                          controller: model.titleCourse,
                          width: width * 0.8,
                          icon: const Icon(Icons.title)),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).exit),
                ),
                TextButton(
                  onPressed: () {
                    model.insertCourse();
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).add),
                ),
              ],
            ),
          );
        },
        icon: const Icon(
          Icons.add,
          size: 30,
        ),
        label: Text(
          S.of(context).addCourse,
          style: const TextStyle(fontSize: 18),
        ),
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff3564ce)),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton(
      {super.key,
      required this.model,
      required this.size,
      required this.title});
  final HomeModel model;

  final double size;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: IconButton(
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Center(
                    child: Text(S.of(context).alertDeleteCourse.toUpperCase())),
                content: Text(title),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(S.of(context).exit),
                  ),
                  TextButton(
                    onPressed: () {
                      model.deleteCourse(title);
                      Navigator.pop(context);
                    },
                    child: Text(S.of(context).delete),
                  ),
                ],
              ),
            );
          },
          icon: Icon(
            Icons.delete,
            color: Colors.amber,
            size: size,
          )),
    );
  }
}

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key, required this.model, required this.title});
  final QuestionModel model;
  final String title;

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return IconButton(
      onPressed: () {
        widget.model.resetInput();
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => Form(
            key: form,
            child: AlertDialog(
              title: Center(
                  child: Text(S.of(context).insertQuestion.toUpperCase())),
              content: SizedBox(
                  height: 550,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BasicTextField(
                          controller: widget.model.contentQuestion,
                          width: width * 0.8,
                          label: '',
                          icon: const Icon(Icons.question_mark)),
                      const SizedBox(
                        height: 20,
                      ),
                      BasicTextField(
                          controller: widget.model.answerA,
                          width: width * 0.8,
                          label: '',
                          icon: const Icon(Icons.question_answer)),
                      const SizedBox(
                        height: 20,
                      ),
                      BasicTextField(
                          controller: widget.model.answerB,
                          width: width * 0.8,
                          label: '',
                          icon: const Icon(Icons.question_answer)),
                      const SizedBox(
                        height: 20,
                      ),
                      BasicTextField(
                          controller: widget.model.answerC,
                          width: width * 0.8,
                          label: '',
                          icon: const Icon(Icons.question_answer)),
                      const SizedBox(
                        height: 20,
                      ),
                      BasicTextField(
                          controller: widget.model.answerD,
                          width: width * 0.8,
                          label: '',
                          icon: const Icon(Icons.question_answer)),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          BasicTextField(
                              controller: widget.model.answerIndex,
                              width: width * 0.8,
                              label: '',
                              icon: const Icon(Icons.label)),
                          Text(
                            '(${S.of(context).ex} A B C D)',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.green),
                          )
                        ],
                      ),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).exit),
                ),
                TextButton(
                  onPressed: () {
                    if (form.currentState!.validate()) {
                      if (widget.model.contentQuestion.text.isNotEmpty &&
                          widget.model.answerA.text.isNotEmpty &&
                          widget.model.answerB.text.isNotEmpty &&
                          widget.model.answerC.text.isNotEmpty &&
                          widget.model.answerD.text.isNotEmpty) {
                        widget.model.insertQuestion(widget.title);
                      }

                      Navigator.pop(context);
                    }
                  },
                  child: Text(S.of(context).add),
                ),
              ],
            ),
          ),
        );
      },
      icon: const Icon(
        Icons.add,
        size: 30,
        color: Color(0xff3564ce),
      ),
    );
  }
}

class UpdateQuestion extends StatelessWidget {
  const UpdateQuestion({super.key, required this.model});
  final QuestionModel model;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 500,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            BasicTextField(
                controller: model.contentQuestion,
                width: width * 0.8,
                label: '',
                icon: const Icon(Icons.question_mark)),
            const SizedBox(
              height: 20,
            ),
            BasicTextField(
                controller: model.answerA,
                width: width * 0.8,
                label: '',
                icon: const Icon(Icons.question_answer)),
            const SizedBox(
              height: 20,
            ),
            BasicTextField(
                controller: model.answerB,
                width: width * 0.8,
                label: '',
                icon: const Icon(Icons.question_answer)),
            const SizedBox(
              height: 20,
            ),
            BasicTextField(
                controller: model.answerC,
                width: width * 0.8,
                label: '',
                icon: const Icon(Icons.question_answer)),
            const SizedBox(
              height: 20,
            ),
            BasicTextField(
                controller: model.answerD,
                width: width * 0.8,
                label: '',
                icon: const Icon(Icons.question_answer)),
            const SizedBox(
              height: 20,
            ),
            BasicTextField(
                controller: model.answerIndex,
                width: width * 0.8,
                label: '',
                icon: const Icon(Icons.label)),
          ],
        ));
  }
}
