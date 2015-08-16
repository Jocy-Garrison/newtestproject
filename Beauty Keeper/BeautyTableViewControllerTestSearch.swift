//
//  BeautyTableViewControllerTestSearch.swift
//  Beauty Keeper
//
//  Created by stephaniesheng on 15/8/12.
//  Copyright (c) 2015年 stephaniesheng. All rights reserved.
//

import UIKit

class BeautyTableViewControllerTestSearch: UITableViewController, UITableViewDataSource ,UISearchBarDelegate, UISearchDisplayDelegate  {
 

    var ctrls:[String] = ["Label","Button1-初级","Button1-高级","Button2-初级","Button2-高级","Switch"]
    // 搜索匹配的结果，Table View使用这个数组作为datasource
    var ctrlsel:[String] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // 引用通过storyboard创建的控件 XX 不能定义，不然RUN的时候报错
//    @IBOutlet weak var searchDisplay: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //向BeautyArray中添加简单的数据
        self.ctrlsel = self.ctrls
        // refresh table
        self.tableView.reloadData()
//        
//        // 不显示Search Bar边框
////        self.searchDisplay.searchBar.searchBarStyle = UISearchBarStyle.Minimal
//        self.searchDisplayController?.searchBar.searchBarStyle = UISearchBarStyle.Minimal
//
//        // 显示分段条
//        self.searchDisplayController?.searchBar.showsScopeBar = true
//        self.searchDisplayController?.searchBar.scopeButtonTitles = ["All","Junior","Senior"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 1
    }

    //返回表格行数（也就是返回控件数）
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
//        println("test\(self.ctrlsel.count)")
        return self.ctrlsel.count
    }

    //创建各单元显示内容(创建参数indexPath指定的单元）
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        // 从我们的数组中获得相应的内容
//        let ctrlss = self.ctrls[indexPath.row]
        cell.textLabel?.text = self.ctrlsel[indexPath.row]
        
        // 设置条目Configure the cell...
//        cell.textLabel!.text = ctrlss.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        // Configure the cell...
        return cell
    }
    
    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(searchBar: UISearchBar!, textDidChange searchText: String!) {
        self.searchText = searchText
        searchCtrls()
    }
    
    // 选择分段条时调用
    func searchBar(searchBar: UISearchBar!, selectedScopeButtonIndexDidChange selectedScope: Int) {
        println(selectedScope)
        searchCtrls();
    }
    
    // 保存搜索内容
    var searchText:String = ""
    
    // 搜索过滤
    func searchCtrls() {
        // 没有搜索内容时显示全部组件
        if self.searchText == "" {
            self.ctrlsel = self.ctrls
        }
        else {
//            var scope = self.searchDisplay.selectedScopeButtonIndex
            var scope = self.searchDisplayController?.searchBar.selectedScopeButtonIndex;
            // 匹配用户输入内容的前缀
            self.ctrlsel = []
            for ctrl in self.ctrls {
                let lc = ctrl.lowercaseString
                if lc.hasPrefix(self.searchText) {
                    if (scope == 0 || (scope == 1 && lc.hasSuffix("初级"))
                        || (scope == 2 && lc.hasSuffix("高级"))) {
                            self.ctrlsel.append(ctrl)
                    }
                }
            }
        }
 }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */


}