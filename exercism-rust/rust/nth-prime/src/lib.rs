pub fn nth(n: u32) -> u32 {
    let mut prime_counter: i32 = -1;
    for number in 2..u32::MAX {
        if check_prime(number) {
            prime_counter += 1;
        }
        if prime_counter == n as i32 {
            return number;
        }
    }
    0
}

fn check_prime(number: u32) -> bool {
    for i in 2..number {
        if number % i == 0 {
            return false;
        }
    }
    true
}
