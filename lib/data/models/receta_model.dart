import 'package:receta_app/domain/entities/receta.dart';

class RecetaModel extends Receta {
  RecetaModel({
    required String id,
    required String titulo,
    required String descripcion,
    required List<String> ingredientes,
    required List<String> pasos,
    required String imagenUrl,
    required int tiempoMinutos,
    required String dificultad,
    required String tipoComida,
    required List<String> dietas,
    required String autor,
    required double valoracion,
    required int calorias,
    required DateTime creadaEn,
    required String pais,
  }) : super(
    id: id,
    titulo: titulo,
    descripcion: descripcion,
    ingredientes: ingredientes,
    pasos: pasos,
    imagenUrl: imagenUrl,
    tiempoMinutos: tiempoMinutos,
    dificultad: dificultad,
    tipoComida: tipoComida,
    dietas: dietas,
    autor: autor,
    valoracion: valoracion,
    calorias: calorias,
    creadaEn: creadaEn,
    pais: pais,
  );

  factory RecetaModel.fromJson(Map<String, dynamic> json) {
    return RecetaModel(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      ingredientes: List<String>.from(json['ingredientes']),
      pasos: List<String>.from(json['pasos']),
      imagenUrl: json['imagenUrl'],
      tiempoMinutos: json['tiempoMinutos'],
      dificultad: json['dificultad'],
      tipoComida: json['tipoComida'],
      dietas: List<String>.from(json['dietas']),
      autor: json['autor'],
      valoracion: (json['valoracion'] as num).toDouble(),
      calorias: json['calorias'],
      creadaEn: DateTime.parse(json['creadaEn']),
      pais: json['pais'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'ingredientes': ingredientes,
      'pasos': pasos,
      'imagenUrl': imagenUrl,
      'tiempoMinutos': tiempoMinutos,
      'dificultad': dificultad,
      'tipoComida': tipoComida,
      'dietas': dietas,
      'autor': autor,
      'valoracion': valoracion,
      'calorias': calorias,
      'creadaEn': creadaEn.toIso8601String(),
      'pais': pais,
    };
  }
}
