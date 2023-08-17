#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit(char),
}

const RADIX: u32 = 10;

pub fn lsp(string_digits: &str, span: usize) -> Result<u64, Error> {
    let mut max = 0;
    if span == 0 {
        return Ok(1);
    }
    if span > string_digits.len() {
        return Err(Error::SpanTooLong);
    }
    for cur in 0..=string_digits.len() - span {
        let chars = string_digits[cur..cur + span].chars();

        println!("{:?}", chars);

        let not_digit_char = chars.clone().find(
            |ch|
            !ch.is_digit(RADIX)
        );

        if not_digit_char.is_some() { return Err(Error::InvalidDigit(not_digit_char.unwrap())); }

        let numbers = chars.map(|ch| ch.to_digit(RADIX)).map(|d| d.unwrap());

        let value = numbers.reduce(|accumulator, digit| accumulator * digit).unwrap();

        if value > max {
            max = value;
        }
    }
    Ok(max as u64)
}
