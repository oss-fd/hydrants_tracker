module.exports = {
  plugins: [
    require('@tailwindcss/ui'),
  ],
  purge: {
    enabled: process.env.NODE_ENV === 'production',
    content: [
      './app/**/*.html.erb',
    ]
  }
}
