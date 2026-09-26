import from "@jac/runtime" { Link }
import from .ui.card { Card, CardContent }
import from .ui.button { Button }
import from "@hugeicons/react" { HugeiconsIcon }
import from "@hugeicons/core-free-icons" { SparklesIcon }

def:pub PetResults() -> JsxElement {
    return <div className="min-h-svh bg-muted/40">
        <header className="border-b bg-background"><div className="mx-auto flex h-16 max-w-5xl items-center justify-between px-5"><Link to="/" className="font-semibold text-foreground">HSHV Pet Match</Link><Link to="/pets" className="text-sm text-muted-foreground">Browse listed pets</Link></div></header>
        <main className="mx-auto flex w-full max-w-5xl flex-col gap-6 px-5 py-10">
            <Card className="shadow-sm"><CardContent className="flex flex-col gap-4 p-6 sm:p-8">
                <span className="flex size-11 items-center justify-center rounded-xl bg-primary/10 text-primary"><HugeiconsIcon icon={SparklesIcon} strokeWidth={2} className="size-5" /></span>
                <h1 className="text-3xl font-semibold tracking-tight">Your possible matches</h1>
                <p className="leading-relaxed text-muted-foreground">Match results are being prepared. Sample pet profiles are not verified current HSHV listings, and compatibility details must be confirmed with shelter staff.</p>
                <div className="flex flex-wrap gap-3"><Link to="/questionnaire"><Button>Continue questionnaire</Button></Link><a href="https://www.hshv.org/adopt/" target="_blank" rel="noreferrer"><Button variant="outline">Visit HSHV adoption listings</Button></a></div>
            </CardContent></Card>
        </main>
    </div>;
}
