import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/features/weather/service/location.dart';
import '../../weather/viewmodel/weather_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context, listen: false);
    return Scaffold(
     appBar: AppBar(title: Text('Weather Home')),
      body: Center(
        child: viewModel.isLoading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  viewModel.fetchCurretLocation();
                },
                child: Text('Get Location')
            ),
            const SizedBox(height: 20),
            if (viewModel.errorMessage != null)
              Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red)
              )
            else if (viewModel.currentPosition != null)
              Text(
                'Lat: ${viewModel.currentPosition!.latitude}, '
                    'Lon: ${viewModel.currentPosition!.longitude}',
                style: const TextStyle(fontSize: 16)
              )
          ],
        )
      ),
    );
  }
}