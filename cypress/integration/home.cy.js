describe('Home Page', () => {

  // NOT WORKING, NO FUCKING CLUE WHY
  // CYPRESS.CONFIG.JS DOES NOT SEEM TO SET BASE URL, NO FUCKING CLUE WHY
  // beforeEach(() => {
  //   cy.visit("http://localhost:3000");
  // });

  // it('should visit the home page', () => {
  //   cy.url().should('eq', "http://localhost:3000/");
  // });

  beforeEach(() => {
    cy.visit("/");
  });

  it('should visit the home page', () => {
    cy.url().should('eq', Cypress.config().baseUrl);
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
  

});