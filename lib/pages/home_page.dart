import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/providers/pets_provider.dart';
import 'package:adopt_app/widgets/pet_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:adopt_app/pages/add_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Adopt"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/add');
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Add a new Pet"),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<PetsProvider>(context, listen: false).getPets();
              },
              child: const Text("GET"),
            ),
            // Future builder
            FutureBuilder<void>(
              future:
                  Provider.of<PetsProvider>(context, listen: false).getPets(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (dataSnapshot.hasError) {
                  return Center(child: Text("Error"));
                } else {
                  return Consumer<PetsProvider>(
                    builder: (context, petsProvider, child) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height),
                        ),
                        itemCount: petsProvider.pets.length,
                        itemBuilder: (context, index) =>
                            PetCard(pet: petsProvider.pets[index]),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:adopt_app/models/pet.dart';
// import 'package:adopt_app/providers/pets_provider.dart';
// import 'package:adopt_app/widgets/pet_card.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     List<Pet> pets = Provider.of<PetsProvider>(context).pets;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Pet Adopt"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: const Padding(
//                   padding: EdgeInsets.all(12.0),
//                   child: Text("Add a new Pet"),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<PetsProvider>(context, listen: false).getPets();
//               },
//               child: const Text("GET"),
//             ),

//             //Future builder
//             FutureBuilder<List<Pet>>(
//               future:
//                   Provider.of<PetsProvider>(context, listen: false).getPets(),
//               builder: (context, dataSnapshot) {
//                 if (dataSnapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   return Consumer<PetsProvider>(
//                       builder: (context, PetsProvider, child) =>
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: PetsProvider.pets.length,
//                             itemBuilder: (context, index) =>
//                                 PetCard(pet: PetsProvider.pets[index]),
//                           ));
//                 }
//               },
//               child: GridView.builder(
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: MediaQuery.of(context).size.width /
//                         (MediaQuery.of(context).size.height),
//                   ),
//                   physics: const NeverScrollableScrollPhysics(), // <- Here
//                   itemCount: pets.length,
//                   itemBuilder: (context, index) => PetCard(pet: pets[index])),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }