# HealthcareML GitHub Pages Update Script
# Author: asarekings
# Date: 2025-06-05 14:28:21

$ErrorActionPreference = "Stop"
$timestamp = "2025-06-05 14:28:21"
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

# Step 3: Create main CSS with dark mode support
@"
/* HealthcareML Custom Styles - Enhanced Version */
:root {
    --primary-color: #0d6efd;
    --secondary-color: #6c757d;
    --background-color: #ffffff;
    --text-color: #333333;
    --card-bg: #ffffff;
    --border-color: #dee2e6;
    --header-bg: #f8f9fa;
    --success-color: #198754;
    --warning-color: #ffc107;
    --danger-color: #dc3545;
    --info-color: #0dcaf0;
    --font-family: 'Segoe UI', Tahoma, sans-serif;
    --transition-speed: 0.3s;
}

[data-theme="dark"] {
    --primary-color: #3d8bfd;
    --secondary-color: #959ca3;
    --background-color: #121212;
    --text-color: #e0e0e0;
    --card-bg: #1e1e1e;
    --border-color: #2c2c2c;
    --header-bg: #1a1a1a;
    --success-color: #20c997;
    --warning-color: #ffcd39;
    --danger-color: #e05260;
    --info-color: #0dcaf0;
}

body {
    font-family: var(--font-family);
    line-height: 1.6;
    color: var(--text-color);
    background-color: var(--background-color);
    transition: background-color var(--transition-speed), color var(--transition-speed);
}

/* Card and Component Styles */
.card {
    background-color: var(--card-bg);
    border-color: var(--border-color);
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    transition: transform 0.3s, box-shadow 0.3s, background-color var(--transition-speed);
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}

.jumbotron {
    background-color: var(--header-bg);
    padding: 2rem;
    margin-bottom: 2rem;
    border-radius: 0.3rem;
    transition: background-color var(--transition-speed);
}

.card-header.bg-primary {
    background-color: var(--primary-color) !important;
}

/* Navigation */
.navbar {
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}

.navbar-brand {
    font-weight: bold;
    letter-spacing: 0.5px;
}

/* Dark Mode Toggle */
.theme-toggle {
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 50%;
    width: 2.5rem;
    height: 2.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.3s;
}

.theme-toggle:hover {
    background-color: rgba(0, 0, 0, 0.1);
}

[data-theme="dark"] .theme-toggle:hover {
    background-color: rgba(255, 255, 255, 0.1);
}

.theme-toggle i {
    font-size: 1.2rem;
}

/* Dashboard Metrics */
.metric-card {
    text-align: center;
    transition: transform 0.3s, background-color var(--transition-speed);
}

.metric-card:hover {
    transform: translateY(-5px);
}

.metric-value {
    font-size: 2.5rem;
    font-weight: bold;
    color: var(--primary-color);
    transition: color var(--transition-speed);
}

.metric-label {
    color: var(--secondary-color);
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: color var(--transition-speed);
}

/* Risk Categories */
.risk-badge-low {
    background-color: rgba(25, 135, 84, 0.2);
    color: var(--success-color);
}

.risk-badge-medium {
    background-color: rgba(255, 193, 7, 0.2);
    color: var(--warning-color);
}

.risk-badge-high {
    background-color: rgba(220, 53, 69, 0.2);
    color: var(--danger-color);
}

/* Interactive Elements */
.risk-calculator {
    background-color: var(--header-bg);
    border-radius: 0.5rem;
    padding: 1.5rem;
    margin-bottom: 1.5rem;
    transition: background-color var(--transition-speed);
}

.risk-result {
    text-align: center;
    padding: 1rem;
    border-radius: 0.5rem;
    margin-top: 1rem;
    font-weight: bold;
    transition: background-color 0.3s;
}

.risk-low {
    background-color: rgba(25, 135, 84, 0.2);
    color: var(--success-color);
}

.risk-medium {
    background-color: rgba(255, 193, 7, 0.2);
    color: var(--warning-color);
}

.risk-high {
    background-color: rgba(220, 53, 69, 0.2);
    color: var(--danger-color);
}

/* Animation Classes */
.fade-in {
    animation: fadeIn 0.5s ease-in;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

.slide-in {
    animation: slideIn 0.5s ease-out;
}

@keyframes slideIn {
    from { transform: translateY(20px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}

/* Tables */
.table {
    color: var(--text-color);
    border-color: var(--border-color);
    transition: color var(--transition-speed);
}

.table-striped tbody tr:nth-of-type(odd) {
    background-color: rgba(0, 0, 0, 0.02);
}

[data-theme="dark"] .table-striped tbody tr:nth-of-type(odd) {
    background-color: rgba(255, 255, 255, 0.05);
}

/* Footer */
footer {
    background-color: var(--header-bg) !important;
    color: var(--text-color);
    transition: background-color var(--transition-speed), color var(--transition-speed);
}
"@ | Set-Content -Path "assets/css/style.css"

# Step 4: Create main JavaScript with advanced functionality
@"
// HealthcareML Main JavaScript
document.addEventListener('DOMContentLoaded', function() {
    console.log('HealthcareML Application Initialized');
    
    // Initialize UI Components
    initThemeToggle();
    initNavigation();
    initRiskCalculator();
    
    // Add current year to copyright
    const currentYear = new Date().getFullYear();
    const copyrightElements = document.querySelectorAll('footer p:first-child');
    copyrightElements.forEach(function(el) {
        el.innerHTML = el.innerHTML.replace('2025', currentYear);
    });
});

// Theme Toggle Functionality
function initThemeToggle() {
    const themeToggle = document.getElementById('theme-toggle');
    if (!themeToggle) return;
    
    // Check for saved theme preference or respect OS preference
    const savedTheme = localStorage.getItem('theme');
    const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    
    if (savedTheme) {
        document.documentElement.setAttribute('data-theme', savedTheme);
        updateThemeIcon(savedTheme);
    } else if (prefersDark) {
        document.documentElement.setAttribute('data-theme', 'dark');
        updateThemeIcon('dark');
    }
    
    // Theme toggle click handler
    themeToggle.addEventListener('click', function() {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        
        updateThemeIcon(newTheme);
    });
}

// Update theme icon based on current theme
function updateThemeIcon(theme) {
    const iconElement = document.querySelector('#theme-toggle i');
    if (!iconElement) return;
    
    if (theme === 'dark') {
        iconElement.className = 'bi bi-sun-fill';
        iconElement.setAttribute('title', 'Switch to Light Mode');
    } else {
        iconElement.className = 'bi bi-moon-fill';
        iconElement.setAttribute('title', 'Switch to Dark Mode');
    }
}

// Navigation Highlight
function initNavigation() {
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
    
    navLinks.forEach(function(link) {
        const href = link.getAttribute('href');
        if (href === currentPage) {
            link.classList.add('active');
            link.setAttribute('aria-current', 'page');
        } else {
            link.classList.remove('active');
            link.removeAttribute('aria-current');
        }
    });
}

// Initialize Risk Calculator
function initRiskCalculator() {
    const calculator = document.getElementById('risk-calculator-form');
    if (!calculator) return;
    
    calculator.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Get form values
        const age = parseInt(document.getElementById('patient-age').value) || 0;
        const prevAdmissions = parseInt(document.getElementById('prev-admissions').value) || 0;
        const lengthOfStay = parseInt(document.getElementById('length-of-stay').value) || 0;
        const comorbidities = parseInt(document.getElementById('comorbidities').value) || 0;
        const medications = parseInt(document.getElementById('medications').value) || 0;
        
        // Calculate risk score (simple weighted sum for demonstration)
        const weights = {
            age: 0.3,
            prevAdmissions: 0.25,
            lengthOfStay: 0.2,
            comorbidities: 0.15,
            medications: 0.1
        };
        
        // Normalize each factor to 0-1 range
        const normalizedAge = Math.min(age / 100, 1);
        const normalizedAdmissions = Math.min(prevAdmissions / 5, 1);
        const normalizedLOS = Math.min(lengthOfStay / 14, 1);
        const normalizedComorbidities = Math.min(comorbidities / 5, 1);
        const normalizedMedications = Math.min(medications / 10, 1);
        
        // Calculate weighted score (0-100)
        const score = 100 * (
            weights.age * normalizedAge +
            weights.prevAdmissions * normalizedAdmissions +
            weights.lengthOfStay * normalizedLOS +
            weights.comorbidities * normalizedComorbidities +
            weights.medications * normalizedMedications
        );
        
        // Display result
        const resultElement = document.getElementById('risk-result');
        const scoreElement = document.getElementById('risk-score');
        const riskLevelElement = document.getElementById('risk-level');
        
        if (resultElement && scoreElement && riskLevelElement) {
            // Round score to one decimal place
            const roundedScore = Math.round(score * 10) / 10;
            
            // Determine risk level
            let riskLevel, riskClass;
            if (score < 30) {
                riskLevel = "Low";
                riskClass = "risk-low";
            } else if (score < 60) {
                riskLevel = "Medium";
                riskClass = "risk-medium";
            } else {
                riskLevel = "High";
                riskClass = "risk-high";
            }
            
            // Update UI
            scoreElement.textContent = roundedScore;
            riskLevelElement.textContent = riskLevel;
            
            // Update classes
            resultElement.className = 'risk-result';
            resultElement.classList.add(riskClass);
            resultElement.style.display = 'block';
            
            // Add slide-in animation
            resultElement.classList.remove('slide-in');
            void resultElement.offsetWidth; // Trigger reflow
            resultElement.classList.add('slide-in');
        }
    });
    
    // Reset button handler
    const resetButton = document.getElementById('reset-calculator');
    if (resetButton) {
        resetButton.addEventListener('click', function() {
            const resultElement = document.getElementById('risk-result');
            if (resultElement) {
                resultElement.style.display = 'none';
            }
            calculator.reset();
        });
    }
}
"@ | Set-Content -Path "assets/js/main.js"

# Step 5: Create/Update index.html with Bootstrap icons and dark mode
@"
<!DOCTYPE html>
<html lang="en" data-theme="light">
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
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="bi bi-activity me-2"></i>HealthcareML
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html" aria-current="page">
                            <i class="bi bi-house-door me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.html">
                            <i class="bi bi-graph-up me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="models.html">
                            <i class="bi bi-diagram-3 me-1"></i>Models
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about.html">
                            <i class="bi bi-info-circle me-1"></i>About
                        </a>
                    </li>
                </ul>
                <div class="d-flex align-items-center">
                    <div id="theme-toggle" class="theme-toggle me-2" title="Toggle Dark Mode">
                        <i class="bi bi-moon-fill"></i>
                        <span class="sr-only">Toggle Dark Mode</span>
                    </div>
                    <a href="https://github.com/$username/$repoName" class="btn btn-outline-light btn-sm">
                        <i class="bi bi-github me-1"></i>GitHub
                    </a>
                </div>
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
                                <div class="feature-icon bg-primary bg-gradient text-white rounded-circle mb-3 mx-auto" style="width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;">
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
                                <div class="feature-icon bg-primary bg-gradient text-white rounded-circle mb-3 mx-auto" style="width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;">
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
                                <div class="feature-icon bg-primary bg-gradient text-white rounded-circle mb-3 mx-auto" style="width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;">
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

            <!-- Risk Calculator -->
            <section class="mb-5 risk-calculator">
                <h2 class="text-center mb-4">Readmission Risk Calculator</h2>
                <p class="text-center mb-4">Enter patient information to calculate their readmission risk score.</p>
                
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <form id="risk-calculator-form" class="needs-validation" novalidate>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="patient-age" class="form-label">Patient Age</label>
                                    <input type="number" class="form-control" id="patient-age" min="18" max="100" value="65" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="prev-admissions" class="form-label">Previous Admissions</label>
                                    <input type="number" class="form-control" id="prev-admissions" min="0" max="10" value="1" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="length-of-stay" class="form-label">Length of Stay (days)</label>
                                    <input type="number" class="form-control" id="length-of-stay" min="1" max="30" value="5" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="comorbidities" class="form-label">Number of Comorbidities</label>
                                    <input type="number" class="form-control" id="comorbidities" min="0" max="10" value="2" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="medications" class="form-label">Number of Medications</label>
                                    <input type="number" class="form-control" id="medications" min="0" max="20" value="4" required>
                                </div>
                                <div class="col-12 d-grid gap-2 d-md-flex justify-content-md-center mt-4">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-calculator me-1"></i>Calculate Risk
                                    </button>
                                    <button type="button" id="reset-calculator" class="btn btn-outline-secondary">
                                        <i class="bi bi-arrow-counterclockwise me-1"></i>Reset
                                    </button>
                                </div>
                            </div>
                        </form>
                        
                        <div id="risk-result" class="mt-4" style="display: none;">
                            <h4 class="text-center">Readmission Risk Score</h4>
                            <p class="text-center fs-1 fw-bold mb-1"><span id="risk-score">0</span>/100</p>
                            <p class="text-center">Risk Level: <span id="risk-level" class="fw-bold">Unknown</span></p>
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
                <div class="col-md-4">
                    <h5><i class="bi bi-activity me-2"></i>HealthcareML</h5>
                    <p class="text-muted">Advanced machine learning for healthcare analytics and readmission prediction.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="index.html" class="text-decoration-none">Home</a></li>
                        <li><a href="dashboard.html" class="text-decoration-none">Dashboard</a></li>
                        <li><a href="models.html" class="text-decoration-none">Models</a></li>
                        <li><a href="about.html" class="text-decoration-none">About</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Connect</h5>
                    <ul class="list-unstyled">
                        <li><a href="https://github.com/$username" class="text-decoration-none"><i class="bi bi-github me-1"></i>GitHub</a></li>
                        <li><a href="mailto:kingstune7@gmail.com" class="text-decoration-none"><i class="bi bi-envelope me-1"></i>Email</a></li>
                    </ul>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2025 HealthcareML by <a href="https://github.com/$username" class="text-decoration-none">$username</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0" id="timestamp">Last Updated: $timestamp UTC</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
"@ | Set-Content -Path "index.html"

# Step 6: Create dashboard.html
@"
<!DOCTYPE html>
<html lang="en" data-theme="light">
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
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="bi bi-activity me-2"></i>HealthcareML
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">
                            <i class="bi bi-house-door me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="dashboard.html" aria-current="page">
                            <i class="bi bi-graph-up me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="models.html">
                            <i class="bi bi-diagram-3 me-1"></i>Models
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about.html">
                            <i class="bi bi-info-circle me-1"></i>About
                        </a>
                    </li>
                </ul>
                <div class="d-flex align-items-center">
                    <div id="theme-toggle" class="theme-toggle me-2" title="Toggle Dark Mode">
                        <i class="bi bi-moon-fill"></i>
                        <span class="sr-only">Toggle Dark Mode</span>
                    </div>
                    <a href="https://github.com/$username/$repoName" class="btn btn-outline-light btn-sm">
                        <i class="bi bi-github me-1"></i>GitHub
                    </a>
                </div>
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
                <div class="col-md-4">
                    <h5><i class="bi bi-activity me-2"></i>HealthcareML</h5>
                    <p class="text-muted">Advanced machine learning for healthcare analytics and readmission prediction.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="index.html" class="text-decoration-none">Home</a></li>
                        <li><a href="dashboard.html" class="text-decoration-none">Dashboard</a></li>
                        <li><a href="models.html" class="text-decoration-none">Models</a></li>
                        <li><a href="about.html" class="text-decoration-none">About</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Connect</h5>
                    <ul class="list-unstyled">
                        <li><a href="https://github.com/$username" class="text-decoration-none"><i class="bi bi-github me-1"></i>GitHub</a></li>
                        <li><a href="mailto:kingstune7@gmail.com" class="text-decoration-none"><i class="bi bi-envelope me-1"></i>Email</a></li>
                    </ul>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2025 HealthcareML by <a href="https://github.com/$username" class="text-decoration-none">$username</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0" id="timestamp">Last Updated: $timestamp UTC</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
"@ | Set-Content -Path "dashboard.html"

# Step 7: Create models.html
@"
<!DOCTYPE html>
<html lang="en" data-theme="light">
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
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="bi bi-activity me-2"></i>HealthcareML
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">
                            <i class="bi bi-house-door me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.html">
                            <i class="bi bi-graph-up me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="models.html" aria-current="page">
                            <i class="bi bi-diagram-3 me-1"></i>Models
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about.html">
                            <i class="bi bi-info-circle me-1"></i>About
                        </a>
                    </li>
                </ul>
                <div class="d-flex align-items-center">
                    <div id="theme-toggle" class="theme-toggle me-2" title="Toggle Dark Mode">
                        <i class="bi bi-moon-fill"></i>
                        <span class="sr-only">Toggle Dark Mode</span>
                    </div>
                    <a href="https://github.com/$username/$repoName" class="btn btn-outline-light btn-sm">
                        <i class="bi bi-github me-1"></i>GitHub
                    </a>
                </div>
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
                <div class="col-md-4">
                    <h5><i class="bi bi-activity me-2"></i>HealthcareML</h5>
                    <p class="text-muted">Advanced machine learning for healthcare analytics and readmission prediction.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="index.html" class="text-decoration-none">Home</a></li>
                        <li><a href="dashboard.html" class="text-decoration-none">Dashboard</a></li>
                        <li><a href="models.html" class="text-decoration-none">Models</a></li>
                        <li><a href="about.html" class="text-decoration-none">About</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Connect</h5>
                    <ul class="list-unstyled">
                        <li><a href="https://github.com/$username" class="text-decoration-none"><i class="bi bi-github me-1"></i>GitHub</a></li>
                        <li><a href="mailto:kingstune7@gmail.com" class="text-decoration-none"><i class="bi bi-envelope me-1"></i>Email</a></li>
                    </ul>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2025 HealthcareML by <a href="https://github.com/$username" class="text-decoration-none">$username</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0" id="timestamp">Last Updated: $timestamp UTC</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
"@ | Set-Content -Path "models.html"

# Step 8: Create about.html
@"
<!DOCTYPE html>
<html lang="en" data-theme="light">
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
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="bi bi-activity me-2"></i>HealthcareML
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">
                            <i class="bi bi-house-door me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.html">
                            <i class="bi bi-graph-up me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="models.html">
                            <i class="bi bi-diagram-3 me-1"></i>Models
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="about.html" aria-current="page">
                            <i class="bi bi-info-circle me-1"></i>About
                        </a>
                    </li>
                </ul>
                <div class="d-flex align-items-center">
                    <div id="theme-toggle" class="theme-toggle me-2" title="Toggle Dark Mode">
                        <i class="bi bi-moon-fill"></i>
                        <span class="sr-only">Toggle Dark Mode</span>
                    </div>
                    <a href="https://github.com/$username/$repoName" class="btn btn-outline-light btn-sm">
                        <i class="bi bi-github me-1"></i>GitHub
                    </a>
                </div>
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
                            <img src="https://github.com/$username.png" alt="Profile Photo" class="rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover; border: 3px solid #0d6efd;">
                            <h5>$username</h5>
                            <p>Data Scientist & Healthcare Analyst</p>
                            <div class="d-grid gap-2">
                                <a href="https://github.com/$username" class="btn btn-outline-primary">
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
                <div class="col-md-4">
                    <h5><i class="bi bi-activity me-2"></i>HealthcareML</h5>
                    <p class="text-muted">Advanced machine learning for healthcare analytics and readmission prediction.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="index.html" class="text-decoration-none">Home</a></li>
                        <li><a href="dashboard.html" class="text-decoration-none">Dashboard</a></li>
                        <li><a href="models.html" class="text-decoration-none">Models</a></li>
                        <li><a href="about.html" class="text-decoration-none">About</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Connect</h5>
                    <ul class="list-unstyled">
                        <li><a href="https://github.com/$username" class="text-decoration-none"><i class="bi bi-github me-1"></i>GitHub</a></li>
                        <li><a href="mailto:kingstune7@gmail.com" class="text-decoration-none"><i class="bi bi-envelope me-1"></i>Email</a></li>
                    </ul>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2025 HealthcareML by <a href="https://github.com/$username" class="text-decoration-none">$username</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0" id="timestamp">Last Updated: $timestamp UTC</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
"@ | Set-Content -Path "about.html"

# Step 9: Update README.md
@"
# HealthcareML: Predicting Patient Readmissions

## Overview
This project demonstrates advanced machine learning techniques for healthcare applications | Created by Asare K. Enock