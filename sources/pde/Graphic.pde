/*
 * Main class that can handle a graphic zone. It can display data formated as:
 * X_LABEL Y0_LABEL Y1_LABEL
 * x0      y0.0     y1.0
 * x1      y0.1     y1.1
 * ...     ...      ...
 * WARNING the format is tsv (i.e : Elements are separated by \t).
 */
 
 import java.util.Iterator;
public class Graphic extends Box implements MouseEventHandler {
  /*
   * Contains the data sent by javascript.
   */
  private FloatTable data = null;
  
  /*
   * Manage the graphic plot zone.
   */
  private PlotZone plotZone;
  
  /*
   * The graphic animation calculator.
   */
  private HashMap<Integer,Integrator[]> interpolators;
  
  
  /*
   * The current column of data which is plot.
   */
  private int currentColumn;
  
  /*
   * The factor that determines the % of the graphic taken by the plot area.
   */
  private float plotZoneFactor;
  
  /*
   * the maximum space that can be allocated to the plot zone.
   */
  private Box plotZoneMax;
  
  /*
   * The tabulations managed by the graphic.
   */
  private TabArray tabulations;
  
  /*
   * The minimum index in the tab of data to display.
   */
  private int indexMinToDisplay;
  /*
   * The maximum index in the tab of data to display.
   */
  private int indexMaxToDisplay;
  
  /*
   * The y interval used to plot the y labels.
   */
   private int yInterval;
  /*
   * The x interval used to plot the x labels.
   */
   private int xInterval;
   
   private int[] bgColors;
  
  private float dataMinToDisplay;
  private float dataMaxToDisplay;
  private String YUnits;
  /*
   * Creates a graphic object with the given position, width and height. 
   * The last argument, the string of data, has to be formated as a tsv file.
   * The tabulations will be created from the first line of the string.
   * The first column is supposed to be the x axis.
   */
  public Graphic (Position p,int w, int h, String stringOfData) {
    super(p,w,h);
    this.data = new FloatTable(stringOfData);
    this.yInterval = 1;
    this.xInterval = 1;
    this.plotZoneMax = new Box(p.getPositionOffset(50,50),w-100,h-100);
    this.currentColumn = 0;
    this.plotZoneFactor = 0.00;
    this.YUnits = "units";
    this.indexMinToDisplay = 0;
    this.indexMaxToDisplay = this.data.getRowNames().length-1;
    this.plotZone = null;
    this.setPlotZone();
    
    this.bgColors  = new int[9];
    for(int i = 0; i<9;i++){
      this.bgColors[i] =#5679C1 +80*i;
    }
    
    int incr = 0;
    this.tabulations = new TabArray(p.getPositionOffset(60,30), 20);
    
    for(int i = 0; i< data.getColumnCount();i++){
      this.tabulations.addTab(data.getColumnName(i), this.bgColors[incr]);
      
      incr++;
    }
    
    this.tabulations.setSelected(0);
    
    
    interpolators = new HashMap<Integer, Integrator[]>();
    
    
    this.updateInterpolators();
    this.updateDataMinAndMax();
    
    
    
    
  }
  
  /*
   * Updates the interpolators to reach their target values.
   */
  private void updateInterpolators() {
    for(int i = 0; i< data.getColumnCount();i++){
    
      if(this.tabulations.isSelected(i)){
        
        if(!interpolators.containsKey(i)) {
          
          Integrator[] integ = new Integrator[this.data.getRowCount()];
          
          for (int row = 0; row < this.data.getRowCount(); row++) {
            float initialValue = this.data.getFloat(row, i);
            integ[row] = new Integrator(0);
            integ[row].attraction = 0.05;  // Set lower than the default
            integ[row].target(initialValue);
          }
          this.interpolators.put(i, integ);
        } else {
          
          for (int row = this.indexMinToDisplay; row <= this.indexMaxToDisplay; row++) {
             
            this.interpolators.get(i)[row].update();
            
          }
          
        }
        
      } else {         
        if(interpolators.containsKey(i)) { 
        this.interpolators.remove(i);
        } 
      }
    }
    
  }
  
  
  /*
   * TODO to delete, debug purposes
   */
  public void debug() {
    
    fill(255);
    textSize(15);
    text("(" + this.YUnits +")", this.plotZone.getLC().getX()-24,this.plotZone.getLC().getY()-5);
    text("(s)", this.plotZone.getRC().getX()+15,this.plotZone.getRC().getY()+20);
  
  
    this.plotZone.drawBox();
    fill(0);
    this.plotZoneMax.drawBox();
    float[] y;
    float[] x;
    y = new float[this.indexMaxToDisplay-this.indexMinToDisplay];
    x = new float[this.indexMaxToDisplay-this.indexMinToDisplay];
    
    for (int row = this.indexMinToDisplay; row <= this.indexMaxToDisplay; row++) {
        x[row-this.indexMinToDisplay] = float(data.getRowNames())[row];
      }    
    this.updateInterpolators();

    for(Integer i : this.interpolators.keySet()) {
      for (int row = this.indexMinToDisplay; row <= this.indexMaxToDisplay; row++) {
        y[row-this.indexMinToDisplay] = this.interpolators.get(i)[row].value;
      }
      this.plotZone.plotData(x,y,this.dataMinToDisplay,this.dataMaxToDisplay,this.bgColors[i]);
    }
    
    this.tabulations.drawTables();
    
    
    this.drawXLabels();
    this.drawYLabels();
    
  }
  
  /*
   * Sets the graph width factor to the given value.
   */
  public void setplotZoneFactor(float factor){
    if (factor > 0.0 && factor < 0.5) {
      this.plotZoneFactor = factor;
      this.setPlotZone();
    }
  }
  
  /*
   * Sets the plotZone according to the width/height & plot zone factor.
   */
  private void setPlotZone(){
    int widthOffset = int((this.plotZoneMax.getWidth())*this.plotZoneFactor);
    int heightOffset = int((this.plotZoneMax.getHeight())*this.plotZoneFactor);
    Position p1 = this.plotZoneMax.getLC().getPositionOffset(widthOffset,heightOffset);
    int w = this.plotZoneMax.getWidth()-2*widthOffset;
    int h = this.plotZoneMax.getHeight()-2*heightOffset;
    if (this.plotZone == null) this.plotZone = new PlotZone(p1, w,h);
    else this.plotZone.setShape(p1, w,h);
  }
  
  //TODO REMOVE
  public float getFactor(){
    return this.plotZoneFactor;
  }
  
  /*
   * Checks if the new position is in the boundaries of the graphic zone.
   * If it is : change the plot zone position.
   */
  public void setGraphicPosition(int x, int y){
    boolean condition = x > this.getLC().getX() && x < this.getRC().getX()-this.plotZoneMax.getWidth();
    condition = condition && y > this.getLC().getY() && y < this.getRC().getY()-this.plotZoneMax.getHeight();
    if (condition){
    this.plotZoneMax = new Box (new Position(x,y), this.plotZoneMax.getWidth(),this.plotZoneMax.getHeight());
    this.setPlotZone();
    }
  }  
  public void setTabulationsPosition(int x, int y) {
    boolean condition = x > this.getLC().getX() && x < this.getRC().getX()-this.tabulations.getWidth();
    condition = condition && y > this.getLC().getY() && y < this.getRC().getY()-this.tabulations.getHeight();
    if(condition) this.tabulations.setPosition(x,y);
  }
  
  /*
   * Draws the X labels.
   */
  private void drawXLabels() {
    int yearInterval = this.xInterval;
    
    int xMin = int(this.data.getRowNames()[this.indexMinToDisplay]);
    int xMax = int(this.data.getRowNames()[this.indexMaxToDisplay]);
    
    yearInterval = int((xMax - xMin)/5);
    if (yearInterval ==0)yearInterval=1;
    fill(234);
  textSize(10);
  textAlign(CENTER);
  
  // Use thin, gray lines to draw the grid
  stroke(224);
  strokeWeight(1);

  for (int row = xMin; row <= xMax; row++) {
    if (int(row % yearInterval) == 0) {
      float x = map(row, xMin, xMax, this.plotZone.getLC().getX(), this.plotZone.getRC().getX());
      text(row, x, this.plotZone.getRC().getY() + textAscent() + 10);
      line(x, this.plotZone.getLC().getY(), x, this.plotZone.getRC().getY());
    }
  } 
  }
  
  /*
   * Draws the Y labels.
   */
  private void drawYLabels() {
    int volumeInterval = this.yInterval;
    float plotY2 = this.plotZone.getRC().getY();
    float plotY1 = this.plotZone.getLC().getY();
    float plotX1 = this.plotZone.getLC().getX();
  
  //TODO ERASE OR ERASE UPPER IF WORKING
    volumeInterval = int((this.dataMaxToDisplay - this.dataMinToDisplay)/5);
    
    if (volumeInterval ==0)volumeInterval=1;

    //------------------
    for (float v = this.dataMinToDisplay; v <= this.dataMaxToDisplay; v++) {
      
      if (int(v) % volumeInterval == 0) {     // If a tick mark
        float y = map(v, this.dataMinToDisplay, this.dataMaxToDisplay, plotY2, plotY1);  
        float textOffset = textAscent()/2;  // Center vertically
        if (v == this.dataMinToDisplay) {
          textOffset = 0;                   // Align by the bottom
        } else if (v == this.dataMaxToDisplay) {
          textOffset = textAscent();        // Align by the top
        }
        text(floor(v), plotX1 - 15, y + textOffset);
        line(plotX1 - 4, y, plotX1, y);     // Draw major tick
        line(plotX1 - 2, y, plotX1, y);   // Draw minor tick   
      }
    }
  }
  
  /*
   * Handles a click from the mouse into the graphic.
   */
  public void handleClick(int x,int y){
    int col = this.tabulations.getTab(new Position (x,y));
    this.updateInterpolators();
  }
  
  /*
   * Sets the interval between marks on the y axis.
   */
  public void setYInterval(int y) {
    if(y>0) this.yInterval = y;
  }
  
  /*
   * Sets the interval between marks on the x axis.
   */
  public void setXInterval(int x) {
    if(x>0) this.xInterval = x;
  }
  
  
  /*
   * Sets the minimum data index to display.
   */
  public void setIndexMinToDisplay(int newX){
    boolean condition = newX >= 0 && newX < this.indexMaxToDisplay && this.indexMinToDisplay != newX;
    if (condition) {
      this.indexMinToDisplay = newX;
      this.updateDataMinAndMax();
    }
  }
  
  /*
   * Sets the maximum data index to display.
   */
  public void setIndexMaxToDisplay(int newX){
    boolean condition = newX > this.indexMinToDisplay && newX < this.data.getRowNames().length;
    condition = condition && this.indexMaxToDisplay != newX; 
    if (condition ){
      this.indexMaxToDisplay = newX;
      this.updateDataMinAndMax();
    }
  }
  
  /*
   * Finds the minimum element of the array.
   * WARNING : FUNCTION DO NOT CHECK FOR NULL 
   */
  public float getMin(int[] tab, int start, int end){
    float min = tab[start];
    for (int i =  start+1; i < end ; i++)
      if (tab[i] < min) min = tab[i];
    return min;
  }
  
  /*
   * Finds the maximum element of the array.
   * WARNING : FUNCTION DO NOT CHECK FOR NULL 
   */
  private float getMax(int[] tab, int start, int end){
    float max = tab[start];
    for (int i =  start+1; i < end ; i++)
      if (tab[i] > max) max = tab[i];
    return max;
  }  

  public void handleClick(Position mousePostion){
    this.tabulations.handleClick(mousePostion);
    this.updateInterpolators();
    this.updateDataMinAndMax();
    
  }
  public void handleRelease(Position mousePostion){};
  public void handleDrag(Position mousePostion){};
  

  private void updateDataMinAndMax(){
    //TODO IMPROVE--------------------------
    float dataMin=999999.0;
    float dataMax=-999999.0;
    for(Integer i : this.interpolators.keySet()) {
      
      float dataMinTmp = data.getColumnMin(i, this.indexMinToDisplay, this.indexMaxToDisplay);
      float dataMaxTmp = data.getColumnMax(i, this.indexMinToDisplay, this.indexMaxToDisplay);
      if(dataMinTmp<dataMin) dataMin = dataMinTmp;
      if(dataMaxTmp>dataMax) dataMax = dataMaxTmp;
    }
    this.dataMinToDisplay = dataMin;
  this.dataMaxToDisplay = dataMax;
  }
  public void setYunits(String units) {
    this.YUnits = units;
  }
}
