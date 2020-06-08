import './pages/tabs_page.dart';
import './pages/category_meals_page.dart';
import './pages/meal_detail_page.dart';
import './pages/filters_page.dart';

final routes = {
  '/': (ctx) => TabsPage(),
  CategoryMealsPage.routeName: (ctx) => CategoryMealsPage(),
  MealDetailPage.routeName: (ctx) => MealDetailPage(),
  FiltersPage.routeName: (ctx) => FiltersPage(),
};
