sv import from ..services.pets { Pet, list_pets, toggle_favorite }
import from .ui.card { Card, CardContent }
import from .ui.button { Button }
import from .ui.badge { Badge }
import from .ui.empty { Empty, EmptyHeader, EmptyTitle, EmptyDescription, EmptyMedia }
import from "@hugeicons/react" { HugeiconsIcon }
import from "@hugeicons/core-free-icons" { HeartAddIcon, HeartCheckIcon, Location01Icon, SparklesIcon }

def:pub PetBrowse() -> JsxElement {
    has pets: list[Pet] = [];
    has species: str = "all";
    has loading: bool = True;
    has load_error: bool = False;

    async can with entry {
        try {
            pets = await list_pets();
            load_error = False;
        } except Exception {
            load_error = True;
        }
        loading = False;
    }

    async def handle_favorite(pet_id: str) -> None {
        try {
            updated = await toggle_favorite(pet_id);
            if updated is not None {
                refreshed: list[Pet] = [];
                for pet in pets {
                    if jid(pet) == pet_id { refreshed = refreshed + [updated]; }
                    else { refreshed = refreshed + [pet]; }
                }
                pets = refreshed;
            }
        } except Exception {
            load_error = True;
        }
    }

    async def handle_retry() -> None {
        loading = True;
        load_error = False;
        try { pets = await list_pets(); }
        except Exception { load_error = True; }
        loading = False;
    }

    visible: list[Pet] = [];
    for pet in pets {
        if species == "all" or pet.species == species { visible = visible + [pet]; }
    }

    return <div className="min-h-svh bg-muted/40">
        <header className="sticky top-0 z-20 border-b bg-background/95 backdrop-blur">
            <div className="mx-auto flex h-16 w-full max-w-7xl items-center justify-between gap-4 px-5 sm:px-8">
                <a href="#top" className="flex items-center gap-2.5 text-foreground no-underline">
                    <span className="flex size-9 items-center justify-center rounded-xl bg-primary text-primary-foreground shadow-sm"><HugeiconsIcon icon={SparklesIcon} strokeWidth={2} className="size-5" /></span>
                    <span className="text-lg font-semibold tracking-tight">HSHV <span className="font-normal text-muted-foreground">Pet Match</span></span>
                </a>
                <span className="hidden text-sm text-muted-foreground sm:block">Humane Society of Huron Valley</span>
                <Button variant="outline" size="sm" onClick={lambda { species = "all"; }}>Browse pets</Button>
            </div>
        </header>
        <main id="top" className="mx-auto flex w-full max-w-7xl flex-col gap-8 px-5 pb-16 pt-8 sm:px-8 sm:pt-12">
            <section className="relative overflow-hidden rounded-3xl bg-primary text-primary-foreground shadow-sm">
                <div className="pointer-events-none absolute -right-12 -top-24 size-80 rounded-full bg-primary-foreground/10 blur-3xl" />
                <div className="relative grid gap-8 px-6 py-9 sm:px-10 sm:py-12 lg:grid-cols-[1fr_auto] lg:items-end">
                    <div className="flex max-w-2xl flex-col gap-4">
                        <Badge variant="secondary" className="w-fit border-primary-foreground/20 bg-primary-foreground/15 text-primary-foreground">Your next chapter starts here</Badge>
                        <h1 className="text-balance text-4xl font-semibold leading-[1.08] tracking-tight sm:text-5xl">A good match changes everything.</h1>
                        <p className="max-w-xl text-base leading-relaxed text-primary-foreground/80 sm:text-lg">Meet adoptable dogs and cats at HSHV. Find the personality that feels like home.</p>
                    </div>
                    <div className="flex flex-wrap gap-2">
                        <Button variant={"secondary" if species == "all" else "outline"} className={"border-primary-foreground/30 " + ("" if species == "all" else "bg-transparent text-primary-foreground hover:bg-primary-foreground/10 hover:text-primary-foreground")} onClick={lambda { species = "all"; }}>All pets</Button>
                        <Button variant={"secondary" if species == "dog" else "outline"} className={"border-primary-foreground/30 " + ("" if species == "dog" else "bg-transparent text-primary-foreground hover:bg-primary-foreground/10 hover:text-primary-foreground")} onClick={lambda { species = "dog"; }}>Dogs</Button>
                        <Button variant={"secondary" if species == "cat" else "outline"} className={"border-primary-foreground/30 " + ("" if species == "cat" else "bg-transparent text-primary-foreground hover:bg-primary-foreground/10 hover:text-primary-foreground")} onClick={lambda { species = "cat"; }}>Cats</Button>
                    </div>
                </div>
            </section>
            <section className="flex flex-col gap-5">
                <div className="flex flex-wrap items-end justify-between gap-3">
                    <div className="flex flex-col gap-1">
                        <h2 className="text-2xl font-semibold tracking-tight">Pets ready to meet you</h2>
                        <p className="text-sm text-muted-foreground">A few wonderful friends looking for their people.</p>
                    </div>
                    <span className="text-sm text-muted-foreground">{str(len(visible))} companions</span>
                </div>
                {if loading {
                    <div className="rounded-2xl border bg-card p-8 text-center text-sm text-muted-foreground shadow-sm">Loading adoptable pets…</div>
                    skip;
                }}
                {if load_error {
                    <div className="flex flex-wrap items-center justify-between gap-3 rounded-2xl border border-destructive/30 bg-card p-6 shadow-sm">
                        <p className="text-sm text-destructive">We couldn’t load the pet listings. Please try again.</p>
                        <Button variant="outline" onClick={handle_retry}>Try again</Button>
                    </div>
                    skip;
                }}
                {if len(visible) == 0 {
                    <Empty className="rounded-2xl border border-dashed bg-card py-12 shadow-sm">
                        <EmptyHeader>
                            <EmptyMedia variant="icon"><HugeiconsIcon icon={SparklesIcon} strokeWidth={2} /></EmptyMedia>
                            <EmptyTitle>No pets in this group just yet</EmptyTitle>
                            <EmptyDescription>Choose another group to meet more HSHV companions.</EmptyDescription>
                        </EmptyHeader>
                    </Empty>
                    skip;
                }}
                <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
                    {for pet in visible {
                        <Card key={jid(pet)} className="group overflow-hidden rounded-2xl border-0 bg-card shadow-sm ring-1 ring-border/70 transition-all hover:-translate-y-0.5 hover:shadow-md">
                            <div className="relative aspect-[4/3] overflow-hidden bg-muted">
                                <img src={pet.image_url} alt={"Adoptable " + pet.species + " " + pet.name} className="size-full object-cover transition-transform duration-500 group-hover:scale-[1.03]" />
                                <Badge variant="secondary" className="absolute left-3 top-3 capitalize shadow-sm">{pet.species}</Badge>
                                <Button variant="secondary" size="icon" aria-label={"Save " + pet.name} className="absolute right-3 top-3 size-9 rounded-full bg-background/95 shadow-sm" onClick={lambda { handle_favorite(jid(pet)); }}>
                                    <HugeiconsIcon icon={HeartCheckIcon if pet.favorite else HeartAddIcon} strokeWidth={2} className={"size-4 " + ("text-primary" if pet.favorite else "text-foreground")} />
                                </Button>
                            </div>
                            <CardContent className="flex flex-col gap-3 p-4 sm:p-5">
                                <div className="flex items-start justify-between gap-3">
                                    <div><h3 className="text-xl font-semibold tracking-tight">{pet.name}</h3><p className="mt-1 text-sm text-muted-foreground">{pet.age} <span aria-hidden="true">·</span> {pet.sex}</p></div>
                                </div>
                                <p className="line-clamp-2 min-h-10 text-sm leading-relaxed text-muted-foreground">{pet.description}</p>
                                <div className="flex items-center gap-1.5 border-t pt-3 text-xs text-muted-foreground"><HugeiconsIcon icon={Location01Icon} strokeWidth={2} className="size-4" />{pet.location}, Michigan</div>
                            </CardContent>
                        </Card>
                    }}
                </div>
            </section>
            <footer className="flex flex-wrap items-center justify-between gap-3 border-t pt-5 text-sm text-muted-foreground">
                <span>Every pet deserves a place to call home.</span><span>HSHV · Ann Arbor, Michigan</span>
            </footer>
        </main>
    </div>;
}
