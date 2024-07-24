import 'package:flutter_modular/flutter_modular.dart';
import 'package:mottu_marvel/app_splash_screen.dart';
import 'package:mottu_marvel/modules/home/home_module.dart';
import 'package:mottu_marvel/shared/services/http/dio_factory.dart';
import 'package:mottu_marvel/shared/services/http/dio_http_client_service_impl.dart';
import 'package:mottu_marvel/shared/services/http/http_client_service.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add(createDioFactory);
    i.addSingleton<HttpClientService>(DioHttpClientServiceImpl.new);
    super.exportedBinds(i);
  }

  @override
  void routes(RouteManager r) {
    r.module(HomeModule.route, module: HomeModule());
    r.child('/', child: (context) => const SplashScreen());
    super.routes(r);
  }
}
