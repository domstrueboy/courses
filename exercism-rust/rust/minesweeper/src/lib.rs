pub fn annotate(minefield: &[&str]) -> Vec<String> {
    minefield.iter().enumerate().map(|(row_index, row)|
        row.chars().into_iter().enumerate().map(|(letter_index, letter)| {

            if letter == '*' { return '*'.to_string() }

            let mut number_of_mines = 0;

            let min_row_index = 0;
            let max_row_index = minefield.len() - 1;
            let row_start = if row_index == min_row_index { min_row_index } else { row_index - 1 };
            let row_finish = if row_index == max_row_index { max_row_index } else { row_index + 1 };

            let min_letter_index = 0;
            let max_letter_index = row.len() - 1;
            let letter_start = if letter_index == min_letter_index { min_letter_index } else { letter_index - 1 };
            let letter_finish = if letter_index == max_letter_index { max_letter_index } else { letter_index + 1 };

            for i in row_start..=row_finish {
                for j in letter_start..=letter_finish {

                    if i == row_index && j == letter_index { continue; }

                    let current_field = minefield[i].chars().nth(j).unwrap();
                    if current_field == '*' { number_of_mines += 1; }
                }
            }

            if number_of_mines == 0 { return ' '.to_string(); }

            return number_of_mines.to_string();
        }).collect()
    ).collect()
}
