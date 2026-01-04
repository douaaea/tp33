# Script pour ouvrir des fenêtres de screenshots
# Chaque commande s'ouvre dans une nouvelle fenêtre PowerShell

$MinikubePath = "C:\Program Files\Kubernetes\Minikube"
$EnvPathCmd = "`$env:Path = '$MinikubePath;' + `$env:Path;"

Write-Host "Ouverture des fenêtres pour les screenshots..." -ForegroundColor Cyan

# 1. Image Docker
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& {$EnvPathCmd Write-Host '=== SCREENSHOT: IMAGE DOCKER ===' -ForegroundColor Cyan; minikube docker-env | Invoke-Expression; docker images | Select-String 'demo-k8s'; Write-Host ''}"

# 2. Namespace
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& {$EnvPathCmd Write-Host '=== SCREENSHOT: NAMESPACE ===' -ForegroundColor Cyan; kubectl get namespaces; Write-Host ''}"

# 3. ConfigMap
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& {$EnvPathCmd Write-Host '=== SCREENSHOT: CONFIGMAP ===' -ForegroundColor Cyan; kubectl describe configmap demo-k8s-config -n lab-k8s; Write-Host ''}"

# 4. Pods (CRITIQUE)
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& {$EnvPathCmd Write-Host '=== SCREENSHOT: PODS (CRITIQUE) ===' -ForegroundColor Cyan; kubectl get pods -n lab-k8s; Write-Host ''}"

# 5. Deployment Details
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& {$EnvPathCmd Write-Host '=== SCREENSHOT: DEPLOYMENT DETAILS ===' -ForegroundColor Cyan; kubectl describe deployment demo-k8s-deployment -n lab-k8s; Write-Host ''}"

# 6. Service (CRITIQUE)
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& {$EnvPathCmd Write-Host '=== SCREENSHOT: SERVICE (CRITIQUE) ===' -ForegroundColor Cyan; kubectl get svc -n lab-k8s; Write-Host ''}"

# 7. API Test (CRITIQUE)
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& {$EnvPathCmd Write-Host '=== SCREENSHOT: TEST API (CRITIQUE) ===' -ForegroundColor Cyan; `$ip = minikube ip; Write-Host 'IP Minikube : ' `$ip; curl \"http://`$(`$ip):30080/api/hello\"; Write-Host ''}"

# 8. Logs
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& {$EnvPathCmd Write-Host '=== SCREENSHOT: LOGS ===' -ForegroundColor Cyan; `$pod = kubectl get pods -n lab-k8s -o jsonpath='{.items[0].metadata.name}'; Write-Host 'Pod : ' `$pod; kubectl logs `$pod -n lab-k8s; Write-Host ''}"

# 9. Health Check
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& {$EnvPathCmd Write-Host '=== SCREENSHOT: HEALTH CHECK ===' -ForegroundColor Cyan; `$ip = minikube ip; curl \"http://`$(`$ip):30080/actuator/health\"; Write-Host ''}"

# 10. Vue d'ensemble
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& {$EnvPathCmd Write-Host '=== SCREENSHOT: VUE D ENSEMBLE ===' -ForegroundColor Cyan; kubectl get all -n lab-k8s; Write-Host ''}"
