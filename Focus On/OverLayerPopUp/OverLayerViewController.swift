//
//  OverLayerViewController.swift
//  Focus On
//
//  Created by Eva Sira Madarasz on 05/10/2023.
//

import UIKit

class OverLayerViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func doneAction(_ sender: UIButton) {
        
    }
    
    init() {
        super.init(nibName: "OverLayerViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }


    func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
        
    }
    
    private func show() {
        UIView.animate(withDuration: 1, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
   
    func hide() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }

    }
}
