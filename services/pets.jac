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

obj MatchCard {
    has pet_id: str = "";
    has name: str = "";
    has species: str = "";
    has age: str = "";
    has sex: str = "";
    has location: str = "";
    has description: str = "";
    has image_url: str = "";
    has score: int = 0;
    has reasons: list[str] = [];
    has flags: list[str] = [];
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
        if jid(pet) == pet_id { pet.favorite = not pet.favorite; return pet; }
    }
    return None;
}

def:pub rank_pet_matches(species_preference: str, has_dogs: bool, has_cats: bool, has_children: bool, activity: str, first_pet: bool) -> list[MatchCard] {
    pets = list_pets();
    results: list[MatchCard] = [];
    if species_preference == "other" { return results; }
    for pet in pets {
        if species_preference != "" and species_preference != "either" and pet.species != species_preference { continue; }
        score = 60;
        reasons: list[str] = [];
        flags: list[str] = ["This is mock profile data; compatibility and current availability are unknown."];
        reasons = reasons + ["Species is included in your selected range."];
        if (pet.species == "dog" and activity == "active") or (pet.species == "cat" and activity == "calm") {
            score += 10;
            reasons = reasons + ["The species preference is consistent with the routine you described."];
        } else {
            reasons = reasons + ["Your routine may suit this companion; ask staff about their individual needs."];
        }
        if first_pet { reasons = reasons + ["HSHV staff can help first-time adopters plan a transition."]; }
        elif first_pet == False { reasons = reasons + ["Your previous pet experience may help with the transition."]; }
        if has_dogs or has_cats or has_children { flags = flags + ["Household compatibility is not provided. Ask about resident pets and children before arranging a visit."]; }
        else { flags = flags + ["Ask staff about temperament, training, and time-at-home needs."]; }
        results = results + [MatchCard(pet_id=jid(pet), name=pet.name, species=pet.species, age=pet.age, sex=pet.sex, location=pet.location, description=pet.description, image_url=pet.image_url, score=score, reasons=reasons, flags=flags)];
    }
    return results;
}
