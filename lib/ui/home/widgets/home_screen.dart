import 'package:flutter/material.dart';
import '../home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key
    , required this.viewModel
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListenableBuilder(
            listenable: viewModel.loadCmd,
        builder: (context, _) {
              return Text(viewModel.tasks.length.toString());
        }
          ),
      ),
    );
  }
}

