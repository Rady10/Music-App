from fastapi import FastAPI
from models.base import Base
from routes import auth, genre, song
from database import engine
app = FastAPI()

app.include_router(auth.router, prefix='/auth')
app.include_router(song.router, prefix='/song')
app.include_router(genre.router, prefix='/genre')

Base.metadata.create_all(engine)