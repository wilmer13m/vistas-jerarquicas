//
//  ViewController.swift
//  vista jerarquicas
//
//  Created by Wilmer Mendoza on 19/11/16.
//  Copyright © 2016 Wilmer Mendoza. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,busquedaViewControllerDelegate {

    var libros = [libro]()
    
    var portadas = [UIImage]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        print("el arreglo de libros tiene \(libros.count)")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func agregarLibro(sender: AnyObject) {
        
        performSegueWithIdentifier("detalle", sender: self)
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libros.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellId")
        cell?.textLabel?.text = libros[indexPath.row].titulo
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("detalle") as! DetalleViewController
        
        let titulo = libros[indexPath.row].titulo
        
        let autors = libros[indexPath.row].autor
        
        let portada = portadas[indexPath.row]
        
        vc.autor = autors
        
        vc.titulo = titulo
        
        vc.portada = portada
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    func obtenerLibro(x: libro) {
        
        print("entro aqui")
        
        libros.append(x)
        print(libros.count)
        
        tableView.reloadData()
    }
    
    func imagenLibro(x: UIImage) {
        portadas.append(x)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let goNext = segue.destinationViewController as! busquedaViewController
        goNext.libroDelegate = self
        
    }
    

}

