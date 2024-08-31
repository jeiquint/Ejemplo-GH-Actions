#Instancia EC2
resource "aws_instance" "wordpress" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t3a.small"
  key_name                    = "prueba_terraform"
  subnet_id                   = aws_subnet.public1.id
  security_groups             = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = "false"
  
  tags = {
    Name = "EC2_La_Huerta"
  }

}

# Definición IP Elastica
resource "aws_eip" "eip" {
  domain = "vpc"
}

#Asociación IP elastica a EC2
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.wordpress.id
  allocation_id = aws_eip.eip.id
}

#rds subnet
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id, aws_subnet.private3.id]
}
#Instancia RDS
resource "aws_db_instance" "rds_instance"{

  engine                    = "mysql"
  engine_version            = "8.0.32"
  skip_final_snapshot       = true
  final_snapshot_identifier = "snapshotdb"
  instance_class            = "db.t3.small"
  allocated_storage         = 20
  identifier                = "lahuerta"
  db_name                   = "wordpress_db"
  username                  = "admin"
  password                  = "Colombia2024*"
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids    = [aws_security_group.rds_security_group.id]

  tags = {
    Name = "RDS Instancia"
  }
}
# Grupo de Seguridad RDS 
resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for RDS instance"
  vpc_id      = aws_vpc.vpc_proyecto.id
#Reglas de Entrada
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_ssh.id]
  }

  tags = {
    Name = "RDS Security Group"
  }
}