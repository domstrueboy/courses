fn get_bottles(n: u32, capitalize: bool) -> String {

    if n > 1 {
        return format!("{} bottles", n);
    }

    if n > 0 {
        return format!("{} bottle", n);
    }

    if capitalize {
        return "No more bottles".to_string();
    }

    "no more bottles".to_string()
}

pub fn verse(n: u32) -> String {

    let first_line = format!("{} of beer on the wall, {} of beer.\n", get_bottles(n, true), get_bottles(n, false));
    
    let second_line = if n > 0 {
        format!("Take {} down and pass it around, {} of beer on the wall.\n", if n == 1 { "it" } else { "one" }, get_bottles(n - 1, false))
    } else {
        "Go to the store and buy some more, 99 bottles of beer on the wall.\n".to_string()
    };

    first_line + &second_line
}

pub fn sing(start: u32, end: u32) -> String {

    let mut song = String::from("");

    for i in (end..start + 1).rev() {
        song += &verse(i);
        if i == end { continue; }
        song += "\n";
    }

    song
}
