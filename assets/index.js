let options = {
    root: null,
    rootMargin: "0px",
    threshold: 0.5,
};

let callback = (entries, observer) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const activeImg = entry.target;
            console.log("activeImg", activeImg);
            activeImg.style.opacity = 1;
            // activeImg.src = activeImg.dataset.src;
            observer.unobserve(activeImg);
        }
    });
};

const observer = new IntersectionObserver(callback, options);

const images = document.querySelectorAll('div');

images.forEach(img => {
    observer.observe(img)
})

