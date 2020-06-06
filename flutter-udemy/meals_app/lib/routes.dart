import './pages/categories_page.dart';
import './pages/category_meals_page.dart';

final routes = {
  '/': (ctx) => CategoriesPage(),
  CategoryMealsPage.routeName: (ctx) => CategoryMealsPage(),
};
