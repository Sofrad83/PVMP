class Citation {
  String texte;
  String auteur;

  Citation({required this.texte, required this.auteur});
      
  factory Citation.fromJson(Map<String, dynamic> json) => Citation(
    texte: json["citation"] as String,
    auteur: json["auteur"] as String
  );
}
