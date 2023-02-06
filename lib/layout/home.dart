import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/bloc/bloc.dart';

import '../component/defulttextform.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tittlecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isbottomsheet = false;
  IconData ficon = (Icons.add);
  @override
  Widget build(BuildContext context) {
    //AppCubit appcubit = AppCubit.get(context);
    return Consumer<AppCubit>(
      builder: (context, provider, x) {
        return Scaffold(
          key: scaffoldKey,
          appBar:
              AppBar(title: Text(provider.appbartitlle[provider.currentindex])),
          floatingActionButton: FloatingActionButton(
              child: Icon(ficon),
              onPressed: () {
                if (isbottomsheet) {
                  if (formKey.currentState!.validate()) {
                    provider.insertIntoDataBase(tittlecontroller.text,
                        datecontroller.text, timecontroller.text);

                    Navigator.pop(context);
                    tittlecontroller.clear();
                    timecontroller.clear();
                    datecontroller.clear();
                    isbottomsheet = false;
                    setState(() {
                      ficon = Icons.add;
                    });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) {
                        return Form(
                            key: formKey,
                            child: Container(
                              color: Colors.green[100],
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CostumTextFormFeild(
                                    label: "Task Tittle",
                                    controller: tittlecontroller,
                                    type: TextInputType.name,
                                    prefix: Icons.abc,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return " you must fill this feild";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //////time
                                  CostumTextFormFeild(
                                    label: "Task time",
                                    controller: timecontroller,
                                    type: TextInputType.datetime,
                                    prefix: Icons.lock_clock,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timecontroller.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return " you must fill this feild";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  ////////////
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //////date
                                  CostumTextFormFeild(
                                    label: "Task date",
                                    controller: datecontroller,
                                    type: TextInputType.datetime,
                                    prefix: Icons.date_range_outlined,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2023-05-03'))
                                          .then((value) {
                                        datecontroller.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return " you must fill this feild";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ));
                      })
                      .closed
                      .then((value) {
                        isbottomsheet = false;
                        setState(() {
                          ficon = Icons.add;
                        });
                      });
                  isbottomsheet = true;
                  setState(() {
                    ficon = Icons.edit;
                  });
                }
                //Navigator.pushNamed(context, AppRouat.addTask);
              }),
          body: provider.screen[provider.currentindex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: provider.currentindex,
              onTap: (index) {
                provider.changeBottomNavBar(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_sharp),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archive',
                ),
              ]),
        );
      },
    );
  }
}
