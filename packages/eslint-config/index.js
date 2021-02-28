require("@rushstack/eslint-patch/modern-module-resolution")

module.exports = {
  root: true, // Disable automatic upward propogation to prevent surprises.
  parser: "@typescript-eslint/parser",
  reportUnusedDisableDirectives: true,
  extends: ["alloy"],
  overrides: [
    {
      files: ["*.ts", "*.tsx"],
      parserOptions: {
        // Evaluated relative to tsconfigRootDir or CWD.
        // TS projects should set tsconfigRootDir to make this work properly.
        project: "./tsconfig.json",
      },
    },
  ],
}
