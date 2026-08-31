# Architecture Notes

## Trust boundary

The LLM is treated as an untrusted decision component, not as the authority that performs side effects.

1. Inbound message is normalized by the workflow.
2. The model produces a constrained structured object.
3. The structured parser validates shape/type requirements.
4. Workflow conditions evaluate business rules.
5. Only explicit n8n nodes can write to Supabase or send a notification.
6. Credentials are held by n8n, not passed into the model context.

## Structured state

Representative fields include:

- contact: `name`, `phone`, `email`
- intent: `intent`, `property_type`, `location`, `budget`
- follow-up: `preferred_date`, `preferred_time`
- action state: `lead_ready`, `viewing_intent`, `handoff`
- internal summary: `status`, `notes`

The schema uses required fields and `additionalProperties: false`.

## Lead persistence

`session_id` is used as the lookup key for an existing lead. The workflow performs:

`Find Existing Lead -> Update Lead | Create Lead`

This prevents each message from blindly creating a new record.

## Side-effect policy

A Telegram sales notification is not triggered simply because the model produced text. It must pass workflow conditions.

Current duplicate guard:

`lead_ready == true AND handoff_notified != true`

After the notification succeeds, the workflow writes:

`handoff_notified = true`

### Limitation

The current guard is workflow-level and can still race under concurrent requests. A production version should atomically claim an idempotency key or enforce a unique database constraint before the external side effect.

## Memory policy

LLM context uses a bounded conversation-memory node. Persistent business state lives in Supabase. This separates model context from long-lived storage so the prompt does not need to grow with the lifetime of the lead.

## Anonymous-user authorization model

Because this is an inbound lead-capture demo, there is no account login. Anonymous callers can only enter the predefined workflow. They cannot select credentials, database tables, or arbitrary tool calls.

An authenticated SaaS version would add:

- verified user identity
- tenant ID derived server-side
- RBAC/permission checks
- tenant-scoped database policies
- audit records for privileged actions

## Failure handling / production hardening

The deployed demo relies mainly on n8n execution logs and node failure visibility. It does not claim a mature provider-failover subsystem.

A hardened version would add:

- explicit request timeout
- retry classification for 429/5xx/network errors
- bounded exponential backoff with jitter
- provider/model fallback for retry-safe inference
- idempotency key for side effects
- structured error telemetry
- token/cost logging per request and tenant
