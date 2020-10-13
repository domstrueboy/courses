use super::method::Method;

pub struct Request {
  method: Method,
  path: String,
  query: Option<String>,
}
