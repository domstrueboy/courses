use std::fmt;

fn get_hours(hours: i32, minutes: i32) -> i32 {
    let mut new_hours = if hours < 0 { 24 + hours % 24 } else { hours % 24 };
    new_hours = new_hours + if minutes < 0 { (minutes - 60 + 1) / 60 } else { minutes / 60 };
    if new_hours < 0 { (24 + new_hours % 24) % 24 } else { new_hours % 24 }
}

fn get_minutes(minutes: i32) -> i32 {
    if minutes < 0 { (60 + minutes % 60) % 60 } else { minutes % 60 }
}

#[derive(PartialEq)]
pub struct Clock {
    hours: i32,
    minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        Clock{
            hours: get_hours(hours, minutes),
            minutes: get_minutes(minutes),
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Clock {
            hours: get_hours(self.hours, self.minutes + minutes),
            minutes: get_minutes(self.minutes + minutes),
        }
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{:02}:{:02}", self.hours, self.minutes)
    }
}

impl fmt::Debug for Clock {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.to_string())
    }
}