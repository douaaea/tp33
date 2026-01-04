# Script de nettoyage pour le lab Kubernetes
# Exécuter avec : .\cleanup.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Lab Kubernetes - Nettoyage" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "🧹 Suppression du service..." -ForegroundColor Yellow
kubectl delete -f k8s-service.yaml 2>$null
Write-Host "✅ Service supprimé" -ForegroundColor Green
Write-Host ""

Write-Host "🧹 Suppression du deployment..." -ForegroundColor Yellow
kubectl delete -f k8s-deployment.yaml 2>$null
Write-Host "✅ Deployment supprimé" -ForegroundColor Green
Write-Host ""

Write-Host "🧹 Suppression de la ConfigMap..." -ForegroundColor Yellow
kubectl delete -f k8s-configmap.yaml 2>$null
Write-Host "✅ ConfigMap supprimée" -ForegroundColor Green
Write-Host ""

Write-Host "🧹 Suppression du namespace..." -ForegroundColor Yellow
kubectl delete namespace lab-k8s 2>$null
Write-Host "✅ Namespace supprimé" -ForegroundColor Green
Write-Host ""

Write-Host "🛑 Arrêt de Minikube..." -ForegroundColor Yellow
minikube stop
Write-Host "✅ Minikube arrêté" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Nettoyage terminé !" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
