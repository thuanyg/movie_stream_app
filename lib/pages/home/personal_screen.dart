import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/models/movies_response.dart';
import 'package:movie_stream/networks/api_service.dart';
import 'package:movie_stream/networks/services/movie_service.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PersonalScreen> with AutomaticKeepAliveClientMixin{

  late Future<MoviesResponse> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = MovieService(apiService: ApiService()).fetchListMovies(1);
    // In dữ liệu sau khi tải về
    futureMovies.then((response) {
      print('Movies fetched successfully:');

      // Kiểm tra nếu response.movies không null và không rỗng
      if (response.items!.isNotEmpty) {
        final movie = response.items?[0]; // Truy cập bộ phim đầu tiên
        print('Movie ID: ${movie?.name}, Title: ${movie?.slug}');
      } else {
        print('No movies found in the response');
      }
    }).catchError((error) {
      print('Failed to fetch movies: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<MoviesResponse> (
          future: futureMovies,
          builder: (context, snapshot){
            // Check the connection state of the future
            if (snapshot.connectionState == ConnectionState.none) {
              // Show a loading spinner while waiting for data
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Show an error message if there's an error
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // Show data when available
              return Text("Phim: " + snapshot.data!.items![0].name.toString());
            } else {
              // Handle the case where there is no data
              return const Text('No data available');
            }
          },
        )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}