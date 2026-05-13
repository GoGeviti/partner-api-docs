# Domain Model

## Partner Resources

| Resource | Partner ID | Purpose |
| --- | --- | --- |
| Partner organization | `org_...` | Tenant boundary for members, admins, practitioners, and integrations. |
| Partner member | `mem_...` | A person enrolled through a partner. |
| Practitioner | `prac_...` | A clinician or approved reviewer assigned to partner members. |
| Intake response | `intake_...` | Health intake answers submitted by or for a member. |
| Lab order | `labord_...` | Ordered bloodwork journey for a member. |
| Lab appointment | `appt_...` | Appointment or walk-in state attached to a lab order. |
| Lab result | `labres_...` | Normalized result summary and biomarkers. |
| Bloodwork upload | `upload_...` | External lab PDF upload for processing. |
| Care plan | `cp_...` | Draft, approved, or released recommendations. |
| Webhook endpoint | `we_...` | Partner URL and subscribed events. |

## Lab Order Status

Use one partner-visible state machine for the bloodwork journey.

| Status | Meaning |
| --- | --- |
| `intake_required` | Member must complete intake before ordering or care plan generation. |
| `ordered` | Lab order was created. |
| `requisition_ready` | Requisition exists for appointment or walk-in path. |
| `scheduling_required` | Order exists but appointment is not scheduled. |
| `scheduled` | Appointment has been booked. |
| `drawn` | Blood draw was completed or marked complete. |
| `processing` | Results are being processed. |
| `results_ready` | Lab results are available to authorized reviewers. |
| `care_plan_generating` | Care plan generation is in progress. |
| `care_plan_review` | Draft care plan exists and needs review. |
| `care_plan_released` | Care plan and allowed result views are released to the member. |
| `cancelled` | Order was cancelled. |
| `failed` | Order, processing, or care plan generation failed. |

## Care Plan Status

| Status | Meaning |
| --- | --- |
| `generating` | Generation job is running. |
| `draft` | Draft is available but not approved. |
| `review_required` | Practitioner review is required before release. |
| `approved` | Practitioner has approved the plan. |
| `released` | Member can view the plan. |
| `archived` | Plan was superseded or removed from active use. |

## Member Visibility

Member-facing responses should be intentionally narrower than admin or practitioner responses.

| Field class | Member | Admin | Practitioner |
| --- | --- | --- | --- |
| Own demographic fields | Yes | Yes | Yes |
| Operational lab status | Yes | Yes | Yes |
| Raw biomarkers | After release | Configurable | Yes |
| Care plan draft | No | No by default | Yes |
| Released care plan | Yes | Yes | Yes |
| Clinical review notes | No | No by default | Yes |

## ID Policy

Partner IDs should be opaque, stable, and non-sequential. Partners should treat IDs as identifiers only, not as meaningful or parseable values.
