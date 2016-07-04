//
// Copyright (c) 2014 Sebastian Bub
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
//  Created by SEBASTIAN BUB on 12/11/14.
//  Copyright (c) 2014 Sebastian Bub. All rights reserved.
//

import Foundation

class LRU: NSObject, NSCoding {
    
    private var cache:SwiftlyLRU<NSObject, AnyObject>
    
    var capacity: Int {
        return self.cache.capacity
    }
    
    var length: Int {
        return self.cache.length
    }
    
    // MARK: -
    
    init(capacity: Int){
        self.cache = SwiftlyLRU<NSObject, AnyObject>(capacity: capacity)
    }
    
    // MARK: NSCoding
    
    required init(coder decoder: NSCoder) {
        let capacity = decoder.decodeIntegerForKey("capacity")
        self.cache = SwiftlyLRU<NSObject, AnyObject>(capacity: capacity)
        
        var counter = decoder.decodeIntegerForKey("counter")
        while counter > 0 {
            let itemDict = decoder.decodeObjectForKey(String(counter)) as! [NSObject : AnyObject]
            let itemKey = Array(itemDict.keys)[0]
            self.cache[itemKey] = itemDict[itemKey]
            counter -= 1
        }
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        var counter = 0
        var queueCurrent = self.cache.queue.head
        
        while queueCurrent != nil {
            let key:NSObject = queueCurrent!.key
            if let value:AnyObject = queueCurrent!.value {
                counter += 1
                encoder.encodeObject([key: value], forKey: String(counter))
            }
            queueCurrent = queueCurrent?.next
        }
        
        encoder.encodeInteger(self.cache.capacity, forKey: "capacity")
        encoder.encodeInteger(counter, forKey: "counter")
    }
    
    // MARK: Printable
    
    override var description : String {
        return "LRU Cache(\(self.cache.length)) \n" + self.cache.queue.display()
    }
    
    // MARK: -
    
    func put(key: NSObject, _ value: AnyObject) {
        self.cache[key] = value
    }
    
    func get(key: NSObject) -> AnyObject? {
        return self.cache[key]
    }
    
}
