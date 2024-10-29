from sqlalchemy import TEXT, VARCHAR, Column
from models.base import Base

class Genre(Base):
    __tablename__ = 'genres'
    id = Column(TEXT, primary_key= True)
    thumbnail_url = Column(TEXT)
    name = Column(VARCHAR(100))
    color  = Column(VARCHAR(6))