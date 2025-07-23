import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/weather_viewmodel.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/weather_detail_card.dart';
import 'package:intl/intl.dart';
import '../../training/viewmodel/training_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
@override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final weatherVM = Provider.of<WeatherViewModel>(context, listen: false);
    weatherVM.fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer <WeatherViewModel>(
      builder: (context, weatherVM,_){
        return Scaffold(
            appBar: AppBar(
              title: Text("Weather for ${weatherVM.cityName}"),
              actions: [
                IconButton(
                    onPressed: (){
                      Provider.of<WeatherViewModel>(context, listen: false).fetchWeather();
                    },
                    icon: Icon(Icons.refresh)
                ),
              ],
            ),
            body: Consumer2<WeatherViewModel, Training>(
              builder: (context, weatherVM,trainingVM, _){
                if (weatherVM.isLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                if (weatherVM.errorMessage != null) {
                  return Center(child: Text('Error: ${weatherVM.errorMessage}'));
                }
                final forecast = weatherVM.forecast;
                if (forecast.isEmpty) {
                  return Center(child: Text('Error: No weather data is available'));
                }
                final selectedDayWeather = forecast.firstWhere(
                        (day) => isSameDate (day.date, selectedDate),
                    orElse: () => forecast[0]
                );
                WidgetsBinding.instance.addPostFrameCallback((_){
                  trainingVM.FetchResponse(weatherVM.getFeatures(selectedDayWeather.date));
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
                        }
                    ),
                    Expanded(
                        child: WeatherDetailCard(
                          weather: selectedDayWeather,
                          isSuitable: trainingVM.isSuitable,
                        )
                    )
                  ],
                );
              },
            )
        );
      }
    );
  }
  bool isSameDate (DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}