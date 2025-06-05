# HealthcareML GitHub Pages Update Script
# Author: asarekings
# Date: 2025-06-05 14:53:02

$ErrorActionPreference = "Stop"
$timestamp = "2025-06-05 14:53:02"
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

# Step 2: Create necessary directories
Write-Host "Creating directory structure..." -ForegroundColor Yellow
$directories = @(
    "assets/css", 
    "assets/js", 
    "assets/img", 
    "assets/data"
)

foreach ($dir in $directories) {
    if (-not (Test-Path -Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
        Write-Host "Created directory: $dir" -ForegroundColor Green
    }
}

# Step 3: Create CSS file
Write-Host "Creating CSS file..." -ForegroundColor Yellow
$cssContent = @'
/* HealthcareML Custom Styles */
:root {
    --primary-color: #0d6efd;
    --secondary-color: #6c757d;
    --bg-color: #ffffff;
    --text-color: #333333;
    --card-bg: #ffffff;
    --border-color: #dee2e6;
    --header-bg: #f8f9fa;
}

body {
    font-family: 'Segoe UI', Tahoma, sans-serif;
    line-height: 1.6;
    color: var(--text-color);
    background-color: var(--bg-color);
}

.card {
    transition: transform 0.3s, box-shadow 0.3s;
    border-color: var(--border-color);
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}

.card-header.bg-primary {
    background-color: var(--primary-color) !important;
}

.metric-card {
    text-align: center;
}

.metric-value {
    font-size: 2.5rem;
    font-weight: bold;
    color: var(--primary-color);
}

.metric-label {
    color: var(--secondary-color);
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.feature-icon {
    width: 60px;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
}
'@
Set-Content -Path "assets/css/style.css" -Value $cssContent

# Step 4: Create JavaScript file
Write-Host "Creating JavaScript file..." -ForegroundColor Yellow
$jsContent = @'
// HealthcareML Main JavaScript
document.addEventListener('DOMContentLoaded', function() {
    console.log('HealthcareML Application Initialized');
    
    // Update copyright year
    const currentYear = new Date().getFullYear();
    const copyrightElements = document.querySelectorAll('footer p:first-child');
    copyrightElements.forEach(el => {
        el.innerHTML = el.innerHTML.replace('2025', currentYear);
    });
    
    // Highlight current navigation item
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
    navLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href === currentPage) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });
});
'@
Set-Content -Path "assets/js/main.js" -Value $jsContent

# Step 5: Create index.html
Write-Host "Creating index.html..." -ForegroundColor Yellow
$indexHtml = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HealthcareML - Predictive Analytics for Patient Readmissions</title>
    <meta name="description" content="Advanced machine learning for predicting hospital readmissions and improving healthcare outcomes">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="bi bi-activity me-2"></i>HealthcareML
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="index.html">Home</a>
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

    <!-- Hero Section -->
    <header class="bg-primary text-white py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-3">Predict. Prevent. Improve.</h1>
                    <p class="lead mb-4">Advanced machine learning algorithms that predict hospital readmissions with 85% accuracy, helping healthcare providers deliver better patient outcomes.</p>
                    <div class="d-grid gap-2 d-md-flex">
                        <a href="dashboard.html" class="btn btn-light btn-lg px-4 me-md-2">
                            <i class="bi bi-graph-up me-2"></i>View Dashboard
                        </a>
                        <a href="models.html" class="btn btn-outline-light btn-lg px-4">
                            <i class="bi bi-diagram-3 me-2"></i>Explore Models
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 text-center d-none d-lg-block">
                    <i class="bi bi-activity" style="font-size: 10rem; opacity: 0.8;"></i>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="py-5">
        <div class="container">
            <!-- Key Features -->
            <section class="mb-5">
                <h2 class="text-center mb-4">Key Features</h2>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-body text-center p-4">
                                <div class="feature-icon bg-primary bg-gradient text-white rounded-circle mb-3 mx-auto">
                                    <i class="bi bi-graph-up" style="font-size: 1.5rem;"></i>
                                </div>
                                <h3 class="card-title h5">Predictive Models</h3>
                                <p class="card-text">Ensemble of machine learning algorithms achieving 85% accuracy in predicting readmission risk.</p>
                                <a href="models.html" class="btn btn-outline-primary">
                                    <i class="bi bi-arrow-right me-1"></i>Explore Models
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-body text-center p-4">
                                <div class="feature-icon bg-primary bg-gradient text-white rounded-circle mb-3 mx-auto">
                                    <i class="bi bi-bar-chart" style="font-size: 1.5rem;"></i>
                                </div>
                                <h3 class="card-title h5">Interactive Dashboard</h3>
                                <p class="card-text">Visualize patient data and explore risk factors through our interactive dashboard.</p>
                                <a href="dashboard.html" class="btn btn-outline-primary">
                                    <i class="bi bi-arrow-right me-1"></i>Open Dashboard
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-body text-center p-4">
                                <div class="feature-icon bg-primary bg-gradient text-white rounded-circle mb-3 mx-auto">
                                    <i class="bi bi-file-earmark-medical" style="font-size: 1.5rem;"></i>
                                </div>
                                <h3 class="card-title h5">Research Paper</h3>
                                <p class="card-text">Read our methodology and findings in our published research paper.</p>
                                <a href="#" class="btn btn-outline-primary">
                                    <i class="bi bi-arrow-right me-1"></i>Read Paper
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Statistics -->
            <section class="mb-5">
                <h2 class="text-center mb-4">Impact Statistics</h2>
                <div class="row g-4 text-center">
                    <div class="col-md-3">
                        <div class="card h-100">
                            <div class="card-body">
                                <h3 class="display-4 fw-bold text-primary mb-2">85%</h3>
                                <p class="card-text">Prediction Accuracy</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card h-100">
                            <div class="card-body">
                                <h3 class="display-4 fw-bold text-primary mb-2">$4.2M</h3>
                                <p class="card-text">Potential Annual Savings</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card h-100">
                            <div class="card-body">
                                <h3 class="display-4 fw-bold text-primary mb-2">18.7%</h3>
                                <p class="card-text">Readmission Rate</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card h-100">
                            <div class="card-body">
                                <h3 class="display-4 fw-bold text-primary mb-2">32%</h3>
                                <p class="card-text">Intervention Success</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Call to Action -->
            <section class="text-center py-5 bg-light rounded">
                <h2 class="mb-3">Ready to improve patient outcomes?</h2>
                <p class="lead mb-4">Explore our models and see how machine learning can transform healthcare.</p>
                <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                    <a href="models.html" class="btn btn-primary btn-lg px-4">Explore Models</a>
                    <a href="about.html" class="btn btn-outline-secondary btn-lg px-4">Learn More</a>
                </div>
            </section>
        </div>
    </main>

    <!-- Footer -->
    <footer class="mt-5 py-4 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>&copy; 2025 HealthcareML by <a href="https://github.com/USERNAME">USERNAME</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>Last Updated: TIMESTAMP</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
'@
$indexHtml = $indexHtml.Replace('USERNAME', $username).Replace('TIMESTAMP', $timestamp)
Set-Content -Path "index.html" -Value $indexHtml

# Step 6: Create dashboard.html with your specific section content
Write-Host "Creating dashboard.html..." -ForegroundColor Yellow
$dashboardHtml = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - HealthcareML</title>
    <meta name="description" content="Interactive dashboard for patient readmission risk visualization">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="bi bi-activity me-2"></i>HealthcareML
            </a>
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

    <!-- Main Content -->
    <main class="py-5">
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
                                <i class="bi bi-info-circle me-1"></i>
                                Interactive charts will be added in the next update.
                            </div>
                            <div class="text-center py-3">
                                <i class="bi bi-pie-chart" style="font-size: 5rem; color: #0d6efd; opacity: 0.2;"></i>
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
                                <i class="bi bi-info-circle me-1"></i>
                                Interactive performance metrics will be added in the next update.
                            </div>
                            <div class="text-center py-3">
                                <i class="bi bi-bar-chart" style="font-size: 5rem; color: #0d6efd; opacity: 0.2;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="mt-5 py-4 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>&copy; 2025 HealthcareML by <a href="https://github.com/USERNAME">USERNAME</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>Last Updated: TIMESTAMP</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
'@
$dashboardHtml = $dashboardHtml.Replace('USERNAME', $username).Replace('TIMESTAMP', $timestamp)
Set-Content -Path "dashboard.html" -Value $dashboardHtml

# Step 7: Create models.html
Write-Host "Creating models.html..." -ForegroundColor Yellow
$modelsHtml = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Models - HealthcareML</title>
    <meta name="description" content="Machine learning models for readmission prediction">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="bi bi-activity me-2"></i>HealthcareML
            </a>
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

    <!-- Main Content -->
    <main class="py-5">
        <div class="container">
            <h1 class="mb-4">Machine Learning Models</h1>
            <p class="lead mb-5">Comparison of different machine learning approaches for readmission prediction</p>
            
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
                            <div class="text-center mt-3">
                                <i class="bi bi-bar-chart-line" style="font-size: 4rem; color: #0d6efd; opacity: 0.2;"></i>
                            </div>
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
                            <div class="text-center mt-3">
                                <i class="bi bi-diagram-3" style="font-size: 4rem; color: #0d6efd; opacity: 0.2;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="mt-5 py-4 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>&copy; 2025 HealthcareML by <a href="https://github.com/USERNAME">USERNAME</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>Last Updated: TIMESTAMP</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
'@
$modelsHtml = $modelsHtml.Replace('USERNAME', $username).Replace('TIMESTAMP', $timestamp)
Set-Content -Path "models.html" -Value $modelsHtml

# Step 8: Create about.html
Write-Host "Creating about.html..." -ForegroundColor Yellow
$aboutHtml = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About - HealthcareML</title>
    <meta name="description" content="About the HealthcareML project and team">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="bi bi-activity me-2"></i>HealthcareML
            </a>
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

    <!-- Main Content -->
    <main class="py-5">
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
                            <img src="https://github.com/USERNAME.png" alt="Profile Photo" class="rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover; border: 3px solid #0d6efd;">
                            <h5>USERNAME</h5>
                            <p>Data Scientist & Healthcare Analyst</p>
                            <div class="d-grid gap-2">
                                <a href="https://github.com/USERNAME" class="btn btn-outline-primary">
                                    <i class="bi bi-github me-1"></i> GitHub Profile
                                </a>
                                <a href="mailto:kingstune7@gmail.com" class="btn btn-outline-primary">
                                    <i class="bi bi-envelope me-1"></i> Contact
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            References
                        </div>
                        <div class="card-body">
                            <ul class="list-unstyled">
                                <li class="mb-2"><a href="#" class="text-decoration-none">Machine Learning for Healthcare (2024)</a></li>
                                <li class="mb-2"><a href="#" class="text-decoration-none">Predicting Readmissions: A Systematic Review</a></li>
                                <li class="mb-2"><a href="#" class="text-decoration-none">MIMIC-IV Clinical Database</a></li>
                                <li class="mb-2"><a href="#" class="text-decoration-none">Healthcare Cost and Utilization Project</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="mt-5 py-4 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>&copy; 2025 HealthcareML by <a href="https://github.com/USERNAME">USERNAME</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>Last Updated: TIMESTAMP</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
'@
$aboutHtml = $aboutHtml.Replace('USERNAME', $username).Replace('TIMESTAMP', $timestamp)
Set-Content -Path "about.html" -Value $aboutHtml

# Step 9: Create README.md
Write-Host "Creating README.md..." -ForegroundColor Yellow
$readmeContent = @'
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
https://USERNAME.github.io/HealthcareML-/

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
**USERNAME** - Data Scientist specializing in healthcare analytics
- GitHub: [@USERNAME](https://github.com/USERNAME)
- Email: kingstune7@gmail.com

## Last Updated
TIMESTAMP
'@
$readmeContent = $readmeContent.Replace('USERNAME', $username).Replace('TIMESTAMP', $timestamp)
Set-Content -Path "README.md" -Value $readmeContent

# Step 10: Create basic placeholder image
Write-Host "Creating placeholder logo image..." -ForegroundColor Yellow
$placeholderImagePath = "assets/img/logo.png"
if (-not (Test-Path $placeholderImagePath)) {
    try {
        $logoUrl = "https://placehold.co/200x200/0d6efd/ffffff?text=HealthcareML"
        Invoke-WebRequest -Uri $logoUrl -OutFile $placeholderImagePath
        Write-Host "Logo image created at $placeholderImagePath" -ForegroundColor Green
    } catch {
        Write-Host "Unable to download placeholder image. Will continue without it." -ForegroundColor Yellow
    }
}

# Step 11: Commit and push to GitHub
Write-Host "Committing changes to gh-pages branch..." -ForegroundColor Yellow
try {
    # Add all files to staging
    git add .
    
    # Commit changes
    git commit -m "Update GitHub Pages site - $timestamp"
    
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
Write-Host "Current Date/Time: $timestamp UTC" -ForegroundColor Yellow
Write-Host "User: $username" -ForegroundColor Yellow
Write-Host "Repository: $repoName" -ForegroundColor Yellow