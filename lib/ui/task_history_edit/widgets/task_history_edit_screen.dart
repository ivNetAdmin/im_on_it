import 'package:flutter/material.dart';
import '../../shared_widgets/shared_app_bar.dart';
import '../task_history_edit_view_model.dart';

class TaskHistoryEditScreen extends StatelessWidget {
  const TaskHistoryEditScreen({super.key,
    required this.viewModel
  });

  final TaskHistoryEditViewModel viewModel;

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
                    SharedAppBar(),
                    SliverList.builder(
                        itemCount: viewModel.taskHistoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: EdgeInsets.all(16),
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        viewModel.taskHistoryList[index]
                                            .description,
                                        style: TextStyle(fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      Text('Last completed date: ${viewModel
                                          .taskHistoryList[index]
                                          .lastCompletedDateFormatted()}'),
                                      SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () {
                                          viewModel.deleteTaskHistory(context, viewModel.taskHistoryList[index]);
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  )
                              )

                          );
                        }
                    ),
                    /*
              SliverToBoxAdapter(
                child: Card(
                  color: Colors.blue,
                  elevation: 8,
                  margin: EdgeInsets.all(16.0),
                  borderOnForeground: false,
                  clipBehavior: Clip.antiAlias,
                  semanticContainer: true,
                  shadowColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                child: Text(viewModel.selectedTask.description),
              ),
              ),
              */
                  ],
                );
              }
          ),
        )
    );
  }
}


