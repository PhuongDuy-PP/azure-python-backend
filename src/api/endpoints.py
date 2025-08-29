from fastapi import APIRouter
from typing import Dict

router = APIRouter()

@router.get("/")
def read_root() -> Dict[str, str]:
    return {"message": "Hello from Azure!"}

@router.get("/health")
def health_check() -> Dict[str, str]:
    return {"status": "healthy"}
