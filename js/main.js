// AI Tools Library | Smart Efficiency Guide - Main JavaScript

document.addEventListener('DOMContentLoaded', function() {
    console.log('AI Tools Library website loaded');
    
    // Initialize Google Ads
    initializeGoogleAds();
    
    // Initialize search functionality
    initializeSearch();
    
    // Initialize tool filters
    initializeFilters();
    
    // Initialize language selector
    initializeLanguageSelector();
    
    // Initialize mobile menu
    initializeMobileMenu();
    
    // Initialize tool ratings
    initializeRatings();
    
    // Initialize analytics
    initializeAnalytics();
});

// Google Ads Initialization
function initializeGoogleAds() {
    console.log('Initializing Google Ads');
    
    // Check if adsbygoogle is loaded
    if (typeof adsbygoogle !== 'undefined') {
        (adsbygoogle = window.adsbygoogle || []).push({});
        console.log('Google Ads initialized successfully');
    } else {
        console.warn('Google Ads script not loaded');
        
        // Retry after 2 seconds
        setTimeout(() => {
            if (typeof adsbygoogle !== 'undefined') {
                (adsbygoogle = window.adsbygoogle || []).push({});
                console.log('Google Ads initialized on retry');
            }
        }, 2000);
    }
}

// Search Functionality
function initializeSearch() {
    const searchInput = document.querySelector('.search-input');
    const searchButton = document.querySelector('.search-button');
    
    if (!searchInput || !searchButton) return;
    
    // Search on button click
    searchButton.addEventListener('click', performSearch);
    
    // Search on Enter key
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            performSearch();
        }
    });
    
    function performSearch() {
        const query = searchInput.value.trim();
        if (query) {
            console.log('Searching for:', query);
            
            // Show loading state
            searchButton.textContent = 'Searching...';
            searchButton.disabled = true;
            
            // Simulate API call
            setTimeout(() => {
                // In production, this would be an actual API call
                const results = simulateSearch(query);
                displaySearchResults(results);
                
                // Reset button
                searchButton.textContent = 'Search';
                searchButton.disabled = false;
            }, 500);
        }
    }
    
    function simulateSearch(query) {
        // Mock search results
        return [
            {
                id: 1,
                name: 'ChatGPT',
                category: 'Text & Writing',
                rating: 4.8,
                description: 'Advanced AI writing assistant',
                url: '#'
            },
            {
                id: 2,
                name: 'Midjourney',
                category: 'Image & Design',
                rating: 4.6,
                description: 'AI image generation tool',
                url: '#'
            },
            {
                id: 3,
                name: 'GitHub Copilot',
                category: 'Code & Development',
                rating: 4.7,
                description: 'AI pair programmer',
                url: '#'
            }
        ];
    }
    
    function displaySearchResults(results) {
        // Create results container
        let resultsContainer = document.querySelector('.search-results');
        if (!resultsContainer) {
            resultsContainer = document.createElement('div');
            resultsContainer.className = 'search-results';
            searchInput.parentNode.appendChild(resultsContainer);
        }
        
        // Clear previous results
        resultsContainer.innerHTML = '';
        
        if (results.length === 0) {
            resultsContainer.innerHTML = '<p class="no-results">No tools found. Try different keywords.</p>';
            return;
        }
        
        // Create results list
        const resultsList = document.createElement('ul');
        resultsList.className = 'results-list';
        
        results.forEach(result => {
            const listItem = document.createElement('li');
            listItem.className = 'result-item';
            listItem.innerHTML = `
                <a href="${result.url}" class="result-link">
                    <strong>${result.name}</strong>
                    <span class="result-category">${result.category}</span>
                    <span class="result-rating">⭐ ${result.rating}/5</span>
                    <p class="result-description">${result.description}</p>
                </a>
            `;
            resultsList.appendChild(listItem);
        });
        
        resultsContainer.appendChild(resultsList);
        
        // Add styles
        const style = document.createElement('style');
        style.textContent = `
            .search-results {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background: white;
                border: 1px solid #e5e7eb;
                border-radius: 0.5rem;
                margin-top: 0.5rem;
                box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1);
                z-index: 1000;
                max-height: 400px;
                overflow-y: auto;
            }
            .results-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .result-item {
                border-bottom: 1px solid #f3f4f6;
            }
            .result-item:last-child {
                border-bottom: none;
            }
            .result-link {
                display: block;
                padding: 1rem;
                color: #1f2937;
                text-decoration: none;
                transition: background-color 0.2s;
            }
            .result-link:hover {
                background-color: #f9fafb;
            }
            .result-category {
                display: inline-block;
                background: #f3f4f6;
                color: #6b7280;
                padding: 0.25rem 0.5rem;
                border-radius: 0.25rem;
                font-size: 0.875rem;
                margin-left: 0.5rem;
            }
            .result-rating {
                float: right;
                color: #f59e0b;
                font-weight: 500;
            }
            .result-description {
                color: #6b7280;
                font-size: 0.875rem;
                margin-top: 0.5rem;
                margin-bottom: 0;
            }
            .no-results {
                padding: 1rem;
                text-align: center;
                color: #6b7280;
            }
        `;
        document.head.appendChild(style);
    }
}

// Tool Filters
function initializeFilters() {
    const filterButtons = document.querySelectorAll('.filter-btn');
    
    filterButtons.forEach(button => {
        button.addEventListener('click', function() {
            const filter = this.dataset.filter;
            console.log('Filtering by:', filter);
            
            // Update active state
            filterButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
            
            // Filter tools (in production, this would filter actual data)
            filterTools(filter);
        });
    });
    
    function filterTools(filter) {
        const tools = document.querySelectorAll('.tool-card');
        
        tools.forEach(tool => {
            if (filter === 'all' || tool.dataset.category === filter) {
                tool.style.display = 'block';
                setTimeout(() => {
                    tool.classList.add('fade-in');
                }, 10);
            } else {
                tool.style.display = 'none';
                tool.classList.remove('fade-in');
            }
        });
    }
}

// Language Selector
function initializeLanguageSelector() {
    const translateElement = document.getElementById('google_translate_element');
    
    if (translateElement && typeof google !== 'undefined' && google.translate) {
        // Monitor language changes
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.type === 'attributes' && mutation.attributeName === 'class') {
                    const currentLang = getCurrentLanguage();
                    console.log('Language changed to:', currentLang);
                    
                    // Update UI based on language
                    updateLanguageUI(currentLang);
                    
                    // Save preference
                    localStorage.setItem('preferred-language', currentLang);
                }
            });
        });
        
        observer.observe(translateElement, { attributes: true });
        
        // Restore preferred language
        const preferredLang = localStorage.getItem('preferred-language');
        if (preferredLang) {
            // In production, this would set the Google Translate language
            console.log('Restoring preferred language:', preferredLang);
        }
    }
    
    function getCurrentLanguage() {
        // This is a simplified version
        // In production, you would get the actual language from Google Translate
        return document.documentElement.lang || 'en';
    }
    
    function updateLanguageUI(lang) {
        // Update direction for RTL languages
        if (['ar', 'he', 'fa'].includes(lang)) {
            document.body.style.direction = 'rtl';
        } else {
            document.body.style.direction = 'ltr';
        }
        
        // Update language-specific content
        updateLanguageSpecificContent(lang);
    }
    
    function updateLanguageSpecificContent(lang) {
        // This would update text content based on language
        // For now, just log it
        console.log('Updating content for language:', lang);
    }
}

// Mobile Menu
function initializeMobileMenu() {
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const navLinks = document.querySelector('.nav-links');
    
    if (!mobileMenuBtn || !navLinks) return;
    
    // Create mobile menu button if it doesn't exist
    if (!mobileMenuBtn) {
        const menuBtn = document.createElement('button');
        menuBtn.className = 'mobile-menu-btn';
        menuBtn.innerHTML = '☰';
        document.querySelector('.nav-container').appendChild(menuBtn);
    }
    
    mobileMenuBtn.addEventListener('click', function() {
        navLinks.classList.toggle('show');
        this.classList.toggle('active');
    });
    
    // Add styles for mobile menu
    const style = document.createElement('style');
    style.textContent = `
        .mobile-menu-btn {
            display: none;
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #1f2937;
        }
        
        @media (max-width: 768px) {
            .mobile-menu-btn {
                display: block;
            }
            .nav-links {
                display: none;
                flex-direction: column;
                width: 100%;
                margin-top: 1rem;
            }
            .nav-links.show {
                display: flex;
            }
            .nav-links a {
                width: 100%;
                text-align: center;
            }
        }
    `;
    document.head.appendChild(style);
}

// Tool Ratings
function initializeRatings() {
    // Initialize star ratings
    const ratings = document.querySelectorAll('.tool-rating');
    
    ratings.forEach(rating => {
        const score = parseFloat(rating.textContent.match(/\d+\.?\d*/)[0]);
        updateStarDisplay(rating, score);
    });
    
    function updateStarDisplay(element, score) {
        const stars = '★★★★★';
        const filledStars = Math.round(score);
        const emptyStars = 5 - filledStars;
        
        element.innerHTML = `
            <span class="filled-stars">${stars.slice(0, filledStars)}</span>
            <span class="empty-stars" style="color: #d1d5db">${stars.slice(filledStars)}</span>
            <span class="rating-score">(${score}/5)</span>
        `;
    }
}

// Analytics
function initializeAnalytics() {
    // Track page views
    trackPageView();
    
    // Track user interactions
    trackUserInteractions();
    
    function trackPageView() {
        const pageData = {
            page: window.location.pathname,
            title: document.title,
            timestamp: new Date().toISOString(),
            referrer: document.referrer
        };
        
        console.log('Page view:', pageData);
        
        // In production, send to analytics service
        // Example: sendToAnalytics('pageview', pageData);
    }
    
    function trackUserInteractions() {
        // Track clicks on important elements
        const trackElements = document.querySelectorAll('a, button, .tool-card, .category-card');
        
        trackElements.forEach(element => {
            element.addEventListener('click', function(e) {
                const interactionData = {
                    element: this.tagName,
                    text: this.textContent.trim().substring(0, 50),
                    href: this.href || '',
                    timestamp: new Date().toISOString()
                };
                
                console.log('User interaction:', interactionData);
                
                // In production, send to analytics service
                // Example: sendToAnalytics('click', interactionData);
            });
        });
    }
}

// Utility Functions
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

function throttle(func, limit) {
    let inThrottle;
    return function() {
        const args = arguments;
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

// Export for module usage (if using ES6 modules)
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        initializeGoogleAds,
        initializeSearch,
        initializeFilters,
        initializeLanguageSelector,
        debounce,
        throttle
    };
}