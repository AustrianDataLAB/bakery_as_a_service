use actix_web::{get, App, HttpResponse, HttpServer, Responder};
use indoc::formatdoc;
use rand::prelude::*;

#[get("/")]
async fn index() -> impl Responder {
    HttpResponse::Ok().body("ok")
}

#[get("/metrics")]
async fn metrics() -> impl Responder {
    let mut rng = rand::thread_rng();

    let content = formatdoc! {"
        http_requests_total {total}
        http_request_duration_seconds_sum {duration}
        orders {orders}
        revenue {revenue}
    ", 
    total = rng.gen_range(0..100),
    duration = rng.gen_range(0..100),
    orders = rng.gen_range(0..1000),
    revenue = rng.gen_range(0..10000)
    };

    HttpResponse::Ok().body(content)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().service(index).service(metrics))
        .bind(("0.0.0.0", 8080))?
        .run()
        .await
}
