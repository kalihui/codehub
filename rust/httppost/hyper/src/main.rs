//https://stackoverflow.com/questions/26336281/read-json-in-rust
//http://wiki.jikexueyuan.com/project/rust-primer/action/json_data/readme.html
//https://stackoverflow.com/questions/26336281/read-json-in-rust
//https://www.cnblogs.com/mignet/p/Rust_HayStack.html
extern crate rustc_serialize;
extern crate futures;
extern crate hyper;
extern crate tokio_core;
use std::ptr;
use std::io::{self, Write};
use std::process::Command;
use futures::{Future, Stream};
use hyper::Client;
use tokio_core::reactor::Core;
use hyper::{Method, Request};
use hyper::header::{ContentLength, ContentType};
use rustc_serialize::json;
use rustc_serialize::{Decoder, Decodable};

pub struct Point{
    item : String,
    value : String,
}

fn main(){
    let a_0 = String::from("hello world");
    let a   = a_0.as_str();


    let mut core = Core::new().unwrap();
    let client = Client::new(&core.handle());


    let theusername = Command::new("whoami")
    .output()
    .expect("sh command failed to start")
    .stdout;
    let username = String::from_utf8_lossy(&theusername).to_string();

//    let thecomputer_ip=Command::new("curl")
//        .arg("http://members.3322.org/dyndns/getip")
//        .output()
//        .expect("ls command failed to start")
//        .stdout;

    let thecomputer_ip=Command::new("ifconfig")
        .output()
        .expect("ls command failed to start")
        .stdout;

    let computer_ip = String::from_utf8_lossy(&thecomputer_ip).to_string();

//    let mut jsonstruct:Vec<Point>;
    let mut s1 = String::from("{");
    let s2 = ":";
    let s3 = ",";
    let s4 = "}";

    let json = s1.clone() + "computer_ip" + s2 + computer_ip.as_str() + s3 + "username" + s2 + username.as_str()+ s3 + "cmd" + s2 + "testhttp" + s4;


//let json =r#"{"computer_ip":"123.123.123.123","username":"ukaihui","cmd":"testhttp"}"#;

//    let json: Vec<Point> = json::decode(&s1).unwrap();
let url = "http://172.22.44.55:8088/insert".parse().unwrap();
let mut req = Request::new(Method::Post, url);
req.headers_mut().set(ContentType::json());
//req.headers_mut().set(ContentLength(json.len() as u64));
req.set_body(json.clone());

let post = client.request(req).and_then(|res| {


    println!("POST: {}", res.status());
    println!("{}\n{}\n{}\n",computer_ip,username,json);

    res.body().concat2()
});
    println!("{}\n{}\n{}\n",computer_ip,username,json);
    core.run(post).unwrap();
}

