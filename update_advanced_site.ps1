# HealthcareML Advanced GitHub Pages Update Script
# Author: asarekings
# Date: 2025-06-05 14:11:46

$ErrorActionPreference = "Stop"
$timestamp = "2025-06-05 14:11:46"
$username = "asarekings"
$repoName = "HealthcareML-"

Write-Host "HealthcareML Advanced GitHub Pages Updater" -ForegroundColor Cyan
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
    "assets/data",
    "assets/fonts",
    "assets/vendor"
)

foreach ($dir in $directories) {
    if (-not (Test-Path -Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
        Write-Host "Created directory: $dir" -ForegroundColor Green
    }
}

# Step 3: Download required libraries (Bootstrap, Chart.js)
Write-Host "Downloading external libraries..." -ForegroundColor Yellow

# Create vendor directory for libraries
$chartJsUrl = "https://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js"
$chartJsFile = "assets/vendor/chart.min.js"
Invoke-WebRequest -Uri $chartJsUrl -OutFile $chartJsFile

# Step 4: Create main CSS with dark mode support
@"
<your big CSS as before>
"@ | Set-Content -Path "assets/css/style.css"

# Step 5: Create main JavaScript with advanced functionality
@'
document.addEventListener('DOMContentLoaded', function() {
    console.log('HealthcareML Application Initialized');
    
    // Initialize UI Components
    initThemeToggle();
    initNavigation();
    initRiskCalculator();
    initCharts();
    initPatientSimulator();
    addCurrentYearToCopyright();
    
    // Show page with fade-in effect
    document.body.classList.add('fade-in');
    
    // Hide loader if present
    const loader = document.getElementById('page-loader');
    if (loader) {
        setTimeout(() => {
            loader.style.display = 'none';
        }, 500);
    }
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
    
    navLinks.forEach(link => {
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

// Initialize Charts
function initCharts() {
    // ... your chart code as before ...
}

// Patient Simulator
function initPatientSimulator() {
    const generateButton = document.getElementById('generate-patient');
    if (!generateButton) return;
    
    generateButton.addEventListener('click', function() {
        const patientContainer = document.getElementById('patient-simulator-results');
        if (!patientContainer) return;
        
        // Sample patient data
        const patients = [
            {
                name: "John Smith",
                age: 72,
                gender: "Male",
                admissions: 3,
                los: 8,
                comorbidities: ["Hypertension", "Diabetes", "COPD"],
                risk: "high"
            },
            {
                name: "Emma Johnson",
                age: 45,
                gender: "Female",
                admissions: 1,
                los: 4,
                comorbidities: ["Asthma"],
                risk: "low"
            },
            {
                name: "Robert Davis",
                age: 67,
                gender: "Male",
                admissions: 2,
                los: 6,
                comorbidities: ["Hypertension", "Coronary Artery Disease"],
                risk: "medium"
            },
            {
                name: "Maria Garcia",
                age: 58,
                gender: "Female",
                admissions: 2,
                los: 7,
                comorbidities: ["Diabetes", "Obesity"],
                risk: "medium"
            },
            {
                name: "James Wilson",
                age: 82,
                gender: "Male",
                admissions: 4,
                los: 12,
                comorbidities: ["Heart Failure", "CKD", "Dementia"],
                risk: "high"
            }
        ];
        
        // Randomly select a patient
        const randomIndex = Math.floor(Math.random() * patients.length);
        const patient = patients[randomIndex];
        
        // Create patient card
        const patientCard = document.createElement('div');
        patientCard.className = 'card patient-card slide-in';
        
        let riskBadgeClass = '';
        switch(patient.risk) {
            case 'low': riskBadgeClass = 'risk-badge-low'; break;
            case 'medium': riskBadgeClass = 'risk-badge-medium'; break;
            case 'high': riskBadgeClass = 'risk-badge-high'; break;
        }
        
        // Gender-based avatar
        const avatarSrc = patient.gender === "Male" ? 
            "https://randomuser.me/api/portraits/men/" + (randomIndex * 5) + ".jpg" : 
            "https://randomuser.me/api/portraits/women/" + (randomIndex * 5) + ".jpg";
        
        patientCard.innerHTML = `
            <div class="card-body">
                <div class="patient-header">
                    <img src="${avatarSrc}" alt="${patient.name}" class="patient-avatar">
                    <div class="patient-info">
                        <h5 class="patient-name">${patient.name}</h5>
                        <div class="patient-details">${patient.age} years, ${patient.gender}</div>
                    </div>
                    <span class="patient-risk ${riskBadgeClass}">${patient.risk.toUpperCase()} RISK</span>
                </div>
                <hr>
                <div class="row mt-3">
                    <div class="col-md-6">
                        <p><strong>Previous Admissions:</strong> ${patient.admissions}</p>
                        <p><strong>Length of Stay:</strong> ${patient.los} days</p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Comorbidities:</strong></p>
                        <ul>
                            ${patient.comorbidities.map(c => `<li>${c}</li>`).join('')}
                        </ul>
                    </div>
                </div>
                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
                    <button class="btn btn-outline-primary btn-sm">View Details</button>
                    <button class="btn btn-primary btn-sm">Run Prediction</button>
                </div>
            </div>
        `;
        
        // Clear previous results and add new patient card
        patientContainer.innerHTML = '';
        patientContainer.appendChild(patientCard);
    });
}

// Add current year to copyright
function addCurrentYearToCopyright() {
    const currentYear = new Date().getFullYear();
    const copyrightElements = document.querySelectorAll('footer p:first-child');
    copyrightElements.forEach(el => {
        el.innerHTML = el.innerHTML.replace('2025', currentYear);
    });
}
'@ | Set-Content -Path "assets/js/main.js"

# Step 6: Create Service Worker for PWA capabilities
@'
<your service worker code as before>
'@ | Set-Content -Path "service-worker.js"

# Step 7: Create Web Manifest for PWA
@'
<your manifest.json as before>
'@ | Set-Content -Path "manifest.json"

# Step 8+: HTML generation unchanged, except make sure to use single-quoted here-strings for all HTML/JS blocks containing `${...}`.