use crate::http::{Request, Response, StatusCode};
use std::convert::TryFrom;
use std::io::{Read, Write};
use std::net::TcpListener;

pub struct Server {
  addr: String,
}

impl Server {
  pub fn new(addr: String) -> Self {
    Self { addr }
  }

  pub fn run(self) {
    println!("Listening on {}", self.addr);

    let listener = TcpListener::bind(&self.addr).unwrap();

    loop {
      match listener.accept() {
        Ok((mut stream, _)) => {
          let mut buffer = [0; 1024];
          match stream.read(&mut buffer) {
            Ok(_) => {
              println!("Received a request: {}", String::from_utf8_lossy(&buffer));

              match Request::try_from(&buffer[..]) {
                Ok(request) => {
                  dbg!(request);
                  let response = Response::new(
                    StatusCode::Ok,
                    Some("<h1>It works!</h1>".to_string())
                  );
                  response.send(&mut stream);
                }
                Err(e) => println!("Failed to parse a request: {}", e),
              }
            }
            Err(e) => println!("Failed to read from stream: {}", e),
          }
        }
        Err(e) => print!("Failed to establish connection: {}", e),
      }
    }
  }
}
