import 'package:flutter_modular/flutter_modular.dart';
import 'package:mottu_marvel/app_module.dart';
import 'package:mottu_marvel/modules/home/data/datasources/character_datasource.dart';
import 'package:mottu_marvel/modules/home/data/datasources/character_datasource_impl.dart';
import 'package:mottu_marvel/modules/home/data/repositories/characters_repository_impl.dart';
import 'package:mottu_marvel/modules/home/interactor/blocs/character_bloc.dart';
import 'package:mottu_marvel/modules/home/interactor/repositories/characters_repository.dart';
import 'package:mottu_marvel/modules/home/ui/screens/character_detail_screen.dart';
import 'package:mottu_marvel/modules/home/ui/screens/home_screen.dart';

class HomeModule extends Module {
  static const route = "/home";

  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<CharacterDatasource>(CharacterDatasourceImpl.new);
    i.add<CharactersRepository>(CharactersRepositoryImpl.new);
    i.addSingleton<CharacterBloc>(
      CharacterBloc.new,
      config: BindConfig(
        notifier: (bloc) => bloc.stream,
        onDispose: (bloc) => bloc.close(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(HomeScreen.route, child: (context) => const HomeScreen());
    r.child(
      CharacterDetailScreen.route,
      child: (context) => CharacterDetailScreen(
        character: r.args.data['character'],
        relationatedCharacters: r.args.data['list'],
      ),
    );
    super.routes(r);
  }
}
