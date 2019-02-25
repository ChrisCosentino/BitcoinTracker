//
//  FeedVC.swift
//  CryptoTracker
//
//  Created by Chris Cosentino on 2018-07-09.
//  Copyright © 2018 Chris Cosentino. All rights reserved.
//

import UIKit


class FeedVC: UITableViewController {
    
    @IBOutlet weak var currenctBtn: UIBarButtonItem!
    var b = [Ticker]()
    var refresher: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.tableView.reloadData()
        
        //refresh data
        refresher = UIRefreshControl()
        self.tableView.insertSubview(refresher, at: 5)
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
    }
    
    private func sortList() {
        self.b.sort(by: { $0.price > $1.price }) // Sort the list alphabetically
        self.tableView.reloadData(); // notify the table view the data has changed
    }
    
    @objc func refreshData(){
        loadData()
        self.tableView.reloadData()
        refresher.endRefreshing()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.b.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellString, for: indexPath) as! FeedCell
        
        cell.lblTickerName.text = b[indexPath.row].name
        cell.lblTickerSymbol.text = b[indexPath.row].symbol
        
        let priceStr = self.priceFormat(price: b[indexPath.row].price)
        cell.lblPrice.text = priceStr
        
        let oneHR =  self.percentFormat(val: b[indexPath.row].percent_change_1h)
        
        cell.lblOneHourPercent.text = oneHR.val
        if oneHR.num < 0.0{
            cell.lblOneHourPercent.textColor = UIColor.red
        }else{
            cell.lblOneHourPercent.textColor = UIColor.green
        }
        
        let twentyFourHR =  self.percentFormat(val: b[indexPath.row].percent_change_24h)
        
        cell.lbl24HourPercent.text = twentyFourHR.val
        if twentyFourHR.num < 0.0{
            cell.lbl24HourPercent.textColor = UIColor.red
        }else{
            cell.lbl24HourPercent.textColor = UIColor.green
        }
        
        let sevenDay =  self.percentFormat(val: b[indexPath.row].percent_change_7d)
        
        cell.lbl7DayPercent.text = sevenDay.val
        if sevenDay.num < 0.0{
            cell.lbl7DayPercent.textColor = UIColor.red
        }else{
            cell.lbl7DayPercent.textColor = UIColor.green
        }
       
        return cell
    }
 

    
    func getJsonUrl() -> String{
        return "https://api.coinmarketcap.com/v2/ticker/"
    }
    
    func changeCurrency(currency: String){
        
    }
    
    func percentFormat(val: Double) -> (val: String, num: Double){
        let finalVal:String = "\(val)%"
        let numVal: Double = val
        
        return (val: finalVal, num: numVal)
    }
    
    
    func priceFormat(price: Double) -> String{
        let priceStr : String = "$\(self.truncateDecimal(price: price))"
        return priceStr
    }
    func truncateDecimal(price: Double) -> Double{
        let trunc = (price*100).rounded()/100
        return trunc
    }
    

    func loadData(){
        
        let jsonUrl = getJsonUrl()
        
        guard let url = URL(string: jsonUrl) else{return}
        
        URLSession.shared.dataTask(with: url){ (data, response, err)  in
            guard let data = data else{return}
            var tempArr = [Ticker]()
            do{
                let decoder = JSONDecoder()
                let bitcoinData = try decoder.decode(Bitcoin.self, from: data)
                
                
                
                for btc in bitcoinData.data{
                    
                    let bit = Ticker(name: btc.value.name, symbol: btc.value.symbol, price: Double(btc.value.quotes.USD.price), percent_change_1h: btc.value.quotes.USD.percent_change_1h, percent_change_24h: btc.value.quotes.USD.percent_change_24h, percent_change_7d: btc.value.quotes.USD.percent_change_7d)
                    
                    tempArr.append(bit)
                }
                
                
                DispatchQueue.main.async {
                    self.b = tempArr
                    self.sortList()
                    self.tableView.reloadData()
                }
            } catch let error{
                print(error as? Any)
            }
            }.resume()
    }
    
    
    @IBAction func currencyBtnPressed(_ sender: Any) {
       
        if(self.currenctBtn.title == "USD"){
          
        }
        
        
    }
    
    
}
