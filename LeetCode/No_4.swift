//
//  No_4.swift
//  LeetCode
//
//  Created by 凌永剑 on 2021/8/7.
//

import Foundation

class MidianOfTwoSortedArrays {
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
            let totalCount = nums1.count + nums2.count;
            
            let firstArrayFirstItem = nums1[0];
            let secondArrayFirstItem = nums2[0];
            
            var firstArrayIndex = 0;
            var secondArrayIndex = 0;
            var cacheNum : Int = 0;
            var isFirst : Bool = true;
            
            if (firstArrayFirstItem < secondArrayFirstItem) {
                firstArrayIndex += 1;
                cacheNum = secondArrayFirstItem;
                sortArray.append(firstArrayFirstItem);
            } else {
                secondArrayIndex += 1;
                cacheNum = firstArrayFirstItem;
                sortArray.append(secondArrayFirstItem);
            }
                        
            for i in 1...totalCount {
                if (firstArrayIndex == nums1.count || secondArrayIndex == nums2.count) {
                    sortArray.append(contentsOf: nums1[firstArrayIndex..<nums1.count]);
                    sortArray.append(contentsOf: nums2[secondArrayIndex..<nums2.count]);
                    cacheNum = NSIntegerMax;
                    break;
                }
                
                let currentNum = isFirst ? nums1[firstArrayIndex] : nums2[secondArrayIndex];
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
            
            if (cacheNum != NSIntegerMax) {
                sortArray.append(cacheNum);
            }
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
        let i = findMid(nums1: nums1, nums2: nums2, index: (nums1.count+nums2.count+1)/2);
        let j = findMid(nums1: nums1, nums2: nums2, index: (nums1.count+nums2.count+2)/2);
        return [i, j];
    }
    
    // index从1开始计数
    static func findMid(nums1 : [Int], nums2 : [Int], index : Int) -> Int {
        if (nums1.count > nums2.count) {
            return findMid(nums1: nums2, nums2: nums1, index: index);
        }
        
        // 第一个数组为0，直接取第二个数组
        if (nums1.count == 0) {
            return nums2[index-1];
        }
        
        // 递归结束
        if (index == 1) {
            return min(nums1.first!, nums2.first!);
        }

        let minLenght = min(nums1.count, nums2.count);
        // 偏移的index
        // index/2 保证只丢掉index前面的数据
        var offsetIndex = index / 2;
        // ⚠️坑点: 如果数组长度小于index，则不能折半，只能取最小数组长度，否则将越界⚠️
        offsetIndex = min(offsetIndex, minLenght);
        
        let newNums1 = Array(nums1[0..<offsetIndex]);
        let newNums2 = Array(nums2[0..<offsetIndex]);
        
        if (newNums1.last! < newNums2.last!) {
            return findMid(nums1: Array(nums1[offsetIndex..<nums1.count]), nums2: nums2, index: index-offsetIndex);
        } else {
            return findMid(nums1: nums1, nums2: Array(nums2[offsetIndex..<nums2.count]), index: index-offsetIndex);
        }
    }
    
    //MARK: - print
    static func excuteAndPrint(nums1 : [Int], nums2 : [Int] , excuteFunc: ([Int], [Int]) -> ([Int])) {
        let date : NSDate = NSDate();
        let rs = excuteFunc(nums1, nums2);
        let duration = NSDate().timeIntervalSince(date as Date) * 1000;
        let durationStr = String(format: "%.3f", duration);
        print("result:\(rs), duration:\(durationStr)");
    }
    
    // MARK: - test
    static func test() -> Void {
//        let nums1 = [1,3], nums2 = [2];
//        let nums1 = [1,2], nums2 = [3,4];
//        let nums1 = [0,1,2,4,7], nums2 = [2,5,6];
//        let nums1 = [1,2,3,4,5], nums2 = [6,7,8];
//        let nums1 = [1,2,3,4,5,6,7], nums2 = [9];

        let nums1 = getRandomIntArrayWithMaxCount(count: 20).sorted(by: {$0 < $1});
        let nums2 = getRandomIntArrayWithMaxCount(count: 20).sorted(by: {$0 < $1});
        
        
//        let nums1 = [1, 1, 2, 3];
//        let nums2 = [1, 1, 3, 3, 7, 7, 8, 10, 10, 11, 11, 11, 12, 13, 13, 15, 17, 17];
        
        print(nums1);
        print(nums2);
        
        excuteAndPrint(nums1: nums1, nums2: nums2, excuteFunc: func1(nums1:nums2:));
        excuteAndPrint(nums1: nums1, nums2: nums2, excuteFunc: func2(nums1:nums2:));
//        excuteAndPrint(nums1: nums1, nums2: nums2, excuteFunc: func3(nums1:nums2:));
        excuteAndPrint(nums1: nums1, nums2: nums2, excuteFunc: func4(nums1:nums2:));
        
        testFindMid();
    }
    
    static func testFindMid () -> () {
        let nums1 = getRandomIntArrayWithMaxCount(count: 20).sorted(by: {$0 < $1});
        let nums2 = getRandomIntArrayWithMaxCount(count: 20).sorted(by: {$0 < $1});
    
        var result : [Int] = [];
        let sort = (nums1 + nums2).sorted();
        
        for i in 1...(nums1.count+nums2.count) {
            result.append(findMid(nums1: nums1, nums2: nums2, index: i));
        }
        
        var isCorrect = true;
        var errorIndex = 0;
        for index in 0..<sort.count {
            if (isCorrect == false) {
                errorIndex = index;
                break;
            }
            
            let i = result[index];
            let j = sort[index];
            isCorrect = (i == j);
        }
        
        if (isCorrect == false) {
            print("nums1:\(nums1)");
            print("nums2:\(nums2)");
            print("errorAt:\(errorIndex)");
        }
        
        assert(isCorrect);
    }
}
