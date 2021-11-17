import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/app_cubit.dart';

Widget textFormField({
  required TextEditingController controller,
  required TextInputType textInputType,
  required String hintText,
  String? label,
  IconData? prefix,
  IconData? suffix,
  FormFieldValidator<String>? validation,
  GestureTapCallback? onTap,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: textInputType,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: Icon(suffix),
    ),
    validator: validation,
    onTap: onTap,
  );
}

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: model['id']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.all(2),
          content: Text(
            '${model['title']} task has been deleted',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.teal,
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10),),),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 18,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(0),
                    topEnd: Radius.circular(10),
                    bottomEnd: Radius.circular(10),
                    bottomStart: Radius.circular(10),
                  ),
                ),
                child: Text("${model['time']}",style: TextStyle(fontSize: 18),),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${model['title']}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${model['date']}",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),

          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .updateDatabase(status: 'done', id: model['id']);
                  },
                  icon: Icon(Icons.check_circle_outline),
                  color: Colors.blueAccent,
                ),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .updateDatabase(status: 'archived', id: model['id']);
                  },
                  icon: Icon(Icons.archive),
                  color: Colors.grey,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
