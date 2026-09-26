import from "@jac/runtime" { Link }
import from ..services.pets { MatchCard }
import from .ui.card { Card, CardContent }
import from .ui.button { Button }
import from .ui.badge { Badge }

def:pub PetResults() -> JsxElement {
    has matches: list[MatchCard] = [];
    has loading: bool = True;
    has error: bool = False;
    async can with entry {
        raw = localStorage.getItem("hshv-matches");
        if raw { try { matches = JSON.parse(raw) as list[MatchCard]; } except Exception { error = True; } }
        loading = False;
    }
    return <div className="min-h-svh bg-muted/40">
        <header className="border-b bg-background"><div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-5"><Link to="/" className="font-semibold">HSHV Pet Match</Link><Link to="/pets" className="text-sm text-muted-foreground">Browse listed pets</Link></div></header>
        <main className="mx-auto flex w-full max-w-7xl flex-col gap-6 px-5 py-8">
            <div><h1 className="text-3xl font-semibold tracking-tight">Your possible matches</h1><p className="mt-2 text-sm text-muted-foreground">A starting point for a conversation with HSHV staff.</p></div>
            <Card className="border-primary/20 bg-primary/5 shadow-sm"><CardContent className="p-4 text-sm text-muted-foreground"><strong className="text-foreground">Mock listings:</strong> These sample profiles are not verified current HSHV listings. Confirm current availability and compatibility with HSHV.</CardContent></Card>
            {if loading { <Card><CardContent className="p-8 text-center">Loading your shortlist…</CardContent></Card> }}
            {if error { <Card><CardContent className="p-8 text-center text-destructive">Could not load matches. Return to the questionnaire and try again.</CardContent></Card> }}
            <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
                {for entry in matches {
                    <Card key={entry.pet_id} className="overflow-hidden shadow-sm">
                        <img src={entry.image_url} alt={"Mock pet profile: " + entry.name} className="aspect-[4/3] w-full object-cover" />
                        <CardContent className="flex flex-col gap-3 p-5">
                            <div className="flex items-center justify-between"><h2 className="text-xl font-semibold">{entry.name}</h2><Badge variant="secondary">{entry.species}</Badge></div>
                            <p className="text-sm text-muted-foreground">{entry.age} · {entry.sex}</p>
                            <p className="text-sm leading-relaxed text-muted-foreground">{entry.description}</p>
                            <p className="text-sm"><strong>Fit estimate:</strong> {str(entry.score)}%</p>
                            <p className="text-sm leading-relaxed text-muted-foreground">{entry.reasons[0]}</p>
                            <p className="rounded-lg border border-amber-500/30 bg-amber-500/5 p-3 text-xs leading-relaxed text-muted-foreground">Confirm with HSHV: {entry.flags[0]}</p>
                            <a href="https://www.hshv.org/adopt/" target="_blank" rel="noreferrer"><Button className="w-full">HSHV adoption information</Button></a>
                        </CardContent>
                    </Card>
                }}
            </div>
            {if not loading and not error and len(matches) == 0 { <Card><CardContent className="flex flex-col items-center gap-3 p-8 text-center"><h2 className="text-xl font-semibold">No shortlist yet</h2><p className="text-sm text-muted-foreground">Complete a few questions to generate matches.</p><Link to="/questionnaire"><Button>Start questionnaire</Button></Link></CardContent></Card> }}
        </main>
    </div>;
}
