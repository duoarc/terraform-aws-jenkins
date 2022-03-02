terraform {
  backend "consul" {
    address = "host.docker.internal:8500"
    # address = "127.0.0.1:8500"
    scheme  = "http"
  }
}