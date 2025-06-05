# HealthcareML GitHub Pages Setup Script
# Current Date and Time: 2025-06-05 13:43:26
# Author: asarekings

$ErrorActionPreference = "Stop"
$repoName = "HealthcareML-"
$projectDir = "$PSScriptRoot"
# Note: Including tokens directly in scripts is a security risk
$token = "TOKEN_PLACEHOLDER" # Replace this with your actual token when running

Write-Host "HealthcareML GitHub Pages Setup" -ForegroundColor Cyan
Write-Host "Current Time: 2025-06-05 13:43:26" -ForegroundColor Yellow
Write-Host "User: asarekings" -ForegroundColor Yellow
Write-Host "Project Directory: $projectDir" -ForegroundColor Yellow

# Step 1: Check Git configuration
Write-Host "Checking Git configuration..." -ForegroundColor Yellow
git config --global --get user.name
git config --global --get user.email

# Step 2: Get the current branch name
$currentBranch = git rev-parse --abbrev-ref HEAD 2>$null
if (-not $currentBranch) {
    Write-Host "No Git repository detected. Initializing..." -ForegroundColor Yellow
    git init
    git config user.name "asarekings"
    git config user.email "kingstune7@gmail.com"
    $currentBranch = "main"  # Default to main for new repositories
} else {
    Write-Host "Current branch: $currentBranch" -ForegroundColor Green
}

# Step 3: Create basic content if directory is empty
$fileCount = (Get-ChildItem -Path $projectDir -File).Count
if ($fileCount -lt 3) {
    Write-Host "Creating basic content..." -ForegroundColor Yellow
    
    # Create index.html
    $indexContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>HealthcareML - Predicting Patient Readmissions</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; }
        .jumbotron { padding: 2rem; background-color: #e9ecef; border-radius: .3rem; margin-bottom: 2rem; }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="jumbotron">
            <h1>HealthcareML: Predicting Patient Readmissions</h1>
            <p class="lead">Advanced machine learning techniques for healthcare analytics</p>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <h2>Project Overview</h2>
                <p>
                    This project demonstrates advanced machine learning techniques for predicting 
                    hospital readmissions. By analyzing patient data and creating interpretable models, 
                    we provide healthcare professionals with actionable insights.
                </p>
            </div>
            <div class="col-md-6">
                <h2>Key Features</h2>
                <ul>
                    <li>Predictive Models for readmission risk</li>
                    <li>Interactive dashboard for data exploration</li>
                    <li>Class imbalance handling techniques</li>
                    <li>Model interpretability with SHAP values</li>
                    <li>Privacy-preserving data analysis</li>
                </ul>
            </div>
        </div>
        
        <hr>
        <footer class="mt-4">
            <p>&copy; 2025 HealthcareML by Asare Kings</p>
        </footer>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
"@
    Set-Content -Path "$projectDir\index.html" -Value $indexContent
    
    # Create README.md
    $readmeContent = @"
# HealthcareML: Predicting Patient Readmissions

## Overview
This project demonstrates advanced machine learning techniques for healthcare applications, specifically predicting hospital readmissions.

## Key Features
- **Predictive Models**: Ensemble of interpretable models
- **Interactive Dashboard**: Explore predictions and feature importance
- **Class Imbalance Handling**: Implementation of SMOTE and class weighting
- **Model Interpretability**: SHAP values and feature importance analysis

## Live Demo
Visit the [interactive dashboard](https://asarekings.github.io/$repoName/) to explore the models and predictions.

## Author
**Asare Kings** - Data Scientist specializing in healthcare analytics
- GitHub: [@asarekings](https://github.com/asarekings)
- Email: kingstune7@gmail.com
"@
    Set-Content -Path "$projectDir\README.md" -Value $readmeContent
    
    Write-Host "Basic content created" -ForegroundColor Green
}

# Step 4: Commit any changes
$status = git status --porcelain
if ($status) {
    Write-Host "Uncommitted changes found. Committing changes..." -ForegroundColor Yellow
    git add .
    git commit -m "Initial project setup"
    Write-Host "Changes committed" -ForegroundColor Green
} else {
    Write-Host "No changes to commit" -ForegroundColor Green
}

# Step 5: Configure GitHub repository
Write-Host "Setting up GitHub repository..." -ForegroundColor Yellow

# Set up the remote with token-based authentication
$remote = git remote
if ($remote -contains "origin") {
    Write-Host "Remote 'origin' already exists. Updating..." -ForegroundColor Yellow
    git remote remove origin
}

# Add the remote with token
git remote add origin "https://asarekings:$token@github.com/asarekings/$repoName.git"
Write-Host "Remote 'origin' configured" -ForegroundColor Green

# Step 6: Push to GitHub main branch
Write-Host "Pushing to GitHub main branch..." -ForegroundColor Yellow
try {
    # First try to push to current branch
    git push -u origin $currentBranch
    Write-Host "Successfully pushed to $currentBranch branch" -ForegroundColor Green
} catch {
    Write-Host "Error pushing to $currentBranch branch: $_" -ForegroundColor Red
    
    # Try pushing to main branch
    if ($currentBranch -ne "main") {
        Write-Host "Trying to push to main branch instead..." -ForegroundColor Yellow
        git branch -M main
        git push -u origin main
        Write-Host "Successfully pushed to main branch" -ForegroundColor Green
        $currentBranch = "main"
    } else {
        # Try without -u flag
        git push origin $currentBranch
    }
}

# Step 7: Create and set up GitHub Pages branch
Write-Host "Setting up GitHub Pages branch..." -ForegroundColor Yellow
try {
    # Check if gh-pages branch already exists locally
    $branches = git branch
    if ($branches -match "gh-pages") {
        Write-Host "Branch 'gh-pages' already exists locally" -ForegroundColor Yellow
        git checkout gh-pages
    } else {
        git checkout -b gh-pages
        Write-Host "Created new branch: gh-pages" -ForegroundColor Green
    }
    
    # Push gh-pages branch
    git push origin gh-pages --force
    Write-Host "Successfully pushed gh-pages branch" -ForegroundColor Green
    
    # Switch back to original branch
    git checkout $currentBranch
    Write-Host "Switched back to $currentBranch branch" -ForegroundColor Green
} catch {
    Write-Host "Error setting up GitHub Pages: $_" -ForegroundColor Red
}

Write-Host "`nSetup process completed!" -ForegroundColor Cyan
Write-Host "Your website should be available at: https://asarekings.github.io/$repoName/" -ForegroundColor Cyan
Write-Host "Note: It may take a few minutes for GitHub Pages to build your site." -ForegroundColor Yellow
Write-Host "Remember to visit your repository settings to ensure GitHub Pages is enabled for the gh-pages branch." -ForegroundColor Yellow