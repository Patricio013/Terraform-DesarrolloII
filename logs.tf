resource "aws_cloudwatch_log_group" "backend_prod"  { 
    name = "/ecs/arreglaya-prod-backend"  
    retention_in_days = 14 
}
resource "aws_cloudwatch_log_group" "frontend_prod" { 
    name = "/ecs/arreglaya-prod-frontend" 
    retention_in_days = 14 
}
resource "aws_cloudwatch_log_group" "backend_stg"   { 
    name = "/ecs/arreglaya-stg-backend"   
    retention_in_days = 14 
}
resource "aws_cloudwatch_log_group" "frontend_stg"  { 
    name = "/ecs/arreglaya-stg-frontend"  
    retention_in_days = 14 
}