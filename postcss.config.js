var tailwindcss = require("tailwindcss");

module.exports = {
  plugins: [
    // add the line below
    tailwindcss("./app/javascript/stylesheets/tailwind.config.js"),
    require('autoprefixer'),
    require("postcss-import"),
    require("postcss-flexbugs-fixes"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009"
      },
      stage: 3
    })
  ]
};