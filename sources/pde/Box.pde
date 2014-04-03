/*
 * Represents a rectangular shape. Its is defined by its position, width and height. 
 */
public class Box {
  
  /*
   * Position to define the box top left corner position.
   */
  protected Position topLeftCornerOrigin;
  
  /*
   * Width of the box.
   */
  protected int boxWidth;
  
  /*
   * Height of the box.
   */
   protected int boxHeight;
  
  /*
   * Creates a box with the given boundaries.
   */
  public Box(Position top, int newWidth, int newHeight) {
    this.topLeftCornerOrigin = top;
    this.boxWidth = newWidth;
    this.boxHeight = newHeight;
  }
  
  /*
   * Get the top left corner origin.
   */
  public Position getLC() {
    return this.topLeftCornerOrigin;    
  }
  
  /*
   * Get the bottom right corner origin.
   */
  public Position getRC() {
    return this.topLeftCornerOrigin.getPositionOffset(this.boxWidth, this.boxHeight);
  }
  
  /*
   * Get the width of the box.
   */
  public int getWidth() {return this.boxWidth;}
  /*
   * Get the height of the box.
   */
  public int getHeight() {return this.boxHeight;}
  
  
  /*
   * Draw a filled rectangle with the box boundaries.
   * No modifications are made to the drawing settings.
   */
  public void drawBox() {
    int x1= this.getLC().getX(), y1 = this.getLC().getY();;
    rect(x1,y1,this.boxWidth,this.boxHeight);
  }
  
  /*
   * Sets the boundaries of the box to the given boundaries.
   */
  public void setShape(Position top, int newWidth, int newHeight) {
    this.topLeftCornerOrigin = top;
    this.boxWidth = newWidth;
    this.boxHeight = newHeight;
  }
  
  /*
   * Sets the top left corner position of the box.
   */
  public void setLC(int x, int y) {
    this.topLeftCornerOrigin = new Position(x,y);
  }
  
  /*
   * Returns true if the position p is contained within the box boundaries.
   */
  public boolean contains(Position p ){
    if ( p.getX() < this.topLeftCornerOrigin.getX()) return false;
    if ( p.getX() > this.topLeftCornerOrigin.getX()+this.getWidth()) return false;
    if ( p.getY() < this.topLeftCornerOrigin.getY()) return false;
    if ( p.getY() > this.topLeftCornerOrigin.getY()+this.getHeight()) return false;
    return true;

  }
  
  

  
}
