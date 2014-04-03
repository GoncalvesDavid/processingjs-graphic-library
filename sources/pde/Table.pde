public class Table {
  
  /*
   * The title of the tab.
   */
  private String title;
  /*
   * The square behind the title.
   */
  private Box tab;
  
  /*
   * The size of the title.
   */
   private int sizeOfText;
   
   /*
    * True if the tab is selected.
    */
   private boolean selected;
   
   /*
    * The background color of the tab.
    */
   private int bgColor;
  
  /*
   * Creates a new table with the given title, position and sizeOfText. 
   * WARNING : Changes the sizeOfText to newsizeOfText.
   * Try to find :
   * x = savesizeOfText
   * ...
   * ...
   * sizeOfText(x);
   */
  public Table(String newTitle, Position top, int newTextSize, int backGrColor) {
    
    this.title = newTitle;    
    this.sizeOfText = newTextSize;
    textSize(this.sizeOfText);
    this.tab = new  Box(top, int(textWidth(title)), this.sizeOfText);
    
    this.bgColor = backGrColor;
    
  }
  
  /*
   * Sets the textSize to textSize. Suppress the stroke. Set the textAlign to the left.
   * And draw the tab.
   */
  public void drawBox() {
    noStroke();
    textSize(this.sizeOfText);
    textAlign(LEFT);
    
    // If the current tab, set its background white, otherwise use pale gray
    fill(this.selected ? this.bgColor : 224);
    this.tab.drawBox();
    //rect(this.getLC().getX(), this.getLC().getY(), textWidth(this.title), this.boxHeight);
    
    // If the current tab, use black for the text, otherwise use dark gray
    fill(this.selected ? 0 : 64);
    text(title, this.tab.getLC().getX(), int((this.tab.getRC().getY()-this.sizeOfText*0.2)));
  }
  
  /*
   * Returns the bottom right corner position of the table. 
   */
  public Position getRC(){ 
    return this.tab.getRC();
  }
  
  /*
   * Sets the left corner position of the table.
   */
  public void setLC(int x, int y) {
    this.tab.setLC(x,y);
  }
  
  /*
   * Gets the width of the table.
   */
  public int getWidth() {
    return this.tab.getWidth();
  }
  
  /*
   * Gets the height of the table.
   */
  public int getHeight() {
    return this.tab.getHeight();
  }
  
  /*
   * Return true if the position is inside the tab.
   */
  public boolean isInside(Position p) {
    return this.tab.contains(p);
  }
  
  /*
   * Sets the background color.
   */
  public void setBgColor(int c){
    if (c >= 0 && c <= 255) {
      this.bgColor=c;
    }
  }
  
  /*
   * Returns the background color of the table.
   */
  public int getBgColor(){return this.bgColor;}
  /*
   * Changes the state of the table to selected.
   */
  public void select(){this.selected = true;}
  /*
   * Changes the state of the table to unselected.
   */
  public void unselect(){this.selected = false;}
  
  /*
   * Return true if the state of the table is selected.
   */
  public boolean isSelected(){
  return this.selected;
}
  
  
}
