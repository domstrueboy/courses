pub fn calculate_price(amount: u8) -> u8 {
    const FULL_PRICE: u8 = 2;
    const SALE_PRICE: u8 = 1;
    let price = if amount < 40 { FULL_PRICE } else { SALE_PRICE };
    amount * price
}
