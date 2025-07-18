import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/enums/menu_value_enum.dart';
import '../home_view_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key
    , required this.viewModel
  });

  final descriptionTextController = TextEditingController();

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: SafeArea(
        child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text("I'm On It, Okay"),
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.blueGrey[100],
                    actions: [
                      PopupMenuButton<MenuValueEnum>(
                          onSelected: (value) {
                            switch (value) {
                              case MenuValueEnum.settings:
                                context.go('/settings');
                              case MenuValueEnum.completedTasks:
                                context.go('/completed-tasks');
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<MenuValueEnum>>[
                            PopupMenuItem<MenuValueEnum>(
                              value: MenuValueEnum.settings,
                              child: const ListTile(
                                leading: Icon(Icons.settings),
                                title: Text('Settings'),
                              ),
                            ),

                            const PopupMenuItem<MenuValueEnum>(
                              value: MenuValueEnum.completedTasks,
                              child: ListTile(
                                leading: Icon(Icons.done),
                                title: Text('Completed Tasks'),
                              ),
                            ),
                          ]
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      //color: Colors.yellow,
                      padding: const EdgeInsets.all(8.0),
                      //child: Text('Add a New Task', style: TextStyle(fontSize: 24)),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                labelText: 'New Task Description',
                                fillColor: Colors.white,
                                filled: true),
                            controller: descriptionTextController,
                            onChanged: (String value) async {
                              viewModel.setNewTaskDescription(value);
                            }
                        ),
                      ),
                    ),
                  ),
                  SliverGrid(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        if (index != 6 && index != 9) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FilledButton(
                                style: FilledButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: viewModel
                                      .buttonColours[index],
                                ),
                                onPressed: () {
                                  setTaskAttribute(viewModel, index);
                                },
                                child: Text(viewModel.buttonText[index])
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(),
                          );
                        }
                      },
                      childCount: 15,
                    ),
                  ),

                  SliverGrid.count(
                    crossAxisCount: 3,
                    childAspectRatio: 2.0,
                    children: <Widget>[
                      Container(),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: viewModel.getDateButtonColour(),
                        ),
                        child: Text(viewModel.showNewTaskOptionStartDate(),
                            textAlign: TextAlign.center),
                        onPressed: () async {
                          final currentDate = DateTime.now();
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: currentDate,
                            firstDate: currentDate,
                            lastDate: DateTime(currentDate.year + 5),
                          );
                          if (selectedDate != null) {
                            viewModel.setNewTaskDate(selectedDate);
                          }
                        },
                      ),
                      FilledButton(
                          style: FilledButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: viewModel.getRepeatButtonColour(),
                          ),
                          onPressed: () {
                            viewModel.setRepeatStatus();
                          },
                          child: Text(viewModel.getRepeatStatus(),
                              textAlign: TextAlign.center)
                      ),
                    ],
                  ),

                  SliverToBoxAdapter(
                    child: Container(
                      //color: Colors.yellow,
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 250,
                        child: viewModel.errorMessage.isNotEmpty
                            ? Text(
                          viewModel.errorMessage,
                          style: TextStyle(color: Colors.red),
                        )
                            : SizedBox.shrink(),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Container(
                      //color: Colors.yellow,
                      padding: const EdgeInsets.all(8.0),
                      //child: Text('Optional Start Date', style: TextStyle(fontSize: 24)),
                      child: FilledButton(
                          style: FilledButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black45,
                          ),
                          onPressed: descriptionTextController.text.isEmpty
                              ? null
                              : () {
                            viewModel.saveNewTask();
                            descriptionTextController.clear();
                          },
                          child: Text('Save')
                      ),
                    ),
                  ),

/*
                  SliverToBoxAdapter(
                    child: Container(
                      //color: Colors.yellow,
                      padding: const EdgeInsets.all(8.0),
                      //child: Text('Add a New Task', style: TextStyle(fontSize: 24)),
                      child: Text(viewModel.newTaskToString()),
                    ),
                  ),
*/
                  SliverList.builder(
                    itemCount: viewModel.tasks.length,

                    itemBuilder: (BuildContext context, int index) {
                      //itemBuilder: (_, index) => Text('${viewModel.tasks[index].timeSpan} ${viewModel.tasks[index].lastCompletedDate} ${viewModel.tasks[index].displayTimeLapsed()} ${viewModel.tasks[index].type} ${viewModel.tasks[index].description} ${viewModel.tasks[index].description}')
                      return ListTile(
                        leading: CircleAvatar(child: Icon(viewModel.getTypeIcon(
                            viewModel.tasks[index].type))),
                        title: Text('${viewModel.tasks[index]
                            .description} ${viewModel.tasks[index]
                            .id} ${viewModel.tasks[index].repeat}'),
                        subtitle: Text(viewModel.tasks[index]
                            .targetDateFormatted()),
                        //subtitle: Text(viewModel.tasks[index].targetDateFormatted() + ' * ' + viewModel.tasks[index].createDate.toString() + ' ' + viewModel.tasks[index].lastCompletedDate.toString()),
                        trailing: Icon(Icons.keyboard_double_arrow_right),
                        onTap: () {
                          viewModel.editTask(viewModel.tasks[index]);
                        },
                        onLongPress: () {
                          viewModel.completeTask(viewModel.tasks[index]);
                        },

                      );
                    },
                  ),

                ],

              );
            }
        ),
      ),
    );
  }

  setTaskAttribute(HomeViewModel viewModel, int index) {
    viewModel.setTaskAttribute(index);
  }
}