# HealthcareML GitHub Pages Update Script
# Author: asarekings
# Date: 2025-06-05 15:32:53

$ErrorActionPreference = "Stop"
$timestamp = "2025-06-05 15:32:53"
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
    --info-color: #0dcaf0;
    --transition-speed: 0.3s;
}

[data-theme="dark"] {
    --primary-color: #3d8bfd;
    --secondary-color: #959ca3;
    --bg-color: #121212;
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
    font-family: 'Segoe UI', Tahoma, sans-serif;
    line-height: 1.6;
    color: var(--text-color);
    background-color: var(--bg-color);
    transition: background-color var(--transition-speed), color var(--transition-speed);
}

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

.card-header.bg-primary {
    background-color: var(--primary-color) !important;
}

.navbar {
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
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

.slide-in {
    animation: slideIn 0.5s ease-out;
}

@keyframes slideIn {
    from { transform: translateY(20px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}

/* Progress bars */
.factor-bar {
    height: 0.5rem;
    border-radius: 1rem;
    margin-bottom: 0.5rem;
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

/* Comparison table styles */
.comparison-feature {
    font-weight: bold;
}

.comparison-check {
    color: var(--success-color);
    font-size: 1.2rem;
}

.comparison-x {
    color: var(--danger-color);
    font-size: 1.2rem;
}

/* Advanced features */
.chart-container {
    height: 300px;
    position: relative;
}

.loading-indicator {
    display: none;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.loading-indicator.active {
    display: block;
}

/* Footer */
footer {
    background-color: var(--header-bg) !important;
    color: var(--text-color);
    transition: background-color var(--transition-speed), color var(--transition-speed);
}
'@
Set-Content -Path "assets/css/style.css" -Value $cssContent

# Step 4: Create enhanced JavaScript file with prediction simulator
Write-Host "Creating JavaScript file with prediction functionality..." -ForegroundColor Yellow
$jsContent = @'
// HealthcareML Main JavaScript
document.addEventListener('DOMContentLoaded', function() {
    console.log('HealthcareML Application Initialized');
    
    // Initialize UI Components
    initThemeToggle();
    initNavigation();
    initPredictionForm();
    initCharts();
    
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

// Initialize Prediction Form
function initPredictionForm() {
    const form = document.getElementById('prediction-form');
    if (!form) return;
    
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Show loading state
        const submitBtn = form.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Calculating...';
        submitBtn.disabled = true;
        
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
        
        // Add a small delay to simulate API call
        setTimeout(function() {
            // Calculate readmission risk
            const risk = calculateReadmissionRisk(
                age, gender, prevAdmissions, lengthOfStay, 
                comorbidities, medications, emergencyVisits,
                diabetic, hypertension
            );
            
            // Display result
            displayRiskResult(risk);
            
            // Restore button state
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
        }, 800);
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
    
    // Add small random variation for realism
    const finalScore = Math.min(100, Math.max(0, score + (Math.random() * 6 - 3)));
    
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
        score: Math.round(finalScore),
        level: finalScore < 30 ? "Low" : finalScore < 60 ? "Medium" : "High",
        factors: factors,
        rawFactors: {
            age: age,
            gender: gender,
            prevAdmissions: prevAdmissions,
            lengthOfStay: lengthOfStay,
            comorbidities: comorbidities,
            medications: medications
        }
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
    
    // Display recommendations
    const recommendationsContainer = document.getElementById('recommendations');
    if (recommendationsContainer) {
        // Clear previous recommendations
        recommendationsContainer.innerHTML = '';
        
        // Generate personalized recommendations based on risk factors
        const recommendations = [];
        
        const rawFactors = risk.rawFactors;
        
        if (rawFactors.prevAdmissions > 2) {
            recommendations.push('Consider enhanced care coordination due to multiple previous admissions.');
        }
        
        if (rawFactors.lengthOfStay > 7) {
            recommendations.push('Extended hospital stays may benefit from specialized post-discharge follow-up.');
        }
        
        if (rawFactors.comorbidities > 3) {
            recommendations.push('Multiple comorbidities present - medication reconciliation and specialist coordination is recommended.');
        }
        
        if (rawFactors.medications > 8) {
            recommendations.push('Consider medication review to address potential polypharmacy issues.');
        }
        
        if (rawFactors.age > 75) {
            recommendations.push('Advanced age is a risk factor - consider geriatric assessment.');
        }
        
        // Add general recommendations based on risk level
        if (risk.level === "High") {
            recommendations.push('Schedule follow-up within 7 days of discharge.');
            recommendations.push('Consider telehealth monitoring for first 30 days.');
        } else if (risk.level === "Medium") {
            recommendations.push('Schedule follow-up within 14 days of discharge.');
        } else {
            recommendations.push('Routine follow-up per standard protocols.');
        }
        
        // Add recommendations to container
        if (recommendations.length > 0) {
            const ul = document.createElement('ul');
            ul.className = 'mb-0';
            
            recommendations.forEach(rec => {
                const li = document.createElement('li');
                li.textContent = rec;
                ul.appendChild(li);
            });
            
            recommendationsContainer.appendChild(ul);
        } else {
            recommendationsContainer.textContent = 'No specific recommendations available for this patient profile.';
        }
    }
    
    // Show the result with animation
    resultElement.style.display = 'block';
    resultElement.classList.add('fade-in');
}

// Initialize Charts
function initCharts() {
    // If Chart.js is loaded and we have charts to initialize
    if (typeof Chart !== 'undefined') {
        // Readmission rates by age group
        const ageChartEl = document.getElementById('ageChart');
        if (ageChartEl) {
            new Chart(ageChartEl, {
                type: 'bar',
                data: {
                    labels: ['18-30', '31-45', '46-60', '61-75', '76+'],
                    datasets: [{
                        label: 'Readmission Rate (%)',
                        data: [7.2, 11.5, 16.8, 22.3, 28.7],
                        backgroundColor: '#0d6efd'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        title: {
                            display: true,
                            text: 'Readmission Rates by Age Group'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Readmission Rate (%)'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Age Group'
                            }
                        }
                    }
                }
            });
        }
        
        // Model performance comparison
        const modelChartEl = document.getElementById('modelChart');
        if (modelChartEl) {
            new Chart(modelChartEl, {
                type: 'radar',
                data: {
                    labels: ['Accuracy', 'Precision', 'Recall', 'F1 Score', 'AUC-ROC'],
                    datasets: [{
                        label: 'XGBoost',
                        data: [0.852, 0.783, 0.721, 0.751, 0.880],
                        borderColor: 'rgba(32, 201, 151, 0.8)',
                        backgroundColor: 'rgba(32, 201, 151, 0.2)'
                    }, {
                        label: 'Random Forest',
                        data: [0.824, 0.759, 0.705, 0.731, 0.851],
                        borderColor: 'rgba(13, 110, 253, 0.8)',
                        backgroundColor: 'rgba(13, 110, 253, 0.2)'
                    }, {
                        label: 'Neural Network',
                        data: [0.841, 0.772, 0.711, 0.740, 0.863],
                        borderColor: 'rgba(102, 16, 242, 0.8)',
                        backgroundColor: 'rgba(102, 16, 242, 0.2)'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    elements: {
                        line: {
                            borderWidth: 2
                        }
                    },
                    scales: {
                        r: {
                            min: 0.7,
                            max: 0.9,
                            ticks: {
                                stepSize: 0.05
                            }
                        }
                    }
                }
            });
        }
        
        // Feature importance chart
        const featureChartEl = document.getElementById('featureChart');
        if (featureChartEl) {
            new Chart(featureChartEl, {
                type: 'horizontalBar',
                data: {
                    labels: ['Previous Admissions', 'Length of Stay', 'Age', 'Comorbidities', 'Medications', 'ER Visits', 'Diabetes', 'Hypertension'],
                    datasets: [{
                        label: 'Feature Importance',
                        data: [0.25, 0.20, 0.15, 0.15, 0.10, 0.05, 0.03, 0.02],
                        backgroundColor: [
                            '#20c997', '#ffc107', '#0d6efd', '#dc3545', 
                            '#6610f2', '#fd7e14', '#d63384', '#0dcaf0'
                        ]
                    }]
                },
                options: {
                    indexAxis: 'y',
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        title: {
                            display: true,
                            text: 'Feature Importance in Prediction Model'
                        }
                    },
                    scales: {
                        x: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Importance Score'
                            }
                        }
                    }
                }
            });
        }
    }
}

// Simulate batch predictions for demo purposes
function runBatchPrediction() {
    const resultsList = document.getElementById('batch-results');
    if (!resultsList) return;
    
    // Show loading state
    const loadingIndicator = document.querySelector('.loading-indicator');
    if (loadingIndicator) loadingIndicator.classList.add('active');
    
    // Clear previous results
    resultsList.innerHTML = '';
    
    // Simulate processing delay
    setTimeout(function() {
        // Generate 5 sample predictions
        const patients = [
            { id: 'P1001', age: 72, gender: 'male', prevAdmissions: 3, lengthOfStay: 9, comorbidities: 4, medications: 8 },
            { id: 'P1002', age: 45, gender: 'female', prevAdmissions: 0, lengthOfStay: 3, comorbidities: 1, medications: 2 },
            { id: 'P1003', age: 65, gender: 'male', prevAdmissions: 1, lengthOfStay: 5, comorbidities: 2, medications: 5 },
            { id: 'P1004', age: 83, gender: 'female', prevAdmissions: 2, lengthOfStay: 12, comorbidities: 5, medications: 10 },
            { id: 'P1005', age: 55, gender: 'male', prevAdmissions: 1, lengthOfStay: 4, comorbidities: 3, medications: 6 }
        ];
        
        // Process each patient
        patients.forEach(patient => {
            // Calculate risk
            const risk = calculateReadmissionRisk(
                patient.age, 
                patient.gender, 
                patient.prevAdmissions, 
                patient.lengthOfStay, 
                patient.comorbidities, 
                patient.medications, 
                0, // ER visits
                false, // diabetic
                false // hypertension
            );
            
            // Create result row
            const row = document.createElement('tr');
            
            // Determine risk badge class
            let badgeClass = 'bg-success';
            if (risk.level === 'Medium') badgeClass = 'bg-warning';
            if (risk.level === 'High') badgeClass = 'bg-danger';
            
            row.innerHTML = `
                <td>${patient.id}</td>
                <td>${patient.age}</td>
                <td>${patient.prevAdmissions}</td>
                <td>${patient.lengthOfStay}</td>
                <td>${patient.comorbidities}</td>
                <td>${risk.score}%</td>
                <td><span class="badge ${badgeClass}">${risk.level}</span></td>
            `;
            
            resultsList.appendChild(row);
        });
        
        // Hide loading indicator
        if (loadingIndicator) loadingIndicator.classList.remove('active');
    }, 1500);
}
'@
Set-Content -Path "assets/js/main.js" -Value $jsContent

# Step 5: Create index.html
Write-Host "Creating index.html..." -ForegroundColor Yellow
$indexHtml = @'
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
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                        <a class="nav-link" href="simulator.html">
                            <i class="bi bi-play-fill me-1"></i>Test Model
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
                    <a href="https://github.com/asarekings/HealthcareML-" class="btn btn-outline-light btn-sm">
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
                    <h5 class="card-title mb-0">Key Risk Factors</h5>
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
                            <h5 class="card-title mb-0">Patient Demographics</h5>
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
                            <h5 class="card-title mb-0">Model Performance</h5>
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
                <a href="simulator.html" class="btn btn-primary btn-lg px-4">
                    <i class="bi bi-play-fill me-2"></i>Test the Model with Your Data
                </a>
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
                        <li><a href="simulator.html" class="text-decoration-none">Test Model</a></li>
                        <li><a href="models.html" class="text-decoration-none">Models</a></li>
                        <li><a href="about.html" class="text-decoration-none">About</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Connect</h5>
                    <ul class="list-unstyled">
                        <li><a href="https://github.com/asarekings" class="text-decoration-none"><i class="bi bi-github me-1"></i>GitHub</a></li>
                        <li><a href="mailto:kingstune7@gmail.com" class="text-decoration-none"><i class="bi bi-envelope me-1"></i>Email</a></li>
                    </ul>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2025 HealthcareML by <a href="https://github.com/asarekings" class="text-decoration-none">asarekings</a></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0" id="timestamp">Last Updated: 2025-06-05 15:49:27</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>