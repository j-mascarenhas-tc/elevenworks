provider "cloudflare" {
  email = "you@example.com"
  token = "your-api-key"
}
variable "domain" {
  default = "turma3-elevenworks.com"
}
resource "cloudflare_record" "www" {
  domain     = var.domain
  name       = "www"
  value      = aws_eip.eip.public_ip
  type       = "A"
  proxied    = true
  depends_on = [aws_eip.eip]
}
resource "cloudflare_zone_settings_override" "turma3-elevenworks-settings" {
  name = var.domain
  settings {
    tls_1_3                  = "on"
    automatic_https_rewrites = "on"
    ssl                      = "strict"
    waf                      = "on"
  }
}
