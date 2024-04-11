import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Aquí puedes agregar cualquier otro contenido que desees antes o después del slider

        // Slider de imágenes
        ImageSlideshow(
          width: double.infinity, // Opcional: ajusta el ancho al tamaño disponible
          height: 300, // Altura deseada del slider
          indicatorColor: Colors.blue, // Color del indicador
          indicatorBackgroundColor: Colors.grey, // Color de fondo del indicador
          autoPlayInterval: 8000, // Intervalo de reproducción automática
          isLoop: true, // Repetir el slider en un bucle

          children: [
            // Agrega aquí tus imágenes
            Image.asset(
              'assets/sliderdc/defensa1.jpg', // Ruta de la primera imagen
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
            Image.asset(
              'assets/sliderdc/defensa2.jpg', // Ruta de la segunda imagen
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
             Image.asset(
              'assets/sliderdc/defensa4.jpeg', // Ruta de la segunda imagen
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
             Image.asset(
              'assets/sliderdc/defensa5.jpeg', // Ruta de la segunda imagen
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
             Image.asset(
              'assets/sliderdc/defensa3.webp', // Ruta de la segunda imagen
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
            Image.asset(
              'assets/sliderdc/defensa6.jpg', // Ruta de la segunda imagen
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
            Image.asset(
              'assets/sliderdc/defensa7.jpg', // Ruta de la segunda imagen
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
            // Agrega más imágenes según sea necesario
          ],

        ),
      ],
    );
  }
}
