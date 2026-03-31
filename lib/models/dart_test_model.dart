class DartTest {
  final String id;
  final String foodItem;
  final String adulterant;
  final String materialsNeeded;
  final List<String> steps;
  final String resultPositive;
  final String resultNegative;

  const DartTest({
    required this.id,
    required this.foodItem,
    required this.adulterant,
    required this.materialsNeeded,
    required this.steps,
    required this.resultPositive,
    required this.resultNegative,
  });
}

// FSSAI Verified Manual Adulteration Tests
final List<DartTest> mockDartTests = [
  const DartTest(
    id: 'dart_test_001',
    foodItem: 'Milk',
    adulterant: 'Water',
    materialsNeeded: 'A polished slanted surface (like a plate).',
    steps: [
      'Put a drop of milk on a polished slanted surface.',
    ],
    resultPositive: 'The drop flows down fast without leaving a mark (Adulterated).',
    resultNegative: 'The drop stays or flows slowly leaving a white trail (Pure).',
  ),
  const DartTest(
    id: 'dart_test_002',
    foodItem: 'Turmeric Powder',
    adulterant: 'Chalk Powder',
    materialsNeeded: 'A glass of water.',
    steps: [
      'Add a teaspoon of turmeric to a glass of water.',
      'Do not stir.',
      'Leave it for 10 minutes.',
    ],
    resultPositive: 'Chalk settles at the bottom. The water stays relatively clear.',
    resultNegative: 'Turmeric settles, but the water turns distinctly yellow.',
  ),
  const DartTest(
    id: 'dart_test_003',
    foodItem: 'Black Pepper',
    adulterant: 'Papaya Seeds',
    materialsNeeded: 'A glass of water.',
    steps: [
      'Drop a small amount of black pepper into a glass of water.',
    ],
    resultPositive: 'Papaya seeds will float on the surface.',
    resultNegative: 'Pure black pepper will sink to the bottom.',
  ),
];
