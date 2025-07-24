import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/weather_viewmodel.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/weather_detail_card.dart';
import '../../training/viewmodel/training_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final weatherVM = Provider.of<WeatherViewModel>(context, listen: false);
    weatherVM.fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<WeatherViewModel, Training>(
      builder: (context, weatherVM, trainingVM, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Weather for ${weatherVM.cityName}"),
            actions: [
              IconButton(
                onPressed: () {
                  final weatherVM = Provider.of<WeatherViewModel>(context, listen: false);
                  final trainingVM = Provider.of<Training>(context, listen: false);

                  weatherVM.fetchWeather();

                  final selectedDayWeather = weatherVM.forecast.firstWhere(
                        (day) => isSameDate(day.date, selectedDate),
                    orElse: () => weatherVM.forecast[0],
                  );

                  trainingVM.FetchResponse(
                    weatherVM.getFeatures(selectedDayWeather.date),
                  );
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: Consumer2<WeatherViewModel, Training>(
            builder: (context, weatherVM, trainingVM, _) {
              if (weatherVM.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (weatherVM.errorMessage != null) {
                return Center(child: Text('Error: ${weatherVM.errorMessage}'));
              }

              final forecast = weatherVM.forecast;
              if (forecast.isEmpty) {
                return const Center(child: Text('Error: No weather data is available'));
              }

              final selectedDayWeather = forecast.firstWhere(
                    (day) => isSameDate(day.date, selectedDate),
                orElse: () => forecast[0],
              );

              // Trigger fetch after first render
              WidgetsBinding.instance.addPostFrameCallback((_) {
                trainingVM.FetchResponse(
                  weatherVM.getFeatures(selectedDayWeather.date),
                );
              });

              return Column(
                children: [
                  CalendarWidget(
                    availableDates: forecast.map((d) => d.date).toList(),
                    selectedDate: selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date;
                      });

                      final selectedWeather = forecast.firstWhere(
                            (day) => isSameDate(day.date, date),
                        orElse: () => forecast[0],
                      );

                      trainingVM.FetchResponse(
                        weatherVM.getFeatures(selectedWeather.date),
                      );
                    },
                  ),
                  Expanded(
                    child: WeatherDetailCard(
                      weather: selectedDayWeather,
                      isSuitable: trainingVM.isSuitable == 1,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
