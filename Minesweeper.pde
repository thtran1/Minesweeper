
import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20; 
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
    size(600, 600);
    textAlign(CENTER,CENTER);
    textSize(18);
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r < NUM_ROWS; r++)
        for (int c = 0; c < NUM_COLS; c++)
            buttons[r][c] = new MSButton(r, c);
    //your code to declare and initialize buttons goes here
    setBombs();
}
public void setBombs()
{
    //your code
    for (int i = 0; i < 50; i++)
    {
        int tempRow = (int)(Math.random()*NUM_ROWS);
        int tempCol = (int)(Math.random()*NUM_COLS);
        if (!bombs.contains(buttons[tempRow][tempCol]))
            bombs.add(buttons[tempRow][tempCol]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for (int i = 0; i < bombs.size(); i++)
    {
        if (!bombs.get(i).isMarked())
            return false;
    }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][10].setLabel("L");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("S");
    buttons[9][13].setLabel("E");
    buttons[9][14].setLabel("!");
}
public void displayWinningMessage()
{
    //your code here
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][10].setLabel("W");
    buttons[9][11].setLabel("I");
    buttons[9][12].setLabel("N");
    buttons[9][13].setLabel("!");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        if (mouseButton == LEFT)
        {
            if (!clicked)
                clicked = true;
            if (keyPressed)
                marked = !marked;
            else if (bombs.contains(this))
                displayLosingMessage();
            else if (countBombs(r, c) > 0)
                setLabel(str(countBombs(r, c)));
            else
            {
                if (isValid(r, c+1) && !buttons[r][c+1].isClicked())
                    buttons[r][c+1].mousePressed();
                if (isValid(r, c-1) && !buttons[r][c-1].isClicked())
                    buttons[r][c-1].mousePressed();
                if (isValid(r-1, c) && !buttons[r-1][c].isClicked())
                    buttons[r-1][c].mousePressed();            
                if (isValid(r+1, c) && !buttons[r+1][c].isClicked())
                    buttons[r+1][c].mousePressed();
                if (isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked())
                    buttons[r-1][c-1].mousePressed();
                if (isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked())
                    buttons[r-1][c+1].mousePressed();
                if (isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked())
                    buttons[r+1][c+1].mousePressed();
                if (isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked())
                    buttons[r+1][c-1].mousePressed();
            }
        }  
        if (mouseButton == RIGHT)
        {
            if (clicked == false)
                marked = !marked;
        }
        //your code here
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        if (label.equals("1"))
            fill(0, 0, 255);
        else if (label.equals("2"))
            fill(15, 115, 15);
        else if (label.equals("3"))
            fill(255, 0, 0);
        else if (label.equals("4"))
            fill(95, 40, 95);
        else
            fill(0);

        text(label,x+width/2,y+(13*height)/10); // don't ask
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        return r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if (isValid(r, c+1) && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if (isValid(r, c-1) && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if (isValid(r+1, c) && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if (isValid(r-1, c) && bombs.contains(buttons[r-1][c]))
            numBombs++;
        if (isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        if (isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if (isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        if (isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        return numBombs;
    }
}



