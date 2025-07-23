import 'package:flutter/material.dart';
import '../../weather/model/weather_data.dart';


class WeatherDetailCard extends StatelessWidget {
  final DailyData weather;
  final bool? isSuitable;
  const WeatherDetailCard ({
   Key? key,
    required this.weather,
    this.isSuitable
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return SizedBox(
     height: 220,
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
             const SizedBox(height: 12),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 _buildInfoItem(Icons.thermostat_outlined, "Max", "${weather.maxTemp}°C"),
                 _buildInfoItem(Icons.thermostat, "Min", "${weather.minTemp}°C"),
                 _buildInfoItem(Icons.water, "Humidity", "${weather.humidity}%"),
               ],
             ),
             const SizedBox(height: 24),
             if (isSuitable != null)
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   _buildPred(
                       isSuitable! ? Icons.check : Icons.cancel,
                       isSuitable! ? 'Good for training' : 'Not suitable'
                   )
                 ],
               )
             else
              _buildPred(Icons.downloading, "Checking training condition...")
           ],
         ),
       ),
     ),
   );
  }

  Widget _buildInfoItem(IconData icon, String label, String value){
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.blueGrey,),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.blueGrey),
        ),
        const SizedBox(height: 6),
        Text(
          value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
        ),
      ],
    );
  }


  Widget _buildPred (IconData icon, String label){
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.blueGrey),
        const SizedBox(height: 8),
        Text (
            label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        )
      ],
    );
  }


}