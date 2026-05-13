# Webhooks

Webhooks let partner systems react to long-running workflows without polling every resource.

## Endpoint Registration

```json
{
  "url": "https://partner.example.com/webhooks/geviti",
  "events": [
    "lab_order.scheduled",
    "lab_result.ready",
    "care_plan.released"
  ],
  "description": "Production partner webhook"
}
```

## Event Envelope

```json
{
  "id": "evt_01JZKA6CPYSB9N5BQJZ80KWKED",
  "type": "lab_result.ready",
  "created_at": "2026-05-13T19:04:00Z",
  "organization_id": "org_01JZK4E1NDX1Z3G35C3R8A9JRF",
  "data": {
    "member_id": "mem_01JZK7Q8MR5Y43TPXGT2P7C20C",
    "lab_order_id": "labord_01JZK86VJ8ZQ2K0F5R9TQXJQW3",
    "lab_result_id": "labres_01JZKA5W3S76F6HFWGZZPAM4ZP",
    "status": "results_ready"
  }
}
```

## Signature Headers

| Header | Purpose |
| --- | --- |
| `Geviti-Webhook-Id` | Event ID. |
| `Geviti-Webhook-Timestamp` | Unix timestamp used in signature verification. |
| `Geviti-Webhook-Signature` | HMAC signature over timestamp and body. |

## Delivery Behavior

- Send events at least once.
- Retry transient failures with exponential backoff.
- Treat non-2xx responses as failed deliveries.
- Let partners fetch missed events by event ID or resource ID.
- Keep webhook payloads small. Include resource IDs and status, not full PHI-heavy records.

## Event Catalog

| Event | When it fires |
| --- | --- |
| `member.created` | A partner member is created. |
| `member.updated` | A partner member profile is updated. |
| `intake.completed` | Required health intake is completed. |
| `lab_order.created` | A lab order is created. |
| `lab_order.requisition_ready` | Requisition PDF is available. |
| `lab_order.scheduling_required` | Scheduling is required. |
| `lab_order.scheduled` | Appointment is booked. |
| `lab_order.drawn` | Blood draw is completed. |
| `lab_result.ready` | Results are available to authorized users. |
| `lab_upload.processed` | Uploaded PDF was processed into a lab result. |
| `lab_upload.processing_failed` | Uploaded PDF could not be processed. |
| `care_plan.generated` | Draft care plan is ready for review. |
| `care_plan.approved` | Practitioner approved the care plan. |
| `care_plan.released` | Care plan is visible to the member. |

## PHI Guidance

Default webhook payloads should avoid full lab values, generated recommendations, and PDF URLs. Partners can call the API for details with appropriate scopes and audit logging.
