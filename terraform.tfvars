rg_name                         = "azuremedha"
location                        = "canada central"
sg_name                         = "medha-security-group"
network_name                    = "medha-network"
public_subnet_name              = "medha-public-subnet"
private_subnet_name             = "medha-private-subnet"
address_space                   = ["10.0.0.0/16"]
public_subnet_address_prefixes  = ["10.0.1.0/24"]
private_subnet_address_prefixes = ["10.0.2.0/24"]
network_rules = {
  "MONGODB"  = { port = 27017, priority = 100 }
  "SSH"      = { port = 22, priority = 110 }
  "MySQL"    = { port = 3306, priority = 120 }
  "REDIS"    = { port = 6379, priority = 130 }
  "RABBITMQ" = { port = 5672, priority = 140 }
}
private_subnet_nsg_name = "private-subnet-nsg"
vm_name = ["runner-inst", "db-inst"]
acr_name = "roboshopregistry"
web_apps = {
    "catalogmedha" = {
      image    = "catalogue:97"
      env_vars = { "MONGO" = true, "MONGO_URL" = "" }
      #MONGO_URL="mongodb://<MONGODB-SERVER-IPADDRESS>:27017/catalogue
    },
    "usermedha" = {
      image    = "user:101"
      env_vars = { "MONGO" = true, "REDIS_URL" = "", "MONGO_URL" = "" }
      #MONGO_URL="mongodb://<MONGODB-SERVER-IP-ADDRESS>:27017/users"
      #REDIS_URL='redis://<REDIS-IP-ADDRESS>:6379'
    },
    "cartmedha" = {
      image    = "cart:98"
      env_vars = { "REDIS_HOST" = "", "CATALOGUE_HOST" = "", "CATALOGUE_PORT"= "" }
      #CATALOGUE_HOST=<CATALOGUE-SERVER-IP>
      #CATALOGUE_PORT=8080
    },
     "shippingmedha" = {
      image    = "shipping:102"
      env_vars = { "CART_ENDPOINT" = "", "DB_HOST" = "" }
      #Environment=CART_ENDPOINT=<CART-SERVER-IPADDRESS>:8080
      #Environment=DB_HOST=<MYSQL-SERVER-IPADDRESS>      
    },
    "paymentmedha" = {
      image    = "payment:103"
      env_vars = { "CART_HOST" = "", "CART_PORT" = "", "USER_HOST" = "", "USER_PORT" = "", "AMQP_HOST" = "", "AMQP_USER" = "", "AMQP_PASS" = "" }  
    },
    "frontendmedha" = {
      image    = "frontend"
      #env_vars = { "CART_HOST" = "", "CART_PORT" = "", "USER_HOST" = "", "USER_PORT" = "", "AMQP_HOST" = "", "AMQP_USER" = "", "AMQP_PASS" = "" }  
    }

  }
