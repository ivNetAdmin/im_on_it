import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/home/home_view_model.dart';
import '../ui/home/widgets/home_screen.dart';

GoRouter appRouter = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path:'/',
        builder: (context, state) {
          final viewModel = HomeViewModel(taskRepository: context.read());
          return HomeScreen(viewModel: viewModel);
        }
      )
    ]
);
