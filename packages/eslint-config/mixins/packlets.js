require("@rushstack/eslint-patch/modern-module-resolution")

module.exports = {
  plugins: ["@rushstack/eslint-plugin-packlets"],
  overrides: [
    {
      files: ["*.ts", "*.tsx"],
      rules: {
        "@rushstack/packlets/mechanics": "error",
        "@rushstack/packlets/circular-deps": "error",
      },
    },
    {
      files: ["*.{test,spec}.*", "test/**/*"],
      rules: {
        "@rushstack/packlets/mechanics": "off",
      },
    },
  ],
}
