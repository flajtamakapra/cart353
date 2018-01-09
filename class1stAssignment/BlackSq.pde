class BlackGridSquare {

  int x;
  int y;
  int size;
  int col = 0;
  float food;

 // boolean white;

  BlackGridSquare(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;

   // this.white = white;

    // establish a random amount of food to start with
    this.food = random(500, 1000);
  }

  void render() {

      // reflect the amount of food
      col = (int)map(this.food, 0, 1000, 255, 0);
    fill(col, 10);
    rect(this.x * size, this.y * size, size, size);
  }

  void update() {
    if(this.food > 0) {
      this.food--;
    }
  }

  void feed() {
    if (this.food < 1000) {
      this.food += 10;
      
    }
  }
}