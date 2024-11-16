import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/core/utils.dart';
import 'package:music/core/widgets/loader.dart';
import 'package:music/features/home/view/pages/genre_page.dart';
import 'package:music/features/home/view/pages/search_ui.dart';
import 'package:music/features/home/viewmodel/home_viewmodel.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: CircleAvatar(
                            backgroundColor: Pallete.whiteColor,
                            child: Icon(
                              Icons.person,
                              color: Pallete.backgroundColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchUi()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Pallete.whiteColor,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/search_unfilled.png',
                                color: Pallete.backgroundColor,
                              ),
                            ),
                            const Text(
                              'What do you want to listen to?',
                              style: TextStyle(
                                fontSize: 20,
                                color: Pallete.greyColor,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    const Text(
                      'Browse all',
                      style: TextStyle(
                        color: Pallete.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ref.watch(getAllGenresProvider).when(
                      data: (data) {
                        return SizedBox(
                          height: 800,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 1.2
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final genre = data[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => GenrePage(
                                        genreName: genre.name, 
                                        genreColor: genre.color, 
                                        genreUrl: genre.url
                                      )
                                    )
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: hexToColor(genre.color),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      genre.name,
                                      style: const TextStyle(
                                        color: Pallete.whiteColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                        );
                      }, 
                      error: (error, st) {
                        return Center(
                          child: Text(error.toString()),
                        );
                      }, 
                      loading: () => const Loader()
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
