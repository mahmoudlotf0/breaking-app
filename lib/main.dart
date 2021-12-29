import 'package:blocappapi/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BreakingBadApp(appRouter: AppRouter()));
}

class BreakingBadApp extends StatelessWidget {
  final AppRouter appRouter;
  const BreakingBadApp({required this.appRouter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
