import 'package:flutter/material.dart';
import '../models/news_category.dart';
import 'news_list_page.dart';

class NewsCategoriesScreen extends StatelessWidget {
  final List<NewsCategory> categories = [
    NewsCategory(name: 'Technology', apiEndpoint: 'technology', iconPath: 'assets/gifs/technology.gif'),
    NewsCategory(name: 'Sports', apiEndpoint: 'sports', iconPath: 'assets/gifs/sports.gif'),
    NewsCategory(name: 'Health', apiEndpoint: 'health', iconPath: 'assets/gifs/health.gif'),
    NewsCategory(name: 'Science', apiEndpoint: 'science', iconPath: 'assets/gifs/science.gif'),
    NewsCategory(name: 'Business', apiEndpoint: 'business', iconPath: 'assets/gifs/business.gif'),
    NewsCategory(name: 'Entertainment', apiEndpoint: 'entertainment', iconPath: 'assets/gifs/entertainment.gif'),
    NewsCategory(name: 'Politics', apiEndpoint: 'politics', iconPath: 'assets/gifs/politics.gif'),
    NewsCategory(name: 'Travel', apiEndpoint: 'travel', iconPath: 'assets/gifs/travel.gif'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200, // Updated background color
      appBar: AppBar(
        title: Text(
          'News Categories',
          style: TextStyle(
            fontFamily: 'RobotoMono', // Use custom font if configured
            fontSize: 24, // Larger font size
            fontWeight: FontWeight.bold,
            color: Colors.white, // White for contrast
          ),
        ),
        backgroundColor: Colors.blueAccent, // Custom AppBar background
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Display 4 items per row
            childAspectRatio: 0.85, // Adjust the aspect ratio for taller items
            mainAxisSpacing: 12, // Space between rows
            crossAxisSpacing: 12, // Space between columns
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return NewsCategoryWidget(category: category);
          },
        ),
      ),
    );
  }
}

class NewsCategoryWidget extends StatefulWidget {
  final NewsCategory category;

  const NewsCategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  _NewsCategoryWidgetState createState() => _NewsCategoryWidgetState();
}

class _NewsCategoryWidgetState extends State<NewsCategoryWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    String staticImagePath = widget.category.iconPath.replaceAll('.gif', '_static.png'); // Assuming static image file names

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsListPage(category: widget.category)),
        );
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: SizedBox(
          width: 160, // Slightly smaller width for the widget
          height: 210, // Slightly smaller height for the widget
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50, // Updated card background color
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // Light shadow effect for the whole card
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(color: Colors.grey.shade300, width: 2), // Thin border for each item
            ),
            child: Column(
              children: [
                // Top 3/4th: Image or GIF
                Expanded(
                  flex: 3, // Image takes 3/4 of the widget height
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8.0), // Adds padding around the image
                      child: Center(
                        child: Image.asset(
                          isHovered ? widget.category.iconPath : staticImagePath,
                          fit: BoxFit.contain, // Ensure the image fits but doesn't stretch
                          height: 120.0, // Slightly larger image height
                          width: 120.0, // Slightly larger image width
                          gaplessPlayback: true, // Avoid flicker when switching images
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom 1/4th: Category Name with enhanced visibility
                Container(
                  padding: const EdgeInsets.all(6.0), // Slightly more padding for text container
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6), // Semi-transparent background for better contrast
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    widget.category.name.toUpperCase(), // All caps
                    style: TextStyle(
                      fontSize: 22, // Slightly increased font size for better visibility
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2, // More letter spacing for style
                      color: Colors.white, // White text for contrast
                      shadows: [
                        Shadow(
                          blurRadius: 2.0, // Smaller blur for subtler shadow
                          color: Colors.black.withOpacity(0.6), // Dark shadow for text depth
                          offset: Offset(1.5, 1.5), // Shadow position
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2, // Allow multi-line text if necessary
                    overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
