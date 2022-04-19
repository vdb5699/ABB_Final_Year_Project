class WriteToNote:
    def __init__(self, arr):
        self.content = arr
        
    def write(self):
        for x in range(len(self.content)):
            if x == 0:
                f = open("coord_store.txt", w)
            else:
                f = open("coord_store.txt", a)
            str =self.content[x][0] + " " + self.content[x][1]
            f.write(str)
            f.close()


    def set_arr(self, array):
        self.content = array