resource "aws_cloudwatch_dashboard" "order_metrics_ci" {
  dashboard_name = "Order-Service-Metrics-1"

  dashboard_body = jsonencode(
    {
      "widgets" : [
        {
          "height" : 6,
          "width" : 6,
          "y" : 0,
          "x" : 0,
          "type" : "metric",
          "properties" : {
            "metrics" : [
              [{ "expression" : "SELECT COUNT(watch_orders_total) FROM \"ContainerInsights/Prometheus\" WHERE productId != '*' GROUP BY productId", "id" : "q1", "region" : data.aws_region.current.name }]
            ],
            "view" : "pie",
            "region" : var.region,
            "title" : "Orders by ProductId",
            "period" : 300,
            "stat" : "Average"
          }
        },
        {
          "height" : 6,
          "width" : 6,
          "y" : 0,
          "x" : 6,
          "type" : "metric",
          "properties" : {
            "sparkline" : true,
            "view" : "singleValue",
            "metrics" : [
              [{ "expression" : "SELECT SUM(watch_orders_total) FROM \"ContainerInsights/Prometheus\" WHERE productId = '*'", "label" : "Total", "id" : "q1" }]
            ],
            "region" : data.aws_region.current.name,
            "stat" : "Average",
            "period" : 300,
            "title" : "Order Count"
          }
        }
      ]
  })
}