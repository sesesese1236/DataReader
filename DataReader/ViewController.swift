//
//  ViewController.swift
//  DataReader
//
//  Created by WENDRA RIANTO on 2022/05/26.
//

import UIKit

class shiftData{
    var Date=""
    var Earn=0
    var WorkTime=time()
    var TimeLeft=time()
}
class time{
    var Hour=0
    var Minute=0
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var ListViewer: UITableView!
    var shiftDataList:[shiftData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ListViewer.delegate = self
        ListViewer.dataSource = self
        
        let url = URL(string:"http://192.168.1.217:3010/sendData")!
        
        let task = URLSession.shared.dataTask(with: url){(data,response,error) in guard let data = data else{return}
            print(String(data:data, encoding: .utf8)!)
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell =
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        
    }

}

