# Open Questions

## Product And Partner Model

- Should gyms, athletic departments, and corporate wellness partners share one default permission model, or should they use separate partner templates?
- Can partner admins see individual PHI, or only operational status, for corporate wellness customers?
- Are partners allowed to invite their own practitioners, or must Geviti approve every practitioner account?
- Should members belong to more than one partner organization?
- Should partner membership be time-bound, for example by season, employment period, or membership subscription?

## Clinical And Compliance

- Which care plan changes require a licensed practitioner?
- Can any partner be configured for auto-approval or auto-release?
- What disclaimers must be included in partner-facing care plan responses?
- Should lab results be released before care plan review, after review, or partner-configurable?
- What audit records need to be exportable for compliance review?

## Lab Operations

- Which lab panels are available in the first partner product?
- Is walk-in supported for every partner type?
- What should happen when a member is outside supported lab geography?
- Who handles failed appointments, cancellations, and reschedules?
- Should partner admins be able to order repeat labs on a cadence?

## API Contract

- Should the third-party API use OAuth client credentials, API keys, or both?
- Do partners need healthcare-standard export formats, or only Geviti partner DTOs?
- Do partners need bulk import endpoints for members?
- Do partners need sandbox mode with fake lab states and webhook replay?
- Which rate limits should apply per organization and per machine client?

## Build And Operations

- What build path best supports a stable partner-facing contract?
- Which team owns webhook delivery, retry behavior, and partner support?
- What operational service levels should partners expect for lab status updates and care plan generation?
- How should partner organization roles map to clinical review permissions?
- What onboarding checklist should partners complete before production access?
