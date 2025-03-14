from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import psycopg
import os
import httpx
import requests
from fastapi.responses import StreamingResponse




db_name = os.getenv("POSTGRES_DB")
db_user = os.getenv("POSTGRES_USER")
db_password = os.getenv("POSTGRES_PASSWORD")
db_host = os.getenv("POSTGRES_HOST", "db")

pod_name = os.getenv("POD_NAME", "Unknown Pod")


# Print values (for testing purposes)
print(f"DB Name: {db_name}")
print(f"DB User: {db_user}")
print(f"DB Host: {db_host}")


# FastAPI app
app = FastAPI()

# for docker compose
# conn = psycopg.connect(
#     dbname="postgres",
#     user="postgres",
#     password=123123123,
#     host="db",
#     port=5432
# )

#for kubenestes
conn = psycopg.connect(
    dbname=db_name,
    user=db_user,
    password=db_password,
    host=db_host,
    port=5432
)
cursor = conn.cursor()

# Pydantic model for the Item
class Item(BaseModel):
    name: str
    description: str | None = None
    price: float



@app.get("/")
def read_root():
    return {"message": f"Hello from pod: {pod_name}"}

# NGINX_URL = "http://nginx-service.default.svc.cluster.local"
NGINX_URL = "http://nginx"

@app.get("/nginx-raw")
async def fetch_nginx_page():
    async with httpx.AsyncClient() as client:
        try:
            response = await client.get(NGINX_URL)
            response.raise_for_status()  # Raise an error for non-2xx responses
            return response.text
        except httpx.HTTPStatusError as http_err:
            return {"error": "HTTP error occurred", "details": str(http_err)}
        except httpx.RequestError as req_err:
            return {"error": "Request error occurred", "details": str(req_err)}



@app.get("/nginx-html")
async def fetch_nginx_homepage():
    async with httpx.AsyncClient() as client:
        try:
            response = await client.get(NGINX_URL, follow_redirects=True)
            return StreamingResponse(response.aiter_text(), status_code=response.status_code, headers=response.headers)
        except httpx.RequestError:
            return StreamingResponse("<h1>Error: Could not fetch Nginx</h1>", status_code=500, media_type="text/html")

from fastapi.responses import HTMLResponse

@app.get("/nginx-html-2")
async def fetch_nginx_homepage():
    async with httpx.AsyncClient() as client:
        try:
            response = await client.get(NGINX_URL, follow_redirects=True)
            return HTMLResponse(content=response.text, status_code=response.status_code)
        except httpx.RequestError:
            return HTMLResponse(content="<h1>Error: Could not fetch Nginx</h1>", status_code=500)


@app.get("/nginx-status")
async def fetch_nginx_status():
    try:
        response = requests.get(NGINX_URL)
        return {"status": response.status_code}
    except requests.RequestException:
        return {"status": "error"}

@app.post("/items/")
async def create_item(item: Item):
    """Create a new item"""
    try:
        cursor.execute(
            "INSERT INTO items (name, description, price) VALUES (%s, %s, %s) RETURNING id;",
            (item.name, item.description, item.price)
        )
        item_id = cursor.fetchone()[0]
        conn.commit()
        return {"id": item_id, "message": "Item created successfully"}
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Error creating item: {e}")

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    """Retrieve an item by ID"""
    cursor.execute("SELECT id, name, description, price FROM items WHERE id = %s;", (item_id,))
    result = cursor.fetchone()
    if result:
        return {"id": result[0], "name": result[1], "description": result[2], "price": result[3]}
    else:
        raise HTTPException(status_code=404, detail="Item not found")

@app.put("/items/{item_id}")
async def update_item(item_id: int, item: Item):
    """Update an existing item"""
    cursor.execute("SELECT id FROM items WHERE id = %s;", (item_id,))
    if not cursor.fetchone():
        raise HTTPException(status_code=404, detail="Item not found")
    try:
        cursor.execute(
            "UPDATE items SET name = %s, description = %s, price = %s WHERE id = %s;",
            (item.name, item.description, item.price, item_id)
        )
        conn.commit()
        return {"message": "Item updated successfully"}
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Error updating item: {e}")

@app.delete("/items/{item_id}")
async def delete_item(item_id: int):
    """Delete an item"""
    cursor.execute("SELECT id FROM items WHERE id = %s;", (item_id,))
    if not cursor.fetchone():
        raise HTTPException(status_code=404, detail="Item not found")
    try:
        cursor.execute("DELETE FROM items WHERE id = %s;", (item_id,))
        conn.commit()
        return {"message": "Item deleted successfully"}
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Error deleting item: {e}")
