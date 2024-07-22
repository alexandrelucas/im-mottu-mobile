import 'package:flutter_modular/flutter_modular.dart';
import 'package:mottu_marvel/modules/home/ui/screens/home_screen.dart';
import 'package:mottu_marvel/shared/services/http/dio_factory.dart';
import 'package:mottu_marvel/shared/services/http/dio_http_client_service_impl.dart';
import 'package:mottu_marvel/shared/services/http/http_client_service.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add(createDioFactory);
    i.addSingleton<HttpClientService>(DioHttpClientServiceImpl.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomeScreen());
    super.routes(r);
  }
}
