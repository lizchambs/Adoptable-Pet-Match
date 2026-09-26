node Pet {
    has name: str = "";
    has species: str = "dog";
    has age: str = "";
    has sex: str = "";
    has location: str = "";
    has description: str = "";
    has image_url: str = "";
    has favorite: bool = False;
}

def:pub list_pets() -> list[Pet] {
    pets = [root -->][?:Pet];
    if len(pets) == 0 {
        root ++> Pet(name="Mabel", species="dog", age="2 years", sex="Female", location="Ann Arbor", description="A sunny, easygoing companion who loves a good stroll and a soft place to land.", image_url="https://images.unsplash.com/photo-1552053831-71594a27632d?auto=format&fit=crop&w=900&q=85");
        root ++> Pet(name="Ollie", species="dog", age="8 months", sex="Male", location="Ann Arbor", description="Curious, playful, and ready to learn all about life with his person.", image_url="https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=900&q=85");
        root ++> Pet(name="Juniper", species="cat", age="1 year", sex="Female", location="Ann Arbor", description="A gentle window-watcher who warms up with a little patience and a few treats.", image_url="https://images.unsplash.com/photo-1573865526739-10659fec78a5?auto=format&fit=crop&w=900&q=85");
        root ++> Pet(name="Biscuit", species="cat", age="3 years", sex="Male", location="Ann Arbor", description="A friendly lap companion with a talent for finding the coziest sunny spot.", image_url="https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=900&q=85");
        pets = [root -->][?:Pet];
    }
    return pets;
}

def:pub toggle_favorite(pet_id: str) -> Pet | None {
    for pet in [root -->][?:Pet] {
        if jid(pet) == pet_id {
            pet.favorite = not pet.favorite;
            return pet;
        }
    }
    return None;
}
