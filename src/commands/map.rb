# -*- coding: utf-8 -*-

# ==============================================================================
# * RPG Maker (VX / VX.ACE) Extender
# ------------------------------------------------------------------------------
# {{ TODO: authors }}
# ------------------------------------------------------------------------------
# Maps related commands.
#
# [Dependencies]
#   - `../*.rb`
#   - `../documentation/internal_commands.rb`
#   - `../documentation/internal_documentation.rb`
# ==============================================================================
module RME
  module Command
    module Map

      # Common parameters' declaration
      X = {:name        => :x,
           :type        => ParameterType::Coordinate,
           :description => 'Map.x'}
      Y = {:name        => :y,
           :type        => ParameterType::Coordinate,
           :description => 'Map.y'}
      LAYER = {:name => :layer,
               :type => ParameterType::LayerId,
               :description => 'Map.layer'}

      # ------------------------------------------------------------------------
      # * Returns the identifier of the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :map_id,
                        :description => 'Map.map_id'}) do
        $game_map.map_id
      end

      # ------------------------------------------------------------------------
      # * Returns the current map's name.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :map_name,
                        :description => 'Map.map_name'}) do
        $game_map.display_name
      end

      # ------------------------------------------------------------------------
      # * Returns the event's identifier which is located at the given
      #   coordinates (`x`, `y`).
      # ------------------------------------------------------------------------
      Command::declare({:section          => self,
                        :name             => :id_at,
                        :description      => 'Map.event_at',
                        :deprecated_since => "2.0.0",
                        :see              => [:event_at],
                        :parameters       => [X, Y]}) do |x, y|
        event_at(x, y)
      end

      # ------------------------------------------------------------------------
      # * Returns the event's identifier which is located at the given
      #   coordinates ( `x`, `y`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :event_at,
                        :description => 'Map.event_at',
                        :parameters  => [X, Y]}) do |x, y|
        result = $game_map.event_id_xy(x, y)
        if result > 0
          result
        elsif $game_player.x == x && $game_player.y == y
          0
        else
          1
        end
      end

      # ------------------------------------------------------------------------
      # * Returns the type of terrain which corresponds to the tile located
      #   at the given coordinates (`x`, `y`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :terrain_tag,
                        :description => 'Map.terrain_tag',
                        :parameters  => [X, Y]}) do |x, y|
        $game_map.terrain_tag(x, y)
      end

      # ------------------------------------------------------------------------
      # * Return the identifier of the tile located at the given coordinates
      #   (`x`, `y`, `layer`) and belonging to the given map (`map_id`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :tile_id,
                        :description => 'Map.tile_id',
                        :parameters  => [
                          X,
                          Y,
                          LAYER,
                          {:name        => :map_id,
                           :description => 'Map.map_id',
                           :type        => ParameterType::NullablePositiveInteger,
                           :default     => nil}
                        ]}) do |x, y, layer, map_id|
        unless map_id
          $game_map.tile_id(x, y, layer)
        else
          Cache.map(map_id).data[x, y, layer]
        end
      end

      # ------------------------------------------------------------------------
      # * Changes all the tiles which are located in the given `layer` and
      #   which are complying with the given `id` to the new `new_id`.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :set_tile_where,
                        :description => 'Map.set_tile_where',
                        :parameters  => [
                          LAYER,
                          {:name        => :id,
                           :description => 'Map.set_tile_where.id',
                           :type        => ParameterType::PositiveInteger},
                          {:name        => :new_id,
                           :description => 'Map.set_tile_where.new_id',
                           :type        => ParameterType::PositiveInteger}
                        ]}) do |layer, id, new_id|
        map = $game_map.instance_variable_get(:@map)
        map_height.times do |y|
          map_width.times do |x|
            map.data[x, y, layer] = new_id if map.data[x, y, layer] == id
          end
        end
      end

      # ------------------------------------------------------------------------
      # * Deletes all the tiles which are located in the given `layer` and
      #   complying with the given `id`.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :delete_tiles,
                        :description => 'Map.delete_tiles',
                        :parameters  => [
                          LAYER,
                          {:name        => :id,
                           :description => 'Map.delete_tiles.id',
                           :type        => ParameterType::PositiveInteger}
                        ]}) do |layer, id|
        set_tile_where(layer, id, 0)
      end

      # ------------------------------------------------------------------------
      # * Changes the tile which is located at the given coordinates
      #   (`x`, `y`, `layer`), with the new `value`.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :set_tile,
                        :description => 'Map.set_tile',
                        :parameters  => [
                          {:name        => :value,
                           :description => 'Map.set_tile.value',
                           :type        => ParameterType::PositiveInteger},
                          X,
                          Y,
                          LAYER
                        ]}) do |value, x, y, layer|
        $game_map.instance_variable_get(:@map).data[x, y, layer] = value
      end

      # ------------------------------------------------------------------------
      # * Returns the region's identifier to which the tile located at the
      #   given coordinates belongs to (`x`, `y`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :region_id,
                        :description => 'Map.region_id',
                        :parameters  => [X, Y]}) do |x, y|
        $game_map.region_id(x, y)
      end

      # ------------------------------------------------------------------------
      # * Checks if the tile located at the given coordinates (`x`, `y`)
      #   can be passed through in the given `direction`.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :square_passable?,
                        :description => 'Map.square_passable?',
                        :parameters  => [
                          X,
                          Y,
                          {:name        => :direction,
                           :description => 'Map.direction',
                           :type        => ParameterType::Direction,
                           :default     => 2}
                        ]}) do |x, y, direction|
        $game_map.passable?(x, y, d)
      end

      # ------------------------------------------------------------------------
      # * Returns the identifier of the main tileset used to render
      #   the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :get_tileset_id,
                        :description => 'Map.get_tileset_id'}) do
        $game_map.tileset_id
      end

      # ------------------------------------------------------------------------
      # * Tells whether the dash is enabled (`true`) or not (`false`)
      #   for the player in the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :dash_activate?,
                        :description => 'Map.dash_activate?'}) do
        $game_map.can_dash
      end

      # ------------------------------------------------------------------------
      # * Tells whether the dash is disabled (`true`) or not (`false`)
      #   for the player in the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :dash_deactivate?,
                        :description => 'Map.dash_deactivate?'}) do
        !dash_activate?
      end

      # ------------------------------------------------------------------------
      # * Enables (`true`) or disables (`false`) the dashing option for the
      #   player in the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :dash_activation,
                        :description => 'Map.dash_activation',
                        :parameters  => [
                          {:name        => :flag,
                           :description => 'Map.dash_activation.flag',
                           :type        => ParameterType::Boolean}
                        ]}) do |flag|
        $game_map.can_dash = !!flag
      end

      # ------------------------------------------------------------------------
      # * Enables the dashing option for the player in the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :dash_activate,
                        :description => 'Map.dash_activate'}) do
        dash_activation(true)
      end

      # ------------------------------------------------------------------------
      # * Disables the dashing option for the player in the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :dash_deactivate,
                        :description => 'Map.dash_deactivate'}) do
        dash_activation(false)
      end

      # ------------------------------------------------------------------------
      # * Changes the main tileset of the current map for the given one.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :switch_tileset,
                        :description => 'Map.switch_tileset',
                        :parameters  => [
                          {:name        => :tileset_id,
                           :description => 'Map.switch_tileset.tileset_id',
                           :type        => ParameterType::PositiveInteger}
                        ]}) do |tileset_id|
        $game_map.tileset_id = tileset_id
      end

      # ------------------------------------------------------------------------
      # * Tells whether the tile located at the given coordinates (`x`, `y`)
      #   corresponds to a wall (`true`) or not (`false`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :wall?,
                        :description => 'Map.wall?',
                        :parameters  => [X, Y]}) do |x, y|
        tile_id = tile_id(x, y, 0)

        tile_id.between?(2288, 2335) ||
        tile_id.between?(2384, 2431) ||
        tile_id.between?(2480, 2527) ||
        tile_id.between?(2576, 2623) ||
        tile_id.between?(2672, 2719) ||
        tile_id.between?(2768, 2815) ||
        tile_id.between?(4736, 5119) ||
        tile_id.between?(5504, 5887) ||
        tile_id.between?(6272, 6655) ||
        tile_id.between?(7040, 7423) ||
        tile_id > 7807
      end

      # ------------------------------------------------------------------------
      # * Tells whether the tile located at the given coordinates (`x`, `y`)
      #   corresponds to a roof (`true`) or not (`false`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :roof?,
                        :description => 'Map.roof?',
                        :parameters  => [X, Y]}) do |x, y|
        tile_id = tile_id(x, y, 0)

        tile_id.between?(4352, 4735) ||
        tile_id.between?(5120, 5503) ||
        tile_id.between?(5888, 6271) ||
        tile_id.between?(6656, 7039) ||
        tile_id.between?(7424, 7807)
      end

      # ------------------------------------------------------------------------
      # * Tells whether the tile located at the given coordinates (`x`, `y`)
      #   corresponds to a stair (`true`) or not (`false`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :stair?,
                        :description => 'Map.stair?',
                        :parameters  => [X, Y]}) do |x, y|
        tile_id = tile_id(x, y, 0)

        tile_id.between?(1541, 1542) ||
        tile_id.between?(1549, 1550) ||
        tile_id.between?(1600, 1615)
      end

      # ------------------------------------------------------------------------
      # * Tells whether the tile located at the given coordinates (`x`, `y`)
      #   corresponds to a table (`true`) or not (`false`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :table?,
                        :description => 'Map.table?',
                        :parameters  => [X, Y]}) do |x, y|
        tile_id = tile_id(x, y, 0)

        tile_id.between?(3152, 3199) ||
        tile_id.between?(3536, 3583) ||
        tile_id.between?(3920, 3967) ||
        tile_id.between?(4304, 4351)
      end

      # ------------------------------------------------------------------------
      # * Tells whether the tile located at the given coordinates (`x`, `y`)
      #   corresponds to a ground one (`true`) or not (`false`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :ground?,
                        :description => 'Map.ground?',
                        :parameters  => [X, Y]}) do |x, y|
        tile_id = tile_id(x, y, 0)

        (tile_id.between?(2816, 4351) && !table?(x,y)) ||
        (tile_id > 1663 && !stair?(x,y))
      end

      # ------------------------------------------------------------------------
      # * Returns the width (unit being the tiles) of the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :map_width,
                        :description => 'Map.map_width'}) do
        $game_map.width
      end

      # ------------------------------------------------------------------------
      # * Returns the height (unit being the tiles) of the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :map_height,
                        :description => 'Map.map_height'}) do
        $game_map.height
      end

      # ------------------------------------------------------------------------
      # * Tells whether the tile located at the given coordinates (`x`, `y`)
      #   is traversable by boat (`true`); or not (`false`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :boat_passable?,
                        :description => 'Map.boat_passable?',
                        :parameters  => [X, Y]}) do |x, y|
        $game_map.boat_passable?(x, y)
      end

      # ------------------------------------------------------------------------
      # * Tells whether the tile located at the given coordinates (`x`, `y`)
      #   is traversable by ship (`true`); or not (`false`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :ship_passable?,
                        :description => 'Map.ship_passable?',
                        :parameters  => [X, Y]}) do |x, y|
        $game_map.ship_passable?(x, y)
      end

      # ------------------------------------------------------------------------
      # * Returns the tile's identifier which corresponds to the autotile
      #   located at the given coordinates (`x`, `y`, `z`).
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :autotile_type,
                        :description => 'Map.autotile_type',
                        :parameters  => [
                          X,
                          Y,
                          {:name        => :z,
                           :description => 'Map.autotile_type.z',
                           :type        => ParameterType::PositiveInteger}
                        ]}) do |x, y, z|
        $game_map.autotile_type(x, y, z)
      end

      # ------------------------------------------------------------------------
      # * Tells whether the tile located at the given coordinates (`x`, `y`)
      #   might hurt the player if he walks on it.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :damage_floor?,
                        :description => 'Map.damage_floor?',
                        :parameters  => [X, Y]}) do |x, y|
        $game_map.damage_floor?(x, y)
      end

      # ------------------------------------------------------------------------
      # * Returns a random square in the current map which belongs to the given
      #   `region_id`.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :get_random_square,
                        :description => 'Map.get_random_square',
                        :parameters  => [
                          {:name        => :region_id,
                           :description => 'Map.get_random_square.region_id',
                           :type        => ParameterType::RegionId,
                           :default     => 0}
                        ]}) do |region_id|
        $game_map.random_square(region_id)
      end

      # ------------------------------------------------------------------------
      # * Returns an array of squares which belongs to the given `region_id`,
      #   in the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :get_squares_by_region,
                        :description => 'Map.get_squares_by_region',
                        :parameters  => [
                          {:name        => :region_id,
                           :description => 'Map.get_squares_by_region.region_id',
                           :type        => ParameterType::RegionId}
                        ]}) do |region_id|
        $game_map.squares_by_region(region_id)
      end

      # ------------------------------------------------------------------------
      # * Returns an array of squares which is made of the same tile (`tile_id`)
      #   and which is located on the same `layer` in the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :get_squares_by_tile,
                        :description => 'Map.get_squares_by_tile',
                        :parameters  => [
                          LAYER,
                          {:name        => :tile_id,
                           :description => 'Map.get_squares_by_tile.tile_id',
                           :type        => ParameterType::PositiveInteger}
                        ]}) do |layer, tile_id|
        $game_map.squares_by_tile(layer, tile_id)
      end

      # ------------------------------------------------------------------------
      # * Returns an array of squares which comply with the given `terrain_tag`,
      #   in the current map.
      # ------------------------------------------------------------------------
      Command::declare({:section     => self,
                        :name        => :get_squares_by_terrain,
                        :description => 'Map.get_squares_by_terrain',
                        :parameters  => [
                          {:name        => :terrain_tag,
                           :description => 'Map.get_squares_by_terrain.terrain_tag',
                           :type        => ParameterType::TerrainTag}
                        ]}) do |terrain_tag|
        $game_map.squares_by_terrain(terrain_tag)
      end

      append_commands
    end
  end
end