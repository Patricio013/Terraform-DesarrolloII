resource "aws_cloudwatch_log_group" "backend_prod"  { 
    name = "/ecs/arreglaya-backend-task"  
    retention_in_days = 14 
}
resource "aws_cloudwatch_log_group" "frontend_prod" { 
    name = "/ecs/arreglaya-frontend-task" 
    retention_in_days = 14 
}
resource "aws_cloudwatch_log_group" "backend_stg"   { 
    name = "/ecs/backend-stg"   
    retention_in_days = 14 
}
resource "aws_cloudwatch_log_group" "frontend_stg"  { 
    name = "/ecs/frontend-stg"  
    retention_in_days = 14 
}