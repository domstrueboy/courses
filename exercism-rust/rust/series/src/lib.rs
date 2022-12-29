pub fn series(digits: &str, len: usize) -> Vec<String> {
    let mut values = vec![];
    if len > digits.len() {
        return values;
    }
    for cur in 0..=digits.len() - len {
        let slice = digits[cur..cur + len].to_string();
        values.push(slice);
    }
    values
}
