/*
 * Represents an array of tables.
 */
public class TabArray implements MouseEventHandler {
  
  
  /*
   * The list of managed tables.
   */
  private ArrayList<Table> tables;
  
  /*
   * The top left corner position of the Array of Tables.
   */
  private Position pos;
  
  /*
   * The text size used by all the tables of this array.
   */
  private int textSize;
  
  
  /*
   * Creates a new empty TabArray with the given position and text size.
   */
  public TabArray(Position p, int newTextSize) {
    this.tables = new ArrayList<Table>();
    this.pos = p;
    this.textSize = newTextSize;
  }
  
  /*
   * Add a table to the array with the given title.
   */
  public void addTab(String title, int bgColor){
    Position pos;
    
   if (this.tables.size() > 0) 
     pos = new Position(this.tables.get(this.tables.size()-1).getRC().getX(),this.pos.getY());
    else
      pos = this.pos;
    
    this.tables.add(new Table(title, pos,this.textSize,bgColor));
    
  }
  
  /*
   * Draw all the tables of the array. 
   * The corresponding tab in the array will be highlighted.  
   */
  public void drawTables() {
    for(int i = 0; i<this.tables.size();i++){
      if(this.tables.get(i).isSelected())
      this.tables.get(i).drawBox();
      else
      this.tables.get(i).drawBox();
    }
  }
  
  /*
   * Sets the left corner position of the array.
   */
  public void setPosition(int x, int y) {
    this.pos = new Position(x,y);
    this.repositionTables();
  }
  
  /*
   * Re-positions the tables according to the actual position of the array.
   */
  private void repositionTables(){
    for(int i = 0; i<this.tables.size();i++){
      if (i ==0) 
        this.tables.get(i).setLC(this.pos.getX(),this.pos.getY() );
      else 
        this.tables.get(i).setLC(this.tables.get(i-1).getRC().getX(),this.pos.getY() );
    }
  }
  
  /*
   * Gets the width of the table.
   */
  public int getWidth(){
    int result = 0;
    for (int i = 0; i < this.tables.size();i++){
      result += this.tables.get(i).getWidth();
    }
    return result;
  }
  
  /*
   * Get the height of the table.
   */
  public int getHeight() {
    return this.tables.get(0).getHeight();
  }
  
  /*
   * Get the tab at the position p.
   */
  public int getTab(Position p) {
    for (int i = 0 ; i<this.tables.size();i++){
      if(this.tables.get(i).isInside(p)) return i;
    }
    return -1;
  }
  /*
   * Get the background color of the given tab (selected by position).
   */
  public int getBgColor(int tab){
    return this.tables.get(tab).getBgColor();
  }
  /*
   * If the click is on a tab, select of unselect it.
   */
  public void handleClick(Position mousePostion) {
    int tab = getTab(mousePostion);
    if(tab != -1){
      Table t = this.tables.get(tab);
      if (t.isSelected()) {t.unselect();}
      else t.select();
    }
  }
  /*
   * Empty method.
   */
  public void handleRelease(Position mousePostion){}
  /*
   * Empty method.
   */
 public void handleDrag(Position mousePostion){}
 /*
  * Set the tab (t the gieven position) selected.
  */ 
  public void setSelected(int tab){
    this.tables.get(tab).select();
  }
  /*
   * Return true if the given tab (sorted by its position) is selected.
   */
  public boolean isSelected(int tab){
  
  return this.tables.get(tab).isSelected();
}
}
