from typing import List
from functools import reduce
import sys
import traceback

#################
### Problem  1 ##
#################


# def assoc_list(l):
#     return []

def assoc_list(l):
    cnt = [reduce(lambda x, y: x + (1 if y == p else 0), l, 0) for p in l]
# using reduce to count all occurance of each and every element
# zipping l and cnt then making a set
# to delete repeating values
# then turning the set to a list
    return list(set(zip(l,cnt)))
result = assoc_list([1, 2, 2, 1, 3])
result.sort(key=lambda x:x[0]) # sort the result by the first element of a tuple
assert(result == [(1, 2), (2, 2), (3, 1)])

#################
### Problem  2 ##
#################


# def buckets(f, l):
#     return []

def buckets (equiv, lst):
    classes = []
    
    for index in range(len(lst)):
        a = lst[index]
        
        for b in lst:
            if equiv(a, b):
                if len(classes) <= index: 
                    classes.append([b])
                else:
                    classes[index] += [b]
                    
    for sublist in classes:
        while classes.count(sublist) > 1:
            rindex = classes[:: - 1].index(sublist)
            del classes[len(classes) - 1 - rindex]
            
    return classes


###################################
# Definition for a binary tree node
###################################

class TreeNode:
    def __init__(self, val=None, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

    # construct tree from a list of values `ls`
    def list_to_tree(self, ls):
        self.val = self.left = self.right = None  # clear the current tree

        if not ls:  # ls is None or l == []
            return  # tree is None

        i = 0
        self.val = ls[i]
        queue = [self]
        while queue:  # while queue is not empty
            i += 1
            node = queue.pop(0)
            if node.val is None:
                continue

            if 2*i - 1 >= len(ls) or ls[2*i-1] is None:
                pass
            else:
                node.left = TreeNode(ls[2*i-1])
                queue.append(node.left)

            if 2*i >= len(ls) or ls[2*i] is None:
                pass
            else:
                node.right = TreeNode(ls[2*i])
                queue.append(node.right)


#################
### Problem  3 ##
#################

# def level_order(root: TreeNode):
#     return []
def level_order(root: TreeNode):
    if not root:
        return []
    queue = [root]
    res = []
    level = 0
    while queue:
        res.append([])
        for _ in range(len(queue)):
            node = queue.pop(0)
            res[level].append(node.val)
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
        level += 1
    return res

#################
### Problem  4 ##
#################

# def pathSum(root: TreeNode, targetSum: int) -> List[List[int]]:
#     return []


# def dfs(root: TreeNode, target: int, prev_sum: int, my_list: list):
#     if not root:
#         return
    
#     prev_sum += root.val
#     my_list.append(root.val)

#     if prev_sum == target and root.left == None and root.right == None:
#         res.append(my_list[:])

#     dfs(root.left, target, prev_sum, my_list)
#     dfs(root.right, target, prev_sum, my_list)
#     my_list.pop()


# def pathSum(sroot: TreeNode, targetSum: int):  # -> List[List[int]]:
#     dfs(sroot, targetSum, 0, [])
#     return res


# root_1 = TreeNode()
# root_1.list_to_tree([5, 4, 8, 11, None, 13, 4, 7, 2, None, None, 5, 1])

# root_2 = TreeNode()
# root_2.list_to_tree([1, 2, 3])

def pathSum(root: TreeNode, targetSum: int):
    def solve(root, path, paths, targetSum):
        if root is None:
            return
        #check if it is the leaf node
        if not root.left and not root.right:
            #then check if the targetValue is matched
            if targetSum == root.val:
                path.append(root.val)
                paths.append(path)
                return

        #call the left and right subtree
        solve(root.left, path+[root.val], paths, targetSum-root.val)
        solve(root.right, path+[root.val], paths, targetSum-root.val)

        return paths
    #check if the value of root is None
    if root is None:
        return

    #now check if the root nodes is the leaf node if yes then return
    if root.val == 1 and not root.left and not root.right:
        if targetSum == 1:
            return [[1]]

    path = []
    paths = []
    #function for find the paths
    return solve(root, path, paths, targetSum)


# assert (pathSum(root_1, 22) == [[5, 4, 11, 2], [5, 8, 4, 5]])



#################
### Test cases ##
#################

def main():
    print("Testing your code ...")
    error_count = 0

    # Testcases for Problem 1
    try:
        result = assoc_list([1, 2, 2, 1, 3])
        result.sort(key=lambda x: x[0])
        assert (result == [(1, 2), (2, 2), (3, 1)])

        result = assoc_list(["a", "a", "b", "a"])
        result.sort(key=lambda x: x[0])
        assert (result == [("a", 3), ("b", 1)])

        result = assoc_list([1, 7, 7, 1, 5, 2, 7, 7])
        result.sort(key=lambda x: x[0])
        assert (result == [(1, 2), (2, 1), (5, 1), (7, 4)])
    except AssertionError as err:
        error_count += 1
        _, _, tb = sys.exc_info()
        traceback.print_tb(tb)
    except:
        error_count += 1
        print("Unexpected error:", sys.exc_info()[0])
        _, _, tb = sys.exc_info()
        traceback.print_tb(tb)

    # Testcases for Problem 2
    try:
        assert (buckets(lambda a, b: a == b, [
                1, 2, 3, 4]) == [[1], [2], [3], [4]])
        assert (buckets(lambda a, b: a == b, [1, 2, 3, 4, 2, 3, 4, 3, 4]) == [
                [1], [2, 2], [3, 3, 3], [4, 4, 4]])
        assert (buckets(lambda a, b: a % 3 == b %
                3, [1, 2, 3, 4, 5, 6]) == [[1, 4], [2, 5], [3, 6]])
    except AssertionError as err:
        error_count += 1
        _, _, tb = sys.exc_info()
        traceback.print_tb(tb)
    except:
        error_count += 1
        print("Unexpected error:", sys.exc_info()[0])
        _, _, tb = sys.exc_info()
        traceback.print_tb(tb)

    # Specify 3 trees for testing problems 3 & 4
    root_1 = TreeNode()
    root_1.list_to_tree([5, 4, 8, 11, None, 13, 4, 7, 2, None, None, 5, 1])

    root_2 = TreeNode()
    root_2.list_to_tree([1, 2, 3])

    root_3 = TreeNode()
    root_3.list_to_tree([1, 2])

    # Testcases for Problem 3
    try:
        assert (level_order(root_1) == [
                [5], [4, 8], [11, 13, 4], [7, 2, 5, 1]])
        assert (level_order(root_2) == [[1], [2, 3]])
        assert (level_order(root_3) == [[1], [2]])
    except AssertionError as err:
        error_count += 1
        _, _, tb = sys.exc_info()
        traceback.print_tb(tb)
    except:
        error_count += 1
        print("Unexpected error:", sys.exc_info()[0])
        _, _, tb = sys.exc_info()
        traceback.print_tb(tb)

    # Testcases for Problem 4
    try:
        assert (pathSum(root_1, 22) == [[5, 4, 11, 2], [5, 8, 4, 5]])
        assert (pathSum(root_2, 4) == [[1, 3]])
        assert (pathSum(root_3, 0) == [])
    except AssertionError as err:
        error_count += 1
        _, _, tb = sys.exc_info()
        traceback.print_tb(tb)
    except:
        error_count += 1
        print("Unexpected error:", sys.exc_info()[0])
        _, _, tb = sys.exc_info()
        traceback.print_tb(tb)

    print(f"{error_count} out of 4 programming questions are incorrect.")


main()
