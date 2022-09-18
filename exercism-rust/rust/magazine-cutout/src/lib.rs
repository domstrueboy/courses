use std::collections::HashMap;

pub fn can_construct_note(magazine: &[&str], note: &[&str]) -> bool {

    let mut words: HashMap<&str, u8> = HashMap::new();
    const DEFAULT_NUM: u8 = 0;

    for word in magazine {
        let num = words.entry(word).or_insert(DEFAULT_NUM);
        *num += 1;
    }

    println!("{:?}", magazine);
    println!("{:?}", note);
    println!("{:?}", words);

    for word in note {
        let num = words.entry(word).or_default();
        println!("{}, {}", word, num);
        if *num == DEFAULT_NUM {
            return false;
        }
        *num -= 1;
    }

    return true;
}
