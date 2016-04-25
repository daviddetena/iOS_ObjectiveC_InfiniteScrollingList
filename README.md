## Infinite Scrolling on iOS - ObjectiveC

This sample shows how to implement an infinite scroll on a table by using an ObjectiveC Category.

This category could be used to create custom TableViewControllers that need to fetch new data. *E.g.: fetching new data from a remote mail server to display old emails at the bottom of the table.*


In this sample, we have a table initially populated with 20 items. Every time we scroll down, a new cell appears at the bottom of the table, simulating new items are being fetched in the background.

A category for wrapping in a Navigation Controller has been added in order for the table to be properly displayed.