describe("Product-Details Page Tests", () => {

  beforeEach(() => {

  });

  it("can navigate to the product-details page by clicking on a product article ", () => {
    cy.visit('/');
    cy.get('article').first().click();
    cy.get('h1').should('contain', 'Scented Blade');
  });

});