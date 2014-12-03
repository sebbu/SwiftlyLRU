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

import Foundation

class SwiftlyLRU<K : Hashable, V> : Printable {
    
    let capacity: Int
    var length = 0
    
    private let queue: LinkedList<V>
    private var hashtable: [K : Node<V>]
    
    init(capacity: Int) {
        self.capacity = capacity
        
        self.queue = LinkedList()
        self.hashtable = [K : Node<V>](minimumCapacity: self.capacity)
    }
    
    subscript (key: K) -> V? {
        get {
            if let node = self.hashtable[key] {
                self.queue.remove(node)
                self.queue.addToHead(node)
                
                return node.value
            } else {
                return nil
            }
        }
        
        set(value) {
            if let node = self.hashtable[key] {
                node.value = value!
                
                self.queue.remove(node)
                self.queue.addToHead(node)
            } else {
                var node = Node(value: value!)
                
                if self.length < capacity {
                    self.queue.addToHead(node)
                    self.hashtable[key] = node
                    
                    self.length++
                } else {
                    
                }
            }
        }
    }
        
    var description : String {
        self.queue.display()
        
        return ""
    }
}