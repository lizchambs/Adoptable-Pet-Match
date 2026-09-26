import from "@jac/runtime" { Link }
import from .ui.button { Button }
import from .ui.card { Card, CardContent }
import from "@hugeicons/react" { HugeiconsIcon }
import from "@hugeicons/core-free-icons" { SparklesIcon, HeartCheckIcon, ArrowRight01Icon }

def:pub PetMatchHome() -> JsxElement {
    return <div className="min-h-svh bg-muted/40">
        <header className="border-b bg-background">
            <div className="mx-auto flex h-16 max-w-7xl items-center justify-between gap-4 px-5 sm:px-8">
                <Link to="/" className="flex items-center gap-3 text-foreground no-underline"><span className="flex size-9 items-center justify-center rounded-xl bg-primary text-primary-foreground"><HugeiconsIcon icon={SparklesIcon} strokeWidth={2} className="size-5" /></span><span className="text-lg font-semibold">HSHV <span className="font-normal text-muted-foreground">Pet Match</span></span></Link>
                <Link to="/pets" className="text-sm font-medium text-muted-foreground hover:text-foreground">Browse listed pets</Link>
            </div>
        </header>
        <main className="mx-auto flex w-full max-w-7xl flex-col gap-10 px-5 pb-16 pt-10 sm:px-8 sm:pt-16">
            <section className="grid items-center gap-10 rounded-3xl bg-primary px-6 py-10 text-primary-foreground shadow-sm sm:px-10 lg:grid-cols-[1.1fr_0.9fr] lg:px-14 lg:py-16">
                <div className="flex flex-col items-start gap-5">
                    <span className="rounded-full border border-primary-foreground/25 bg-primary-foreground/10 px-3 py-1 text-sm">A more thoughtful way to meet</span>
                    <h1 className="max-w-2xl text-balance text-4xl font-semibold leading-tight tracking-tight sm:text-5xl lg:text-6xl">Find the pet who fits your life.</h1>
                    <p className="max-w-xl text-base leading-relaxed text-primary-foreground/85 sm:text-lg">Share a little about your home and routine. Get a shortlist with clear reasons and honest questions to ask HSHV.</p>
                    <div className="flex flex-wrap gap-3 pt-1">
                        <Link to="/questionnaire"><Button size="lg" variant="secondary" className="gap-2">Find my match <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4" /></Button></Link>
                        <Link to="/pets"><Button size="lg" variant="outline" className="border-primary-foreground/40 bg-transparent text-primary-foreground hover:bg-primary-foreground/10 hover:text-primary-foreground">Browse all listed pets</Button></Link>
                    </div>
                    <p className="text-xs text-primary-foreground/75">About 5 minutes · No account needed</p>
                </div>
                <Card className="overflow-hidden rounded-2xl border-0 bg-background text-foreground shadow-xl">
                    <div className="grid grid-cols-2 gap-2 p-2">
                        <img src="https://images.unsplash.com/photo-1552053831-71594a27632d?auto=format&fit=crop&w=700&q=85" alt="A friendly dog available in the sample listings" className="h-48 w-full rounded-xl object-cover sm:h-60" />
                        <img src="https://images.unsplash.com/photo-1573865526739-10659fec78a5?auto=format&fit=crop&w=700&q=85" alt="A cat available in the sample listings" className="h-48 w-full rounded-xl object-cover sm:h-60" />
                    </div>
                    <CardContent className="flex items-center gap-3 px-5 pb-5 pt-2"><span className="flex size-10 items-center justify-center rounded-xl bg-primary/10 text-primary"><HugeiconsIcon icon={HeartCheckIcon} strokeWidth={2} className="size-5" /></span><div><p className="font-semibold">A match is more than a photo</p><p className="text-sm text-muted-foreground">Your home, experience, and routine matter.</p></div></CardContent>
                </Card>
            </section>
            <section className="grid gap-4 md:grid-cols-3">
                <Card className="shadow-sm"><CardContent className="flex flex-col gap-3 p-5"><span className="text-sm font-semibold text-primary">01 · Tell us about home</span><h2 className="text-lg font-semibold">The people and pets</h2><p className="text-sm leading-relaxed text-muted-foreground">Share who lives with you and what kind of companion you hope to welcome.</p></CardContent></Card>
                <Card className="shadow-sm"><CardContent className="flex flex-col gap-3 p-5"><span className="text-sm font-semibold text-primary">02 · Share your routine</span><h2 className="text-lg font-semibold">Your everyday life</h2><p className="text-sm leading-relaxed text-muted-foreground">A few answers about activity and experience help shape your shortlist.</p></CardContent></Card>
                <Card className="shadow-sm"><CardContent className="flex flex-col gap-3 p-5"><span className="text-sm font-semibold text-primary">03 · Explore thoughtfully</span><h2 className="text-lg font-semibold">Reasons, not verdicts</h2><p className="text-sm leading-relaxed text-muted-foreground">See what may fit and what to confirm with HSHV adoption staff.</p></CardContent></Card>
            </section>
            <p className="rounded-xl border bg-card p-4 text-sm leading-relaxed text-muted-foreground">Prototype notice: these sample profiles are not verified current HSHV listings. Availability and compatibility must be confirmed directly with the Humane Society of Huron Valley.</p>
        </main>
    </div>;
}
