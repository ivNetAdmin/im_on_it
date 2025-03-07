import 'package:go_router/go_router.dart';

import '../ui/home/widgets/home_screen.dart';

GoRouter appRouter = GoRouter(
    routes: <RouteBase>[
    GoRoute(
      path:'/',
        builder: (context, state){
          return HomeScreen();
        }
    )
    ]
);