pub fn is_armstrong_number(num: u32) -> bool {

    let digits: Vec<u32> = num
        .to_string()
        .chars()
        .map(|d| d.to_digit(10).unwrap())
        .collect();

    let exp = digits.len() as u32;

    let mut result = 0;

    for d in digits {
        result += d.pow(exp);
    }

    result == num
}
