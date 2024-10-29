import uuid
import bcrypt
from fastapi import Depends, HTTPException
from database import get_db
from middleware.auth_middleware import auth_middleware
from models.user import User
from pydantic_schemas.user_create import UserCreate
from fastapi import APIRouter
from sqlalchemy.orm import session, joinedload
from pydantic_schemas.user_login import UserLogin
import jwt

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
    
    token = jwt.encode({ 'id' : user_db.id }, 'password_key')

    db.refresh(user_db)

    return {'token' : token , 'user' : user_db}

@router.get('/')
def current_user_data(db: session = Depends(get_db), user_dict = Depends(auth_middleware)):
    user = db.query(User).filter(User.id == user_dict['uid']).options(
        joinedload(User.favorites)
    ).first()
    if not user:
        raise HTTPException(404, 'User not found!')
    return user