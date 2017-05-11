# Honeycomb Engineering Test - Makers Edition

## Specification

We have a system that delivers advertising materials to broadcasters. 

Our sales team have some new promotions they want to offer so we need to introduce a mechanism for applying Discounts to orders.

Promotions like this can and will change over time so we need the solution to be flexible.

Provide a means of defining and applying various discounts to the cost of delivering material to broadcasters.

We don't need any UI for this, we just need you to show us how it would work through its API.

## Discounts

* Send 2 or more materials via express delivery and the price for express delivery drops to $15
* Spend over $30 to get 10% off

## Improvements

- Order takes a new instance of Discount upon instantiation, I would improve it to create a new instance of the Discount class each time check_discounts is called. As if it is called more than once it doubles the discounted amount. 
