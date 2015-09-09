# Windsor

Windsor acts as a front-end to csv files, exposing a GeoJSON feed that can be consumed by services like <mapbox.com> 

## Installation

To install Windsor, run `bundle install` in the root directory. While a default csv file can be found at `listings.csv`, you will want to substitute your own.

While Windsor uses reasonable defaults for viewing attributes about real estate, you'll want to change some files to best suite your files:

* How search is handled in `listings.rb`
* How request parameters are validated and coerced in `app.rb`
* What properties are exposed in the api in `listings.erb`

To get running, `rackup` fires up webbrick, which works ok for testing. While developing, it's best to use `shotgun`, which reloads Windsor with each request. 

## Usage


There is only one API endpoint:
> `GET /listings`

You can filter based on these query parameters:

* min_price
* max_price
* min_bed
* max_bed
* min_bath
* max_bath

All parameters are optional, and min/max fields are inclusive. The results are valid GeoJSON.

###Pagination
Should you need to paginate, Windsor comes out of the box with cursor based pagination.  

Pagination requires two parameters:

* **since**, the id of the first record you want. When paging, this is the next id after the last id from the previous page. 
* **count**, the number of records per page.
 
This enables pagination should the csv, or datastore behind window have new records added while making requests.

### Tests

Tests are Minitest, and very simple. 

`app_test.rb` covers a high level integration test. Does the app load, and do we get back all the records as GeoJSON?

`listings_test.rb` tests searching and paging functionality in listing.rb. 

### Listing.search
`Listing.search` accepts two parameters, a hash parameters that select listings, and a limit of listings to return. `since` is passed in via the hash parameter. `count` is optional. 

## Example

```
curl http://localhost:9393/listings?min_price=278803&min_bath=2&max_bed=4&min_bed=2&since=40&count=10
```

This will return 10 listings with an id greater than 40, that have between 2-4 bedrooms, 2-4 bathrooms, and cost more than $278,803.

## History

This application if for exposing the GB of xls about real estate I have on S3.

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Write some tests, make sure you don't break anything.
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D