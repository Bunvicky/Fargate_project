#module "ecs_cluster" {
# source      = "./ecs_cluster"
# name        = var.name
# environment = var.environment
#}
#resource "aws_ecs_cluster" "ecs_cluster" {
# name = "${var.name}-cluster-${var.environment}"
#}

#module "ecs_task_definition" {
# source                = "./ecs_task_definition"
# name                  = var.name
# environment           = var.environment
# container_image       = var.container_image
# container_environment = var.container_environment
#container_port        = var.container_port
#}

#module "ecs_service" {
# source                      = "./ecs_service"
# name                        = var.name
# environment                 = var.environment
#ecs_cluster_id              = module.ecs_cluster.cluster_id
#ecs_task_definition_arn     = module.ecs_task_definition.task_definition_arn
#ecs_service_security_groups = var.ecs_service_security_groups
#subnets                     = var.subnets
#aws_alb_target_group_arn    = var.aws_alb_target_group_arn
# container_port              = var.container_port
#}
