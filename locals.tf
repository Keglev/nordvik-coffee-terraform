locals {
  reviews_api_url = "${aws_apigatewayv2_stage.default.invoke_url}reviews"

  site_html = templatefile("${path.module}/website/index.html.tpl", {
    api_endpoint = local.reviews_api_url
  })
}
