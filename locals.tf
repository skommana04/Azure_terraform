locals {
  # 1. Gather your "Source of Truth" values from other modules/resources
  mongo_ip     = module.public_vms["db-inst"].public_ip
  redis_ip     = module.public_vms["db-inst"].public_ip
  mysql_ip     = module.public_vms["db-inst"].public_ip
  rabbitmq_ip  = module.public_vms["db-inst"].public_ip
  # Standardized URLs
  mongo_connection = "mongodb://${local.mongo_ip}:27017"
  redis_connection = "redis://${local.redis_ip}:6379"

  # 2. Construct the Environment Maps for each App
  # This merges the static tfvars with the dynamic values calculated above
  app_env_config = {
    "catalogmedha" = merge(var.web_apps["catalogmedha"].env_vars, {
      "MONGO_URL" = "${local.mongo_connection}/catalogue"
    })

    # "usermedha" = merge(var.web_apps["usermedha"].env_vars, {
    #   "MONGO_URL" = "${local.mongo_connection}/users"
    #   "REDIS_URL" = local.redis_connection
    # })

    # "cartmedha" = merge(var.web_apps["cartmedha"].env_vars, {
    #   "REDIS_HOST"     = local.redis_ip
    #   "CATALOGUE_HOST" = "robot-catalogmedha-medha.azurewebsites.net"
    #   "CATALOGUE_PORT" = "8080"
    # })

    # "shippingmedha" = merge(var.web_apps["shippingmedha"].env_vars, {
    #   "CART_ENDPOINT" = "robot-cartmedha-medha.azurewebsites.net:8080"
    #   "DB_HOST"       = local.mysql_ip
    # })

    # "paymentmedha" = merge(var.web_apps["paymentmedha"].env_vars, {
    #   "CART_HOST" = "robot-cartmedha-medha.azurewebsites.net"
    #   "USER_HOST" = "robot-usermedha-medha.azurewebsites.net"
    #   "AMQP_HOST" = local.rabbitmq_ip
    # })
  }
}