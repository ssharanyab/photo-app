// Search Page
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyxsio_grid_view/onyxsio_grid_view.dart';
import 'package:photo_app/bloc/photo_bloc/photo_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  Widget body = Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.white,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            CupertinoIcons.photo_fill_on_rectangle_fill,
            size: 100,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text('Search Your favorite images'),
        ],
      ),
    ),
  );
  final PhotoBloc photoBloc = PhotoBloc();

  final List<double> _heightList = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void getRandomHeight(double count) {
    final random = Random();
    for (int i = 0; i < count; i++) {
      _heightList.add(random.nextInt(100) + 200);
    }
  }

  void _searchPhoto(String query) {
    photoBloc.add(SearchPhoto(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoBloc, PhotoState>(
      bloc: photoBloc,
      listener: (context, state) {
        if (state is PhotoLoading) {
          body = const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SearchPhotoLoaded) {
          getRandomHeight(state.photoData.photos!.length.toDouble());
          body = OnyxsioGridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 20,
            physics: const BouncingScrollPhysics(),
            staggeredTileBuilder: (index) => const OnyxsioStaggeredTile.fit(2),
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
                  state.photoData.photos![index].src!.original!,
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
          );
        }
        if (state is PhotoError) {
          body = Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.report_problem,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text('Something went wrong'),
                ],
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              toolbarHeight: 60,
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                          },
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none),
                    onSubmitted: (value) {
                      print(value);
                      _searchPhoto(searchController.text);
                    },
                    textInputAction: TextInputAction.search,
                  ),
                ),
              )),
          body: body,
        );
      },
    );
  }
}
