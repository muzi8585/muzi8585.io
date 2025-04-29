import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUser extends StatelessWidget {
  const ShimmerUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 35,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8))),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 2),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 35,
                    width: 338,
                    color: Colors.white,
                  ),
                
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class ShimmerUser extends StatelessWidget {
//   const ShimmerUser({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Table(
//               columnWidths: const {
//                 0: FixedColumnWidth(200),
//                 1: FixedColumnWidth(250),
//                 2: FixedColumnWidth(150),
//               },
//               children: [
//                 // Header shimmer
//                 TableRow(
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF2A3D56),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8),
//                     ),
//                   ),
//                   children: List.generate(3, (index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Shimmer.fromColors(
//                         baseColor: Colors.grey[300]!,
//                         highlightColor: Colors.grey[100]!,
//                         child: Container(
//                           height: 20,
//                           width: double.infinity,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//                 // Rows shimmer
//                 ...List.generate(10, (index) {
//                   final isEvenRow = index % 2 != 0;

//                   return TableRow(
//                     decoration: BoxDecoration(
//                       color: isEvenRow
//                           ? const Color(0x001e3a5f).withOpacity(0.09)
//                           : Colors.transparent,
//                     ),
//                     children: List.generate(3, (_) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 10),
//                         child: Shimmer.fromColors(
//                           baseColor: Colors.grey[300]!,
//                           highlightColor: Colors.grey[100]!,
//                           child: Container(
//                             height: 16,
//                             width: double.infinity,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       );
//                     }),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
