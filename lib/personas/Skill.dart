class Skill {
  final int id;
  final String name;
  final String type;
  final int basePower;

  const Skill({
    this.id,
    this.name,
    this.type,
    this.basePower,
  });

  get power => basePower;

  factory Skill.fromJSON(Map<String, dynamic> json) => Skill(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        basePower: json["base_power"],
      );
}
