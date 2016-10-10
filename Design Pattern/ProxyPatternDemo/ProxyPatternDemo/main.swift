//
//  main.swift
//  ProxyPatternDemo
//
//  Created by forwardto9 on 16/3/22.
//  Copyright © 2016年 forwardto9. All rights reserved.
//

import Foundation

print("Hello, World!")

protocol Protocol {
    func method() ->Void
}

class Original:Protocol {
    func method() {
        print("Original method!")
    }
}

class Proxy:Protocol {
    private var delegate:Protocol?
    init() {
        delegate = Original()
    }
    
    func method() ->Void {
        delegate?.method()
    }
    
}

// 代理类代替了Original类做同样的事情
let proxy = Proxy()
proxy.method()

// 如果已有的方法在使用的时候需要对原有的方法进行改进，此时有两种办法：
// 修改原有的方法来适应。这样违反了“对扩展开放，对修改关闭”的原则。
// 就是采用一个代理类调用原有的方法，且对产生的结果进行控制。这种方法就是代理模式。
// 使用代理模式，可以将功能划分的更加清晰，有助于后期维护！
