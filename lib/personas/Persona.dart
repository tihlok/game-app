import 'package:game_app_flutter/personas/Skill.dart';

class Persona {
  final int id;
  final String name;
  final String origin;
  final String imageURL;
  final int level;
  final int maxHP;
  final int currentHP;
  final int tacticalStress;
  final int combatStress;
  final List<Skill> skills;

  const Persona({
    this.id,
    this.name,
    this.origin,
    this.imageURL,
    this.level,
    this.maxHP,
    this.currentHP,
    this.tacticalStress,
    this.combatStress,
    this.skills,
  });

  get power => skills.length > 0 ? skills.map((m) => m.power).reduce((p, e) => p + e) : 0;

  get title => "[$level] $name";

  get subtitle => "poder $power";

  factory Persona.fromJSON(Map<String, dynamic> json) => Persona(
        id: json["id"],
        name: json["name"],
        origin: json["origin"],
        imageURL: json["image_url"],
        level: json["level"],
        maxHP: json["max_hp"],
        currentHP: json["current_hp"],
        tacticalStress: json["tactical_stress"],
        combatStress: json["combat_stress"],
        skills: List<Skill>.from((json["skills"] ?? []).map((m) => Skill.fromJSON(m))) ?? [],
      );
}
