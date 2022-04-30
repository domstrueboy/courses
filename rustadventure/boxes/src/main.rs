use bevy::prelude::*;
use itertools::Itertools;
use rand::prelude::*;
use std::{convert::TryFrom, cmp::Ordering};

mod colors;
use colors::MATERIALS;

const TILE_SIZE: f32 = 40.0;
const TILE_SPACER: f32 = 10.0;

#[derive(Component)]
struct Board {
    size: u8,
    physical_size: f32,
}

impl Board {
    fn new(size: u8) -> Self {

        let physical_size = f32::from(size) * TILE_SIZE
            + f32::from(size + 1) *TILE_SPACER;

        Board {
            size,
            physical_size,
        }
    }

    fn cell_position_to_physical(&self, pos: u8) -> f32 {

        let offset = -self.physical_size / 2.0 + 0.5 * TILE_SIZE;

        offset
            + f32::from(pos) * TILE_SIZE
            + f32::from(pos + 1) * TILE_SPACER
    }
}

#[derive(Debug, PartialEq, Component)]
struct Points {
    value: u32,
}

#[derive(Debug, PartialEq, Copy, Clone, Eq, Hash, Component)]
struct Position {
    x: u8,
    y: u8,
}

#[derive(Component)]
struct TileText;

struct FontSpec {
    family: Handle<Font>,
}

impl FromWorld for FontSpec {
    fn from_world(world: &mut World) -> Self {

        let asset_server = world
            .get_resource_mut::<AssetServer>()
            .unwrap();

        FontSpec {
            family: asset_server
                .load("fonts/FiraSans-Bold.ttf"),
        }
    }
}

#[derive(Debug)]
enum BoardShift {
    Left,
    Right,
    Up,
    Down,
}

impl TryFrom<&KeyCode> for BoardShift {
    type Error = &'static str;

    fn try_from(
        value: &KeyCode
    ) -> Result<Self, Self::Error> {
        match value {
            KeyCode::Left => Ok(BoardShift::Left),
            KeyCode::Up => Ok(BoardShift::Up),
            KeyCode::Right => Ok(BoardShift::Right),
            KeyCode::Down => Ok(BoardShift::Down),
            _ => Err("not a valid board_shift key"),
        }
    }
}

impl BoardShift {
    fn sort(&self, a: &Position, b: &Position) -> Ordering {
        match Ord::cmp(&a.y, &b.y) {
            Ordering::Equal => Ord::cmp(&a.x, &b.x),
            ordering => ordering,
        }
    }

    fn set_column_position(
        &self,
        position: &mut Mut<Position>,
        index: u8,
    ) {
        position.x = index;
    }

    fn set_row_position(
        &self,
        position: &mut Mut<Position>,
    ) {
        position.y;
    }
}

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .init_resource::<FontSpec>()
        .add_startup_system(setup)
        .add_startup_system(spawn_board)
        .add_startup_system_to_stage(
            StartupStage::PostStartup,
            spawn_tyles
        )
        .add_system(render_tile_points)
        .add_system(board_shift)
        .run();
}

fn setup(mut commands: Commands) {
    commands
        .spawn_bundle(OrthographicCameraBundle::new_2d());
}

fn spawn_board(
    mut commands: Commands,
) {
    let board = Board::new(4);

    commands
        .spawn_bundle(SpriteBundle {
            sprite: Sprite {
                color: MATERIALS.board,
                custom_size: Some(Vec2::new(
                    board.physical_size, 
                    board.physical_size,
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
                            TILE_SIZE,
                        )),
                        ..Sprite::default()
                    },
                    transform: Transform::from_xyz(
                        board.cell_position_to_physical(tile.0),
                        board.cell_position_to_physical(tile.1),
                        1.0,
                    ),
                    ..Default::default()
                });
            }
        })
        .insert(board);
}

fn spawn_tyles(
    mut commands: Commands,
    query_board: Query<&Board>,
    font_spec: Res<FontSpec>,
) {
    let board = query_board.single();

    let mut rng = rand::thread_rng();

    let starting_tiles: Vec<(u8, u8)> = (0..board.size)
        .cartesian_product(0..board.size)
        .choose_multiple(&mut rng, 2);

    for (x, y) in starting_tiles.iter() {
        let pos = Position { x: *x, y: *y };
        commands
            .spawn_bundle(SpriteBundle {
                sprite: Sprite {
                    color: MATERIALS.tile,
                    custom_size: Some(Vec2::new(
                        TILE_SIZE, 
                        TILE_SIZE,
                    )),
                    ..Sprite::default()
                },
                transform: Transform::from_xyz(
                    board.cell_position_to_physical(pos.x),
                    board.cell_position_to_physical(pos.y),
                    1.0,
                ),
                ..Default::default()
            })
            .with_children(|child_builder| {
                    child_builder.spawn_bundle(Text2dBundle {
                        text: Text::with_section(
                            "2", 
                            TextStyle {
                                font: font_spec
                                    .family
                                    .clone(),
                                font_size: 40.0,
                                color: Color::BLACK,
                                ..Default::default()
                            },
                            TextAlignment {
                                vertical: VerticalAlign::Center,
                                horizontal: HorizontalAlign::Center,
                            }),
                        transform: Transform::from_xyz(0.0, 0.0, 1.0),
                        ..Default::default()
                    })
                    .insert(TileText);
            })
            .insert(Points { value: 2 })
            .insert(pos);
    }
}

fn render_tile_points(
    mut texts: Query<&mut Text, With<TileText>>,
    tiles: Query<(&Points, &Children)>,
) {
    for (points, children) in tiles.iter() {
        if let Some(entity) = children.first() {

            let mut text = texts
                .get_mut(*entity)
                .expect("expected Text to exist");

            let mut text_section = text.sections
                .first_mut()
                .expect("expect first section to be accessible as mutable");

            text_section.value = points.value.to_string();
        }
    }
}

fn board_shift(
    mut commands: Commands,
    keyboard_input: Res<Input<KeyCode>>,
    mut tiles: Query<(Entity, &mut Position, &mut Points)>,
) {
    let shift_direction =
        keyboard_input.get_just_pressed().find_map(
            |key_code| BoardShift::try_from(key_code).ok(),
        );

    match shift_direction {
        Some(BoardShift::Left) => {
            let mut it =
                tiles
                    .iter_mut()
                    .sorted_by(|a, b| {
                        match Ord::cmp(&a.1.y, &b.1.y) {
                            Ordering::Equal => {
                                Ord::cmp(&a.1.x, &b.1.x)
                            }
                            ordering => ordering,
                        }
                    })
                    .peekable();
                
                    let mut column: u8 = 0;

                    while let Some(mut tile) = it.next() {
                        tile.1.x = column;
                        match it.peek() {
                            None => {},
                            Some(tile_next) => {
                                if tile.1.y != tile_next.1.y {
                                    // different rows, don't merge
                                    column = 0;
                                } else if tile.2.value != tile_next.2.value {
                                    // different values, don't merge
                                    column = column + 1;
                                } else {
                                    // merge
                                    let real_next_tile = it
                                        .next()
                                        .expect("A peeked tile should always exist when we .next here");

                                    tile.2.value = tile.2.value + real_next_tile.2.value;

                                    commands
                                        .entity(real_next_tile.0)
                                        .despawn_recursive();

                                    if let Some(future) = it.peek() {
                                        if tile.1.y != future.1.y {
                                            column = 0;
                                        } else {
                                            column = column + 1;
                                        }
                                    }
                                }
                            }
                        }
                    }
        }
        Some(BoardShift::Right) => {
            dbg!("right");
        }
        Some(BoardShift::Up) => {
            dbg!("up");
        }
        Some(BoardShift::Down) => {
            dbg!("down");
        }
        None => (),
    }
}

fn render_tiles(
    mut tiles: Query<(
        &mut Transform,
        &Position,
        Changed<Position>,
    )>,
    query_board: Query<&Board>,
) {
    let board = query_board.single();

    for (mut transform, pos, pos_changed) in tiles.iter_mut() {
        if pos_changed {
            transform.translation.x = board.cell_position_to_physical(pos.x);
            transform.translation.y = board.cell_position_to_physical(pos.y);
        }
    }
}