import 'package:flutter_modular/flutter_modular.dart';
import 'package:mottu_marvel/modules/home/ui/screens/home_screen.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomeScreen());
    super.routes(r);
  }
}
