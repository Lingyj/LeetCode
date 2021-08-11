//
//  No_4.swift
//  LeetCode
//
//  Created by 凌永剑 on 2021/8/7.
//

import Foundation

class MidianOfTwoSortedArrays {
    static func test() -> Void {
//        let nums1 = [1,3], nums2 = [2];
//        let nums1 = [1,2], nums2 = [3,4];
        let nums1 = [0,1,2,4,7], nums2 = [2,5,6];
//        let nums1 = [1,2,3,4,5], nums2 = [6,7,8];
//        let nums1 = [1,2,3,4,5,6,7], nums2 = [9];

        
//        excuteAndPrint(nums1: nums1, nums2: nums2, excuteFunc: func1(nums1:nums2:));
//        excuteAndPrint(nums1: nums1, nums2: nums2, excuteFunc: func2(nums1:nums2:));
        excuteAndPrint(nums1: nums1, nums2: nums2, excuteFunc: func3(nums1:nums2:));
//        excuteAndPrint(nums1: nums1, nums2: nums2, excuteFunc: func4(nums1:nums2:));
        
//        print(findMid(nums1: nums1, nums2: nums2, index: 0));
//        print(findMid(nums1: nums1, nums2: nums2, index: 1));
//        print(findMid(nums1: nums1, nums2: nums2, index: 2));
//        print(findMid(nums1: nums1, nums2: nums2, index: 3));
//        print(findMid(nums1: nums1, nums2: nums2, index: 4));
        print(findMid(nums1: nums1, nums2: nums2, index: 5));
//        print(findMid(nums1: nums1, nums2: nums2, index: 6));
//        print(findMid(nums1: nums1, nums2: nums2, index: 7));
    }
    
    static func excuteAndPrint(nums1 : [Int], nums2 : [Int] , excuteFunc: ([Int], [Int]) -> ([Int])) {
        let date : NSDate = NSDate();
        let rs = excuteFunc(nums1, nums2);
        let duration = NSDate().timeIntervalSince(date as Date) * 1000;
        let durationStr = String(format: "%.3f", duration);
        print("result:\(rs), duration:\(durationStr)");
    }
    
    // 合并，排序，取中间值 😂
    static func func1(nums1 : [Int], nums2 : [Int]) -> [Int] {
        guard (nums1.count + nums2.count) > 2 else {
            return nums1 + nums2;
        }
        
        let array = nums1 + nums2;
        let sortArray = array.sorted();
        
        if (sortArray.count % 2 == 0) {
            return Array(sortArray[(sortArray.count/2-1)...(sortArray.count/2)]);
        } else {
            let index = (Int)(sortArray.count/2);
            return [sortArray[index]];
        }
    }
    
    // 自排序数组
    static func func2(nums1 : [Int], nums2 : [Int]) -> [Int] {
        guard (nums1.count + nums2.count) > 2 else {
            return nums1 + nums2;
        }
        
        var sortArray : [Int] = [];
        if (nums1.count == 0 || nums2.count == 0) {
            sortArray = nums1 + nums2;
        } else {
            let maxIndex = nums1.count + nums2.count - 1;
            
            let firstArrayFirstItem = nums1[0];
            let secondArrayFirstItem = nums2[0];
            
            var firstArrayIndex = 0;
            var secondArrayIndex = 0;
            var cacheNum : Int = 0;
            var isFirst : Bool = true;
            
            if (firstArrayFirstItem < secondArrayFirstItem) {
                firstArrayIndex += 1;
                cacheNum = secondArrayFirstItem;
                sortArray.insert(firstArrayFirstItem, at: 0);
            } else {
                secondArrayIndex += 1;
                cacheNum = firstArrayFirstItem;
                sortArray.insert(secondArrayFirstItem, at: 0);
            }
                        
            for i in 1..<maxIndex{
                var currentNum : Int;
                if (firstArrayIndex == nums1.count) {
                    currentNum = nums2[secondArrayIndex+1];
                } else if (secondArrayIndex == nums2.count) {
                    currentNum = nums1[firstArrayIndex+1];
                } else {
                    currentNum = isFirst ? nums1[firstArrayIndex] : nums2[secondArrayIndex];
                }
                    
                if (currentNum > cacheNum) {
                    isFirst = !isFirst;
                    sortArray.insert(cacheNum, at: i);
                    cacheNum = currentNum;
                } else {
                    sortArray.insert(currentNum, at: i);
                }
                
                if isFirst {
                    firstArrayIndex+=1;
                } else {
                    secondArrayIndex+=1;
                }
            }
            
            sortArray.append(cacheNum);
        }
        
        if (sortArray.count % 2 == 0) {
            return Array(sortArray[(sortArray.count/2-1)...(sortArray.count/2)]);
        } else {
            let index = (Int)(sortArray.count/2);
            return [sortArray[index]];
        }
    }
    
    // 自排序数组，不完全排序，只排序到到中分位
    static func func3(nums1 : [Int], nums2 : [Int]) -> [Int] {
        guard (nums1.count + nums2.count) > 2 else {
            return nums1 + nums2;
        }
        
        guard (nums1.count > 0 && nums2.count > 0) else {
            let array = nums1 + nums2;
            if (array.count % 2 == 0) {
                return Array(array[(array.count/2-1)...(array.count/2)]);
            } else {
                let index = (Int)(array.count/2);
                return [array[index]];
            }
        }
        
        var sortArray : [Int] = [];
        let totalCount = nums1.count + nums2.count;
        let middleIndex : Int = totalCount / 2;
        
        let firstArrayFirstItem = nums1[0];
        let secondArrayFirstItem = nums2[0];
        
        var firstArrayIndex = 0;
        var secondArrayIndex = 0;
        var cacheNum : Int = 0;
        var isFirst : Bool = true;
        
        if (firstArrayFirstItem < secondArrayFirstItem) {
            firstArrayIndex += 1;
            cacheNum = secondArrayFirstItem;
            sortArray.insert(firstArrayFirstItem, at: 0);
        } else {
            secondArrayIndex += 1;
            cacheNum = firstArrayFirstItem;
            sortArray.insert(secondArrayFirstItem, at: 0);
        }
                    
        for i in 1...middleIndex {
            var currentNum : Int;
            if (firstArrayIndex == nums1.count) {
                currentNum = nums2[secondArrayIndex+1];
            } else if (secondArrayIndex == nums2.count) {
                currentNum = nums1[firstArrayIndex+1];
            } else {
                currentNum = isFirst ? nums1[firstArrayIndex] : nums2[secondArrayIndex];
            }
                
            if (currentNum > cacheNum) {
                isFirst = !isFirst;
                sortArray.insert(cacheNum, at: i);
                cacheNum = currentNum;
            } else {
                sortArray.insert(currentNum, at: i);
            }
            
            if isFirst {
                firstArrayIndex+=1;
            } else {
                secondArrayIndex+=1;
            }
        }
            
        if (sortArray.count % 2 == 0) {
            let index = sortArray.count-1;
            return [sortArray[index]];
        } else {
            return Array(sortArray[(sortArray.count-2)...(sortArray.count-1)]);
        }
    }
    
    static func func4(nums1 : [Int], nums2 : [Int]) -> [Int] {
        guard (nums1.count + nums2.count > 2) else {
            return nums1 + nums2;
        }

        let mid1 : Int = (nums1.count-1) / 2;
        let sub1 = nums1[0...mid1];
        let sub2 = nums1[mid1+1...nums1.count-1];
        
        let mid2 : Int = (nums2.count-1) / 2;
        let sub3 = nums2[0...mid2];
        let sub4 = nums2[mid2+1...nums2.count-1];
        
        let newNums1 = sub1.last! < sub3.last! ? Array(sub3) : Array(sub1);
        var newNums2 : [Int];
        if (sub2.first == nil) {
            newNums2 = Array(sub4);
        } else if (sub4.first == nil) {
            newNums2 = Array(sub2);
        } else {
            newNums2 = (sub2.first! < sub4.first! ? Array(sub2) : Array(sub4));
        }
        return func4(nums1: newNums1, nums2: newNums2);
    }
    
    static func findMid(nums1 : [Int], nums2 : [Int], index : Int) -> Int {
        print(nums1);
        print(nums2);
        print(index);
        print("---");
        
        // 有一个数组为0，直接取index
        if (nums1.count == 0 || nums2.count == 0) {
            return (nums1+nums2)[index];
        }

        // index为0，仅需比较第一个
        if (index == 0) {
            return min(nums1.first!, nums2.first!);
        }

        let minLenght = min(nums1.count, nums2.count);
        // 偏移的index
        var midIndex = 0;
        if (index <= minLenght) {
            // 由于是index，所以新数组长度需要减1之后折半
            midIndex = (index-1) / 2;
        } else {
            // index大于数组长度，会导致越界，因此新的index为length-1
            midIndex = minLenght - 1;
        }
        
        let newNums1 = Array(nums1[0..<(midIndex+1)]);
        let newNums2 = Array(nums2[0..<(midIndex+1)]);
        
        if (newNums1.last! < newNums2.last!) {
            return findMid(nums1: Array(nums1[midIndex+1..<nums1.count]), nums2: nums2, index: index-midIndex-1);
        } else {
            return findMid(nums1: nums1, nums2: Array(nums2[midIndex+1..<nums2.count]), index: index-midIndex-1);
        }
    }
}
