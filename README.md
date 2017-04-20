Swift LRU Cache with NSCoding / NSKeyed​Archiver (based on SwiftlyLRU)
==========

This fork has a wrapper around SwiftlyLRU which is NSCoding-compliant.


```swift
//
// Example
//

import Foundation

//...

        // Create a NSCoding compliant cache with capacity 7
        let lru = LRU(capacity: 7)
        lru.put("AAPL", 114.63)
        lru.put("GOOG", 533.75)
        lru.put("YHOO", 50.67)
        lru.put("TWTR", 38.91)
        lru.put("BABA", 109.89)
        lru.put("YELP", 55.17)
        lru.put("BABA", 109.80)
        lru.put("TSLA", 231.43)
        lru.put("AAPL", 113.41)
        lru.put("GOOG", 533.60)
        lru.put("AAPL", 113.01)
        
        //Retrieve
        if let item = lru.get("AAPL") {
            print("Key: AAPL Value: \(item)")
        } else {
            print("Item not found.")
        }

/* OUTPUT    
    Key: AAPL Value: 113.01
*/
        
        //Describe
        print(lru)
        
/* OUTPUT
    LRU Cache(7) 
    Key: AAPL Value: Optional(113.01) 
    Key: GOOG Value: Optional(533.6) 
    Key: TSLA Value: Optional(231.43) 
    Key: BABA Value: Optional(109.8) 
    Key: YELP Value: Optional(55.17) 
    Key: TWTR Value: Optional(38.91) 
    Key: YHOO Value: Optional(50.67) 
*/
        
        // Save to disk
        let myPathList = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = (myPathList[0] as NSString).appendingPathComponent("LRU.archive")
        
        if NSKeyedArchiver.archiveRootObject(lru, toFile: path) {
            print("success")
        } else {
            print("failed")
        }
        
        // fetch from disk
        let unarchivedLRU = NSKeyedUnarchiver.unarchiveObject(withFile: path) as! LRU
        
        //Describe
        print(unarchivedLRU)

/* OUTPUT
    LRU Cache(7) 
    Key: AAPL Value: Optional(113.01) 
    Key: GOOG Value: Optional(533.6) 
    Key: TSLA Value: Optional(231.43) 
    Key: BABA Value: Optional(109.8) 
    Key: YELP Value: Optional(55.17) 
    Key: TWTR Value: Optional(38.91) 
    Key: YHOO Value: Optional(50.67) 
*/

//...
```


## Installation:
Simply drag SwiftlyLRU.swift and LRU.swift files from the source folder into your target project.

## Reference Notes:

If you have the need to persist your cache between app launches, NSCoding / NSKeyed​Archiver is a simple option. Unfortunatly Swift's generics and Objective-C are not really compatible. LRU is a wrapper around SwiftlyLRU which is NSCoding-compliant.


## Performance:
Time: O(1), Space: O(1) assumes no collisions into the hashtable.

