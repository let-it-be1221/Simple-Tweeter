// import 'package:demo2_form/pages/settings.dart';
// import 'package:demo2_form/providers/user_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Home extends ConsumerWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Home"),
//           leading: Builder(builder: (context) {
//             return GestureDetector(
//               onTap: () => Scaffold.of(context).openDrawer(),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: CircleAvatar(
//                   backgroundImage:
//                       NetworkImage(ref.watch(userProvider).user.profilePic),
//                 ),
//               ),
//             );
//           }),
           
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             Text(ref.watch(userProvider).user.email),
//             //Image(image: NetworkImage('assets/user.png'), width: 200, height: 200),
    
//             Text(ref.watch(userProvider).user.name),
//           ],
//         ),
//         drawer: Drawer(
//             child: Column(
//           children: [
//             Image.network(ref.watch(userProvider).user.profilePic),
//             ListTile(
//               title: Text(
//                 "Hello, ${ref.watch(userProvider).user.name}",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//             ),
//             ListTile(
//               title: Text("Seetings"),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: ((context) => Settings())));
//               },
//             ),
    
//             ListTile(
//               title: Text("Sign Out"),
//               onTap: () {
//                  FirebaseAuth.instance.signOut();
//                   ref.watch(userProvider.notifier).logOut();
//               },
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }
