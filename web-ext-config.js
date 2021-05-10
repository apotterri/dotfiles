module.exports = {
  ignoreFiles: [
    '**/*~'
  ],
  run: {
    firefoxProfile: "debugging",
    keepProfileChanges: true,
    target: [
      'firefox-desktop',
      'chromium'
    ]
  }
};
