import 'package:angular/angular.dart';

import 'hero_service.dart';
import 'package:angular_router/angular_router.dart';

import 'hero.dart';
import 'mock_heroes.dart';
import 'route_paths.dart';

@Component(
  selector: 'my-heroes',
  templateUrl: 'hero_list_component.html',
  styleUrls: ['hero_list_component.css'],
  directives: [coreDirectives],
  providers: [ClassProvider(HeroService)],
  pipes: [commonPipes],
)
class HeroListComponent implements OnInit {
  final HeroService _heroService;
  final Router _router;
  List<Hero> heroes = mockHeroes;
  Hero selected;

  HeroListComponent(this._heroService, this._router);

  void ngOnInit() => _getHeroes();

  void onSelect(Hero hero) => selected = hero;
  // void _getHeroes() {
  //   _heroService.getAll().then((heroes) => this.heroes = heroes);
  // }
  // Future<void> _getHeroes() async {
  //   heroes = await _heroService.getAllSlowly();
  // }
  Future<void> _getHeroes() async {
    heroes = await _heroService.getAll();
  }

  String _heroUrl(int id) =>
      RoutePaths.hero.toUrl(parameters: {idParam: '$id'});

  Future<NavigationResult> gotoDetail() =>
      _router.navigate(_heroUrl(selected.id));
}