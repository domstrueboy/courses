#[derive(Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value(i32),
}

pub fn evaluate(inputs: &[CalculatorInput]) -> Option<i32> {

    let mut stack: Vec<i32> = vec![];

    for element in inputs {

        if let CalculatorInput::Value(val) = element {

            stack.push(*val);

        } else {

            let last = stack.pop();
            let first = stack.pop();

            if first.is_none() || last.is_none() {
                return None;
            }

            let a = first.unwrap();
            let b = last.unwrap();

            match element {
                CalculatorInput::Add => {
                    stack.push(a + b);
                },
                CalculatorInput::Subtract => {
                    stack.push(a - b);
                },
                CalculatorInput::Multiply => {
                    stack.push(a * b);
                },
                CalculatorInput::Divide => {
                    stack.push(a / b);
                },
                CalculatorInput::Value(_val) => {
                    
                }
            }
        }
    }

    if stack.len() == 1 {
        return Some(stack[0]);
    }

    None
}
