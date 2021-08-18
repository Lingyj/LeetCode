//
//  No_1.swift
//  LeetCode
//
//  Created by 凌永剑 on 2021/8/6.
//

import Foundation

class TwoNum {
    static func test() -> Void {
//        let nums = [2,7,11,15];
        let nums = [2,7,11,15,12,13,122,312,32,33,45,456,3];
        let target = 5;

        excuteAndPrint(nums: nums, target: target, excuteFunc: func0(nums:target:));
        excuteAndPrint(nums: nums, target: target, excuteFunc: func1(nums:target:));
        excuteAndPrint(nums: nums, target: target, excuteFunc: func2(nums:target:));
        excuteAndPrint(nums: nums, target: target, excuteFunc: func3(nums:target:));
    }
    
    static func excuteAndPrint(nums: [Int], target: Int, excuteFunc: ([Int], Int) -> (Int?, Int?)) {
        let date : NSDate = NSDate();
        let rs = excuteFunc(nums, target);
        let duration = NSDate().timeIntervalSince(date as Date) * 1000;
        let durationStr = String(format: "%.3f", duration);
        print("first index:\(rs.0!), second index:\(rs.1!), duration:\(durationStr)");
    }

    // 遍历呗，暴力破解:)
    static func func0(nums: [Int], target: Int) -> (Int?, Int?) {
        var first : Int?
        var second : Int?
        
        for i in 0..<nums.count {
            let num = nums[i]
            for j in 0..<nums.count {
                let secNum = nums[j]
                
                if num + secNum == target {
                    first = i;
                    second = j;
                    break;
                }
            }
            
            if first != nil {
                break;
            }
        }
        
        return (first, second);
    }
    
    // 遍历呗，暴力破解，顺带试试swift的enumerated ^^
    static func func1(nums: [Int], target: Int) -> (Int?, Int?) {
        var first : Int?
        var second : Int?
        
        for (i, num) in nums.enumerated() {
            for (j, secNum) in nums.enumerated() {
                if i == j {
                    continue;
                }
                
                if num + secNum == target {
                    first = i;
                    second = j;
                    break;
                }
            }
            
            if first != nil {
                break;
            }
        }
        
        return (first, second);
    }

    // 依旧是遍历，优化细节，第二轮从上一轮结束的地方开始
    static func func2(nums: [Int], target: Int) -> (Int?, Int?) {
        var first : Int?
        var second : Int?
        
        for i in 0..<nums.count {
            let num = nums[i]
            for j in i+1..<nums.count {
                let secNum = nums[j]
                
                if num + secNum == target {
                    first = i;
                    second = j;
                    break;
                }
            }
            
            if first != nil {
                break;
            }
        }
        
        return (first, second);
    }
    
    // 试了下map，从时间来看没什么卵用
    // 个人觉得网上的所谓hashmap最优解，无非借助了语言的底层优化，把自己遍历的时间，交给了hashmap
    // 依赖于hashmap的优化，和自己写个查询算法有什么区别呢？
    static func func3(nums: [Int], target: Int) -> (Int?, Int?) {
        var first : Int?
        var second : Int?

        var dict = [Int : Int]()
        for index in 0..<nums.count {
            dict[nums[index]] = index;
        }
        
        for index in 0..<nums.count {
            let discount = target - nums[index];
            if let secIndex = dict[discount] {
                first = index;
                second = secIndex;
                break;
            }
        }
        
        return (first, second)
    }
}
