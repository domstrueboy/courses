use std::collections::HashSet;

fn get_sorted_string(str: &str) -> String {
    let mut chars: Vec<char> = str.chars().collect();
    chars.sort_unstable_by(|a, b| b.cmp(a));
    String::from_iter(chars)
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let mut anagrams = HashSet::new();

    let a = get_sorted_string(&word.to_lowercase());

    for possible_anagram in possible_anagrams {

        if possible_anagram.len() != word.len() {
            continue;
        }

        if possible_anagram.to_lowercase().eq(&word.to_lowercase()) {
            continue;
        }

        let b = get_sorted_string(&possible_anagram.to_lowercase());

        if a.eq(&b) {
            anagrams.insert(possible_anagram.to_owned());
        }
    }

    anagrams
}
