import from services.pets { Pet, list_pets, toggle_favorite }
import from .components.PetBrowse { PetBrowse }
import from "@jac/runtime" { Router, Routes, Route }
import ".styles.global.css";

def:pub app() -> JsxElement {
    return <Router>
        <Routes>
            <Route path="/" element={<PetBrowse />} />
        </Routes>
    </Router>;
}
