pub fn reply(message: &str) -> &str {
    let trimmed_message = message.trim();
    let is_empty = trimmed_message.len() == 0;
    if is_empty {
        return "Fine. Be that way!";
    }

    let is_question = trimmed_message.ends_with('?');
    let mut alphabetic_chars = trimmed_message.chars().filter(|char| char.is_alphabetic());
    let is_shouting = alphabetic_chars.any(|char| char.is_uppercase())
                            && alphabetic_chars.all(|char| char.is_uppercase());
    if is_question && is_shouting {
        return "Calm down, I know what I'm doing!";
    } else if is_question {
        return "Sure.";
    } else if is_shouting {
        return "Whoa, chill out!";
    }
    "Whatever."
}