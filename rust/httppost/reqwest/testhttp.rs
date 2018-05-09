extern crate futures;
extern crate hyper;
extern crate tokio_core;
use std::io::{self, Write};
use futures::{Future, Stream};
use hyper::Client;
use tokio_core::reactor::Core;
use hyper::{Method, Request};
use hyper::header::{ContentLength, ContentType};
use std;

fn main(){
let mut core = Core::new().unwrap();
let client = Client::new(&core.handle());
//let mut username=' '  ;
//let mut computer_ip= ' ';
//let mut cmd=' ';
let json = r#"{"computer_ip":"127.0.0.1","username":"ukaihui","cmd":"testhttp"}"#;
let uri = "http://172.22.44.55:8088/insert".parse().unwrap();
let mut req = Request::new(Method::Post, uri);
req.headers_mut().set(ContentType::json());
req.headers_mut().set(ContentLength(json.len() as u64));
req.set_body(json);

let post = client.request(req).and_then(|res| {
    println!("POST: {}", res.status());

    res.body().concat2()
});
    core.run(request).unwrap();

}

