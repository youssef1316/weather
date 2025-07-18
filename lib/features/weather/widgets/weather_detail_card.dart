import 'package:flutter/material.dart';
import '../../weather/model/weather_data.dart';

class WeatherDetailCard extends StatelessWidget {
  final DailyData weather;
  const WeatherDetailCard ({
   Key? key,
   required this.weather
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return SizedBox(
     height: 100,
     child: Card(
       elevation: 4,
       margin: const EdgeInsets.all(12),
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
       child: Padding(
         padding: const EdgeInsets.all(20),
         child: Column(
           children: [
             Text(
               '${weather.condition}',
               style: const TextStyle(
                   fontSize: 22,
                   fontWeight: FontWeight.bold
               ),
             ),
             const SizedBox(height: 15),
             Image.network(
               weather.icon,
               width: 60,
               height: 60,
               errorBuilder: (_,__,___) => const Icon(Icons.cloud),
             ),
             const SizedBox(height: 10),
             Text(
               'Max: ${weather.maxTemp}°C',
               style: const TextStyle(fontSize: 18),
             ),
             Text(
               'Min: ${weather.minTemp}°C',
               style: const TextStyle(fontSize: 18),
             ),
           ],
         ),
       ),
     ),
   );
  }

}