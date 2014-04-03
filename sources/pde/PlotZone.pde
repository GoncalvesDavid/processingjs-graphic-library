/*
 * Represents the zone where the graphic is plot.
 */
public class PlotZone extends Box {
  
  /*
   * Creates a plot zone with the given start & end position..
   */
  public PlotZone(Position top, int newWidth, int newHeight ){
    super(top, newWidth, newHeight);
  }
  
  /*
   * Finds the minimum element of the array.
   * WARNING : FUNCTION DO NOT CHECK FOR NULL 
   */
  public float getMin(float[] tab){
    float min = tab[0];
    for (int i =  1; i < tab.length ; i++)
      if (tab[i] < min) min = tab[i];
    return min;
  }
  
  /*
   * Finds the maximum element of the array.
   * WARNING : FUNCTION DO NOT CHECK FOR NULL 
   */
  private float getMax(float[] tab){
    float max = tab[0];
    for (int i =  1; i < tab.length ; i++)
      if (tab[i] > max) max = tab[i];
    return max;
  }
  
  /*
   * Plot an array of data.
   */
  public void plotData(float[] x, float y[], float dataMin, float dataMax, int bgColor) {

    float xMin = this.getMin(x);
    float xMax = this.getMax(x);
    float yMin = dataMin-10;
    float yMax = dataMax+10;
    fill(#5679C1);
    strokeWeight(2);
    stroke(bgColor); 
    float xPos1 = map(x[0], xMin, xMax, this.getLC().getX(), this.getRC().getX());
    float yPos1 = map(y[0], yMin, yMax, this.getRC().getY(), this.getLC().getY());
    for (int row = 1; row < x.length; row++) {
        float xPos = map(x[row], xMin, xMax, this.getLC().getX(), this.getRC().getX());
        float yPos = map(y[row], yMin, yMax, this.getRC().getY(), this.getLC().getY());
        
        line(xPos1, yPos1, xPos, yPos);
          
        xPos1 = map(x[row], xMin, xMax, this.getLC().getX(), this.getRC().getX());
        yPos1 = map(y[row], yMin, yMax, this.getRC().getY(), this.getLC().getY());
    }
  }
  
  
}
