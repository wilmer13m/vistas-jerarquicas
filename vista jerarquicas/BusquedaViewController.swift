//
//  busquedaViewController.swift
//  vista jerarquicas
//
//  Created by Wilmer Mendoza on 19/11/16.
//  Copyright © 2016 Wilmer Mendoza. All rights reserved.
//

import UIKit

class busquedaViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var labelTitulo: UILabel!
    
    @IBOutlet weak var autorLabel: UILabel!
    
    @IBOutlet weak var portadaLabel: UILabel!
    
    @IBOutlet weak var isbnTextField: UITextField!
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var guardarBoton: UIButton!
    
    let libroGuardado = libro()
    
    
    var libroDelegate : busquedaViewControllerDelegate?
    
    var isbn = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guardarBoton.hidden = true
        isbnTextField.delegate = self
        
        
       
        
    }
    
    
    
    func buscarLibros(isbn : String)  {
        
        
        self.myActivityIndicator.startAnimating()
        
        let url = NSURL(string: "https://openlibrary.org/api/books?bibkeys=ISBN:\(isbn)&jscmd=data&format=json")
        
        
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            //verificando si ha ocurrido un error
            
            
            
            guard data != nil else {
                print(error)
                self.myActivityIndicator.stopAnimating()
                
                
                
                return
            }
            
            do{
                
               
                
                
                //parseando la data del json
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.MutableContainers)
                
                
                print(" este es el json \n \(json)")
                let diccionario = json as! [String : AnyObject]
                
                print("ESTE es el diccionario\(diccionario)")
                
                let datos = diccionario["ISBN:\(isbn)"] as! [String : AnyObject]
                print("los datos del libro son \n \(datos)")
                
                let titulo = datos["title"] as! String
                print("el titulo del libro es: \(titulo)")
                
                let autores = datos["authors"] as! [[String : AnyObject]]
                print("los autores son \(autores)")
                
                var nombreAutor = [String]()
                
                let cover = datos["cover"] as! [String : AnyObject]
                
                let portada = cover["medium"] as! String
                
                print("direccion de la portada \(portada)")
                
                for x in autores{
                    let nombre = x["name"] as! String
                    print("los autores son \(nombre)")
                
                    nombreAutor.append(nombre)
                }
                
                self.libroGuardado.titulo = titulo
                self.libroGuardado.portada = portada
                self.libroGuardado.autor = nombreAutor
                
                self.libroDelegate?.obtenerLibro(self.libroGuardado)
                
                print("el titulo guardado es\(self.libroGuardado.titulo)")
                
              
//                
//                //recargo la data del collectionView de manera asincrona
                dispatch_async(dispatch_get_main_queue(), {
                    self.myActivityIndicator.stopAnimating()
                    
                    if let label = self.labelTitulo.text {
                        self.labelTitulo.text = "\(label)\(titulo)"
                    }
                    
//                    self.portadaLabel.text = "No Hay portada"
                    for x in nombreAutor{
                        if let nom = self.autorLabel.text {
                            self.autorLabel.text = "\(nom)\(x) "
                        }
                    }
                    
                    let url = NSURL(string: "\(portada)")
                    let data = NSData(contentsOfURL:url!)
                    
                    
                    if  let dat = data  {
                        self.imageView.image = UIImage(data:dat)
                        self.libroDelegate?.imagenLibro(self.imageView.image!)
                    }
                    
                    self.guardarBoton.hidden = false
                })
                
                            
                
                
            }catch let error as NSError {
                print("error serializing JSON: \(error)")
                print("rntro aqui")
            }
            
            }.resume()
        
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        labelTitulo.text = ""
        autorLabel.text = ""
        imageView.image = UIImage(named: "")
        
        
        print("entro aqui")
        
        if isbnTextField.text != nil || isbnTextField.text != ""{
            
            
            isbn = isbnTextField.text!
            
            print(isbn)
            
            
            buscarLibros(isbn)
            
            if isbnTextField.isFirstResponder() == true{
                
                isbnTextField.resignFirstResponder()
                
            }
        }
        
        return true
        
        
    }
    
    @IBAction func guardarLibro(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    

    
}


protocol busquedaViewControllerDelegate{
    
    func obtenerLibro(x : libro)
    
    func imagenLibro(x : UIImage)

}










