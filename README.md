# Python Backend with Azure Deployment

Một ứng dụng Python backend sử dụng FastAPI, được triển khai lên Azure sử dụng Terraform.

## Cấu trúc Dự Án
```
.
├── src/                            # Mã nguồn backend
│   ├── api/                        # API endpoints
│   ├── core/                       # Core configuration
│   ├── models/                     # Database models
│   ├── schemas/                    # Pydantic schemas
│   ├── services/                   # Business logic
│   └── utils/                      # Utility functions
│
├── infrastructure/                 # Infrastructure as Code
│   └── terraform/
│       ├── modules/                # Terraform modules
│       │   ├── app_service/       # App Service module
│       │   └── database/          # Database module (future use)
│       └── environments/          # Environment-specific configurations
│           ├── dev/              # Development environment
│           └── prod/             # Production environment
│
│   └── requirements.txt           # Python dependencies
└── README.md                      # Documentation
```

## Phát Triển Cục Bộ

1. Tạo môi trường ảo:
```bash
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
```

2. Cài đặt dependencies:
```bash
pip install -r src/requirements.txt
```

3. Chạy ứng dụng:
```bash
python src/main.py
```

Ứng dụng sẽ chạy tại http://localhost:8000

## Triển Khai lên Azure

### Yêu Cầu

1. Cài đặt [Terraform](https://www.terraform.io/downloads.html)
2. Cài đặt [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
3. Đăng nhập vào Azure:
```bash
az login
```

### Các Bước Triển Khai

1. Di chuyển vào thư mục môi trường phù hợp:
```bash
cd infrastructure/terraform/environments/dev  # hoặc prod
```

2. Khởi tạo Terraform:
```bash
terraform init
```

3. Xem trước các thay đổi:
```bash
terraform plan
```

4. Áp dụng cấu hình:
```bash
terraform apply
```

### Tùy Chỉnh Triển Khai

Bạn có thể tùy chỉnh triển khai bằng cách:
1. Sửa đổi các biến trong `variables.tf`
2. Cung cấp giá trị khi chạy lệnh:
```bash
terraform apply -var="project_name=my-app" -var="location=westus2"
```

### Dọn Dẹp

Để xóa tất cả tài nguyên:
```bash
terraform destroy
```

## API Endpoints

- `GET /api/v1/`: Trả về thông điệp chào mừng
- `GET /api/v1/health`: Trả về trạng thái của ứng dụng

## Lưu ý

- Ứng dụng được triển khai sử dụng Azure App Service với tier Basic (B1)
- Sử dụng App Service dựa trên Linux
- Python 3.9 được sử dụng cho runtime
- Ứng dụng chạy trên cổng 8000 theo cấu hình App Service