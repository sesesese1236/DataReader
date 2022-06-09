//
//  ViewController.swift
//  DataReader
//
//  Created by WENDRA RIANTO on 2022/05/26.
//

import UIKit

struct ShiftData{
    var Date=""
    var Earn=0
    var WorkTime=Time()
    var TimeLeft=Time()
}
struct Time{
    var Hour=0
    var Minute=0
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var ListViewer: UITableView!
    var shiftDataList:[ShiftData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListViewer.delegate = self
        ListViewer.dataSource = self
        
        let url = URL(string:"http://192.168.1.217:3010/sendData")!
        
        let task = URLSession.shared.dataTask(with: url){(data,response,error) in guard let data = data else{return}
//            print(String(data:data, encoding: .utf8)!)
            do{
                let jsonData = try JSONSerialization.jsonObject(with:data,options:JSONSerialization.ReadingOptions.allowFragments)
                for dt_base in jsonData as! [Any]{
                    let dt = dt_base as! [String:Any]
                    let wt = dt["WorkTime"] as! [String:Any]
                    let tl = dt["TimeLeft"] as! [String:Any]
                    let shift = ShiftData(
                        Date: dt["Date"] as! String,
                        Earn: dt["Earn"] as! Int,
                        WorkTime: Time(
                            Hour: wt["hour"] as! Int,
                            Minute: wt["minute"] as! Int),
                        TimeLeft: Time(
                            Hour: tl["hour"] as! Int,
                            Minute: tl["minute"] as! Int))
                    self.shiftDataList.append(shift)
                }
                print(self.shiftDataList.count)
//                self.ListViewer.reloadData()
            }catch{
                print("error")
            }
//            for dt in data{
//                print(String(dt))
//            }
            
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        count = shiftDataList.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell =
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Date \(shiftDataList[indexPath.row].Date),TimeLeft:\(shiftDataList[indexPath.row].TimeLeft)"
        return cell
    }
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        
    }

}

