import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyxsio_grid_view/onyxsio_grid_view.dart';
import 'package:photo_app/bloc/photo_bloc/photo_bloc.dart';
import 'package:photo_app/views/search_screen.dart';
import 'package:shimmer/shimmer.dart';

class PhotoDisplayScreen extends StatefulWidget {
  const PhotoDisplayScreen({Key? key}) : super(key: key);

  @override
  State<PhotoDisplayScreen> createState() => _PhotoDisplayScreenState();
}

class _PhotoDisplayScreenState extends State<PhotoDisplayScreen> {
  final List<double> _heightList = [];
  void getRandomHeight(double count) {
    final random = Random();
    for (int i = 0; i < count; i++) {
      _heightList.add(random.nextInt(100) + 200);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoBloc()..add(FetchPhoto()),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ],
            bottom: TabBar(
              physics: const BouncingScrollPhysics(),
              indicatorWeight: 4,
              tabs: [
                Tab(
                  child: Row(
                    children: const [
                      Icon(Icons.nature),
                      SizedBox(width: 10),
                      Text(
                        'Rose',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: const [
                      Icon(Icons.pets),
                      SizedBox(width: 10),
                      Text(
                        'Dogs',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: const [
                      Icon(CupertinoIcons.tortoise_fill),
                      SizedBox(width: 10),
                      Text(
                        'Tortoise',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: BlocConsumer<PhotoBloc, PhotoState>(
            listener: (context, state) {
              if (state is PhotoError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is PhotoLoaded) {
                getRandomHeight(state.plantData.photos!.length.toDouble());
              }
            },
            builder: (context, state) {
              if (state is PhotoLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PhotoLoaded) {
                return TabBarView(
                  children: [
                    OnyxsioGridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: 20,
                      physics: const BouncingScrollPhysics(),
                      staggeredTileBuilder: (index) =>
                          const OnyxsioStaggeredTile.fit(2),
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => OnyxsioGridTile(
                        index: index,
                        heightList: _heightList,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            state.plantData.photos![index].src!.original!,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;

                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              );
                            },
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    OnyxsioGridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: 20,
                      physics: const BouncingScrollPhysics(),
                      staggeredTileBuilder: (index) =>
                          const OnyxsioStaggeredTile.fit(2),
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => OnyxsioGridTile(
                        index: index,
                        heightList: _heightList,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            state.animalData.photos![index].src!.original!,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;

                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              );
                            },
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    OnyxsioGridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: 20,
                      physics: const BouncingScrollPhysics(),
                      staggeredTileBuilder: (index) =>
                          const OnyxsioStaggeredTile.fit(2),
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => OnyxsioGridTile(
                        index: index,
                        heightList: _heightList,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            state.birdData.photos![index].src!.original!,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;

                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              );
                            },
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
