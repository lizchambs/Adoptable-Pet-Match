import from "@jac/runtime" { Link, useNavigate }
import from ..services.pets { rank_pet_matches }
import from .ui.button { Button }
import from .ui.card { Card, CardContent }
import from .ui.progress { Progress }
import from .ui.radio_group { RadioGroup, RadioGroupItem }
import from .ui.label { Label }
import from "@hugeicons/react" { HugeiconsIcon }
import from "@hugeicons/core-free-icons" { ArrowLeft01Icon, ArrowRight01Icon, SparklesIcon }

def:pub PetQuestionnaire() -> JsxElement {
    has step: int = 0;
    has species: str = "either";
    has home: str = "house";
    has tenure: str = "own";
    has yard: str = "some";
    has dogs: bool = False;
    has cats: bool = False;
    has kids: bool = False;
    has activity: str = "moderate";
    has experience: str = "some";
    has hours: str = "4-8";
    has submitting: bool = False;
    has problem: str = "";
    navigate = useNavigate();

    async can with entry {
        raw = localStorage.getItem("hshv-profile");
        if raw {
            try {
                profile = JSON.parse(raw);
                species = profile["species"];
                home = profile["home"];
                tenure = profile["tenure"];
                yard = profile["yard"];
                dogs = profile["dogs"];
                cats = profile["cats"];
                kids = profile["kids"];
                activity = profile["activity"];
                experience = profile["experience"];
                hours = profile["hours"];
            } except Exception { problem = "Saved answers could not be restored. You can continue with this profile."; }
        }
    }

    def save_profile {
        localStorage.setItem("hshv-profile", JSON.stringify({"species": species, "home": home, "tenure": tenure, "yard": yard, "dogs": dogs, "cats": cats, "kids": kids, "activity": activity, "experience": experience, "hours": hours}));
    }
    async def handle_next {
        save_profile();
        if step < 2 { step = step + 1; }
        else { await handle_matches(); }
    }
    async def handle_matches {
        submitting = True;
        problem = "";
        save_profile();
        try {
            matches = await rank_pet_matches(species, dogs, cats, kids, activity, experience == "first");
            localStorage.setItem("hshv-matches", JSON.stringify(matches));
            navigate.call(None, "/matches");
        } except Exception { problem = "We couldn’t prepare your matches. Please try again."; }
        submitting = False;
    }
    def handle_back {
        save_profile();
        if step > 0 { step = step - 1; }
        else { navigate.call(None, "/"); }
    }
    def select_species(value: str) { species = value; save_profile(); }
    def select_home(value: str) { home = value; save_profile(); }
    def select_tenure(value: str) { tenure = value; save_profile(); }
    def select_yard(value: str) { yard = value; save_profile(); }
    def select_activity(value: str) { activity = value; save_profile(); }
    def select_experience(value: str) { experience = value; save_profile(); }
    def select_hours(value: str) { hours = value; save_profile(); }

    progress_value = (step + 1) * 33;
    step_title = "Who are you hoping to meet?" if step == 0 else "Tell us about your home" if step == 1 else "What does your routine look like?";
    step_description = "Choose a species or stay open to either." if step == 0 else "These details help identify questions to confirm with staff." if step == 1 else "There are no wrong answers. Skip anything you are unsure about.";

    return <div className="min-h-svh bg-muted/40">
        <header className="border-b bg-background"><div className="mx-auto flex h-16 max-w-5xl items-center justify-between px-5 sm:px-8"><Link to="/" className="flex items-center gap-2 text-foreground no-underline"><span className="flex size-8 items-center justify-center rounded-lg bg-primary text-primary-foreground"><HugeiconsIcon icon={SparklesIcon} strokeWidth={2} className="size-4" /></span><span className="font-semibold">HSHV Pet Match</span></Link><span className="text-sm font-medium text-muted-foreground">Step {str(step + 1)} of 3</span></div></header>
        <main className="mx-auto flex w-full max-w-3xl flex-col gap-6 px-5 pb-16 pt-8 sm:px-8 sm:pt-12">
            <div className="flex flex-col gap-2"><Progress value={progress_value} /><div className="flex justify-between text-xs text-muted-foreground"><span>About 5 minutes</span><span>Answers save in this browser</span></div></div>
            <Card className="shadow-sm"><CardContent className="flex flex-col gap-7 p-5 sm:p-8">
                <div className="flex flex-col gap-2"><h1 className="text-2xl font-semibold tracking-tight sm:text-3xl">{step_title}</h1><p className="text-sm leading-relaxed text-muted-foreground">{step_description}</p></div>
                {if problem { <p role="alert" className="rounded-lg border border-destructive/30 bg-destructive/5 p-3 text-sm text-destructive">{problem}</p> }}
                {if step == 0 {
                    <fieldset className="flex flex-col gap-3"><legend className="text-sm font-medium">Which pets should we include?</legend><RadioGroup value={species} onValueChange={select_species} className="grid gap-3 sm:grid-cols-2">
                        <Label htmlFor="species-either" className="flex cursor-pointer items-center gap-3 rounded-xl border bg-background p-4"><RadioGroupItem id="species-either" value="either" />Dogs or cats</Label>
                        <Label htmlFor="species-dog" className="flex cursor-pointer items-center gap-3 rounded-xl border bg-background p-4"><RadioGroupItem id="species-dog" value="dog" />Dogs only</Label>
                        <Label htmlFor="species-cat" className="flex cursor-pointer items-center gap-3 rounded-xl border bg-background p-4"><RadioGroupItem id="species-cat" value="cat" />Cats only</Label>
                        <Label htmlFor="species-other" className="flex cursor-pointer items-center gap-3 rounded-xl border bg-background p-4"><RadioGroupItem id="species-other" value="other" />Other pets</Label>
                    </RadioGroup></fieldset>
                }}
                {if step == 1 {
                    <div className="grid gap-6 sm:grid-cols-2">
                        <fieldset className="flex flex-col gap-3"><legend className="text-sm font-medium">What kind of home?</legend><RadioGroup value={home} onValueChange={select_home} className="flex flex-wrap gap-2"><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="house" />House</Label><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="apartment" />Apartment or condo</Label><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="other" />Other</Label></RadioGroup></fieldset>
                        <fieldset className="flex flex-col gap-3"><legend className="text-sm font-medium">Do you rent or own?</legend><RadioGroup value={tenure} onValueChange={select_tenure} className="flex gap-3"><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="own" />Own</Label><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="rent" />Rent</Label></RadioGroup></fieldset>
                        <fieldset className="flex flex-col gap-3"><legend className="text-sm font-medium">What outdoor space is available?</legend><RadioGroup value={yard} onValueChange={select_yard} className="flex flex-wrap gap-2"><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="none" />None</Label><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="some" />Shared or unfenced</Label><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="fenced" />Fenced</Label></RadioGroup></fieldset>
                        <fieldset className="flex flex-col gap-3"><legend className="text-sm font-medium">Who is already at home?</legend><label className="flex items-center gap-2 text-sm"><input type="checkbox" checked={dogs} onChange={lambda (e: ChangeEvent) { dogs = e.target.checked; save_profile(); }} />I have a dog</label><label className="flex items-center gap-2 text-sm"><input type="checkbox" checked={cats} onChange={lambda (e: ChangeEvent) { cats = e.target.checked; save_profile(); }} />I have a cat</label><label className="flex items-center gap-2 text-sm"><input type="checkbox" checked={kids} onChange={lambda (e: ChangeEvent) { kids = e.target.checked; save_profile(); }} />Children live in or visit my home</label></fieldset>
                    </div>
                }}
                {if step == 2 {
                    <div className="grid gap-6 sm:grid-cols-2">
                        <fieldset className="flex flex-col gap-3"><legend className="text-sm font-medium">How active is a typical day?</legend><RadioGroup value={activity} onValueChange={select_activity} className="flex flex-wrap gap-2"><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="calm" />Mostly calm</Label><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="moderate" />A mix of both</Label><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="active" />Very active</Label></RadioGroup></fieldset>
                        <fieldset className="flex flex-col gap-3"><legend className="text-sm font-medium">How much pet experience do you have?</legend><RadioGroup value={experience} onValueChange={select_experience} className="flex flex-wrap gap-2"><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="first" />This is my first pet</Label><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="some" />I have had pets</Label></RadioGroup></fieldset>
                        <fieldset className="flex flex-col gap-3"><legend className="text-sm font-medium">How long might a pet be home alone?</legend><RadioGroup value={hours} onValueChange={select_hours} className="flex flex-wrap gap-2"><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="0-4" />Under 4 hours</Label><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="4-8" />4 to 8 hours</Label><Label className="flex items-center gap-2 rounded-lg border bg-background px-3 py-2"><RadioGroupItem value="8+" />Over 8 hours</Label></RadioGroup></fieldset>
                    </div>
                }}
                <div className="flex flex-wrap items-center justify-between gap-3 border-t pt-5"><Button variant="outline" onClick={handle_back} className="gap-2"><HugeiconsIcon icon={ArrowLeft01Icon} strokeWidth={2} className="size-4" />{"Back to home" if step == 0 else "Previous"}</Button><div className="flex gap-2"><Button variant="ghost" onClick={lambda { save_profile(); navigate.call(None, "/matches"); }}>Skip for now</Button><Button onClick={handle_next} disabled={submitting} className="gap-2">{"Continue" if step < 2 else "See my matches"}<HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4" /></Button></div></div>
            </CardContent></Card>
            <p className="text-center text-xs leading-relaxed text-muted-foreground">Your answers stay in this browser. Compatibility details are shown as unknown when a listing does not provide them.</p>
        </main>
    </div>;
}
