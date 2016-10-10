//
//  ViewController.swift
//  MVVMPatternDemo
//
//  Created by uwei on 5/5/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var button:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button.frame = CGRect(x: 100, y: 200, width: 44, height: 44)
//        button.setTitle("Click", for:.normal)
        button.setTitle("click", for: UIControlState.selected)
        button.backgroundColor = UIColor.black()
        button.addTarget(self, action: #selector(ViewController.showView), for: UIControlEvents.touchUpInside)
//        button.addTarget(self, action: , forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func showView() -> Void {
        let mvvmVC = storyboard?.instantiateViewController(withIdentifier: "MVVMViewController") as! MVVMViewController
        
        let model  = Person(name: "uwei", age: 27)
        let viewModel = ViewModel(person: model)
        mvvmVC.viewModel = viewModel
        
        self.present(mvvmVC, animated: true, completion: nil)
    }

}

