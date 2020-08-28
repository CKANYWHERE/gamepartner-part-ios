//
//  String.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/26.
//
import Foundation

extension String{
    
     func isValidId() -> Bool{
         do{
               let regex = try NSRegularExpression(pattern: "^[a-zA-Z!@#.1-9\\s]$", options: .caseInsensitive)
               if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)){
                   return true
               }
           }catch{
               print(error.localizedDescription)
               return false
           }
           return false
     }
     
}
