class Elem:
    def __init__(self):
        self.P = None
        self.L = None
    
    def saveToDisk(self):
        '''
        resave an elem's new data to disk
        '''
        pass

    def calculated(self):
        '''
        whether has been calculated
        '''
        pass

    def reload(self):
        '''
        reload information from disk
        '''
        pass

class PagerankCalculator():
    def __init__(self):
        self.initEveryElemRank()
    
    def initEveryElemRank():
        '''
        init each elem's initial rank to 1/N
        and save them to disk
        '''
        pass

    def allCalculated():
        '''
        whether all elements are calculated and resaved
        '''
        pass

    def calRank(self):
        '''
        main program
        '''
        while not close_enough():
            while not self.allCalculated():
                #random select an elem that has not been calculated
                elem = self.selectOneNotCalculatedElem()
                while elem.hasNeighbour():
                    neighbours = elem.getNeighboursFromDisk() # List of Elem objects

                    for neighbour in nabours:
                        elem.P += k * neighbour.P / neighbour.L
                    elem.p += (1-k) * (1 / N)
                    elem.saveToDisk()

                    for neighbour in neighbours:
                        elem = neighbour.reload()

                        if elem.Calculated():
                            continue

                    elem = neighbours
