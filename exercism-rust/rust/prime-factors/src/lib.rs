pub fn factors(n: u64) -> Vec<u64> {
    
    let mut number_to_divide = n;
    let mut current_factor = 2;
    let mut factors = Vec::new();

    while number_to_divide > 1 {
        if number_to_divide % current_factor == 0 {
            number_to_divide /= current_factor;
            factors.push(current_factor);
        } else {
            current_factor += 1;
        }
    }

    factors
}
