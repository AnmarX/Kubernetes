from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import psycopg

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
    dbname="postgres",
    user="postgres",
    password=123123123,
    host="postgres-service",
    port=5432
)
cursor = conn.cursor()

# Pydantic model for the Item
class Item(BaseModel):
    name: str
    description: str | None = None
    price: float

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
