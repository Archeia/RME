# coding: utf-8
{
  # Parameters' types
  'doc.Coordinate.description'      => "Coordonées d'un point dans un repère cartésien",
  'doc.Boolean.description'         => 'Valeur booléenne (deux états : vrai ou faux)',
  'doc.PositiveInteger.description' => 'Entier positif',
  'doc.NullablePositiveInteger.description' => 'Entier positif (peut-être nul)',
  'doc.Direction.description' => "Direction du mouvement (`2` pour le bas, `4` pour la gauche, `6` pour la droite et `8` pour le haut)",
  'doc.RegionId.description' => "Identifiant de région (tiles)",
  'doc.LayerId.description' => "Identifiant de la couche (tiles)",
  'doc.TerrainTag.description' => "Étiquette de terrain (tiles)",

  # Sections
  'doc.section.Map' => "Commandes relatives aux informations des cartes",
  'doc.section.Actors' => "Offre des commandes pour obtenir des informations sur les acteurs (héros) ",

  # Commands
  ## Map
  'doc.cmd.Map.map_id' => "Renvoie l'ID de la map en cours. Idéalement, utiliser c(:map_id) qui est plus sur!",
  'doc.cmd.Map.map_name' => "Renvoie le nom de la map en cours",
  'doc.cmd.Map.event_at' => "Renvoie l'ID de l'évènement pointé par les coordonnées X,Y (O si c'est le héros, -1 s'il n'y en a pas)",
  'doc.cmd.Map.terrain_tag' => "Renvoie le tag du terrain de la case pointée par les coordonnées X,Y",
  'doc.cmd.Map.tile_id' => "Renvoie l'ID de la tile pointée par les coordonnées X,Y",
  'doc.cmd.Map.set_tile_where' => "Change tous les tile d'une carte selon un ID et un layer",
  'doc.cmd.Map.delete_tiles' => "Supprime tous les tiles référencés par un ID et un layer",
  'doc.cmd.Map.set_tile' => "Change une case de tile",
  'doc.cmd.Map.region_id' => "Renvoie l'ID de la région pointée par les coordonnées X,Y",
  'doc.cmd.Map.square_passable?' => "Renvoie `true` si la case référencée par X, Y est passable dans la direction référencée par `direction`; `false` sinon",
  'doc.cmd.Map.get_tileset_id' => "Renvoie l'ID du tileset de la carte en cours",
  'doc.cmd.Map.dash_activate?' => "Renvoie `true` si la course est activée pour la map en cours, `false` sinon",
  'doc.cmd.Map.dash_deactivate?' => "Renvoie `true` si la course est désactivée pour la map en cours, `true` sinon",
  'doc.cmd.Map.dash_activation' => "Active ou désactive la course sur la map en cours",
  'doc.cmd.Map.dash_activate' => "Active la course sur la map en cours",
  'doc.cmd.Map.dash_deactivate' => "Désactive la course pour la map en cours",
  'doc.cmd.Map.switch_tileset' => "Change le tileset de la carte en cours",
  'doc.cmd.Map.wall?' => "Renvoie `true` si les coordonnées sont sur un mur, `false` sinon",
  'doc.cmd.Map.roof?' => "Renvoie `true` si les coordonnées sont sur un toit, `false` sinon",
  'doc.cmd.Map.stair?' => "Renvoie `true` si les coordonnées sont sur une marche, `false` sinon",
  'doc.cmd.Map.table?' => "Renvoie `true` si les coordonnées sont sur une table, `false` sinon",
  'doc.cmd.Map.ground?' => "Renvoie `true` si les coordonnées sont sur le sol, `false` sinon",
  'doc.cmd.Map.map_width' => "Retourne la largeur de la carte",
  'doc.cmd.Map.map_height' => "Retourne la hauteur de la carte",
  'doc.cmd.Map.boat_passable?' => "Renvoie `true` si l'on peut traverser la case avec le radeau",
  'doc.cmd.Map.ship_passable?' => "Renvoie `true` si l'on peut traverser la case avec le bateau",
  'doc.cmd.Map.autotile_type' => "Renvoie l'ID qui correspond au tile d'autotile aux coordonnées passées en paramètre",
  'doc.cmd.Map.damage_floor?' => "Renvoie `true` si la case référencée par (`x`, `y`) est blessante, `false` sinon",
  'doc.cmd.Map.get_random_square' => "Renvoie un point aléatoire sur la carte, dont la région est référencée par son ID",
  'doc.cmd.Map.get_squares_by_region' => "Renvoie un tableau de cases pour une région donnée",
  'doc.cmd.Map.get_squares_by_tile' => "Renvoie un table de cases pour un tile (et une couche) donnés",
  'doc.cmd.Map.get_squares_by_terrain' => "Renvoie un tableau de cases pour un `terrain_tag` donné",
  ## Actors
  'doc.cmd.Actors.actor_equip' => "Renvoie l'id de l'équipement (dans le slot indiqué) du héros (référencé par son ID)",
  'doc.cmd.Actors.actor_weapon' => "Renvoie l'id de l'arme équipée par le héros référencé par son ID",
  'doc.cmd.Actors.actor_shield' => "Renvoie l'id du bouclier équipé par le héros référencé par son ID",

  # Parameters
  ## Map
  'doc.parameter.Map.x' => "Coordonnée X de la case",
  'doc.parameter.Map.y' => "Coordonnée Y de la case",
  'doc.parameter.Map.layer' => "Numéro de la couche",
  'doc.parameter.Map.map_id' => "ID d'une carte, si aucun argument n'est donné, map_id vaut l'id de la map courante",
  'doc.parameter.Map.direction' => "Direction depuis laquelle on souhaite atteindre la case",
  'doc.parameter.Map.set_tile_where.id' => "Id du tile à remplacer",
  'doc.parameter.Map.set_tile_where.new_id' => "Nouvel Id du tile",
  'doc.parameter.Map.delete_tiles.id' => "Id du tile à supprimer",
  'doc.parameter.Map.set_tile.value' => "Valeur du tile (utilisez éventuellement la commande `tile_id`)",
  'doc.parameter.Map.dash_activation.flag' => "`true` pour l'activer, `false` pour la désactiver",
  'doc.parameter.Map.switch_tileset.tileset_id' => "ID du nouveau tileset",
  'doc.parameter.Map.autotile_type.z' => "Couche du tileset",
  'doc.parameter.Map.get_random_square.region_id' => "L'id de la région dans laquelle chercher une case aléatoire. Par défaut, elle vaut 0",
  'doc.parameter.Map.get_squares_by_region.region_id' => "l'ID de la région (entre 0 et 63)",
  'doc.parameter.Map.get_squares_by_tile.tile_id' => "L'ID du tile",
  'doc.parameter.Map.get_squares_by_terrain.terrain_tag' => "Le terrain tag (entre 0 et 7)",
  ## Actors
  'doc.parameter.Actors.actor_id' => "ID de l'acteur",
  'doc.parameter.Actors.actor_equip.slot' => "Slot d'équipement"
}
