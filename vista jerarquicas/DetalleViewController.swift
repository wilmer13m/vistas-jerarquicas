//
//  DetalleViewController.swift
//  vista jerarquicas
//
//  Created by Wilmer Mendoza on 19/11/16.
//  Copyright © 2016 Wilmer Mendoza. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {
    
    var titulo = String()
    var autor = [String]()
    var portada = UIImage()
    
    @IBOutlet weak var autorLabel: UILabel!
    
    @IBOutlet weak var tituloLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tituloLabel.text = titulo
        
        for nombre in autor{
            
            autorLabel.text = "\(nombre) "
        
        }
        
        imageView.image = portada
        
        
    }
    
    
    
    
    
}
