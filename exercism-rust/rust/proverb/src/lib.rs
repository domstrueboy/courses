pub fn build_proverb(list: &[&str]) -> String {
    if list.len() == 0 {
        return "".to_string();
    }
    let last_index = list.len() - 1;
    let mut lines = vec![];
    for i in 0..last_index {
        let line = format!("For want of a {} the {} was lost.", list[i], list[i+1]);
        lines.push(line);
    }
    let last_line = format!("And all for the want of a {}.", list[0]);
    lines.push(last_line);
    lines.join("\n")
}
