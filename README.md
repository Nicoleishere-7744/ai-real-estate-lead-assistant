# AI Real Estate Lead Assistant

An AI lead qualification and viewing-request assistant for real estate agencies, built with **n8n, OpenAI, Supabase, Telegram, and a lightweight web demo**.

## What it does

- Handles property-buying and rental inquiries
- Captures location, property type, budget, bedrooms, area requirements, financing/payment preferences, and contact information
- Detects viewing intent and high-intent leads
- Stores and updates lead history in Supabase
- Sends qualified leads to an agent via Telegram
- Prevents repeated sales notifications
- Supports a live website demo through an n8n webhook
- Avoids claiming that a property is currently available unless the approved data confirms it

## Repository structure

```text
workflow/
  real-estate-ai-agent.json    # n8n workflow (credentials removed)
demo/
  index.html                   # browser demo
setup/
  supabase.sql                 # database schema
```

## Setup

1. Create a dedicated Supabase project.
2. Run `setup/supabase.sql`.
3. Import `workflow/real-estate-ai-agent.json` into n8n.
4. Reconnect your own:
   - OpenAI credential
   - Supabase credential
   - Telegram credential
5. Set the Telegram Chat ID.
6. Replace demo property/business information in the system prompt with approved client data.
7. Publish the workflow in n8n.
8. Update the webhook URL in `demo/index.html` if necessary.
9. Deploy the demo folder to Netlify, GitHub Pages, Vercel, or another static host.

## Security

This public version intentionally contains **no API keys, Supabase secrets, Telegram bot tokens, or n8n credential references**.

Do not commit customer data or private credentials.

## Example demo flow

1. Visitor asks for a two-bedroom apartment in a target neighborhood with a stated budget.
2. Assistant qualifies the request without inventing availability.
3. Visitor asks to arrange a viewing and provides a phone number.
4. Lead is stored/updated in Supabase.
5. Telegram notifies the agent when follow-up is actionable.
6. The workflow prevents duplicate notifications for the same qualified lead.

## Production note

Demo listings are placeholders. For a real agency, replace them with approved listings or connect the workflow to the agency's maintained listing source/CRM.
