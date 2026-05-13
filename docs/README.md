# Geviti Partner API

Status: mock documentation draft.

The Geviti Partner API is a proposed partner-facing API for white-label health experiences. It gives approved partner organizations a simplified way to enroll members, order or upload bloodwork, surface results, and review care plans.

This GitBook is intended for product, engineering, and partner teams before build begins. The endpoint names, payloads, and workflows are draft contracts that should be refined against clinical, compliance, operational, and partner needs.

## What This Covers

- Partner member enrollment and health intake.
- Bloodwork ordering, scheduling, requisitions, status tracking, and result delivery.
- External bloodwork PDF upload for care plan generation.
- Simplified member-facing results and care plan reads.
- Partner admin workflows for ordering labs, viewing lab progress, and reviewing care plans.
- Webhooks for partner systems and white-label frontends.

## Primary Consumers

- White-label Partner UI used by gyms, athletic departments, and corporate wellness programs.
- Third-party partner systems that want to integrate member enrollment, lab ordering, or results status.
- Practitioner or admin users acting on behalf of a partner organization.

## Design Position

The Partner API should be a stable partner contract with clear resources, predictable states, and partner-safe permissions. Partners should be able to build against member, lab, result, care plan, and webhook resources without needing to understand Geviti operational details.

The first build should be narrow and predictable on purpose: tenant-safe, auditable, idempotent, webhook-friendly, and easy to document.

## Start Here

| Page | Use it for |
| --- | --- |
| [Quickstart](quickstart.md) | The shortest path from auth to member creation, labs, results, and care plan release. |
| [Member Journey](member-journey.md) | The lifecycle partners and white-label UIs should build around. |
| [Product Scope](product-scope.md) | What belongs in the partner product and what does not. |
| [Auth And Tenancy](auth-and-tenancy.md) | Roles, scopes, organization resolution, and PHI visibility boundaries. |
| [API Reference](api-reference.md) | Endpoint groups, examples, and the full generated endpoint explorer. |

The generated endpoint explorer is available at [Endpoint Explorer](https://geviti.gitbook.io/docs.gogeviti.com/reference).
