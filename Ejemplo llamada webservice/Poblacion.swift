import Foundation
import UIkit

class Poblacion {
    var ID: Int
    var Nombre: String
    
    init() {
        ID = 0
        Nombre = ""
    }
    
    func GetPoblaciones() -> Array<Poblacion> {
        var usuario, pass, post, postLenght, strPrueba: String
        var url: NSURL
        var postData: NSData
        var request: NSMutableURLRequest
        var miPob = Poblacion()
        var arrPob = Array<Poblacion>()
        
        usuario = "federico"
        pass = "federico82"
        post = "usuario=\(usuario)&pass=\(pass)"
        
        url = NSURL(string:"http://localHost/serviciosWeb/pruebas/servicio.php")!
        
        postData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        postLenght = String(postData.length)
        
        request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLenght, forHTTPHeaderField: "Content-Lenght")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
        
        if ( urlData != nil ) {
            let res = response as NSHTTPURLResponse!
            
            if (res.statusCode >= 200 && res.statusCode < 300)
            {
                // Hacemos una primera llamada para comprobar usuario y contraseña
                var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!

                if responseData.lowercaseString == "error login" {
                    println(responseData)
                    return arrPob
                }
                
                var error: NSError?
                
                // Llamada al servicio web que devuelve un array
                let jsonData:NSArray = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSArray
                
                if error != nil {
                    println(error)
                } else {
                    // Comprobamos si ha devuelto datos
                    if jsonData.count > 0 {
                        // Recorro el array que me devuelve el servicio web y creo un objeto población en cada pasada
                        for item in jsonData {
                            var nombre: String? = item.valueForKey("Nombre") as? String
                            var idAux: String? = item.valueForKey("ID") as? String
                            var i: Int?
                            
                            i = idAux?.toInt()
                        
                            miPob = Poblacion()  // Inicializo el objeto en cada iteración porque machacaría el valor anterior en el array
                            miPob.ID = i!
                            miPob.Nombre = nombre!
                            
                            // Guardo en el array de Poblaciones cada objeto
                            arrPob.append(miPob)
                        }
                        
                        // Recorro el array obtenido para comprobar que los datos son correctos
                        for el in arrPob {
                            strPrueba = String(el.ID) + " - " + el.Nombre
                            println(strPrueba)
                        }
                    }
                    else {
                        println("No se han econtrado datos")
                    }
                }
            } else {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Error de conexión"
                alertView.message = "No se ha podido conectar"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        } else {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Error de conexión"
            alertView.message = "No se ha podido conectar"
            if let error = reponseError {
                alertView.message = (error.localizedDescription)
            }
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        
        return arrPob
    }
}