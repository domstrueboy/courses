fn main() {
    let api_token = std::env::var("API_TOKEN") // 6ac32f203f2d1a6d06440aa5c659380930d97a4b
        .expect("expected there to be an api token");
    dbg!(api_token);
}
