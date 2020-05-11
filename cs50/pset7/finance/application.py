from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session, url_for
from flask_session import Session
from passlib.apps import custom_app_context as pwd_context
from tempfile import gettempdir

from helpers import *

# configure application
app = Flask(__name__)

# ensure responses aren't cached
if app.config["DEBUG"]:
    @app.after_request
    def after_request(response):
        response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
        response.headers["Expires"] = 0
        response.headers["Pragma"] = "no-cache"
        return response

# custom filter
app.jinja_env.filters["usd"] = usd

# configure session to use filesystem (instead of signed cookies)
app.config["SESSION_FILE_DIR"] = gettempdir()
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

@app.route("/")
@login_required
def index():
    if session["user_id"]:

        stocks = get_stocks(session["user_id"])

        own, cash, total = get_portfolio(session["user_id"])
                        
        return render_template("portfolio.html", own=own, cash=cash, total=total)
        
    else:
        return redirect(url_for("login"))

@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock."""
    if request.method == "POST":
        
        if not request.form.get("symbol").isalpha():
            return apology("Symbol should have alphabetic symbols only")
                
        elif ( not request.form.get("shares").isdigit() ) or int(request.form.get("shares")) <= 0:
            return apology("Shares should be a positive integer")
            
        else:
            quote = lookup(request.form.get('symbol'))
            symbol = quote.get('symbol')
            
            if quote:
                
                stocks = get_stocks(session["user_id"])
                
                if stocks.count(symbol) == 0:
                    ret = db.execute( 'INSERT INTO able_symbols (owner, symbol) VALUES (:owner, :symbol)', owner=session["user_id"], symbol=symbol )
                    if ret == None :
                        stocks.append(symbol)

                price = quote.get('price')
                shares = int(request.form.get("shares"))
                
                cash = db.execute( 'SELECT cash FROM users WHERE id = :id', id=session["user_id"] )[0]['cash']
                
                if shares * price <= cash :

                    flag = db.execute( 'SELECT shares FROM portfolio WHERE owner = :owner AND symbol = :symbol', owner=session["user_id"], symbol=symbol )

                    if len(flag) > 0 :
                        db.execute( 'UPDATE portfolio SET shares = shares + :shares WHERE owner = :owner AND symbol = :symbol', owner=session["user_id"], symbol=symbol, shares=shares )
                    else:
                        db.execute( 'INSERT INTO portfolio (owner, symbol, shares) VALUES (:owner, :symbol, :shares)', owner=session["user_id"], symbol=symbol, shares=shares )
                        
                    db.execute( 'UPDATE users SET cash = cash - :cash WHERE id = :id', id=session["user_id"], cash = shares * price )
                    
                    #insert log into history table:
                    db.execute( 'INSERT INTO history (owner, symbol, shares, price) VALUES (:owner, :symbol, :shares, :price)', owner=session["user_id"], symbol=symbol, shares=shares, price=price )
                    
                    
                    own, cash, total = get_portfolio(session["user_id"])
                    
                    return render_template("portfolio.html", own=own, cash=cash, total=total, status='Bought!', link='buy')
                    
                else:
                    return apology("There is not enough money on the account")

            else:
                return apology("Such symbol unable to stock")

    elif request.method == "GET":
        stocks = get_stocks(session["user_id"])
        return render_template("buy.html", stocks = stocks)
        
    else:
        return apology("error in buy")

@app.route("/history")
@login_required
def history():
    """Show history of transactions."""
    history = db.execute( 'SELECT * FROM history WHERE owner=:owner', owner=session["user_id"]  )
    return render_template("history.html", history=history)

@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in."""

    # forget any user_id
    session.clear()

    # if user reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username")

        # ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password")

        # query database for username
        rows = db.execute("SELECT * FROM users WHERE username = :username", username=request.form.get("username"))

        # ensure username exists and password is correct
        if len(rows) != 1 or not pwd_context.verify(request.form.get("password"), rows[0]["hash"]):
            return apology("invalid username and/or password")

        # remember which user has logged in
        session["user_id"] = rows[0]["id"]
        session["username"] = rows[0]["username"]

        # redirect user to home page
        return redirect(url_for("index"))

    # else if user reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")

@app.route("/logout")
def logout():
    """Log user out."""

    # forget any user_id
    session.clear()

    # redirect user to login form
    return redirect(url_for("login"))

@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    
    if request.method == "POST":
      
        quote = lookup(request.form.get("symbol"))
        
        if quote:
            stocks = get_stocks(session["user_id"]) 
            
            symbol = quote.get('symbol')
            if stocks.count(symbol) == 0:
                ret = db.execute( 'INSERT INTO able_symbols (owner, symbol) VALUES (:owner, :symbol)', owner=session["user_id"], symbol=quote.get('symbol') )
                if ret == None :
                    stocks.append(symbol)
                
            return render_template( "quoted.html", name = quote.get('name'), symbol = quote.get('symbol'), price = usd(quote.get('price')) )
        else:
            return apology("invalid symbol")

    elif request.method == "GET":
        stocks = get_stocks(session["user_id"])
        return render_template("quote.html", stocks = stocks)
        
    else:
        return apology("error in quote")

@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user."""
    
    # forget any user_id
    session.clear()

    # if user reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username")

        # ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password")
            
        elif not request.form.get("passwordConfirmation"):
            return apology("must confirm the password")
        
        elif request.form.get("password") != request.form.get("passwordConfirmation"):
            return apology("invalid password confirmation")

        # query database for username
        rows = db.execute("SELECT * FROM users WHERE username = :username", username=request.form.get("username"))

        # ensure username exists and password is correct
        if len(rows) > 0:
            return apology("user already exists")
            
        # insert username and password in database
        db.execute("INSERT INTO users (username, hash) VALUES (:username, :hash)", username=request.form.get("username"), hash=pwd_context.hash(request.form.get("password")))
        
        # query database for username
        rows = db.execute("SELECT * FROM users WHERE username = :username", username=request.form.get("username"))

        # ensure username exists and password is correct
        if len(rows) == 1 or pwd_context.verify(request.form.get("password"), rows[0]["hash"]):
            # remember which user has logged in
            session["user_id"] = rows[0]["id"]
            # redirect user to home page
            return redirect(url_for("index"))
            
        else: return apology("error, the user is not added to the database")

    # else if user reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("register.html")
        
@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock."""
    if request.method == "POST":
        
        if not request.form.get("symbol").isalpha():
            return apology("Symbol should have alphabetic symbols only")
                
        elif ( not request.form.get("shares").isdigit() ) or int(request.form.get("shares")) <= 0:
            return apology("Shares should be a positive integer")
            
        else:
            stock_list = db.execute('SELECT symbol FROM portfolio WHERE owner=:owner', owner=session["user_id"])
            stock_list = [ stock_list[i]['symbol'] for i in range(len(stock_list)) ]
            
            quote = lookup(request.form.get('symbol'))
            symbol = quote.get('symbol')
            
            if stock_list.count(symbol) > 0:
                
                price = quote.get('price')
                shares = int(request.form.get("shares"))
                
                current_shares = db.execute( 'SELECT shares FROM portfolio WHERE owner=:owner AND symbol=:symbol', owner=session["user_id"], symbol=symbol)[0]['shares']
                
                if current_shares > shares :
                    db.execute( 'UPDATE portfolio SET shares = shares - :shares WHERE owner = :owner AND symbol = :symbol', owner=session["user_id"], symbol=symbol, shares=shares )
                elif current_shares == shares:
                    db.execute( 'DELETE FROM portfolio WHERE owner = :owner AND symbol = :symbol', owner=session["user_id"], symbol=symbol )
                else:
                    return apology("Too much shares for sale")
                
                db.execute( 'UPDATE users SET cash = cash + :cash WHERE id = :id', id=session["user_id"], cash = shares * price )
                
                
                #insert log into history table:
                db.execute( 'INSERT INTO history (owner, symbol, shares, price) VALUES (:owner, :symbol, :shares, :price)', owner=session["user_id"], symbol=symbol, shares = -shares, price=price )
                
                own, cash, total = get_portfolio(session["user_id"])
                        
                return render_template("portfolio.html", own=own, cash=cash, total=total, status='Sold!', link='sell')
                
                    
            else:
                return apology("You have not this symbol in your portfolio")
            
    elif request.method == "GET":
        stock_list = db.execute('SELECT symbol FROM portfolio WHERE owner=:owner', owner=session["user_id"])
        stock_list = [ stock_list[i]['symbol'] for i in range(len(stock_list)) ]
        return render_template("sell.html", stocks = stock_list)
        
    else:
        return apology("error in sell")