# EmployeeRecords

## Build tools & versions used : Xcode 13.2.1
##### Minimum deployment target - iOS 15.2


## Steps to run the app
##### Download the repo. Run `pod install`. Open SquareTest.xccworkspace and run the app

## What areas of the app did you focus on?
##### Focused on User Interface, supporting dark mode. Added additional text and tint colors for pull-to-refresh feature. The `Sort` feature sorts by name. Used SkeletonView for the shimmering load state.

## What was the reason for your focus? What problems were you trying to solve?
##### I was trying to make the screen look more user-friendly, giving as much information as possible during error states.

## How long did you spend on this project?
##### I spent 3 days on the project, about an hour or so each day. I divided the project work into 5 parts. 
1. Getting the UITableView, CustomTableViewCell, Fetch data and Image Cache 
1. Sort, Filter, Empty state for tableview and Error Handling
1. TestCases
1. SkeletonView - this took a little longer than expected, since it is the first time I am working with it.

## Did you make any trade-offs for this project? What would you have done differently with more time?
##### Organize/ architect the code in a better way. This happened because adding SkeletonView was an after thought. Also write better test cases for the tableViewController.
##### With more time, I would have added options for Sort. Like sort by Name, Team etc instead of sorting it by name by default.
##### Something else I would have done differently was add a Class for Colors, creating pairs for light mode and dark mode instead of using `Assets`

## What do you think is the weakest part of your project?
##### The ViewController which is longer than what it should ideally be.

## Did you copy any code or dependencies? Please make sure to attribute them here!
##### I used Cocoapods (SkeletonView) to add the shimmering loading state.

## Is there any other information you’d like us to know?
##### I worked on UI using iPhone 11 pro simulator. I have tested it for portrait and landscape on other iPhones but not on iPads.
