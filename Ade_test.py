import unittest
from Ade_app import CartItem, ShoopingCart

'''
========================================
Graded Challange 1 of Phase 0
Hacktiv8 FTDS

Name: Ade William tabrani
Batch: Remote - 026 (RMT-026)

Assignment objective: to test student's ability in unit testing.

About the code:
    This is the test program for the main program to see if it run as intended
=======================================
'''

cart = CartItem()
shoop = ShoopingCart()
class UnitTest(unittest.TestCase):
    def test_itemAdder(self):
        '''
        testing item adder function.
        '''
        #input:
        newItemName = 'testonly'
        newItemPrice = 5000
        #process:
        addItem = shoop.itemAdder(newItemName, newItemPrice)
        #output:
        self.assertEqual(len(addItem), 2) #2 bcs it takes in two inputs and store them

    def test_itemDeleter(self):
        '''
        testing item deleter function.
        '''
        #input:
        deleteWhichItem = 'testonly'
        #process:
        removeItem = shoop.itemDeleter(deleteWhichItem)
        #output
        self.assertEqual(len(cart.itemName), 0)

    def test_priceSum(self):
        '''
        testing the price adder/totaler function.
        '''
        #input:
        shoop.itemAdder('test1', 3000000)
        shoop.itemAdder('test2', 3500000)
        #process:
        sumOfPrice = shoop.priceSum()
        #output:
        self.assertEqual(sumOfPrice, 6500000)


if __name__ == '__main__':
    unittest.main()