const RADIX: u32 = 10;

/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {

    let mut sum: u32 = 0;
    let mut index: u32 = 0;

    for ch in code.chars().rev() {

        if ch == ' ' { continue; }
        
        if !ch.is_digit(RADIX) { return false; }

        let number = ch.to_digit(RADIX).unwrap();

        if index % 2 == 0 {
            sum += number
        } else if number * 2 > 9 {
            sum += number * 2 - 9;
        } else {
            sum += number * 2;
        }

        index += 1;
    }

    if index < 2 { return false; }

    sum % 10 == 0
}
