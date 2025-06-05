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
