/* BUSHMEN SAFARIS - CUSTOM CURSOR */

const cursorDot = document.querySelector('.cursor-dot');
const cursorOutline = document.querySelector('.cursor-outline');

if (window.innerWidth > 768) {
    window.addEventListener('mousemove', (e) => {
        const posX = e.clientX;
        const posY = e.clientY;

        if (cursorDot && cursorOutline) {
            cursorDot.style.left = `${posX}px`;
            cursorDot.style.top = `${posY}px`;

            cursorOutline.animate({
                left: `${posX}px`,
                top: `${posY}px`
            }, { duration: 500, fill: 'forwards' });
        }
    });

    // Hover interaction for cursor
    document.querySelectorAll('.hover-trigger').forEach(el => {
        if (!cursorOutline) return;
        el.addEventListener('mouseenter', () => {
            cursorOutline.classList.add('hovered');
        });
        el.addEventListener('mouseleave', () => {
            cursorOutline.classList.remove('hovered');
        });
    });
}
