class Receta {
  final String id;
  final String titulo;
  final String descripcion;
  final List<String> ingredientes;
  final List<String> pasos;
  final String imagenUrl;
  final int tiempoMinutos;
  final String dificultad;
  final String tipoComida;
  final List<String> dietas;
  final String autor;
  final double valoracion;
  final int calorias;
  final DateTime creadaEn;
  final String pais;

  Receta({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.ingredientes,
    required this.pasos,
    required this.imagenUrl,
    required this.tiempoMinutos,
    required this.dificultad,
    required this.tipoComida,
    required this.dietas,
    required this.autor,
    required this.valoracion,
    required this.calorias,
    required this.creadaEn,
    required this.pais,
  });
}
