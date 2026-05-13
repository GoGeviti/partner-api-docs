# Auth And Tenancy

## Auth Model

Use two auth modes:

| Client | Auth mode | Notes |
| --- | --- | --- |
| Partner UI | WorkOS user session | Maps users to partner organizations and roles. |
| Third-party API client | OAuth 2.0 client credentials or signed API keys | Machine-to-machine access scoped to one or more partner organizations. |

## Tenant Resolution

Every request must resolve to exactly one partner organization.

Recommended resolution order:

1. Organization embedded in WorkOS session or access token.
2. `X-Geviti-Partner-Org` header for multi-org machine clients.
3. Rejected request if the token has access to multiple orgs and no org is selected.

Do not infer tenant access from member IDs alone.

## Suggested Scopes

| Scope | Meaning |
| --- | --- |
| `partner:read` | Read organization metadata. |
| `members:read` | Read partner members. |
| `members:write` | Create and update partner members. |
| `intake:read` | Read intake templates and member intake state. |
| `intake:write` | Submit or update intake responses. |
| `labs:order` | Create lab orders and scheduling requests. |
| `labs:read` | Read lab order and lab result status. |
| `labs:upload` | Upload external bloodwork files. |
| `careplans:read` | Read care plans visible to the caller. |
| `careplans:write` | Generate or modify draft care plans. |
| `careplans:approve` | Approve care plans. |
| `careplans:release` | Release approved care plans to members. |
| `webhooks:manage` | Create and manage webhook endpoints. |

## Role Permissions

| Action | Member | Admin | Practitioner | Integration client |
| --- | --- | --- | --- | --- |
| Complete own intake | Yes | On behalf of member | On behalf of member | If scoped |
| Order labs | Optional | Yes | Yes | If scoped |
| View operational lab status | Own only | Partner members | Assigned members | If scoped |
| View lab results | Released own results | Configurable | Assigned members | If scoped |
| Generate care plan | No | Optional | Yes | If scoped |
| Modify care plan | No | No | Yes | No by default |
| Approve care plan | No | No | Yes | No |
| Release care plan | No | Optional after approval | Yes | Optional |

## PHI And Audit Requirements

The Partner API should log:

- Caller identity and organization.
- Resource ID and action.
- Previous and next status for state transitions.
- Whether PHI was read, exported, downloaded, or released.
- Webhook delivery attempts and response codes.

Partner admins in corporate wellness contexts may require a different PHI visibility model than gyms or athletic departments. Treat this as a product/compliance decision, not a per-endpoint afterthought.

## Headers

| Header | Required | Purpose |
| --- | --- | --- |
| `Authorization: Bearer <token>` | Yes | WorkOS/session token or machine access token. |
| `X-Geviti-Partner-Org` | Conditional | Selects tenant when a token can access multiple orgs. |
| `Idempotency-Key` | For writes | Prevents duplicate lab orders, uploads, and care plan generation. |
| `Geviti-Request-Id` | Response | Request correlation ID returned by the API. |
