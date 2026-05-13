# Member Journey

The Partner API should expose one simple member journey even though Geviti's internal implementation spans several services.

## Journey Map

| Stage | Member experience | Partner/admin experience | Public status |
| --- | --- | --- | --- |
| Enrolled | Member has a profile in the partner program. | Admin can see member eligibility. | `active` |
| Intake | Member completes health questions. | Admin can monitor completion. | `intake_required` or `completed` |
| Bloodwork ordered | Member has an approved lab order. | Admin or practitioner can create the order. | `ordered` |
| Scheduled | Member books a draw or uses walk-in requisition. | Admin can see appointment state. | `scheduled` |
| Results processing | Member waits for results. | Practitioner can monitor operational status. | `processing` |
| Results ready | Results are available to authorized reviewers. | Practitioner can review biomarkers. | `results_ready` |
| Care plan review | Draft plan is generated. | Practitioner modifies and approves the plan. | `care_plan_review` |
| Released | Member can view released results and care plan. | Admin can see released state. | `care_plan_released` |

## Status Philosophy

Partner clients should not need to understand internal provider states. The Partner API should translate internal lab provider, upload, and care plan states into the public lifecycle above.

## Member-Facing Defaults

- Members can see their own profile, intake status, lab order status, released lab results, and released care plans.
- Members should not see draft care plans.
- Members should not see internal notes or provider IDs.
- Lab result visibility before care plan release should be partner-configurable.

## Admin And Practitioner Defaults

- Partner admins can enroll members, order labs, and monitor progress.
- Practitioners can review lab results, modify draft care plans, approve plans, and release plans.
- Corporate wellness partners may need stricter PHI visibility than gyms or athletic departments.
