from pydantic import BaseModel

#user model
class UserCreate(BaseModel):
    name : str
    email : str
    password : str