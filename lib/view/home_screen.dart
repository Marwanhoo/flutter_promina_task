import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_promina_task/controller/cubit.dart';
import 'package:flutter_promina_task/controller/states.dart';
import 'package:flutter_promina_task/model/global_user.dart';
import 'package:flutter_promina_task/view/login_screen.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_picker/image_picker.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ProminaCubit prominaCubit = BlocProvider.of<ProminaCubit>(context);
    prominaCubit.fetchGallery();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://plus.unsplash.com/premium_photo-1668359407785-ac5dca1de611?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Welcome\nMuhammad",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),
                InkWell(
                  onTap: (){
                   showDialog(context: context, builder: (context) {
                     return AlertDialog(
                       title: const Text("User"),
                       content: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Text("• ID: ${GlobalUser.userModel?.id}"),
                           Text("• Name: ${GlobalUser.userModel?.name}"),
                           Text("• Email: ${GlobalUser.userModel?.email}"),
                         ],
                       ),
                       actions: [
                         TextButton(
                             onPressed: () {
                               Navigator.of(context).pop();
                             },
                             child: const Text("OK")),
                       ],
                     );
                   },);
                  },
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://avatars.githubusercontent.com/u/125823028?v=4"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Logout"),
                            content: const Text(
                                "Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  BlocProvider.of<ProminaCubit>(context)
                                      .logout();
                                  Navigator.of(context)
                                      .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                          const LoginScreen()),
                                          (route) => false);
                                },
                                child: const Text("Ok"),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel")),
                            ],
                          );
                        },
                      );
                    },
                    icon: Image.asset(
                      "assets/images/logout.png",
                      width: 25,
                    ),
                    label: const Text(
                      "Log out",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            child: GlassmorphicContainer(
                              width: 350,
                              height: 250,
                              borderRadius: 40,
                              blur: 10,
                              alignment: Alignment.bottomCenter,
                              border: 2,
                              linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFffffff)
                                        .withOpacity(0.1),
                                    const Color(0xFFFFFFFF)
                                        .withOpacity(0.05),
                                  ],
                                  stops: const [
                                    0.1,
                                    1,
                                  ]),
                              borderGradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFFffffff)
                                      .withOpacity(0.5),
                                  const Color((0xFFFFFFFF))
                                      .withOpacity(0.5),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      BlocProvider.of<ProminaCubit>(context)
                                          .pickImage(ImageSource.gallery);
                                    },
                                    icon: Image.asset(
                                      "assets/images/gallery.png",
                                      width: 35,
                                    ),
                                    label: const Text(
                                      "Gallery",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xffefd8f9),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 18),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(18),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      BlocProvider.of<ProminaCubit>(context)
                                          .pickImage(ImageSource.camera);
                                    },
                                    icon: Image.asset(
                                      "assets/images/camera.png",
                                      width: 35,
                                    ),
                                    label: const Text(
                                      "Camera",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xffebf6ff),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 18),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Image.asset(
                      "assets/images/image-upload.png",
                      width: 25,
                    ),
                    label: const Text(
                      "Upload",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            BlocConsumer<ProminaCubit, ProminaStates>(
              listener: (context, state) {
                if (state is UploadSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Photo uploaded successfully')),
                  );
                  Navigator.pop(context);
                } else if (state is UploadErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                  if (state is GalleryLoadingState) {
                    return const Center(child: CircularProgressIndicator(),);
                  } else if (state is GalleryLoadedState) {
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: ()=> BlocProvider.of<ProminaCubit>(context).openGallery(context, index, state.images),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(22),
                                    child: FancyShimmerImage(
                                      imageUrl: state.images[index],
                                      boxFit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              itemCount: state.images.length,
                            ),
                          ),
                          FloatingActionButton.extended(
                            onPressed: (){},
                            label: const Text("Number of photos"),
                            icon: Text("${state.images.length}"),
                          ),
                        ],
                      ),
                    );
                  } else if (state is GalleryErrorState) {
                    return Center(child: Text(state.error));
                  } else {
                    return const Center(child: Text('No images found'));
                  }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: const FlutterLogo(),
    );
  }
}