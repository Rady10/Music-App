from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URL = 'postgresql://postgres:rady123@localhost:5432/musicapp'

#engine used to conncet to the database
engine = create_engine(DATABASE_URL)

#database configuration
SessionLocal = sessionmaker(autocommit = False, autoflush = False , bind = engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()