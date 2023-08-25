#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    let first_len = _first_list.len();
    let second_len = _second_list.len();

    fn lists_equal<T1: PartialEq>(list_a: &[T1], list_b: &[T1]) -> bool {
        return list_a.iter().zip(list_b.iter()).all(|(a, b)| a == b);
    }

    if first_len == second_len && lists_equal(_first_list, _second_list) {
        return Comparison::Equal;
    } else if first_len > second_len {
        for i in 0..=(first_len - second_len) {
            if lists_equal(&_first_list[i..(i + second_len)], _second_list){
                return Comparison::Superlist;
            }
        }
    } else if first_len < second_len {
        for i in 0..=(second_len - first_len) {
            if lists_equal(&_second_list[i..(i + first_len)], _first_list) {
                return Comparison::Sublist;
            }
        }
    } 
    return Comparison::Unequal;
}
