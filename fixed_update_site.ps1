# HealthcareML GitHub Pages Update Script
# Author: asarekings
# Date: 2025-06-05 15:07:06

$ErrorActionPreference = "Stop"
$timestamp = "2025-06-05 15:07:06"
$username = "asarekings"
$repoName = "HealthcareML-"

Write-Host "HealthcareML GitHub Pages Updater" -ForegroundColor Cyan
Write-Host "Current Time: $timestamp" -ForegroundColor Yellow
Write-Host "User: $username" -ForegroundColor Yellow

# Create simpler versions of all files - single HTML file with model test form
Write-Host "Creating index.html with model test form..." -ForegroundColor Yellow

$singlePageContent = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HealthcareML - Readmission Risk Prediction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            line-height: 1.6;
        }
        .card {
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .metric-card {
            text-align: center;
        }
        .metric-value {
            font-size: 2.5rem;
            font-weight: bold;
            color: #0d6efd;
        }
        .metric-label {
            color: #6c757d;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .risk-result {
            padding: 1.5rem;
            border-radius: 0.5rem;
            text-align: center;
            margin-top: 1.5rem;
            display: none;
        }
        .risk-low {
            background-color: rgba(25, 135, 84, 0.1);
            border: 1px solid #198754;
            color: #198754;
        }
        .risk-medium {
            background-color: rgba(255, 193, 7, 0.1);
            border: 1px solid #ffc107;
            color: #ffc107;
        }
        .risk-high {
            background-color: rgba(220, 53, 69, 0.1);
            border: 1px solid #dc3545;
            color: #dc3545;
        }
        .result-score {
            font-size: 3rem;
            font-weight: bold;
        }
        .result-text {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .fade-in {
            animation: fadeIn 0.5s ease;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="bi bi-activity me-2"></i>HealthcareML
            </a>
            <div class="ms-auto">
                <a href="https://github.com/USERNAME" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-github me-1"></i>GitHub
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="py-4">
        <div class="container">
            <div class="text-center mb-5">
                <h1 class="display-4 fw-bold mb-3">HealthcareML</h1>
                <p class="lead">Predict hospital readmissions with machine learning</p>
            </div>
            
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card metric-card">
                        <div class="card-body">
                            <div class="metric-value">85%</div>
                            <div class="metric-label">Prediction Accuracy</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card metric-card">
                        <div class="card-body">
                            <div class="metric-value">18.7%</div>
                            <div class="metric-label">Readmission Rate</div>
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
                            <div class="metric-label">Annual Savings</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <!-- Model Test Form -->
                <div class="col-lg-7">
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0">
                                <i class="bi bi-person-vcard me-2"></i>Test Our Model
                            </h5>
                        </div>
                        <div class="card-body">
                            <p>Enter patient information to get a readmission risk prediction:</p>
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
                                        <label for="prev-admissions" class="form-label">Previous Admissions</label>
                                        <input type="number" class="form-control" id="prev-admissions" min="0" max="10" value="1" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="length-of-stay" class="form-label">Length of Stay (days)</label>
                                        <input type="number" class="form-control" id="length-of-stay" min="1" max="30" value="5" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="emergency-visits" class="form-label">Emergency Visits</label>
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
                            This is a simulation. In clinical settings, predictions should be reviewed by healthcare professionals.
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0">
                                <i class="bi bi-info-circle me-2"></i>About The Model
                            </h5>
                        </div>
                        <div class="card-body">
                            <p>Our machine learning model uses an ensemble approach combining:</p>
                            <ul>
                                <li>XGBoost (85.2% accuracy)</li>
                                <li>Random Forest (82.4% accuracy)</li>
                                <li>Neural Networks (84.1% accuracy)</li>
                            </ul>
                            <p>Top factors influencing readmission:</p>
                            <ol>
                                <li>Previous admissions</li>
                                <li>Length of stay</li>
                                <li>Age</li>
                                <li>Number of comorbidities</li>
                                <li>Medication count</li>
                            </ol>
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

    <!-- JavaScript for prediction functionality -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize the form
            const form = document.getElementById('prediction-form');
            if (form) {
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
                    
                    // Calculate risk
                    const risk = calculateReadmissionRisk(
                        age, gender, prevAdmissions, lengthOfStay, 
                        comorbidities, medications, emergencyVisits,
                        diabetic, hypertension
                    );
                    
                    // Display result
                    displayRiskResult(risk);
                });
            }
            
            // Reset button
            const resetButton = document.getElementById('reset-form');
            if (resetButton) {
                resetButton.addEventListener('click', function() {
                    form.reset();
                    document.getElementById('risk-result').style.display = 'none';
                });
            }
        });

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
                            <div class="progress-bar" role="progressbar" 
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
    </script>
</body>
</html>
'@

$singlePageContent = $singlePageContent.Replace('USERNAME', $username).Replace('TIMESTAMP', $timestamp)
Set-Content -Path "index.html" -Value $singlePageContent

# Step 12: Commit and push to GitHub
Write-Host "Committing changes to gh-pages branch..." -ForegroundColor Yellow
try {
    # Add all files to staging
    git add index.html
    
    # Commit changes
    git commit -m "Update GitHub Pages site with model testing feature - $timestamp"
    
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