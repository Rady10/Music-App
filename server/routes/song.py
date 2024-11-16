import uuid
import cloudinary
import cloudinary.uploader
from fastapi import APIRouter, Depends, File, Form, UploadFile
from sqlalchemy.orm import session, joinedload
from database import get_db
from middleware.auth_middleware import auth_middleware
from models.favorite import Favorite
from models.song import Song
from pydantic_schemas.favorite_song import FavoriteSong

router = APIRouter()

cloudinary.config( 
    cloud_name = "add yours here", 
    api_key = "add yours here", 
    api_secret = "add yours here",
    secure=True
)

@router.post('/upload', status_code = 201)

def uploadSong(
    song: UploadFile = File(...), 
    thumbnail: UploadFile = File(), 
    artist: str = Form(...), 
    name: str = Form(...), 
    genre: str = Form(...), 
    color: str = Form(...),
    db: session = Depends(get_db),
    auth_dict = Depends(auth_middleware)
):
    song_id = str(uuid.uuid4())
    song_res = cloudinary.uploader.upload(song.file, resource_type = 'auto', folder = f'songs/{song_id}')
    print(song_res['url'])
    thumbnail_res = cloudinary.uploader.upload(thumbnail.file, resource_type = 'image', folder = f'songs/{song_id}')
    print(thumbnail_res['url'])

    new_song = Song(
        id = song_id,
        name = name,
        artist = artist,
        color = color,
        genre = genre,
        song_url = song_res["url"],
        thumbnail_url = thumbnail_res["url"],
    )
    db.add(new_song)
    db.commit()
    db.refresh(new_song)
    return new_song

@router.get('/list')
def list_songs(db : session = Depends(get_db), auth_details = Depends(auth_middleware)):
    songs = db.query(Song).all()
    return songs


@router.post('/favorite')
def favorite_song(song : FavoriteSong ,db : session = Depends(get_db), auth_details = Depends(auth_middleware)):
    user_id = auth_details['uid']
    fav_song = db.query(Favorite).filter(Favorite.song_id == song.song_id, Favorite.user_id == user_id).first()
    if fav_song:
        db.delete(fav_song)
        db.commit()
        return{'message': False}
    else:
        new_fav = Favorite(id = str(uuid.uuid4()), song_id = song.song_id, user_id = user_id)
        db.add(new_fav)
        db.commit()
        return{'message': True}

@router.get('/list/favorites')
def list_fav_songs(db : session = Depends(get_db), auth_details = Depends(auth_middleware)):
    user_id = auth_details['uid']
    fav_songs = db.query(Favorite).filter(Favorite.user_id == user_id).options(
        joinedload(Favorite.song),
        joinedload(Favorite.user)
    ).all()
    return fav_songs
