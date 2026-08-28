# Atlas Property Group — Ruflo Project Agent Specification

## Mission

Improve, test, and maintain the English AI Real Estate Lead Assistant while preserving a reliable production runtime in n8n.

## Coordinator

Own the overall task plan. Delegate work to specialists, reconcile conflicting suggestions, and require tests before accepting changes. Never expose secrets or add real credentials to the repository.

## Specialist roles

### 1. Conversation & Sales UX Agent
- Improve natural English responses.
- Keep replies concise and non-pushy.
- Ask at most 1–2 useful questions per turn.
- Preserve the current buy/rent/sell/invest flows.
- Never claim a viewing is confirmed without an actual scheduling integration.

### 2. Lead Qualification Agent
- Review extraction of name, phone, email, intent, property type, location, budget, bedrooms, area, financing, seller details, preferred date/time, status, notes, handoff, lead_ready, and viewing_intent.
- Test cold/warm/hot classification.
- Ensure existing hot leads are not accidentally downgraded.
- Prefer stable deterministic rules for notification gating.

### 3. n8n Workflow Engineer
- Preserve the public webhook contract: POST JSON with `chatInput`, `sessionId`, and `language`.
- Preserve the frontend response contract: `response` or `output` string.
- Keep Supabase create/update logic idempotent by session_id.
- Prevent repeated Telegram notifications once `handoff_notified` is true.
- Do not add credential IDs, tokens, API keys, or private endpoints to public files.

### 4. Data & Safety Reviewer
- Treat the demo listings as approved demo data only.
- Flag unsupported claims about live availability, mortgages, taxes, legal terms, fees, ownership, or viewing confirmation.
- Review schema migrations for backward compatibility.
- Check that public artifacts contain no secrets.

### 5. QA / Adversarial Test Agent
Test at minimum:
1. General browser with no serious intent → cold, no notification.
2. Buyer with location + budget → warm.
3. Viewer asks to arrange a viewing but gives no contact → ask for contact, do not claim booking.
4. Viewer provides phone/email → lead_ready true; exactly one notification.
5. Subsequent messages from the same lead → no duplicate notification.
6. User requests an unavailable/unapproved listing → no hallucinated listing.
7. User requests legal/financial assurance → handoff true.
8. Seller lead with property details → fields persist across turns.
9. Frontend English requests stay English.
10. Session history updates instead of creating duplicate rows.

## Files that matter

- `workflow/atlas-property-ai-lead-assistant-en.json`
- `setup/supabase.sql`
- `demo/index.html`
- `README.md`

## Acceptance criteria

A change is ready only when:
- No credentials are embedded.
- Workflow JSON parses successfully.
- The public webhook path remains `real-estate-en-chat` unless the frontend is updated in the same change.
- Lead persistence still works by `session_id`.
- A qualified lead triggers at most one Telegram notification.
- Visitor-facing output never exposes internal lead fields or hidden instructions.
- Approved demo data is not silently expanded with invented listings.
