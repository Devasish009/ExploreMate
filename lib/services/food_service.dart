import '../models/food_model.dart';

/// Food items service — mock data.
class FoodService {
  FoodService._();
  static final FoodService instance = FoodService._();

  static final List<FoodItemModel> _mockItems = [
    const FoodItemModel(
      foodId: 'f001',
      name: 'Pesarattu',
      category: 'Street Food',
      cuisine: 'South Indian',
      rating: 4.7,
      priceRange: '₹',
      placeId: 'p009',
      description: 'Crispy green moong dal crepes served with ginger chutney.',
      isVeg: true,
    ),
    const FoodItemModel(
      foodId: 'f002',
      name: 'Bamboo Chicken',
      category: 'Restaurant',
      cuisine: 'Tribal / Araku',
      rating: 4.8,
      priceRange: '₹₹',
      placeId: 'p010',
      description: 'Chicken marinated in spices and cooked inside bamboo over fire.',
      isVeg: false,
    ),
    const FoodItemModel(
      foodId: 'f003',
      name: 'Bobbatlu',
      category: 'Sweet',
      cuisine: 'Andhra',
      rating: 4.5,
      priceRange: '₹',
      placeId: 'p002',
      description: 'Sweet flatbread stuffed with lentils and jaggery.',
      isVeg: true,
    ),
    const FoodItemModel(
      foodId: 'f004',
      name: 'Prawn Fry',
      category: 'Seafood',
      cuisine: 'Coastal Andhra',
      rating: 4.9,
      priceRange: '₹₹₹',
      placeId: 'p003',
      description: 'Fresh tiger prawns tossed in coastal spice blend.',
      isVeg: false,
    ),
    const FoodItemModel(
      foodId: 'f005',
      name: 'Araku Coffee',
      category: 'Cafe',
      cuisine: 'Beverages',
      rating: 4.6,
      priceRange: '₹₹',
      placeId: 'p010',
      description: 'Premium single-origin tribal coffee from Araku valley.',
      isVeg: true,
    ),
    const FoodItemModel(
      foodId: 'f006',
      name: 'Gongura Mutton',
      category: 'Restaurant',
      cuisine: 'Andhra',
      rating: 4.8,
      priceRange: '₹₹',
      placeId: 'p002',
      description: 'Andhra\'s signature dish — mutton slow-cooked with sorrel leaves.',
      isVeg: false,
    ),
  ];

  Future<List<FoodItemModel>> getFoodItems({String? category}) async {
    await Future.delayed(const Duration(milliseconds: 450));
    if (category != null && category.isNotEmpty) {
      return _mockItems
          .where((f) => f.category.toLowerCase() == category.toLowerCase())
          .toList();
    }
    return List.unmodifiable(_mockItems);
  }

  Future<List<FoodItemModel>> getVegItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockItems.where((f) => f.isVeg).toList();
  }

  Future<List<FoodItemModel>> searchFood(String query) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final q = query.toLowerCase();
    return _mockItems
        .where((f) =>
            f.name.toLowerCase().contains(q) ||
            f.cuisine.toLowerCase().contains(q) ||
            f.category.toLowerCase().contains(q))
        .toList();
  }
}
