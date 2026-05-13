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
- Does the public contract need FHIR-compatible resources, or only Geviti-native partner DTOs?
- Do partners need bulk import endpoints for members?
- Do partners need sandbox mode with fake lab states and webhook replay?
- Which rate limits should apply per organization and per machine client?

## Implementation

- Should Partner API be a new service or a module inside an existing backend?
- Where should public-to-internal ID mappings live?
- Which service owns webhook delivery and retry state?
- Should care plan generation be called directly from Partner API or through an internal workflow queue?
- How should WorkOS organization roles map to Geviti clinical roles?
