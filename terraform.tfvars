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
vm_name = [runner, db]