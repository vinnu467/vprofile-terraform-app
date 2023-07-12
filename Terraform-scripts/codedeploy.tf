resource "aws_codedeploy_app" "vprofile_app" {
  name    = "vprofile-_new-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "prod_deployment_group" {
  app_name            = aws_codedeploy_app.vprofile_app.name
  deployment_config_name = "CodeDeployDefault.OneAtATime"
  deployment_group_name = "prod-deployment-group"
  service_role_arn    = aws_iam_role.vprofile-app-role.arn
  deployment_style {
    deployment_type = "IN_PLACE"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }
  ec2_tag_filter {
    key = "tag:Environment"
    value = "Production"
    type = "KEY_AND_VALUE"
  }
  
  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.production_tg.name
    }
  }
}
