# Hướng Dẫn Triển Khai Infrastructure với Terraform

## Chuẩn Bị

### 1. Yêu Cầu Công Cụ
- Azure CLI
- Terraform
- Tài khoản Azure với subscription hợp lệ

### 2. Đăng Nhập Azure
```bash
# Đăng nhập vào Azure CLI
az login
```

## Thiết Lập Terraform Backend

### 1. Tạo Resource Group cho Terraform State
```bash
# Tạo resource group để lưu trữ terraform state
az group create --name terraform-state-rg --location eastasia
```

### 2. Tạo Storage Account
```bash
# Tạo storage account với tên duy nhất
az storage account create \
  --name tfstatec5cded22 \
  --resource-group terraform-state-rg \
  --location eastasia \
  --sku Standard_LRS
```

### 3. Tạo Container
```bash
# Tạo container trong storage account để lưu terraform state
az storage container create \
  --name tfstate \
  --account-name tfstatec5cded22
```

## Cấu Trúc Terraform

```
infrastructure/terraform/
├── modules/
│   └── app_service/
│       ├── main.tf          # Định nghĩa App Service Plan và Web App
│       ├── variables.tf     # Input variables cho module
│       └── outputs.tf       # Output values từ module
└── environments/
    └── dev/
        ├── main.tf          # Cấu hình chính cho môi trường dev
        ├── variables.tf     # Biến cho môi trường dev
        └── outputs.tf       # Outputs cho môi trường dev
```

## Triển Khai Infrastructure

### 1. Khởi Tạo Terraform
```bash
# Di chuyển vào thư mục môi trường dev
cd infrastructure/terraform/environments/dev

# Khởi tạo Terraform
terraform init
```

### 2. Kiểm Tra Plan
```bash
# Xem trước các thay đổi sẽ được áp dụng
terraform plan
```

### 3. Áp Dụng Cấu Hình
```bash
# Triển khai infrastructure
terraform apply -auto-approve
```

## Tài Nguyên Được Tạo

### 1. Resource Group cho Ứng Dụng (`python-backend-dev-rg`)
- Chứa tất cả tài nguyên của ứng dụng
- Tags: Environment, Project, Terraform

### 2. App Service Plan
- Tên: `python-backend-dev-plan`
- SKU: B1 (Basic)
- OS: Linux
- Tags: Environment, Project, Terraform

### 3. Web App
- Tên: `python-backend-dev-app`
- Runtime: Python 3.9
- Cấu hình:
  - Always On: true
  - Startup Command: `python -m uvicorn main:app --host 0.0.0.0`
- Environment Variables:
  - WEBSITE_PORT: 8000
  - PYTHONPATH: /home/site/wwwroot
  - SCM_DO_BUILD_DURING_DEPLOYMENT: true

## Kiểm Tra Triển Khai

### 1. Kiểm Tra Web App
```bash
# Liệt kê thông tin web app
az webapp list --resource-group python-backend-dev-rg
```

### 2. Truy Cập Ứng Dụng
- API Endpoint: https://python-backend-dev-app.azurewebsites.net/api/v1/
- Health Check: https://python-backend-dev-app.azurewebsites.net/api/v1/health
- API Documentation: https://python-backend-dev-app.azurewebsites.net/api/v1/docs

## Dọn Dẹp (Nếu Cần)

```bash
# Xóa tất cả tài nguyên
terraform destroy -auto-approve
```

## Lưu Ý
- Tất cả tài nguyên được gắn tags để dễ dàng quản lý và theo dõi chi phí
- Terraform state được lưu trữ an toàn trong Azure Storage
- Sử dụng module để tái sử dụng code và dễ dàng mở rộng
- Môi trường được tách biệt để dễ quản lý (dev, prod)
