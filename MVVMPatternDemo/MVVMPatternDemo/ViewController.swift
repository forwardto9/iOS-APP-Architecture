//
//  ViewController.swift
//  MVVMPatternDemo
//
//  Created by uwei on 5/5/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

import UIKit


@objc protocol ViewControllerDelegate:class {
    @objc func showView() -> Void
    init(controller:UIViewController)
}


class ViewControllerModel:ViewControllerDelegate {
    fileprivate var vc:ViewController?
    
    internal required init(controller: UIViewController) {
        vc = controller as? ViewController
    }

    
    internal func showView() {
        let mvvmVC = vc?.storyboard?.instantiateViewController(withIdentifier: "MVVMViewController") as! MVVMViewController
        
        let model  = Person(name: "uwei", age: 27)
        let viewModel = ViewModel(person: model)
        mvvmVC.viewModel = viewModel
        
        vc?.present(mvvmVC, animated: true, completion: nil)
    }
}



class ViewController: UIViewController {

    private var button:UIButton = UIButton()
    private var vcModel:ViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        vcModel = ViewControllerModel(controller: self)
        
        button.frame = CGRect(x: 100, y: 200, width: 44, height: 44)
        button.setTitle("click", for: UIControlState.selected)
        button.backgroundColor = UIColor.black
        button.addTarget(vcModel!, action: #selector(vcModel!.showView), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func showView() -> Void {
        
    }

}

