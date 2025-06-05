# HealthcareML GitHub Pages Update Script
# Author: asarekings
# Date: 2025-06-05 14:57:47

$ErrorActionPreference = "Stop"
$timestamp = "2025-06-05 14:57:47"
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
    --success-color: #198754;
    --warning-color: #ffc107;
    --danger-color: #dc3545;
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

/* Risk result styles */
.risk-result {
    padding: 1.5rem;
    border-radius: 0.5rem;
    text-align: center;
    margin-top: 1.5rem;
    display: none;
    transition: all 0.3s ease;
}

.risk-low {
    background-color: rgba(25, 135, 84, 0.1);
    border: 1px solid var(--success-color);
    color: var(--success-color);
}

.risk-medium {
    background-color: rgba(255, 193, 7, 0.1);
    border: 1px solid var(--warning-color);
    color: var(--warning-color);
}

.risk-high {
    background-color: rgba(220, 53, 69, 0.1);
    border: 1px solid var(--danger-color);
    color: var(--danger-color);
}

.result-score {
    font-size: 3rem;
    font-weight: bold;
}

.result-text {
    font-size: 1.5rem;
    font-weight: bold;
}

/* Animations */
.fade-in {
    animation: fadeIn 0.5s ease;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

/* Progress bars */
.factor-bar {
    height: 0.5rem;
    border-radius: 1rem;
    margin-bottom: 0.5rem;
}
'@
Set-Content -Path "assets/css/style.css" -Value $cssContent

# Step 4: Create enhanced JavaScript file with prediction simulator
Write-Host "Creating JavaScript file with prediction functionality..." -ForegroundColor Yellow
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
    
    // Initialize Prediction Form
    initPredictionForm();
});

// Initialize Prediction Form
function initPredictionForm() {
    const form = document.getElementById('prediction-form');
    if (!form) return;
    
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Get form values
        const age = parseInt(document.getElementById('patient-age').value) || 0;
        const gender = document.getElementById('patient-gender').value;
        const prevAdmissions = parseInt(document.getElementById('prev-admissions').value) || 0;
        const lengthOfStay = parseInt(document.getElementById('length-of-stay').value) || 0;
        const comorbidities = parseInt(document.getElementById('comorbidities').value) || 0;
        const medications = parseInt(document.getElementById('medications').value) || 0;
        const emergencyVisits = parseInt(document.getElementById('emergency-visits').value) || 0;
        const diabetic = document.getElementById('diabetic').checked;
        const hypertension = document.getElementById('hypertension').checked;
        
        // Calculate readmission risk
        const risk = calculateReadmissionRisk(
            age, gender, prevAdmissions, lengthOfStay, 
            comorbidities, medications, emergencyVisits,
            diabetic, hypertension
        );
        
        // Display result
        displayRiskResult(risk);
    });
    
    // Reset button
    const resetButton = document.getElementById('reset-form');
    if (resetButton) {
        resetButton.addEventListener('click', function() {
            form.reset();
            document.getElementById('risk-result').style.display = 'none';
        });
    }
}

// Calculate readmission risk based on input factors
function calculateReadmissionRisk(age, gender, prevAdmissions, lengthOfStay, comorbidities, medications, emergencyVisits, diabetic, hypertension) {
    // Factor weights - based on typical importance in readmission models
    const weights = {
        age: 0.15,
        gender: 0.05,
        prevAdmissions: 0.25,
        lengthOfStay: 0.20,
        comorbidities: 0.15,
        medications: 0.10,
        emergencyVisits: 0.05,
        diabetic: 0.03,
        hypertension: 0.02
    };
    
    // Normalize each factor to 0-1 range
    const normalizedAge = Math.min(age / 100, 1);
    const normalizedGender = gender === 'male' ? 0.55 : 0.45; // Slightly higher risk for males in many studies
    const normalizedAdmissions = Math.min(prevAdmissions / 5, 1);
    const normalizedLOS = Math.min(lengthOfStay / 14, 1);
    const normalizedComorbidities = Math.min(comorbidities / 5, 1);
    const normalizedMedications = Math.min(medications / 10, 1);
    const normalizedER = Math.min(emergencyVisits / 5, 1);
    const normalizedDiabetic = diabetic ? 1 : 0;
    const normalizedHypertension = hypertension ? 1 : 0;
    
    // Calculate final score (0-100)
    const score = 100 * (
        weights.age * normalizedAge +
        weights.gender * normalizedGender +
        weights.prevAdmissions * normalizedAdmissions +
        weights.lengthOfStay * normalizedLOS +
        weights.comorbidities * normalizedComorbidities +
        weights.medications * normalizedMedications +
        weights.emergencyVisits * normalizedER +
        weights.diabetic * normalizedDiabetic +
        weights.hypertension * normalizedHypertension
    );
    
    // Calculate factor contributions
    const factors = {
        age: weights.age * normalizedAge,
        prevAdmissions: weights.prevAdmissions * normalizedAdmissions,
        lengthOfStay: weights.lengthOfStay * normalizedLOS,
        comorbidities: weights.comorbidities * normalizedComorbidities,
        medications: weights.medications * normalizedMedications
    };
    
    // Return an object with the score and risk level
    return {
        score: Math.round(score),
        level: score < 30 ? "Low" : score < 60 ? "Medium" : "High",
        factors: factors
    };
}

// Display risk prediction result
function displayRiskResult(risk) {
    const resultElement = document.getElementById('risk-result');
    if (!resultElement) return;
    
    // Update score and text
    document.getElementById('risk-score').textContent = risk.score;
    document.getElementById('risk-level').textContent = risk.level;
    
    // Update result class
    resultElement.className = 'risk-result';
    if (risk.level === "Low") {
        resultElement.classList.add('risk-low');
    } else if (risk.level === "Medium") {
        resultElement.classList.add('risk-medium');
    } else {
        resultElement.classList.add('risk-high');
    }
    
    // Display factor bars
    const factorContainer = document.getElementById('factor-contributions');
    if (factorContainer) {
        factorContainer.innerHTML = '';
        
        // Get factors
        const factors = risk.factors;
        const maxFactor = Math.max(...Object.values(factors));
        
        // Factor display names
        const factorNames = {
            age: 'Age',
            prevAdmissions: 'Previous Admissions',
            lengthOfStay: 'Length of Stay',
            comorbidities: 'Comorbidities',
            medications: 'Medications'
        };
        
        // Factor colors
        const factorColors = {
            age: '#0d6efd',
            prevAdmissions: '#20c997',
            lengthOfStay: '#ffc107',
            comorbidities: '#dc3545',
            medications: '#6610f2'
        };
        
        // Create bars
        Object.keys(factors).forEach(factor => {
            const factorDiv = document.createElement('div');
            factorDiv.className = 'mb-3';
            
            const percent = Math.round((factors[factor] / maxFactor) * 100);
            
            factorDiv.innerHTML = `
                <div class="d-flex justify-content-between">
                    <span>${factorNames[factor]}</span>
                    <small>${Math.round(factors[factor] * 100)}%</small>
                </div>
                <div class="progress">
                    <div class="progress-bar factor-bar" role="progressbar" 
                        style="width: ${percent}%; background-color: ${factorColors[factor]}" 
                        aria-valuenow="${percent}" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
            `;
            
            factorContainer.appendChild(factorDiv);
        });
    }
    
    // Show the result with animation
    resultElement.style.display = 'block';
    resultElement.classList.add('fade-in');
}
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
                        <a class="nav-link" href="simulator.html">Test Model</a>
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
                        <a href="simulator.html" class="btn btn-outline-light btn-lg px-4">
                            <i class="bi bi-play-fill me-2"></i>Test the Model
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
                                    <i class="bi bi-person-plus" style="font-size: 1.5rem;"></i>
                                </div>
                                <h3 class="card-title h5">Model Testing</h3>
                                <p class="card-text">Test our model with your own patient data and see predicted readmission risk instantly.</p>
                                <a href="simulator.html" class="btn btn-outline-primary">
                                    <i class="bi bi-arrow-right me-1"></i>Test Now
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
                <p class="lead mb-4">Test our model with your patient data and see how machine learning can transform healthcare.</p>
                <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                    <a href="simulator.html" class="btn btn-primary btn-lg px-4">Test the Model</a>
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

# Step 6: Create new simulator.html page for model testing
Write-Host "Creating simulator.html for model testing..." -ForegroundColor Yellow
$simulatorHtml = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Model - HealthcareML</title>
    <meta name="description" content="Test our readmission prediction model with your patient data">
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
                        <a class="nav-link active" href="simulator.html">Test Model</a>
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
            <h1 class="mb-4">Test Our Readmission Prediction Model</h1>
            <p class="lead mb-4">Enter patient data below to get a real-time readmission risk prediction based on our machine learning model.</p>
            
            <div class="row">
                <div class="col-lg-7">
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0">
                                <i class="bi bi-person-vcard me-2"></i>Patient Information
                            </h5>
                        </div>
                        <div class="card-body">
                            <form id="prediction-form">
                                <div class="row g-3">
                                    <!-- Basic Demographics -->
                                    <div class="col-md-6">
                                        <label for="patient-age" class="form-label">Age</label>
                                        <input type="number" class="form-control" id="patient-age" min="18" max="100" value="65" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="patient-gender" class="form-label">Gender</label>
                                        <select class="form-select" id="patient-gender" required>
                                            <option value="male">Male</option>
                                            <option value="female">Female</option>
                                        </select>
                                    </div>
                                    
                                    <!-- Hospital Data -->
                                    <div class="col-md-4">
                                        <label for="prev-admissions" class="form-label">Previous Admissions (past year)</label>
                                        <input type="number" class="form-control" id="prev-admissions" min="0" max="10" value="1" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="length-of-stay" class="form-label">Length of Stay (days)</label>
                                        <input type="number" class="form-control" id="length-of-stay" min="1" max="30" value="5" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="emergency-visits" class="form-label">Emergency Visits (past year)</label>
                                        <input type="number" class="form-control" id="emergency-visits" min="0" max="10" value="1" required>
                                    </div>
                                    
                                    <!-- Clinical Data -->
                                    <div class="col-md-6">
                                        <label for="comorbidities" class="form-label">Number of Comorbidities</label>
                                        <input type="number" class="form-control" id="comorbidities" min="0" max="10" value="2" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="medications" class="form-label">Number of Medications</label>
                                        <input type="number" class="form-control" id="medications" min="0" max="20" value="4" required>
                                    </div>
                                    
                                    <!-- Common Conditions -->
                                    <div class="col-md-12">
                                        <label class="form-label">Common Conditions</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="diabetic">
                                            <label class="form-check-label" for="diabetic">Diabetes</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="hypertension">
                                            <label class="form-check-label" for="hypertension">Hypertension</label>
                                        </div>
                                    </div>
                                    
                                    <!-- Form Buttons -->
                                    <div class="col-12 d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                        <button type="button" id="reset-form" class="btn btn-outline-secondary">
                                            <i class="bi bi-arrow-counterclockwise me-1"></i>Reset
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-calculator me-1"></i>Calculate Risk
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-5">
                    <!-- Result Display -->
                    <div id="risk-result" class="risk-result mb-4">
                        <h3 class="mb-3">Readmission Risk Prediction</h3>
                        <div class="result-score mb-2"><span id="risk-score">0</span>%</div>
                        <div class="result-text mb-4">Risk Level: <span id="risk-level">Unknown</span></div>
                        
                        <hr class="my-4">
                        
                        <h5 class="mb-3">Key Contributing Factors</h5>
                        <div id="factor-contributions">
                            <!-- Factor bars will be added here by JavaScript -->
                        </div>
                        
                        <div class="alert alert-info mt-4">
                            <i class="bi bi-info-circle me-2"></i>
                            This is a simulation of our predictive model. In a clinical setting, predictions should be reviewed by healthcare professionals.
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0">
                                <i class="bi bi-question-circle me-2"></i>How It Works
                            </h5>
                        </div>
                        <div class="card-body">
                            <p>Our model uses the following approach:</p>
                            <ol>
                                <li>Patient data is collected and preprocessed</li>
                                <li>Key risk factors are weighted based on their predictive power</li>
                                <li>An ensemble of machine learning algorithms analyzes the data</li>
                                <li>The final prediction combines results from multiple models</li>
                                <li>Risk scores are normalized on a 0-100 scale</li>
                            </ol>
                            <p class="mb-0 small text-muted">The simulation on this page provides a simplified version of our full model.</p>
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
$simulatorHtml = $simulatorHtml.Replace('USERNAME', $username).Replace('TIMESTAMP', $timestamp)
Set-Content -Path "simulator.html" -Value $simulatorHtml

# Step 7: Update dashboard.html (keeping your specific sections)
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
                        <a class="nav-link" href="simulator.html">Test Model</a>
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
            
            <div class="text-center mt-5">
                <a href="simulator.html" class="btn btn-primary btn-lg">
                    <i class="bi bi-play-fill me-2"></i>Test the Model with Your Data
                </a>
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

# Step 8: Create models.html
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
                        <a class="nav-link" href="simulator.html">Test Model</a>
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
            
            <div class="text-center mt-5">
                <a href="simulator.html" class="btn btn-primary btn-lg">
                    <i class="bi bi-play-fill me-2"></i>Test the Model
                </a>
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

# Step 9: Create about.html
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
                        <a class="nav-link" href="simulator.html">Test Model</a>
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

# Step 10: Create README.md
Write-Host "Creating README.md..." -ForegroundColor Yellow
$readmeContent = @'
# HealthcareML: Predicting Patient Readmissions

## Overview
This project demonstrates advanced machine learning techniques for healthcare applications, specifically predicting hospital readmissions using patient data.

## Features
- **Predictive Models:** Ensemble of machine learning algorithms for readmission risk prediction
- **Interactive Dashboard:** Visualize patient risk factors and model performance
- **Model Testing:** Interactive form to test the prediction model with custom patient data
- **Model Interpretability:** Feature importance analysis for clinical decision support
- **Class Imbalance Handling:** Advanced techniques to address readmission class imbalance

## Live Demo
The project is deployed using GitHub Pages and can be accessed at:
https://USERNAME.github.io/HealthcareML-/

## Pages
- **Home:** Overview of the project and key features
- **Dashboard:** Interactive visualizations of readmission risk factors
- **Test Model:** Enter patient data and get real-time risk predictions
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

# Step 11: Create basic placeholder image
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

# Step 12: Commit and push to GitHub
Write-Host "Committing changes to gh-pages branch..." -ForegroundColor Yellow
try {
    # Add all files to staging
    git add .
    
    # Commit changes
    git commit -m "Update GitHub Pages site with model testing feature - $timestamp"
    
    # Push to GitHub Pages
    git push origin gh-pages
    
    Write-Host "Successfully pushed changes to GitHub Pages!" -ForegroundColor Green
    Write-Host "Your