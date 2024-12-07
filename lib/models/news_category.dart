class NewsCategory {
  final String name;
  final String apiEndpoint;
  final String iconPath; // Add this field

  // Update the constructor to include iconPath
  NewsCategory({
    required this.name,
    required this.apiEndpoint,
    required this.iconPath, // Add iconPath as required
  });
}
