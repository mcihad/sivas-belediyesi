/**
 * Mobile Optimization for Keycloak Login Theme
 * Handles keyboard viewport adjustments and responsive behavior
 */

document.addEventListener('DOMContentLoaded', function () {
    // Handle input focus to avoid keyboard hiding buttons
    const inputs = document.querySelectorAll('input, textarea, select');

    inputs.forEach(input => {
        input.addEventListener('focus', function () {
            // Ensure the focused element scrolls into view
            setTimeout(() => {
                this.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }, 300);
        });
    });

    // Handle viewport height changes (keyboard show/hide)
    let lastWindowHeight = window.innerHeight;

    window.addEventListener('resize', function () {
        const currentHeight = window.innerHeight;
        const heightDifference = lastWindowHeight - currentHeight;

        // Keyboard is opening
        if (heightDifference > 50) {
            document.body.style.overflow = 'hidden';
        }
        // Keyboard is closing
        else if (heightDifference < -50) {
            document.body.style.overflow = 'auto';
        }

        lastWindowHeight = currentHeight;
    });

    // Prevent 100vh issues on mobile
    const appBar = document.querySelector('.card-header') || document.querySelector('.card > div:first-child');
    const cardBody = document.querySelector('.card-body');
    const cardFooter = document.querySelector('.card-footer');

    if (appBar && cardBody && cardFooter) {
        const calculateHeights = () => {
            const headerHeight = appBar.offsetHeight;
            const footerHeight = cardFooter.offsetHeight;
            const availableHeight = window.innerHeight - headerHeight - footerHeight;

            cardBody.style.maxHeight = availableHeight + 'px';
        };

        calculateHeights();
        window.addEventListener('resize', calculateHeights);
        window.addEventListener('orientationchange', calculateHeights);
    }

    // Handle form submission with loading state
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function () {
            const submitButton = this.querySelector('button[type="submit"]');
            if (submitButton) {
                submitButton.disabled = true;
                submitButton.textContent = 'Yükleniyor...';
            }
        });
    });
});
