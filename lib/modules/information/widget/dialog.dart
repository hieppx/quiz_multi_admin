import 'package:flutter/material.dart';
import 'package:quiz_multi_admin/modules/information/provider/acount.provider.dart';

import '../../../common/widget/text_field.dart';
import '../../../generated/l10n.dart';

class InsertUser extends StatelessWidget {
  const InsertUser({super.key, required this.model});
  final AccountModel model;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 40,
      child: IconButton(
        onPressed: () {
          model.resetValue();
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title:
                  Center(child: Text(S.of(context).insertUser.toUpperCase())),
              content: SizedBox(
                  height: 250,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BasicTextField(
                          controller: model.usernameInsert,
                          width: width * 0.8,
                          icon: const Icon(Icons.account_circle)),
                      const SizedBox(
                        height: 20,
                      ),
                      BasicTextField(
                          controller: model.passwordInsert,
                          width: width * 0.8,
                          icon: const Icon(Icons.lock)),
                      const SizedBox(
                        height: 20,
                      ),
                      BasicTextField(
                          controller: model.fullNameInsert,
                          width: width * 0.8,
                          icon: const Icon(Icons.account_box)),
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
                    model.insertUser();
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
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff3564ce)),
      ),
    );
  }
}
