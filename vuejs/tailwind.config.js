module.exports = {
    content: ['./src/**/*.{html,js}'],
    theme: {
        colors: {
            'back': '#F7F3FE',
            'purple': '#7C49E9',
            'dark-purple': '#2A194D',
            'gray': '#C4C4C4'
        },
        fontFamily: {
            sans: ['Graphik', 'sans-serif'],
            serif: ['Merriweather', 'serif'],
        },
        extend: {
            spacing: {
                '8xl': '96rem',
                '9xl': '128rem',
            },
            borderRadius: {
                '4xl': '2rem',
            }
        }
    },
}