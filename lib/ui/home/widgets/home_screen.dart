import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      //color: Colors.yellow,
                      padding: const EdgeInsets.all(8.0),
                      //child: Text('Add a New Task', style: TextStyle(fontSize: 24)),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'New Task Description'),
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
                          leading: CircleAvatar(child: Icon(viewModel.getTypeIcon(viewModel.tasks[index].type))),
                          title: Text(viewModel.tasks[index].description),
                          subtitle: Text(viewModel.tasks[index].targetDateFormatted()),
                          trailing: Icon(Icons.keyboard_double_arrow_right),

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