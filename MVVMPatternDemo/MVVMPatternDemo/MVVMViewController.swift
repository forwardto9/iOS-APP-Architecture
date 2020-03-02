//
//  MVVMViewController.swift
//  MVVMPatternDemo
//
//  Created by uwei on 5/5/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

import UIKit

struct Person {
    var name:String
    var age:Int8
}

// class 关键字表明这个Protocol只能是 class 才能采纳的 struct 或者是 enumeration 都是不可以的
// interface
protocol ViewModelProtocol:class {
    var greeting:String? {get}
    
    // hook by block
//    var greetingDidChange:((_ vModel:ViewModelProtocol) -> ())? {get set}
    var greetingDidChange:(() -> Void)? {get set}
    init(person:Person)
    func showGreeting() -> Void
}

// 独立出来的模块
// 负责 数据的逻辑处理
class ViewModel: ViewModelProtocol {
    let person:Person
    var greeting: String? {
        didSet {
//            self.greetingDidChange?(self)
            self.greetingDidChange?()
        }
    }
    
//    var greetingDidChange: ((_ vModel:ViewModelProtocol) -> ())?
    var greetingDidChange: (() -> Void)?
    required init(person: Person) {
        self.person = person
    }
    
    @objc func showGreeting() {
        greeting = "Hi" + " " + person.name
    }
}


class MVVMViewController: UIViewController {
    // 也是可以的，但是这只能将数据的逻辑处理放到了控制器中，增加了耦合，而且在响应UI操作的时候，也只能放到控制器中，耦合性大增
    // 数据和UI的处理绑定在一起
/*
    var person:Person! {
        didSet {
            self.label.text = "Hi" + " " + person.name
        }
    }
 */
    
    var viewModel:ViewModelProtocol! {
        didSet {
//            self.viewModel.greetingDidChange = { [unowned self] viewModel in
            self.viewModel.greetingDidChange = {
                self.label.text = self.viewModel.greeting
            }
        }
    }
    
    private var button:UIButton = UIButton()
    private var label:UILabel   = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let frame = self.view.frame
        
        button.frame = CGRect(x:frame.width/2 - 32, y:frame.height/2 - 22, width:64, height:44)
        button.backgroundColor = UIColor.black
        button.setTitle("Set", for: UIControl.State.selected)
        button.addTarget(viewModel, action: #selector(ViewModel.showGreeting), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
        
        label.frame  = CGRect(x:frame.width/2 - 60, y:frame.height/2 - 50, width:120, height:40)
        label.backgroundColor = UIColor.blue
        label.textColor = UIColor.white
        label.text      = "Default"
        self.view.addSubview(label)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
