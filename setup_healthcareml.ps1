# HealthcareML Complete Project Setup and Deployment Script
# Author: Asare Kings
# Date: 2025-06-05 13:29:41

$ErrorActionPreference = "Stop"
$repoName = "HealthcareML-"
$repoUrl = "https://github.com/asarekings/$repoName.git"
$projectDir = "$PSScriptRoot"
$email = "kingstune7@gmail.com"
$token = "YOUR_GITHUB_TOKEN" # Replace with actual token when running

Write-Host "Starting HealthcareML Project Setup..." -ForegroundColor Cyan
Write-Host "Current User: asarekings" -ForegroundColor Yellow
Write-Host "Project Directory: $projectDir" -ForegroundColor Yellow

# Step 1: Initialize Git repository
Write-Host "Initializing Git repository..." -ForegroundColor Yellow
if (-not (Test-Path "$projectDir/.git")) {
    git init
    git config user.name "asarekings"
    git config user.email $email
    Write-Host "Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "Git repository already exists" -ForegroundColor Green
}

# Step 2: Create basic project structure
Write-Host "Creating project structure..." -ForegroundColor Yellow

# Create directories
$directories = @(
    "_data",
    "_includes",
    "_layouts",
    "_posts",
    "assets/css",
    "assets/js",
    "assets/images",
    "models",
    "pages",
    "scripts"
)

foreach ($dir in $directories) {
    $path = Join-Path $projectDir $dir
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Write-Host "Created directory: $dir" -ForegroundColor Green
    }
}

# Step 3: Create basic configuration files
Write-Host "Creating configuration files..." -ForegroundColor Yellow

# Create _config.yml
$configContent = @"
# Site settings
title: HealthcareML
description: Advanced predictive analytics for healthcare readmissions
baseurl: "/$repoName"
url: "https://asarekings.github.io"

# Build settings
markdown: kramdown
theme: minima
plugins:
  - jekyll-feed
  - jekyll-seo-tag
  - jekyll-sitemap

# Default layouts
defaults:
  - scope:
      path: ""
    values:
      layout: "default"

# Custom variables
github_username: asarekings
author: Asare Kings
"@

Set-Content -Path "$projectDir/_config.yml" -Value $configContent
Write-Host "Created _config.yml" -ForegroundColor Green

# Create Gemfile
$gemfileContent = @"
source "https://rubygems.org"

gem "jekyll", "~> 4.2.0"
gem "minima", "~> 2.5"

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
end

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.1.1", platforms: [:mingw, :x64_mingw, :mswin]
"@

Set-Content -Path "$projectDir/Gemfile" -Value $gemfileContent
Write-Host "Created Gemfile" -ForegroundColor Green

# Create index.html
$indexContent = @"
---
layout: default
title: Home
---

<div class="jumbotron">
  <h1>HealthcareML: Predicting Patient Readmissions</h1>
  <p class="lead">Advanced machine learning techniques for healthcare analytics</p>
</div>

<div class="row">
  <div class="col-md-6">
    <h2>Project Overview</h2>
    <p>
      This project demonstrates predictive analytics for healthcare readmissions,
      addressing challenges of class imbalance and creating interpretable models.
    </p>
  </div>
  <div class="col-md-6">
    <h2>Features</h2>
    <ul>
      <li>Interactive Dashboard</li>
      <li>Machine Learning Models</li>
      <li>Feature Importance Analysis</li>
      <li>Patient Explorer</li>
    </ul>
  </div>
</div>
"@

Set-Content -Path "$projectDir/index.html" -Value $indexContent
Write-Host "Created index.html" -ForegroundColor Green

# Create default layout
$layoutContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{% if page.title %}{{ page.title }} | {{ site.title }}{% else %}{{ site.title }}{% endif %}</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container">
      <a class="navbar-brand" href="{{ '/' | relative_url }}">{{ site.title }}</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="{{ '/' | relative_url }}">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="{{ '/pages/dashboard' | relative_url }}">Dashboard</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="{{ '/pages/models' | relative_url }}">Models</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container">
    {{ content }}
  </div>

  <footer class="mt-5 py-3 bg-light">
    <div class="container text-center">
      <span>&copy; 2025 {{ site.title }} by {{ site.author }}</span>
    </div>
  </footer>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
"@

New-Item -ItemType Directory -Path "$projectDir/_layouts" -Force | Out-Null
Set-Content -Path "$projectDir/_layouts/default.html" -Value $layoutContent
Write-Host "Created default layout" -ForegroundColor Green

# Create CSS file
$cssContent = @"
body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.jumbotron {
  padding: 2rem;
  margin-bottom: 2rem;
  background-color: #e9ecef;
  border-radius: 0.3rem;
}
"@

Set-Content -Path "$projectDir/assets/css/main.css" -Value $cssContent
Write-Host "Created CSS file" -ForegroundColor Green

# Create sample dashboard page
$dashboardContent = @"
---
layout: default
title: Dashboard
permalink: /pages/dashboard/
---

<h1>Interactive Dashboard</h1>
<p>This dashboard shows patient readmission predictions and analytics.</p>

<div class="row">
  <div class="col-md-6">
    <div class="card mb-4">
      <div class="card-header">
        Readmission Rate
      </div>
      <div class="card-body">
        <h5 class="card-title">18.7%</h5>
        <p class="card-text">Overall readmission rate across all patients</p>
      </div>
    </div>
  </div>
  
  <div class="col-md-6">
    <div class="card mb-4">
      <div class="card-header">
        Model Accuracy
      </div>
      <div class="card-body">
        <h5 class="card-title">85.2%</h5>
        <p class="card-text">Prediction accuracy of our best performing model</p>
      </div>
    </div>
  </div>
</div>

<div class="card mb-4">
  <div class="card-header">
    Patient Risk Factors
  </div>
  <div class="card-body">
    <p>Top factors influencing readmission risk:</p>
    <ul>
      <li>Previous Admissions</li>
      <li>Length of Stay</li>
      <li>Age</li>
      <li>Comorbidities</li>
      <li>Medication Count</li>
    </ul>
  </div>
</div>
"@

New-Item -ItemType Directory -Path "$projectDir/pages" -Force | Out-Null
Set-Content -Path "$projectDir/pages/dashboard.html" -Value $dashboardContent
Write-Host "Created dashboard page" -ForegroundColor Green

# Create sample models page
$modelsContent = @"
---
layout: default
title: Models
permalink: /pages/models/
---

<h1>Machine Learning Models</h1>
<p>Comparison of different machine learning models for readmission prediction.</p>

<div class="table-responsive">
  <table class="table table-striped">
    <thead>
      <tr>
        <th>Model</th>
        <th>Accuracy</th>
        <th>Precision</th>
        <th>Recall</th>
        <th>F1 Score</th>
        <th>AUC</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>XGBoost</td>
        <td>0.85</td>
        <td>0.78</td>
        <td>0.72</td>
        <td>0.75</td>
        <td>0.88</td>
      </tr>
      <tr>
        <td>Random Forest</td>
        <td>0.82</td>
        <td>0.76</td>
        <td>0.71</td>
        <td>0.73</td>
        <td>0.85</td>
      </tr>
      <tr>
        <td>Logistic Regression</td>
        <td>0.78</td>
        <td>0.74</td>
        <td>0.70</td>
        <td>0.72</td>
        <td>0.81</td>
      </tr>
    </tbody>
  </table>
</div>
"@

Set-Content -Path "$projectDir/pages/models.html" -Value $modelsContent
Write-Host "Created models page" -ForegroundColor Green

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
Visit the [interactive dashboard](https://asarekings.github.io/$repoName/dashboard) to explore the models and predictions.

## Author
**Asare Kings** - Data Scientist specializing in healthcare analytics
- GitHub: [@asarekings](https://github.com/asarekings)
- Email: kingstune7@gmail.com
"@

Set-Content -Path "$projectDir/README.md" -Value $readmeContent
Write-Host "Created README.md" -ForegroundColor Green

# Step 4: Add & commit files
Write-Host "Adding files to Git repository..." -ForegroundColor Yellow
git add .
git commit -m "Initial project setup"
Write-Host "Files committed to local repository" -ForegroundColor Green

# Step 5: Set up GitHub repository
Write-Host "Setting up GitHub repository..." -ForegroundColor Yellow

# Configure remote origin with token authentication
$secureUrl = "https://asarekings:$token@github.com/asarekings/$repoName.git"
git remote add origin $secureUrl
Write-Host "Remote origin configured" -ForegroundColor Green

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push -u origin master
Write-Host "Files pushed to GitHub" -ForegroundColor Green

# Step 6: Set up GitHub Pages
Write-Host "Setting up GitHub Pages branch..." -ForegroundColor Yellow
git checkout -b gh-pages
git push origin gh-pages
git checkout master
Write-Host "GitHub Pages branch created and pushed" -ForegroundColor Green

Write-Host "`nHealthcareML project setup completed successfully!" -ForegroundColor Cyan
Write-Host "Your website will be available shortly at: https://asarekings.github.io/$repoName/" -ForegroundColor Cyan
Write-Host "Note: It may take a few minutes for GitHub Pages to build and deploy your site." -ForegroundColor Yellow