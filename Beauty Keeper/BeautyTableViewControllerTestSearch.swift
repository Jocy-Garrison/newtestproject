//
//  BeautyTableViewControllerTestSearch.swift
//  Beauty Keeper
//
//  Created by stephaniesheng on 15/8/12.
//  Copyright (c) 2015年 stephaniesheng. All rights reserved.
//

import UIKit

class BeautyTableViewControllerTestSearch: UITableViewController, UITableViewDataSource ,UISearchBarDelegate, UISearchDisplayDelegate  {
    var beauties = [Beauty]()
    var filteredBeauties = [Beauty]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //向BeautyArray中添加简单的数据
        self.beauties = [Beauty(category: "MAKEUP & FRAGRANCE", name:"BB Cream"),
            Beauty(category: "MAKEUP & FRAGRANCE", name:"Blush & Bronzer"),
            Beauty(category: "MAKEUP & FRAGRANCE", name:"Body Mist"),
            Beauty(category: "SKIN & HAIR CARE", name:"Anti-Aging"),
            Beauty(category:"SKIN & HAIR CARE", name:"Antiperspirant"),
            Beauty(category:"SKIN & HAIR CARE", name:"Bath & Shower"),
            Beauty(category:"SKIN & HAIR CARE", name:"Body & Firming"),
            Beauty(category:"SKIN & HAIR CARE", name:"Body Treatment"),
            Beauty(category:"SKIN & HAIR CARE", name:"Cleanser"),
            Beauty(category:"MEN", name:"Aftershave"),
            Beauty(category:"MEN", name:"Fragrance"),
            Beauty(category:"MEN", name:"Hair Care"),
            Beauty(category:"MOTHER & BABY", name:"Baby Skin Care"),
            Beauty(category:"MOTHER & BABY", name:"Postpartum Skin Care"),
            Beauty(category:"MOTHER & BABY", name:"Pregnancy Skin Care")
        ]
        
        // 不显示Search Bar边框
        self.searchDisplayController?.searchBar.searchBarStyle = UISearchBarStyle.Minimal

//        // 显示分段条
//        self.searchDisplayController?.searchBar.showsScopeBar = true
//        self.searchDisplayController?.searchBar.scopeButtonTitles = ["All","Junior","Senior"]
        // refresh table
        self.tableView.reloadData()
        
    }
    
//   mark:  过滤数组
    //返回表格行数（也就是返回控件数）
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //让 tableView 知道什么时候使用过滤过的数据
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredBeauties.count
            
        } else {
            // 简单的告诉 tableView ，应该包含许多行
            return self.beauties.count
        }
    }

    //创建各单元显示内容(创建参数indexPath指定的单元）
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var beauty : Beauty
        //在tableview中查询一个元素／条目，如果没有创建一个。
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        // 检查标准table和搜索结果table是否正常显示，然后从beauty数据集查找需要的对象.如果确实是搜索table，则数据从 filteredBeauties 数组中获取。否则，数据从全部的项目中获取。
        if tableView == self.searchDisplayController!.searchResultsTableView {
            beauty = filteredBeauties[indexPath.row]
            
        } else {
            beauty = beauties[indexPath.row]
            
        }
        
        // 设置元素／条目
        cell.textLabel!.text = beauty.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell

    }
    
    // mark: searchBar
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        // 使用 searchText （也就是你的搜索字符串） 过滤 beauties ，然后将结果放入filteredBeauties
        self.filteredBeauties = self.beauties.filter({( beauty: Beauty) -> Bool in
            
            let categoryMatch = (scope == "All") || (beauty.category == scope)
            //rangeOfString() 用于检查是否字符串包含要查找的字符串。如果是，则返回true，表明当前的化妆品包含在过滤的数组中；如果返回false则不包含
            let stringMatch = beauty.name.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
           
            
        })
    }
    
    // 当用户更改搜索的字符串时，方法被调用。
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        
        
        let scopes = self.searchDisplayController!.searchBar.scopeButtonTitles as! [String]
        
        let selectedScope = scopes[self.searchDisplayController!.searchBar.selectedScopeButtonIndex] as String
        
        self.filterContentForSearchText(searchString, scope: selectedScope)
        
        return true
        
    }
    
    //用于操作分类条的输入：输入的searchtext如果在Shows Scope Bar属性中定义的分类条下匹配，就输出查找内容
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        
        let scope = self.searchDisplayController!.searchBar.scopeButtonTitles as! [String]
        
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text, scope: scope[searchOption])
        return true
        
    }
    
//  mark: 当向详细视图控件中发送消息时，你需要确定view controller知道哪个用户正在使用的是哪一个table view：完整的列表，或者搜索过的列表。
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("beautyDetail", sender: tableView)
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "beautyDetail" {
            
            let beautyDetailViewController = segue.destinationViewController as! UIViewController
            
            if sender as! UITableView == self.searchDisplayController!.searchResultsTableView {
                
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                
                let destinationTitle = self.filteredBeauties[indexPath.row].name
                
                beautyDetailViewController.title = destinationTitle
                
            } else {
                
                let indexPath = self.tableView.indexPathForSelectedRow()!
                
                let destinationTitle = self.beauties[indexPath.row].name
                
                beautyDetailViewController.title = destinationTitle
                
            }
            
        }
        
    }
    
 
}