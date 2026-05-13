# Product Scope

## Goal

Create a Partner API that supports a simplified, white-label version of Geviti's bloodwork and care plan experience for partner organizations.

The Partner API should support two clients:

- Partner UI: a white-label application for partner members, practitioners, and admins.
- Third-party API clients: partner-owned systems that need to automate member enrollment, lab ordering, status checks, and webhook consumption.

## Target Partner Types

| Segment | Typical users | API needs |
| --- | --- | --- |
| Gym organizations | Coaches, members, gym admins | High-volume enrollment, simple lab ordering, member result views, care plan release. |
| College athletic departments | Athletes, trainers, team physicians, admins | Cohort management, practitioner review, tighter role boundaries, audit trails. |
| Corporate wellness | Employees, HR benefits admins, wellness vendors | Consent, eligibility, aggregate-safe operations, restricted PHI visibility. |

## MVP Capabilities

| Capability | Included in MVP | Notes |
| --- | --- | --- |
| Member enrollment | Yes | Create partner-scoped member profiles and eligibility records. |
| Health intake | Yes | Fetch the current intake template and submit member responses. |
| Bloodwork ordering | Yes | Create orders for supported lab panels and track status. |
| Scheduling | Yes | Resolve availability and book appointments where supported. |
| Requisition delivery | Yes | Make requisition PDFs available for orders that require them. |
| Results delivery | Yes | Show normalized biomarker results and downloadable PDFs when available. |
| Bloodwork upload | Yes | Let members or admins upload external bloodwork PDFs for processing. |
| Care plan generation | Yes | Trigger care plan generation from ordered labs or uploaded labs. |
| Care plan review | Yes | Let approved partner practitioners review, modify, approve, and release plans. |
| Webhooks | Yes | Notify partners of major status transitions. |

## Out Of Scope For The First Partner Contract

- Raw clinical records or low-level lab vendor payloads.
- Vendor-specific order IDs as primary partner-facing IDs.
- Subscription billing, supplement ordering, pharmacy workflows, or payments.
- Full clinical operations tooling.
- Ad hoc partner-defined lab panels without clinical/product approval.
- Cross-organization member search.
- Aggregate reporting dashboards for employers or teams.

## Partner Roles

| Role | Purpose |
| --- | --- |
| `partner_admin` | Manages partner members, can order labs, sees operational statuses, may see lab results if configured. |
| `partner_practitioner` | Reviews results, modifies care plans, approves and releases care plans. |
| `partner_member` | Completes intake, schedules labs, uploads labs, views released results and plans. |
| `integration_client` | Machine-to-machine client for partner-owned systems. |

## Product Principle

The API should present one clear partner journey across enrollment, intake, bloodwork, results, care plan review, and release.
