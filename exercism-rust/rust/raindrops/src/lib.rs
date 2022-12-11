pub fn raindrops(n: u32) -> String {
    let mut drops = vec![];
    let map = vec![(3, "Pling"), (5, "Plang"), (7, "Plong")];

    for (factor, drop) in map {
        if n % factor == 0 {
            drops.push(drop);
        }
    }

    if drops.len() == 0 {
        return n.to_string();
    }

    drops.join("")
}
