const { defineConfig } = require('cypress')

module.exports = defineConfig({
  // setupNodeEvents can be defined in either
  // the e2e or component configuration
  e2e: {
    setupNodeEvents(on, config) {
      on('before:browser:launch', (browser = {}, launchOptions) => {
        /* ... */
      })
    },
    // baseUrl: "http://localhost:3000/", //DOESN'T DO ANYTHING, NO FUCKING CLUE WHY
    specPattern: "cypress/integration/**/*.cy.{js,jsx,ts,tsx}", 
  },
  screenshotsFolder: "tmp/cypress_screenshots",
  videosFolder: "tmp/cypress_videos",
  trashAssetsBeforeRuns: false
})
