const RADIX: u32 = 10;
const ISBN_LEN: usize = 10;

/// Determines whether the supplied string is a valid ISBN number
pub fn is_valid_isbn(isbn: &str) -> bool {

    let mut numbers = vec![];

    for (i, c) in isbn.chars().enumerate() {
        if c.is_digit(RADIX) {
            let digit = c.to_digit(RADIX).unwrap();
            numbers.push(digit);
        }
        if i == isbn.len() - 1 && c == 'X' {
            numbers.push(10);
        }
    }
    
    if numbers.len() != ISBN_LEN { return false; }

    let mut acc = 0;
    for factor in 1..=10 {
        acc += numbers[ISBN_LEN - factor] * factor as u32;
    }

    return acc % 11 == 0;
}
