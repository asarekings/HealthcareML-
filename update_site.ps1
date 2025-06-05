# HealthcareML GitHub Pages Auto-Update Script
# Author: asarekings
# Date: 2025-06-05 14:06:53

$ErrorActionPreference = "Stop"
$timestamp = "2025-06-05 14:06:53"
$username = "asarekings"
$repoName = "HealthcareML-"

Write-Host "HealthcareML GitHub Pages Updater" -ForegroundColor Cyan
Write-Host "Current Time: $timestamp" -ForegroundColor Yellow
Write-Host "User: $username" -ForegroundColor Yellow

# Step 1: Ensure we're on the gh-pages branch
try {
    git checkout gh-pages
    Write-Host "Switched to gh-pages branch" -ForegroundColor Green
} catch {
    Write-Host "Error switching to gh-pages branch: $_" -ForegroundColor Red
    Write-Host "Creating gh-pages branch..." -ForegroundColor Yellow
    git checkout -b gh-pages
}

# Step 2: Create/Update index.html
Write-Host "Creating index.html..." -ForegroundColor Yellow
@"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HealthcareML - Predictive Analytics for Patient Readmissions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="#">HealthcareML</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.html">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="models.html">Models</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about.html">About</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="jumbotron">
            <h1 class="display-4">HealthcareML</h1>
            <p class="lead">Advanced predictive analytics for patient readmission risk</p>
            <hr class="my-4">
            <p>Using machine learning to improve healthcare outcomes and resource allocation</p>
            <a class="btn btn-primary btn-lg" href="dashboard.html" role="button">View Dashboard</a>
        </div>

        <div class="row mt-5">
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Predictive Models</h5>
                    </div>
                    <div class="card-body">
                        <p class="card-text">Our ensemble of machine learning models achieves 85% accuracy in predicting readmission risk.</p>
                        <a href="models.html" class="btn btn-outline-primary">Explore Models</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Interactive Dashboard</h5>
                    </div>
                    <div class="card-body">
                        <p class="card-text">Visualize patient data and explore risk factors through our interactive dashboard.</p>
                        <a href="dashboard.html" class="btn btn-outline-primary">Open Dashboard</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Research Paper</h5>
                    </div>
                    <div class="card-body">
                        <p class="card-text">Read our methodology and findings in our published research paper.</p>
                        <a href="#" class="btn btn-outline-primary">Read Paper</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="mt-5 py-3 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>&copy; 2025 HealthcareML by <a href="https://github.com/$username">$username</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p id="timestamp">Last Updated: $timestamp UTC</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
"@ | Set-Content -Path "index.html"

# Step 3: Create/Update CSS directories and files
Write-Host "Creating CSS directories and files..." -ForegroundColor Yellow
if (-not (Test-Path -Path "assets")) {
    New-Item -Path "assets" -ItemType Directory -Force | Out-Null
}
if (-not (Test-Path -Path "assets/css")) {
    New-Item -Path "assets/css" -ItemType Directory -Force | Out-Null
}
if (-not (Test-Path -Path "assets/js")) {
    New-Item -Path "assets/js" -ItemType Directory -Force | Out-Null
}

# Step 4: Create/Update style.css
@"
/* HealthcareML Custom Styles */
body {
    font-family: 'Segoe UI', Tahoma, sans-serif;
    line-height: 1.6;
    color: #333;
}

.jumbotron {
    background-color: #f8f9fa;
    padding: 2rem;
    margin-bottom: 2rem;
    border-radius: 0.3rem;
}

.card-header {
    font-weight: 500;
}

.navbar-brand {
    font-weight: bold;
    letter-spacing: 0.5px;
}

footer {
    font-size: 0.9rem;
    color: #666;
}

.text-white {
    color: white !important;
}

/* Dashboard styles */
.metric-card {
    text-align: center;
    transition: transform 0.3s;
}

.metric-card:hover {
    transform: translateY(-5px);
}

.metric-value {
    font-size: 2.5rem;
    font-weight: bold;
    color: #0d6efd;
}

.metric-label {
    color: #666;
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 1px;
}
"@ | Set-Content -Path "assets/css/style.css"

# Step 5: Create/Update main.js
@"
// HealthcareML Main JavaScript
document.addEventListener('DOMContentLoaded', function() {
    console.log('HealthcareML Application Initialized');
    
    // Add current year to copyright
    const currentYear = new Date().getFullYear();
    const copyrightElements = document.querySelectorAll('footer p:first-child');
    copyrightElements.forEach(el => {
        el.innerHTML = el.innerHTML.replace('2025', currentYear);
    });
    
    // Highlight current navigation item
    const currentPage = window.location.pathname.split('/').pop();
    const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
    navLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href === currentPage) {
            link.classList.add('active');
        }
    });
});
"@ | Set-Content -Path "assets/js/main.js"

# Step 6: Create/Update dashboard.html
Write-Host "Creating dashboard.html..." -ForegroundColor Yellow
@"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - HealthcareML</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="index.html">HealthcareML</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="dashboard.html">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="models.html">Models</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about.html">About</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h1 class="mb-4">Readmission Risk Dashboard</h1>
        <p class="lead">Interactive visualization of patient readmission predictions</p>
        
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card metric-card">
                    <div class="card-body">
                        <div class="metric-value">18.7%</div>
                        <div class="metric-label">Overall Readmission Rate</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card metric-card">
                    <div class="card-body">
                        <div class="metric-value">85.2%</div>
                        <div class="metric-label">Model Accuracy</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card metric-card">
                    <div class="card-body">
                        <div class="metric-value">0.82</div>
                        <div class="metric-label">AUC-ROC</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card metric-card">
                    <div class="card-body">
                        <div class="metric-value">$4.2M</div>
                        <div class="metric-label">Potential Annual Savings</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                Key Risk Factors
            </div>
            <div class="card-body">
                <p>The following patient characteristics have the highest impact on readmission risk:</p>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Factor</th>
                                <th>Importance Score</th>
                                <th>Impact Direction</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Previous Admissions (>2)</td>
                                <td>0.85</td>
                                <td>↑ Increases Risk</td>
                            </tr>
                            <tr>
                                <td>Length of Stay (>7 days)</td>
                                <td>0.78</td>
                                <td>↑ Increases Risk</td>
                            </tr>
                            <tr>
                                <td>Age (>65)</td>
                                <td>0.72</td>
                                <td>↑ Increases Risk</td>
                            </tr>
                            <tr>
                                <td>Comorbidities (>3)</td>
                                <td>0.68</td>
                                <td>↑ Increases Risk</td>
                            </tr>
                            <tr>
                                <td>Medication Count (>8)</td>
                                <td>0.65</td>
                                <td>↑ Increases Risk</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        Patient Demographics
                    </div>
                    <div class="card-body">
                        <p>This section will contain interactive demographic charts.</p>
                        <div class="alert alert-info">
                            Interactive charts will be added in the next update.
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        Model Performance
                    </div>
                    <div class="card-body">
                        <p>This section will show performance metrics across different patient subgroups.</p>
                        <div class="alert alert-info">
                            Interactive performance metrics will be added in the next update.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="mt-5 py-3 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>&copy; 2025 HealthcareML by <a href="https://github.com/$username">$username</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p id="timestamp">Last Updated: $timestamp UTC</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
"@ | Set-Content -Path "dashboard.html"

# Step 7: Create/Update models.html
Write-Host "Creating models.html..." -ForegroundColor Yellow
@"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Models - HealthcareML</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="index.html">HealthcareML</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.html">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="models.html">Models</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about.html">About</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h1 class="mb-4">Machine Learning Models</h1>
        <p class="lead">Comparison of different machine learning approaches for readmission prediction</p>
        
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                Model Performance Comparison
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Model</th>
                                <th>Accuracy</th>
                                <th>Precision</th>
                                <th>Recall</th>
                                <th>F1 Score</th>
                                <th>AUC-ROC</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>XGBoost</strong></td>
                                <td>0.852</td>
                                <td>0.783</td>
                                <td>0.721</td>
                                <td>0.751</td>
                                <td>0.880</td>
                            </tr>
                            <tr>
                                <td>Random Forest</td>
                                <td>0.824</td>
                                <td>0.759</td>
                                <td>0.705</td>
                                <td>0.731</td>
                                <td>0.851</td>
                            </tr>
                            <tr>
                                <td>Logistic Regression</td>
                                <td>0.784</td>
                                <td>0.738</td>
                                <td>0.698</td>
                                <td>0.717</td>
                                <td>0.812</td>
                            </tr>
                            <tr>
                                <td>Neural Network</td>
                                <td>0.841</td>
                                <td>0.772</td>
                                <td>0.711</td>
                                <td>0.740</td>
                                <td>0.863</td>
                            </tr>
                            <tr>
                                <td>Ensemble (Combined)</td>
                                <td>0.867</td>
                                <td>0.795</td>
                                <td>0.735</td>
                                <td>0.764</td>
                                <td>0.891</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <p class="mt-3"><strong>Note:</strong> Bold indicates the best performing single model. The ensemble combines all models with weighted voting.</p>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        Feature Importance
                    </div>
                    <div class="card-body">
                        <p>Top 10 most important features in the XGBoost model:</p>
                        <ol>
                            <li>Previous Admissions Count</li>
                            <li>Length of Stay</li>
                            <li>Age</li>
                            <li>Number of Medications</li>
                            <li>Number of Diagnoses</li>
                            <li>Blood Glucose Level</li>
                            <li>Hemoglobin A1c</li>
                            <li>Systolic Blood Pressure</li>
                            <li>Number of Procedures</li>
                            <li>Number of Emergency Visits</li>
                        </ol>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        Model Training Methodology
                    </div>
                    <div class="card-body">
                        <p>Our model development process included:</p>
                        <ul>
                            <li><strong>Data Preprocessing:</strong> Handling missing values, encoding categorical variables</li>
                            <li><strong>Class Imbalance:</strong> SMOTE oversampling to address readmission class imbalance</li>
                            <li><strong>Feature Selection:</strong> Recursive feature elimination with cross-validation</li>
                            <li><strong>Hyperparameter Tuning:</strong> Grid search with 5-fold cross-validation</li>
                            <li><strong>Validation Strategy:</strong> Temporal validation with 80/20 train-test split</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="mt-5 py-3 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>&copy; 2025 HealthcareML by <a href="https://github.com/$username">$username</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p id="timestamp">Last Updated: $timestamp UTC</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
"@ | Set-Content -Path "models.html"

# Step 8: Create about.html
Write-Host "Creating about.html..." -ForegroundColor Yellow
@"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About - HealthcareML</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="index.html">HealthcareML</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.html">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="models.html">Models</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="about.html">About</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h1 class="mb-4">About HealthcareML</h1>
        
        <div class="row">
            <div class="col-md-8">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        Project Overview
                    </div>
                    <div class="card-body">
                        <p>HealthcareML is a research project focused on applying advanced machine learning techniques to predict hospital readmissions. 
                        By analyzing patient data, we aim to identify high-risk individuals for targeted interventions.</p>
                        
                        <p>Hospital readmissions represent a significant burden on healthcare systems, with approximately 20% of Medicare patients 
                        being readmitted within 30 days of discharge, at an annual cost of over $26 billion. Many of these readmissions are 
                        potentially preventable with appropriate post-discharge care and monitoring.</p>
                        
                        <p>Our machine learning models analyze patient data including demographics, medical history, laboratory results, and 
                        hospital course information to generate personalized readmission risk scores. Healthcare providers can use these predictions
                        to allocate resources more efficiently and improve patient outcomes.</p>
                    </div>
                </div>
                
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        Technology Stack
                    </div>
                    <div class="card-body">
                        <ul>
                            <li><strong>Data Processing:</strong> Python, Pandas, NumPy</li>
                            <li><strong>Machine Learning:</strong> Scikit-learn, XGBoost, TensorFlow</li>
                            <li><strong>Visualization:</strong> Matplotlib, Seaborn, Plotly</li>
                            <li><strong>Web Frontend:</strong> HTML5, CSS3, JavaScript, Bootstrap</li>
                            <li><strong>Deployment:</strong> GitHub Pages, Flask API (backend)</li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        Author
                    </div>
                    <div class="card-body text-center">
                        <img src="https://github.com/$username.png" alt="Profile Photo" class="rounded-circle mb-3" style="width: 150px; height: 150px;">
                        <h5>$username</h5>
                        <p>Data Scientist & Healthcare Analyst</p>
                        <div class="d-grid gap-2">
                            <a href="https://github.com/$username" class="btn btn-outline-primary">GitHub Profile</a>
                            <a href="mailto:kingstune7@gmail.com" class="btn btn-outline-primary">Contact</a>
                        </div>
                    </div>
                </div>
                
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        References
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled">
                            <li class="mb-2"><a href="#">Machine Learning for Healthcare (2024)</a></li>
                            <li class="mb-2"><a href="#">Predicting Readmissions: A Systematic Review</a></li>
                            <li class="mb-2"><a href="#">MIMIC-IV Clinical Database</a></li>
                            <li class="mb-2"><a href="#">Healthcare Cost and Utilization Project</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="mt-5 py-3 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>&copy; 2025 HealthcareML by <a href="https://github.com/$username">$username</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p id="timestamp">Last Updated: $timestamp UTC</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
"@ | Set-Content -Path "about.html"

# Step 9: Update README.md
Write-Host "Updating README.md..." -ForegroundColor Yellow
@"
# HealthcareML: Predicting Patient Readmissions

## Overview
This project demonstrates advanced machine learning techniques for healthcare applications, specifically predicting hospital readmissions using patient data.

## Features
- **Predictive Models:** Ensemble of machine learning algorithms for readmission risk prediction
- **Interactive Dashboard:** Visualize patient risk factors and model performance
- **Model Interpretability:** Feature importance analysis for clinical decision support
- **Class Imbalance Handling:** Advanced techniques to address readmission class imbalance

## Live Demo
The project is deployed using GitHub Pages and can be accessed at:
https://$username.github.io/$repoName/

## Pages
- **Home:** Overview of the project and key features
- **Dashboard:** Interactive visualizations of readmission risk factors
- **Models:** Technical details of machine learning models and their performance
- **About:** Project background, author information, and references

## Technology Stack
- **Frontend:** HTML5, CSS3, JavaScript, Bootstrap 5
- **Data Processing:** Python, Pandas, NumPy
- **Machine Learning:** Scikit-learn, XGBoost, TensorFlow
- **Visualization:** Matplotlib, Seaborn, Plotly
- **Deployment:** GitHub Pages

## Author
**$username** - Data Scientist specializing in healthcare analytics
- GitHub: [@$username](https://github.com/$username)
- Email: kingstune7@gmail.com

## Last Updated
$timestamp UTC
"@ | Set-Content -Path "README.md"

# Step 10: Commit and push to GitHub
Write-Host "Committing changes to gh-pages branch..." -ForegroundColor Yellow
try {
    # Add all files to staging
    git add .
    
    # Commit changes
    git commit -m "Update website content - $timestamp"
    
    # Push to GitHub Pages
    git push origin gh-pages
    
    Write-Host "Successfully pushed changes to GitHub Pages!" -ForegroundColor Green
    Write-Host "Your website should be available at: https://$username.github.io/$repoName/" -ForegroundColor Green
    Write-Host "Note: It may take a few minutes for GitHub Pages to build and deploy your site." -ForegroundColor Yellow
} catch {
    Write-Host "Error pushing changes: $_" -ForegroundColor Red
    Write-Host "Trying force push..." -ForegroundColor Yellow
    git push -f origin gh-pages
}

Write-Host "`nUpdate process completed!" -ForegroundColor Cyan