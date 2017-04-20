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
    
    private let cache: SwiftlyLRU<AnyHashable, Any>
    
    var capacity: Int {
        return self.cache.capacity
    }
    
    var length: Int {
        return self.cache.length
    }
    
    // MARK: -
    
    init(capacity: Int){
        self.cache = SwiftlyLRU(capacity: capacity)
    }
    
    // MARK: NSCoding
    
    required init(coder decoder: NSCoder) {
        let capacity = decoder.decodeInteger(forKey: "capacity")
        self.cache = SwiftlyLRU<AnyHashable, Any>(capacity: capacity)
        
        var counter = decoder.decodeInteger(forKey: "counter")
        while counter > 0 {
            let itemDict = decoder.decodeObject(forKey: String(counter)) as! [AnyHashable : Any]
            let itemKeys = Array(itemDict.keys)
            let itemKey = itemKeys[0]
            self.cache[itemKey] = itemDict[itemKey]
            counter -= 1
        }
    }
    
    
    func encode(with encoder: NSCoder) {
        var counter = 0
        var queueCurrent = self.cache.queue.head
        
        while let key = queueCurrent?.key {
            if let value = queueCurrent!.value {
                counter += 1
                encoder.encode([key: value], forKey: String(counter))
            }
            queueCurrent = queueCurrent?.next
        }
        
        encoder.encode(self.cache.capacity, forKey: "capacity")
        encoder.encode(counter, forKey: "counter")
    }
    
    // MARK: Printable
    
    override var description: String {
        return "LRU Cache(\(self.cache.length)) \n" + self.cache.queue.display()
    }
    
    // MARK: -
    
    func put(_ key: AnyHashable, _ value: Any) {
        self.cache[key] = value
    }
    
    func get(_ key: AnyHashable) -> Any? {
        return self.cache[key]
    }
    
}
