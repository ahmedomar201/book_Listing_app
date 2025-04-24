// import 'package:flutter/material.dart';


// class BookListScreen1 extends StatefulWidget {
//   const BookListScreen1({super.key});

//   @override
//   State<BookListScreen1> createState() => _BookListScreen1State();
// }

// class _BookListScreen1State extends State<BookListScreen1> {
//   final TextEditingController _searchController = TextEditingController();
//   bool _isLoading = false;

//   // بيانات وهمية للعرض
//   final List<Map<String, dynamic>> _books = [
//     {
//       'id': 1,
//       'title': 'Book Title 1',
//       'authors': ['Author 1', 'Author 2'],
//       'summary': 'This is a long summary for book 1. It should be truncated after 3 lines with ellipsis and expand when "See More" is clicked.',
//       'coverImageUrl': 'https://covers.openlibrary.org/b/id/10417897-L.jpg',
//     },
//     {
//       'id': 2,
//       'title': 'Book Title 2',
//       'authors': ['Author 3'],
//       'summary': 'Short summary for book 2.',
//       'coverImageUrl': 'https://covers.openlibrary.org/b/id/10417898-L.jpg',
//     },
//     {
//       'id': 3,
//       'title': 'Book Title 3',
//       'authors': ['Author 4', 'Author 5', 'Author 6'],
//       'summary': 'Another long summary for book 3. This one should also be truncated and expandable. The text is longer to demonstrate the truncation and expansion functionality properly.',
//       'coverImageUrl': null,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Book List'),
//       ),
//       body: Column(
//         children: [
//           // شريط البحث
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search books...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.clear),
//                   onPressed: () {
//                     _searchController.clear();
//                     // هنا سيتم تنفيذ البحث عند مسح النص إذا أردت
//                   },
//                 ),
//               ),
//               onSubmitted: (value) {
//                 // هنا سيتم تنفيذ البحث عند الضغط على Enter
//               },
//             ),
//           ),
          
//           // قائمة الكتب
//           Expanded(
//             child: ListView.builder(
//               itemCount: _books.length + (_isLoading ? 1 : 0),
//               itemBuilder: (context, index) {
//                 if (index >= _books.length) {
//                   return const Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 }
                
//                 final book = _books[index];
//                 return BookListItem(
//                   title: book['title'],
//                   authors: book['authors'],
//                   summary: book['summary'],
//                   coverImageUrl: book['coverImageUrl'],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BookListItem extends StatefulWidget {
//   final String title;
//   final List<String> authors;
//   final String summary;
//   final String? coverImageUrl;

//   const BookListItem({
//     super.key,
//     required this.title,
//     required this.authors,
//     required this.summary,
//     this.coverImageUrl,
//   });

//   @override
//   State<BookListItem> createState() => _BookListItemState();
// }

// class _BookListItemState extends State<BookListItem> {
//   bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // صورة الغلاف والعنوان والمؤلفون
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // صورة الغلاف
//                 if (widget.coverImageUrl != null)
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(4),
//                     child: Image.network(
//                       widget.coverImageUrl!,
//                       width: 80,
//                       height: 120,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => Container(
//                         width: 80,
//                         height: 120,
//                         color: Colors.grey[200],
//                         child: const Icon(Icons.book, size: 40),
//                       ),
//                     ),
//                   )
//                 else
//                   Container(
//                     width: 80,
//                     height: 120,
//                     color: Colors.grey[200],
//                     child: const Icon(Icons.book, size: 40),
//                   ),
                
//                 const SizedBox(width: 12),
                
//                 // العنوان والمؤلفون
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.title,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         widget.authors.join(', '),
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontStyle: FontStyle.italic,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
            
//             const SizedBox(height: 12),
            
//             // الملخص
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Summary:',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     final textSpan = TextSpan(
//                       text: widget.summary,
//                       style: const TextStyle(fontSize: 14),
//                     );
                    
//                     final textPainter = TextPainter(
//                       text: textSpan,
//                       maxLines: 3,
//                       textDirection: TextDirection.ltr,
//                     )..layout(maxWidth: constraints.maxWidth);

//                     if (textPainter.didExceedMaxLines) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.summary,
//                             maxLines: _isExpanded ? null : 3,
//                             overflow: _isExpanded ? null : TextOverflow.ellipsis,
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 _isExpanded = !_isExpanded;
//                               });
//                             },
//                             style: TextButton.styleFrom(
//                               padding: EdgeInsets.zero,
//                               minimumSize: const Size(50, 30),
//                               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                             ),
//                             child: Text(
//                               _isExpanded ? 'See Less' : 'See More',
//                               style: const TextStyle(
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     } else {
//                       return Text(widget.summary);
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }