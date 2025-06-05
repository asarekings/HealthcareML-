# HealthcareML GitHub Pages Setup Script
# Current Date and Time: 2025-06-05 13:33:19
# Author: asarekings

$ErrorActionPreference = "Stop"
$repoName = "HealthcareML-"
$projectDir = "$PSScriptRoot"

Write-Host "HealthcareML GitHub Pages Setup" -ForegroundColor Cyan
Write-Host "Current Time: 2025-06-05 13:33:19" -ForegroundColor Yellow
Write-Host "User: asarekings" -ForegroundColor Yellow
Write-Host "Project Directory: $projectDir" -ForegroundColor Yellow

# Step 1: Configure Git with credential helper to store credentials securely
Write-Host "Configuring Git credential helper..." -ForegroundColor Yellow
git config --global credential.helper wincred

# Step 2: Get the current branch name
$currentBranch = git rev-parse --abbrev-ref HEAD
Write-Host "Current branch: $currentBranch" -ForegroundColor Green

# Step 3: Check if files are already committed
$status = git status --porcelain
if ($status) {
    Write-Host "Uncommitted changes found. Committing changes..." -ForegroundColor Yellow
    git add .
    git commit -m "Initial project setup"
    Write-Host "Changes committed" -ForegroundColor Green
} else {
    Write-Host "No changes to commit" -ForegroundColor Green
}

# Step 4: Configure GitHub repository
Write-Host "Enter your GitHub Personal Access Token (will be hidden):" -ForegroundColor Yellow
$token = Read-Host -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($token)
$plainToken = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

# Set up the remote with token-based authentication
$remote = git remote
if ($remote -contains "origin") {
    Write-Host "Remote 'origin' already exists. Updating..." -ForegroundColor Yellow
    git remote remove origin
}

# Add the remote with token
git remote add origin "https://asarekings:$plainToken@github.com/asarekings/$repoName.git"
Write-Host "Remote 'origin' configured" -ForegroundColor Green

# Step 5: Push to GitHub main branch
Write-Host "Pushing to GitHub main branch..." -ForegroundColor Yellow
try {
    git push -u origin $currentBranch
    Write-Host "Successfully pushed to $currentBranch branch" -ForegroundColor Green
} catch {
    Write-Host "Error pushing to GitHub: $_" -ForegroundColor Red
    Write-Host "Trying alternative method..." -ForegroundColor Yellow
    
    # Try without -u flag
    git push origin $currentBranch
}

# Step 6: Create and set up GitHub Pages branch
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
    git push origin gh-pages
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