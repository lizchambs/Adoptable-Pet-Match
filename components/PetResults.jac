import from "@jac/runtime" { Link }
import from ..services.pets { MatchCard }
import from .ui.button { Button }
import from .ui.card { Card, CardContent }
import from .ui.badge { Badge }
import from "@hugeicons/react" { HugeiconsIcon }
import from "@hugeicons/core-free-icons" { SparklesIcon, Location01Icon, ArrowLeft01Icon, HeartCheckIcon }

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
        <header className="border-b bg-background"><div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-5 sm:px-8"><Link to="/" className="flex items-center gap-2 text-foreground no-underline"><span className="flex size-8 items-center justify-center rounded-lg bg-primary text-primary-foreground"><HugeiconsIcon icon={SparklesIcon} strokeWidth={2} className="size-4" /></span><span className="font-semibold">HSHV Pet Match</span></Link><Link to="/pets" className="text-sm text-muted-foreground hover:text-foreground">Browse listed pets</Link></div></header>
        <main className="mx-auto flex w-full max-w-7xl flex-col gap-7 px-5 pb-16 pt-8 sm:px-8 sm:pt-12">
            <div className="flex flex-wrap items-start justify-between gap-4"><div><Link to="/questionnaire" className="mb-3 inline-flex items-center gap-2 text-sm text-muted-foreground hover:text-foreground"><HugeiconsIcon icon={ArrowLeft01Icon} strokeWidth={2} className="size-4" />Edit your answers</Link><h1 className="text-3xl font-semibold tracking-tight">Your possible matches</h1><p className="mt-2 max-w-2xl text-sm leading-relaxed text-muted-foreground">A starting point for a conversation with HSHV staff, not a guarantee of fit or availability.</p></div><Link to="/questionnaire"><Button variant="outline">Update my profile</Button></Link></div>
            <div className="flex items-start gap-3 rounded-xl border border-primary/20 bg-primary/5 p-4"><span className="flex size-9 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary"><HugeiconsIcon icon={HeartCheckIcon} strokeWidth={2} className="size-4" /></span><p className="text-sm leading-relaxed text-muted-foreground"><strong className="text-foreground">Prototype listings:</strong> These sample pets are not verified current HSHV listings. Compatibility information is unavailable in the sample data; confirm each pet’s needs and availability with HSHV before visiting.</p></div>
            {if loading { <Card className="shadow-sm"><CardContent className="p-8 text-center text-sm text-muted-foreground">Preparing your shortlist…</CardContent></Card> }}
            {if error { <Card className="shadow-sm"><CardContent className="p-8 text-center text-sm text-destructive">We couldn’t read this shortlist. Return to the questionnaire to generate it again.</CardContent></Card> }}
            <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
                {for match in matches {
                    <article key={match.pet_id} className="overflow-hidden rounded-2xl border bg-card shadow-sm">
                        <div className="flex flex-wrap items-center justify-between gap-3 border-b p-5"><div><Badge variant="secondary" className="capitalize">{match.species}</Badge><span className="ml-3 text-sm font-semibold text-primary">{str(match.score)}% fit</span></div><img src={match.image_url} alt={"Sample profile: " + match.name} className="size-16 rounded-xl object-cover" /></div>
                        <div className="flex flex-col gap-4 p-5">
                            <div><h2 className="text-xl font-semibold">{match.name}</h2><p className="mt-1 text-sm text-muted-foreground">{match.age} · {match.sex}</p></div>
                            <p className="text-sm leading-relaxed text-muted-foreground">{match.description}</p>
                            <div className="flex flex-col gap-2"><h3 className="text-sm font-semibold">Why this could be a fit</h3>{for reason in match.reasons { <p key={reason} className="text-sm leading-relaxed text-muted-foreground">{reason}</p> }}</div>
                            <div className="flex flex-col gap-2 rounded-lg border border-amber-500/30 bg-amber-500/5 p-3"><h3 className="text-sm font-semibold">Things to confirm</h3>{for flag in match.flags { <p key={flag} className="text-xs leading-relaxed text-muted-foreground">{flag}</p> }}</div>
                            <div className="flex items-center gap-1.5 border-t pt-3 text-xs text-muted-foreground"><HugeiconsIcon icon={Location01Icon} strokeWidth={2} className="size-4" />{match.location}, Michigan</div>
                            <a href="https://www.hshv.org/adopt/" target="_blank" rel="noreferrer"><Button className="w-full">Check with HSHV about this pet</Button></a>
                        </div>
                    </article>
                }}
            </div>
            <p className="border-t pt-5 text-xs leading-relaxed text-muted-foreground">Fit estimates are based on limited sample listing details, not verified behavior or safety assessments. HSHV adoption staff are the best source for current availability and household compatibility.</p>
        </main>
    </div>;
}
