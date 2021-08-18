//
//  No_6.swift
//  LeetCode
//
//  Created by 凌永剑 on 2021/8/18.
//

import Foundation

class ZigZagConversion {
    static func test() -> Void {
//        let strignLength =  Int(arc4random_uniform(UInt32(40)));
//        let string = getRandomStringWithLength(length: strignLength, letter: getRandomLetter);
//        let rows =  Int(arc4random_uniform(UInt32(10)));
//        print(string);
//        excuteAndPrint(string: string, rows: rows, excuteFunc: func1(string:rows:));
        
        excuteAndPrint(string: "PAYPALISHIRING", rows: 3, excuteFunc: func1(string:rows:));
        excuteAndPrint(string: "PAYPALISHIRING", rows: 4, excuteFunc: func1(string:rows:));
    }
    
    static func excuteAndPrint(string : String, rows : Int, excuteFunc: (String, Int) -> (String)) {
        let date : NSDate = NSDate();
        let rs = excuteFunc(string, rows);
        let duration = NSDate().timeIntervalSince(date as Date) * 1000;
        let durationStr = String(format: "%.3f", duration);
        print("result:\(rs), duration:\(durationStr)");
    }
    
//   a     | a     | a
//   a   a | a   a | a
//   a a   | a a   |
//   a     | a     |
    
//    C-style for statement has been removed in Swift 3 这是人干的事？
    
    static func func1(string : String, rows : Int) -> String {
        guard rows > 1 else {
            return string;
        }
        // ⚠️听说string转letters之后查询letter，效率比在string里查询letter效率高，待验证⚠️
        let letters = Array(string).map(String.init);
        // 以第一行字母划分列
        let preColumn = (rows - 1) * 2;
        // 多少列
        let column = letters.count / preColumn + 1;
        
        var array : [String] = [];
        for i in 0..<rows {
            for j in 0..<column {
                let index = j * preColumn + i;
                if (index < letters.count) {
                    array.append(letters[index]);
                }
                
                // 第一行 & 最后一行 仅一个元素，否则都是2个元素
                if (i == 0 || i == rows-1) {
                    continue;
                }
                
                let lastIndex = j * preColumn + (preColumn - i);
                if (lastIndex < letters.count) {
                    array.append(letters[lastIndex]);
                }
            }
        }
        
        return array.joined();
    }
}
