//
//  main.swift
//  InterfaceOrientedProgram
//
//  Created by uweiyuan on 2020/3/26.
//  Copyright © 2020 Tencent. All rights reserved.
//

import Foundation

print("Hello, World!")

/// 抽象类和接口的区别在于使用动机。
/// 使用抽象类是为了代码的复用
/// 使用接口的动机是为了实现多态性

protocol IMobileStorage {
    func read() -> Void
    func write() -> Void
}

class MP3Player: IMobileStorage {
    func write() {
        print("MP3 write")
    }
    
    func read() {
        print("PM3 read")
    }
}

class FlashDisk: IMobileStorage {
    func read() {
        print("Flash read")
    }
    func write() {
        print("Flash write")
    }
}

class MobileHardDisk: IMobileStorage {
    func read() {
        print("Hard disk read")
    }
    func write() {
        print("Hard disk write")
    }
}

class Computer {
    var storage:IMobileStorage?
    func readData() -> Void {
        storage?.read()
    }
    func writeData() -> Void {
        storage?.write()
    }
}

let mp3 = MP3Player()
let flash = FlashDisk()
let mobileHard = MobileHardDisk()
let computer = Computer()
computer.storage = mp3
computer.readData()
computer.writeData()

computer.storage = flash
computer.readData()
computer.writeData()

computer.storage = mobileHard
computer.readData()
computer.writeData()


class SuperStorage {
    func r() -> Void {
        print("Super read")
    }
    func w() -> Void {
        print("Super write")
    }
}

class SuperAdapter: IMobileStorage {
    var storage:SuperStorage?
    func read() {
        storage?.r()
    }
    
    func write() {
        storage?.w()
    }
}

let superStorage = SuperStorage()
let adapter = SuperAdapter()
adapter.storage = superStorage
computer.storage = adapter
computer.readData()
computer.writeData()


