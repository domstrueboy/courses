use bevy::prelude::*;
use itertools::Itertools;

mod colors;
use colors::MATERIALS;

const TILE_SIZE: f32 = 40.0;
const TILE_SPACER: f32 = 10.0;

#[derive(Component)]
struct Board {
    size: u8,
}

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_startup_system(setup)
        .add_startup_system(spawn_board)
        .run();
}

fn setup(mut commands: Commands) {
    commands
        .spawn_bundle(OrthographicCameraBundle::new_2d());
}

fn spawn_board(
    mut commands: Commands,
) {
    let board = Board { size: 4 };

    let physical_board_size = f32::from(board.size) * TILE_SIZE
        + f32::from(board.size + 1) * TILE_SPACER;

    let offset = - physical_board_size / 2.0 + 0.5 * TILE_SIZE;

    commands
        .spawn_bundle(SpriteBundle {
            sprite: Sprite {
                color: MATERIALS.board,
                custom_size: Some(Vec2::new(
                    physical_board_size, 
                    physical_board_size
                )),
                ..Sprite::default()
            },
            ..Default::default()
        })
        .with_children(|builder| {
            for tile in (0..board.size)
                .cartesian_product(0..board.size)
            {
                builder.spawn_bundle(SpriteBundle {
                    sprite: Sprite {
                        color: MATERIALS.tile_placeholder,
                        custom_size: Some(Vec2::new(
                            TILE_SIZE, 
                            TILE_SIZE
                        )),
                        ..Sprite::default()
                    },
                    transform: Transform::from_xyz(
                        offset + f32::from(tile.0) * TILE_SIZE
                            + f32::from(tile.0 + 1) * TILE_SPACER,
                        offset + f32::from(tile.1) * TILE_SIZE
                            + f32::from(tile.1 + 1) * TILE_SPACER,
                        1.0,
                    ),
                    ..Default::default()
                });
            }
        })
        .insert(board);
}