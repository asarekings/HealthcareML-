# HealthcareML GitHub Pages Update Script
# Author: asarekings
# Date: 2025-06-05 15:22:28

$ErrorActionPreference = "Stop"
$timestamp = "2025-06-05 17:55:27"
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