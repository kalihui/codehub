extern crate curl;

use curl::http;

fn main(){
    let resp = http::handle()
        .post("http://172.22.44.55:8088/insert", "computer_ip=123&username=ukaihui&cmd=testhttp")
        .exec().unwrap();

    println!("code={}; headers={}; body={}",
             resp.get_code(), resp.get_headers(), resp.get_body());

}