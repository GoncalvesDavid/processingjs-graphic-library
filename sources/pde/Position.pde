/*
 * Represents a position on the screen. 
 * (0,0) is the top left corner.
 */
public class Position {
  /*
   * The x coordinates of the position.
   */
  private int x;
  /*
   * The y coordinates of the position.
   */
  private int y;
  
  /*
   * Creates a new position inside the size of the sketch.
   */
  public Position(int newX, int newY){
    if(newX > width) this.x = width;
    else if(newX < 0) this.x = 0;
    else this.x = newX;
    if(newY > height) this.y = height;
    else if(newY < 0) {this.y = 0;}
    else this.y = newY;

  }

  /*
   * Get the x position.
   */
  public int getX(){
    return this.x;
  }
  /*
   * Get the y position.
   */
  public int getY(){
    return this.y;
  }
  
  /*
   * Returns a new position according to the actual position with the given delta's. 
   */
  public Position getPositionOffset(int deltaX, int deltaY) {
    return new Position(this.x + deltaX, this.y + deltaY);
  }
  
  /*
   * Returns "(x,y)".
   */
  public String toString() {
    return  "("+this.getX()+","+this.getY()+")";
  }
}
