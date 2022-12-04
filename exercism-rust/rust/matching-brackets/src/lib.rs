pub fn brackets_are_balanced(string: &str) -> bool {

    let mut buffer = vec![' '; 1];

    const BRACKET_PAIRS: [(char, char); 3] = [
        ('[', ']'),
        ('{', '}'),
        ('(', ')'),
    ];

    let open_brackets: [char; 3] = BRACKET_PAIRS.map(|pair| pair.0);

    for c in string.chars() {
        if open_brackets.iter().any(|&bracket| bracket == c ) {
            buffer.push(c);
            continue;
        }
        for (open_bracket, close_bracket) in BRACKET_PAIRS {
            if c == close_bracket {
                let last_index = buffer.len() - 1;
                if buffer[last_index] == open_bracket {
                    buffer.pop();
                } else {
                    return false;
                }
            }
        }
    }

    buffer.len() == 1
}
