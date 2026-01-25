/* BUSHMEN SAFARIS - THEME MANAGER */

const rootHtml = document.documentElement;
const themeToggleBtn = document.getElementById('theme-toggle');
const themeIconMoon = document.getElementById('theme-icon-moon');
const themeIconSun = document.getElementById('theme-icon-sun');

function updateThemeIcons(theme) {
    if (!themeIconMoon || !themeIconSun) return;
    if (theme === 'light') {
        themeIconMoon.classList.add('hidden');
        themeIconSun.classList.remove('hidden');
    } else {
        themeIconMoon.classList.remove('hidden');
        themeIconSun.classList.add('hidden');
    }
}

// Initialize theme
const savedTheme = localStorage.getItem('bushmen-theme') || 'dark';
rootHtml.setAttribute('data-theme', savedTheme);
updateThemeIcons(savedTheme);

if (themeToggleBtn) {
    themeToggleBtn.addEventListener('click', () => {
        const current = rootHtml.getAttribute('data-theme') === 'light' ? 'light' : 'dark';
        const next = current === 'light' ? 'dark' : 'light';
        rootHtml.setAttribute('data-theme', next);
        localStorage.setItem('bushmen-theme', next);
        updateThemeIcons(next);
    });
}
