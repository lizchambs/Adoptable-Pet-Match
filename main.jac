import from services.pets { MatchCard, rank_pet_matches }
import from services.pets { MatchCard, rank_pet_matches }
import from .components.PetBrowse { PetBrowse }
import from .components.PetMatchHome { PetMatchHome }
import from .components.PetQuestionnaire { PetQuestionnaire }
import from .components.PetResults { PetResults }
import from "@jac/runtime" { Router, Routes, Route }
import ".styles.global.css";

def:pub app() -> JsxElement {
    return <Router>
        <Routes>
            <Route path="/" element={<PetMatchHome />} />
            <Route path="/questionnaire" element={<PetQuestionnaire />} />
            <Route path="/matches" element={<PetResults />} />
            <Route path="/pets" element={<PetBrowse />} />
        </Routes>
    </Router>;
}
