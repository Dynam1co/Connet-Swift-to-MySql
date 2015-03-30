//
//  TablaPoblacionTableViewController.swift
//  Ejemplo llamada webservice
//
//  Created by Francisco Asensi Benito on 26/3/15.
//  Copyright (c) 2015 Francisco Asensi Benito. All rights reserved.
//

import UIKit

class TablaPoblacionTableViewController: UITableViewController {

    @IBOutlet var miLista: UITableView!
    var arrayPoblaciones = Array<Poblacion>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        var miPoblacion = Poblacion()
        arrayPoblaciones = miPoblacion.GetPoblaciones()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPoblaciones.count
    }
    
    // Este método es obligatorio porque si no lo implementamos, la aplicación no se ejecuta.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Mostramos la población que estemos recorriendo en cada momento
        let pobla = arrayPoblaciones[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CeldaPoblacion", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = pobla.Nombre
        cell.tag = indexPath.row
        
        return cell
    }
}
