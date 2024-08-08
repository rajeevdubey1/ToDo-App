import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/database_controller.dart';
import 'package:todo_app/views/pending_tasks_screen.dart';
import '../controllers/task_controller.dart';

class DoneTasksScreen extends StatefulWidget {
  const DoneTasksScreen({super.key});

  @override
  State<DoneTasksScreen> createState() => _DoneTasksScreenState();
}

class _DoneTasksScreenState extends State<DoneTasksScreen> {
  final taskController = TaskController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black.withOpacity(0.5),
      drawer: Drawer(
          child: Column(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(color: Colors.teal),
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(color: Colors.teal),
              accountName: Text(
                "TODO LIST",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              accountEmail: Text(
                "Developed by rajeevdubey",
                style: TextStyle(fontSize: 12),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/todo_logo.png"),
              ),
            ),
          ),
          ListTile(
            tileColor: Colors.teal[100],
            leading: const Icon(
              Icons.pending_actions_rounded,
              color: Colors.teal,
              size: 28,
            ),
            title: const Text(
              "Pending",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              Get.offAll(() => (const PendingTasksScreen()));
              // Navigator.pop(context);
            },
          ),
          SizedBox(
            height: Get.height * 0.015,
          ),
          ListTile(
            tileColor: Colors.teal[100],
            leading: const Icon(
              Icons.done_outline_rounded,
              color: Colors.teal,
              size: 28,
            ),
            title: const Text(
              "Completed",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              Get.offAll(const DoneTasksScreen());
              // Navigator.pop(context);
            },
          ),
        ],
      )),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.teal),
        title: const Text("Completed Tasks",
            style: TextStyle(
              color: Colors.teal,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            )),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.teal[100],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            FutureBuilder(
                future: TaskController.getDoneTasks(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Get.height * 0.3,
                          ),
                          Text(
                            "No Tasks Completed Yet",
                            style: TextStyle(
                              color: Colors.teal[300],
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              int todoId = snapshot.data![index].id!.toInt();
                              String todoTitle =
                                  snapshot.data![index].title!.toString();
                              String todoDescription =
                                  snapshot.data![index].description!.toString();
                              String todoDate =
                                  snapshot.data![index].date!.toString();
                              String todoTime =
                                  snapshot.data![index].time!.toString();
                              // int todoStatus = snapshot.data![index].status!.toInt();

                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Dismissible(
                                  background: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 2),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(1.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(1.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  key: UniqueKey(),
                                  direction: DismissDirection.horizontal,
                                  onDismissed: (direction) {
                                    setState(() {
                                      DatabaseController.delete(todoId);
                                      TaskController.getDoneTasks();
                                    });
                                  },
                                  child: Container(
                                      // margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.teal.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 4,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      // margin: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            title: Text(
                                              todoTitle,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                todoDescription,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white70),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Divider(
                                              color: Colors.white,
                                              thickness: 1.2,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 3,
                                              horizontal: 10,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Text("Completed at: ",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white,
                                                      )),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Text(
                                                    todoTime,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Text(
                                                    todoDate,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            }),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
    // ignore: empty_statements
  }
}
