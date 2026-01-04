# Script de déploiement automatisé pour le lab Kubernetes
# Exécuter avec : .\deploy.ps1

# Ajouter Minikube au PATH
$env:Path = "C:\Program Files\Kubernetes\Minikube;" + $env:Path

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Lab Kubernetes - Spring Boot Deploy  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. Build Maven
Write-Host "[1/8] Construction du JAR avec Maven..." -ForegroundColor Yellow
mvn clean package -DskipTests
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erreur Maven" -ForegroundColor Red
    exit 1
}
Write-Host "✅ JAR OK" -ForegroundColor Green
Write-Host ""

# 2. Minikube
Write-Host "[2/8] Démarrage de Minikube (Cela peut prendre du temps)..." -ForegroundColor Yellow
minikube start --driver=docker
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️ Minikube semble déjà démarré ou a signalé une erreur. On continue..." -ForegroundColor Yellow
}
Write-Host "✅ Minikube OK" -ForegroundColor Green
Write-Host ""

# 3. Docker Env
Write-Host "[3/8] Config Docker Env..." -ForegroundColor Yellow
minikube docker-env | Invoke-Expression
Write-Host "✅ Docker Env OK" -ForegroundColor Green
Write-Host ""

# 4. Build Image
Write-Host "[4/8] Build Image Docker..." -ForegroundColor Yellow
docker build -t demo-k8s:1.0.0 .
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erreur Docker Build" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Image OK" -ForegroundColor Green
Write-Host ""

# 5. Namespace
Write-Host "[5/8] Creating Namespace..." -ForegroundColor Yellow
kubectl create namespace lab-k8s
Write-Host "✅ Namespace OK (Create or Exists)" -ForegroundColor Green
Write-Host ""

# 6. ConfigMap
Write-Host "[6/8] Deploy ConfigMap..." -ForegroundColor Yellow
kubectl apply -f k8s-configmap.yaml
Write-Host "✅ ConfigMap OK" -ForegroundColor Green
Write-Host ""

# 7. Deployment
Write-Host "[7/8] Deploy App..." -ForegroundColor Yellow
kubectl apply -f k8s-deployment.yaml
Write-Host "✅ App Deployment OK" -ForegroundColor Green
Write-Host ""

# 8. Service
Write-Host "[8/8] Deploy Service..." -ForegroundColor Yellow
kubectl apply -f k8s-service.yaml
Write-Host "✅ Service OK" -ForegroundColor Green
Write-Host ""

# Wait
Write-Host "⏳ Attente des pods (120s max)..." -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l app=demo-k8s -n lab-k8s --timeout=120s
Write-Host ""

# Status
Write-Host "📦 Pods :"
kubectl get pods -n lab-k8s
Write-Host "🌐 Service :"
kubectl get svc -n lab-k8s

# Test
$IP = minikube ip
$URL = "http://$IP" + ":30080/api/hello"
Write-Host ""
Write-Host "🔗 TEST API : $URL" -ForegroundColor Green
Write-Host ""
curl $URL
