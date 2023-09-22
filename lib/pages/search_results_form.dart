import 'package:flutter/material.dart';

class SearchResultsForm extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;

  SearchResultsForm(this.searchResults);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.black45], // Adjust the gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: searchResults.length + 1, // +1 for the "Searched Vehicles" header
          itemBuilder: (context, index) {
            if (index == 0) {
              // Display the "Searched Vehicles" header
              return Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  'Searched Vehicles',
                  style: TextStyle(
                    fontSize: 35, // Increased font size
                    fontWeight: FontWeight.bold, // Make the text bold
                    color: Colors.white, // Text color
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.pink, // Neon pink color
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              );
            }

            final result = searchResults[index - 1];
            final imageUrl = result['imageUrl'] ?? '';
            final name = result['name'] ?? 'N/A';
            final type = result['type'] ?? 'N/A';
            final pricePerHour = result['pricePerHour'] ?? 'N/A';
            final pricePerDay = result['pricePerDay'] ?? 'N/A';

            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0), // Adjust gap here
              child: Row(
                children: [
                  if (imageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      child: Container(
                        width: 350, // Adjust image width
                        height: 200, // Adjust image height
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  SizedBox(width: 10), // Gap between image and details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18, // Adjust the font size as needed
                            color: Colors.black, // Text color
                          ),
                        ),
                        Text(
                          'Type: $type',
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                            color: Colors.black, // Text color
                          ),
                        ),
                        Text(
                          'Price per Hour: $pricePerHour',
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                            color: Colors.black, // Text color
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Price per Day: $pricePerDay',
                              style: TextStyle(
                                fontSize: 16, // Adjust the font size as needed
                                color: Colors.black, // Text color
                              ),
                            ),
                            SizedBox(width: 10),
                            MouseRegion(
                              onHover: (_) {
                                // Handle hover
                                // You can change the color to bright yellow or apply any other effect here
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent, // Button background color
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width: 2, // Border width
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  child: Text(
                                    'Rent Now',
                                    style: TextStyle(
                                      color: Colors.yellow, // Text color
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
