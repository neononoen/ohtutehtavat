class Player:
    def __init__(self, dict):
        self.name = dict['name']
        self.nationality = dict['nationality']
        

    def __str__(self):
        return f"{self.name} {self.nationality}"