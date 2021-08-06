//
//  No_2.swift
//  LeetCode
//
//  Created by 凌永剑 on 2021/8/6.
//

import Foundation

class AddTwoNumbers {
    static func test() -> Void {
        let l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9];
//        let l1 = [2,4,3], l2 = [5,6,4];
        excuteAndPrint(first: l1, second: l2, excuteFunc: func1(first:second:));
    }
    
    static func excuteAndPrint(first: [Int], second: [Int], excuteFunc: ([Int], [Int]) -> ([Int])) {
        let date : NSDate = NSDate();
        let rs = excuteFunc(first, second);
        let duration = NSDate().timeIntervalSince(date as Date) * 1000;
        let durationStr = String(format: "%.3f", duration);
        print("result:\(rs), duration:\(durationStr)");
    }
    
    // 链表不熟，所以用数组来做
    // 思路: 反转数组相加，进位存储
    // 顺便记录个swift的小tip: 数组不能隔空插入:)
    static func func1(first: [Int], second: [Int]) -> [Int] {
        var array : [Int] = [];
        
        // 区分长短数组，避免后续越界
        var maxArray:[Int], minArray:[Int];
        if first.count < second.count {
            minArray = first;
            maxArray = second;
        } else {
            maxArray = first;
            minArray = second;
        }
        
        // 保存的进位信息
        var tmp = 0;
        
        for index in 0..<minArray.count {
            let firstNum = maxArray[maxArray.count-1-index];
            let secondNum = minArray[minArray.count-1-index];
            let sum = firstNum + secondNum + tmp;
            let i = sum % 10;
            tmp = sum / 10;
            array.insert(i, at: index);
        }

        for index in minArray.count..<maxArray.count {
            let num = maxArray[index];
            let sum = num + tmp;
            let i = sum % 10;
            tmp = sum / 10;
            array.insert(i, at: index);
        }
        
        if tmp > 0 {
            let count = array.count;
            array.insert(tmp, at: count);
        }
        
        return array;
    }
}
