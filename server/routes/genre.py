import uuid
import cloudinary
import cloudinary.uploader
from fastapi import APIRouter, Depends, File, Form, UploadFile
from sqlalchemy.orm import session
from database import get_db
from models.genre import Genre
from models.song import Song

router = APIRouter()

cloudinary.config( 
    cloud_name = "dnpweqtiw", 
    api_key = "528252838717467", 
    api_secret = "Gh1ppFvsxY8JF4l3kwlfMpkYT7s",
    secure=True
)


@router.post('/upload', status_code = 201)

def uploadGenre( 
    image: UploadFile = File(...),
    name: str = Form(...), 
    color: str = Form(...),
    db: session = Depends(get_db),
):
    genre_id = str(uuid.uuid4())
    image = cloudinary.uploader.upload(image.file, resource_type = 'image', folder = f'genres/{genre_id}')
    print(image['url'])

    new_genre = Genre(
        id = genre_id,
        name = name,
        thumbnail_url = image['url'],
        color = color,
    )
    db.add(new_genre)
    db.commit()
    db.refresh(new_genre)
    return new_genre

@router.get('/list')
def list_genres(db : session = Depends(get_db)):
    genres = db.query(Genre).all()
    return genres

@router.get('/{genre}')
def list_love_songs(genre:str, db: session = Depends(get_db)):
    songs = db.query(Song).filter(Song.genre.ilike(f'%{genre}%')).all()
    return songs