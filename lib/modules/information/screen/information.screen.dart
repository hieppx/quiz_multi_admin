import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_multi_admin/modules/information/provider/acount.provider.dart';
import 'package:quiz_multi_admin/modules/information/widget/dialog.dart';

import '../../../common/widget/basic_button.dart';
import '../../../common/widget/responsive/responsive_container.dart';
import '../../../common/widget/text_field.dart';
import '../../../generated/l10n.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  AccountModel model = AccountModel();
  bool isShowPass = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    model.getUser();
    model.getUsers();
  }

  void showPass() {
    setState(() {
      isShowPass = !isShowPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
        large: AccountScreen(
          model: model,
          width: width * 0.25,
          isShowPass: isShowPass,
          showPass: showPass,
          isSmall: false,
          isMedium: false,
        ),
        medium: AccountScreen(
          model: model,
          width: width * 0.25,
          isShowPass: isShowPass,
          showPass: showPass,
          isSmall: false,
          isMedium: true,
        ),
        small: AccountScreen(
          model: model,
          width: width * 0.8,
          isShowPass: isShowPass,
          showPass: showPass,
          isSmall: true,
          isMedium: false,
        ));
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen(
      {super.key,
      required this.model,
      required this.width,
      required this.isShowPass,
      required this.showPass,
      required this.isSmall,
      required this.isMedium});
  final AccountModel model;
  final double width;
  final bool isShowPass;
  final Function showPass;
  final bool isSmall;
  final bool isMedium;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            !isSmall && !isMedium
                ? Text(
                    S.of(context).managerAccount,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  )
                : Container(),
            Expanded(
              child: SingleChildScrollView(
                child: ChangeNotifierProvider(
                    create: (_) => model,
                    builder: (context, widgets) => Consumer<AccountModel>(
                            builder: ((context, value, child) {
                          return value.userLogin.fullName != null
                              ? isSmall != true
                                  ? _buildLarge(context)
                                  : _buildSmall(context)
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                        }))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLarge(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  S.of(context).labelLogin,
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicTextField(
                  width: width,
                  label: model.userLogin.userName ?? '',
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
                  S.of(context).labelPassword,
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    BasicTextField(
                      width: width,
                      controller: model.password!,
                      isObscure: !isShowPass,
                      icon: const Icon(
                        Icons.lock,
                        color: Color(0xff3564ce),
                        size: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showPass.call();
                      },
                      child: isShowPass == true
                          ? Text(
                              S.of(context).hidePassword,
                              style: const TextStyle(fontSize: 10),
                            )
                          : Text(S.of(context).showPassword,
                              style: const TextStyle(fontSize: 10)),
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).nameUser,
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicTextField(
                  width: width,
                  controller: model.fullName!,
                  enabled: true,
                  icon: const Icon(
                    Icons.account_box,
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
        Center(
          child: BacsicButton(
            label: S.of(context).labelUpdate,
            onPressed: model.updateUser,
            width: width * 0.5,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        model.userLogin.isRole == 0
            ? Row(
                children: [
                  Text(
                    S.of(context).listUser,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  InsertUser(model: model)
                ],
              )
            : Container(),
        const SizedBox(
          height: 20,
        ),
        model.userLogin.isRole == 0 ? _listUser(context) : Container()
      ],
    );
  }

  Widget _buildSmall(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            S.of(context).labelLogin,
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          BasicTextField(
            width: width,
            label: model.userLogin.userName ?? '',
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
            S.of(context).labelPassword,
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              BasicTextField(
                width: width,
                controller: model.password!,
                isObscure: !isShowPass,
                icon: const Icon(
                  Icons.lock,
                  color: Color(0xff3564ce),
                  size: 20,
                ),
              ),
              TextButton(
                onPressed: () {
                  showPass.call();
                },
                child: isShowPass == true
                    ? Text(
                        S.of(context).hidePassword,
                        style: const TextStyle(fontSize: 10),
                      )
                    : Text(S.of(context).showPassword,
                        style: const TextStyle(fontSize: 10)),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            S.of(context).nameUser,
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          BasicTextField(
            width: width,
            controller: model.fullName!,
            enabled: true,
            icon: const Icon(
              Icons.account_box,
              color: Color(0xff3564ce),
              size: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.3),
            child: BacsicButton(
              label: S.of(context).labelUpdate,
              onPressed: model.updateUser,
              width: width * 0.4,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).listUser,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              InsertUser(model: model)
            ],
          ),
          _listUser(context)
        ],
      ),
    );
  }

  Widget _listUser(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMedium == true
                ? 3
                : isSmall == false && isMedium == false
                    ? 3
                    : 1,
            childAspectRatio: 2 / 1,
            mainAxisSpacing: 1,
            crossAxisSpacing: 4),
        itemCount: model.users.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Center(
                      child: Text(S.of(context).resetPassword.toUpperCase())),
                  content: BasicTextField(
                      controller: model.passwordReset,
                      width: width * 0.8,
                      icon: const Icon(Icons.lock)),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).exit),
                    ),
                    TextButton(
                      onPressed: () {
                        model.resetPassword(model.users[index].userName ?? '');
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).labelUpdate),
                    ),
                  ],
                ),
              );
            },
            onLongPress: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Center(
                      child: Text(S.of(context).deleteQuestion.toUpperCase())),
                  content: Text(model.users[index].fullName ?? ''),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).exit),
                    ),
                    TextButton(
                      onPressed: () {
                        model.deleteUser(model.users[index].userName ?? '');
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).delete),
                    ),
                  ],
                ),
              );
            },
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BasicTextField(
                    width: width,
                    controller: controller,
                    enabled: false,
                    label: model.users[index].userName,
                    icon: const Icon(
                      Icons.account_circle,
                      color: Color(0xff3564ce),
                      size: 20,
                    ),
                  ),
                  BasicTextField(
                    width: width,
                    controller: controller,
                    enabled: false,
                    label: model.users[index].fullName,
                    icon: const Icon(
                      Icons.account_box,
                      color: Color(0xff3564ce),
                      size: 20,
                    ),
                  ),
                ]),
          );
        });
  }
}
