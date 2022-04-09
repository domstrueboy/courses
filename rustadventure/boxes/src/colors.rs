use bevy::prelude::Color;

pub struct Materials {
    pub board: Color,
    pub tile_placeholder: Color,
    pub tile: Color,
    pub none: Color,
}

pub const MATERIALS: Materials = Materials {
    board: Color::rgb(0.7, 0.7, 0.8),
    tile_placeholder: Color::rgb(0.75, 0.75, 0.75),
    tile: Color::rgb(0.9, 0.9, 1.0),
    none: Color::NONE,
};
