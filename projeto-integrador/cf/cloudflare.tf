provider "cloudflare" {
  api_token = "mytoken"
}


data "cloudflare_zone" "turma3-elevenworks" {
  name = "turma3-elevenworks.com"
}

resource "cloudflare_record" "turma3-elevenworks" {
  zone_id    = data.cloudflare_zone.turma3-elevenworks.id
  name       = "www"
  value      = aws_eip.eip.public_ip
  type       = "A"
  proxied    = true
  depends_on = [aws_eip.eip]
}
resource "cloudflare_zone_settings_override" "turma3-elevenworks-settings" {
  zone_id = data.cloudflare_zone.turma3-elevenworks.id
  settings {
    tls_1_3                  = "on"
    automatic_https_rewrites = "on"
    ssl                      = "strict"
    waf                      = "on"
    depends_on               = [cloudflare_record.turma3-elevenworks]
  }
}
