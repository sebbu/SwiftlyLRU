//
// Copyright (c) 2014 Justin M Fischer
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  Created by JUSTIN M FISCHER on 12/1/14.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Create cache with capacity
        let cache = SwiftlyLRU<String, Float>(capacity: 7)
        
        //Add Key, Value pairs
        cache["AAPL"] = 114.63
        cache["GOOG"] = 533.75
        cache["YHOO"] = 50.67
        cache["TWTR"] = 38.91
        cache["BABA"] = 109.89
        cache["YELP"] = 55.17
        cache["BABA"] = 109.80
        cache["TSLA"] = 231.43
        cache["AAPL"] = 113.41
        cache["GOOG"] = 533.60
        cache["AAPL"] = 113.01
        
        //Retrieve
        if let item = cache["AAPL"] {
            print("Key: AAPL Value: \(item)")
        } else {
            print("Item not found.")
        }
        
        //Describe
        print(cache)
        
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
        if let item: AnyObject = lru.get("AAPL") {
            print("Key: AAPL Value: \(item)")
        } else {
            print("Item not found.")
        }
        
        //Describe
        print(lru)
        
        // Save to disk
        let myPathList = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path = (myPathList[0] as NSString).stringByAppendingPathComponent("LRU.archive")
        
        if NSKeyedArchiver.archiveRootObject(lru, toFile: path) {
            print("success")
        } else {
            print("failed")
        }
        
        // fetch from disk
        let unarchivedLRU = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! LRU
        
        //Describe
        print(unarchivedLRU)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
