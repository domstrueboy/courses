use std::str::Utf8Error;
use super::method::Method;
use std::convert::TryFrom;
use std::error::Error;
use std::fmt::{ Display, Formatter, Result as FmtResult, Debug };
use std::str;

pub struct Request {
  method: Method, 
  path: String,
  query: Option<String>,
}

impl TryFrom<&[u8]> for Request {
  type Error = ParseError;

  // GET /search?name=abc&sort=1 HTTP/1.1
  fn try_from(buf: &[u8]) -> Result<Self, Self::Error> {
    let request = str::from_utf8(buf)?;

    unimplemented!();
  }
}

pub enum ParseError {
  InvalidRequest,
  InvalidEncoding,
  InvalidProtocol,
  InvalidMethod,
}

impl ParseError {
  fn message(&self) -> &str {
    match self {
      Self::InvalidRequest => "Invalid request",
      Self::InvalidEncoding => "Invalid encoding",
      Self::InvalidProtocol => "Invalid protocol",
      Self::InvalidMethod => "Invalid method",
    }
  }
}

impl From<Utf8Error> for ParseError {
  fn from(_: Utf8Error) -> Self {
    Self::InvalidEncoding
  }
}

impl Display for ParseError {
  fn fmt(&self, f: &mut Formatter) -> FmtResult {
    write!(f, "{}", self.message())
  }
}

impl Debug for ParseError {
  fn fmt(&self, f: &mut Formatter) -> FmtResult {
    write!(f, "{}", self.message())
  }
}

impl Error for ParseError {

}