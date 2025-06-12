import 'package:receta_app/domain/entities/receta.dart';

class RecetaModel extends Receta {
  RecetaModel({
    required super.id,
    required super.titulo,
    required super.descripcion,
    required super.ingredientes,
    required super.pasos,
    required super.imagenUrl,
    required super.tiempoMinutos,
    required super.dificultad,
    required super.tipoComida,
    required super.dietas,
    required super.autor,
    required super.valoracion,
    required super.calorias,
    required super.creadaEn,
    required super.pais,
  });

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
