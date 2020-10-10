use std::io;

fn main() {
    println!("Enter your weight (in kg):");

    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();

    let weight: f32 = input.trim().parse().unwrap();

    let weight_on_mars = calculate_weight_on_mars(weight);

    println!("Weight on Mars: {} kg", weight_on_mars);
}

fn calculate_weight_on_mars(weight: f32) -> f32 {
    (weight / 9.81) * 3.711
}