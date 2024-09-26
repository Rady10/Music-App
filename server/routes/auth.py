import uuid
import bcrypt
from fastapi import Depends, HTTPException
from database import get_db
from models.user import User
from pydantic_schemas.user_create import UserCreate
from fastapi import APIRouter
from sqlalchemy.orm import session
from pydantic_schemas.user_login import UserLogin


router = APIRouter()

#signup route
@router.post('/signup', status_code = 201)

#signup function
def singup_user(user: UserCreate, db: session = Depends(get_db)):

    #checking if user exist in database
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db:
        raise HTTPException(400,'User with the same email already exists!')
    
    # add new user into the database
    hashed_pw = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    user_db = User(
        id = str(uuid.uuid4()), 
        name = user.name, 
        email = user.email, 
        password = hashed_pw, 
    )
    db.add(user_db)
    db.commit()
    db.refresh(user_db)

    return user_db

@router.post('/login')
def login_user(user: UserLogin, db: session = Depends(get_db)):
    #check if user exits
    user_db = db.query(User).filter(User.email == user.email).first()

    if not user_db:
        raise HTTPException(400 ,"User with this email doesn't exist!")
    
    isMatched = bcrypt.checkpw(user.password.encode(), user_db.password)

    if not isMatched:
        raise HTTPException(400, 'Incorrcet Password')
    
    db.refresh(user_db)

    return user_db