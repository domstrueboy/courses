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
        let mut digits = chars.map(|c| c.to_digit(RADIX));

        if digits.all(|d| d.is_some()) {
            
        } else {
            return Err(Error::InvalidDigit('a'));
        }

        let numbers = digits.map(|n| n.unwrap());

        let value = numbers.reduce(|accumulator, digit| accumulator * digit).unwrap();
        if value > max {
            max = value;
        }
    }
    Ok(max as u64)
}
