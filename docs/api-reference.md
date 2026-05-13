# API Reference

Base URL:

```text
https://api.gogeviti.com/partner/v1
```

This is a mock public contract. Names and payloads should be validated before implementation.

For the generated endpoint explorer, use the [full OpenAPI reference](https://geviti.gitbook.io/docs.gogeviti.com/reference).

## Conventions

| Convention | Draft decision |
| --- | --- |
| Versioning | Path versioning under `/v1`. |
| IDs | Opaque prefixed IDs such as `mem_`, `labord_`, `labres_`, `cp_`, `we_`. |
| Pagination | Cursor pagination with `limit` and `cursor`. |
| Writes | Support `Idempotency-Key` on create, upload, scheduling, generation, approval, and release operations. |
| Time | ISO 8601 timestamps in UTC. |
| Errors | JSON error envelope with `code`, `message`, `request_id`, and optional `details`. |
| Files | Multipart upload for PDFs. Download links should be short-lived signed URLs. |

## Error Shape

```json
{
  "error": {
    "code": "lab_order_not_schedulable",
    "message": "This lab order cannot be scheduled in its current state.",
    "request_id": "req_01J..."
  }
}
```

## Organization

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/me` | Return caller identity, org memberships, roles, and scopes. |
| `GET` | `/organization` | Return the selected partner organization and enabled capabilities. |

## Members

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/members` | List partner members. |
| `POST` | `/members` | Create a partner member. |
| `GET` | `/members/{member_id}` | Read a member profile and high-level status. |
| `PATCH` | `/members/{member_id}` | Update allowed demographic or contact fields. |

### Create Member

```http
POST /partner/v1/members
Authorization: Bearer <token>
Idempotency-Key: 87b7a49f-00af-4f85-8e9e-61ac0f30df05
Content-Type: application/json
```

```json
{
  "external_id": "athlete-2048",
  "email": "jordan@example.edu",
  "first_name": "Jordan",
  "last_name": "Lee",
  "date_of_birth": "2001-05-12",
  "sex_at_birth": "female",
  "phone": "+16025550100",
  "address": {
    "line1": "100 Training Center Way",
    "city": "Phoenix",
    "region": "AZ",
    "postal_code": "85004",
    "country": "US"
  }
}
```

```json
{
  "id": "mem_01JZK7Q8MR5Y43TPXGT2P7C20C",
  "external_id": "athlete-2048",
  "email": "jordan@example.edu",
  "first_name": "Jordan",
  "last_name": "Lee",
  "status": "active",
  "created_at": "2026-05-13T18:21:00Z"
}
```

## Intake

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/intake-template` | Read the currently active partner intake template. |
| `GET` | `/members/{member_id}/intake` | Read member intake status and latest response. |
| `PUT` | `/members/{member_id}/intake` | Submit or replace member intake response. |

## Lab Ordering

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/lab-orders` | List lab orders by member, status, or date. |
| `POST` | `/lab-orders` | Create a lab order for a member. |
| `GET` | `/lab-orders/{lab_order_id}` | Read lab order status and appointment summary. |
| `POST` | `/lab-orders/{lab_order_id}/availability` | Find available appointment slots near an address. |
| `POST` | `/lab-orders/{lab_order_id}/appointments` | Book an appointment. |
| `POST` | `/lab-orders/{lab_order_id}/cancel` | Cancel a lab order where allowed. |
| `GET` | `/lab-orders/{lab_order_id}/requisition` | Return a short-lived requisition PDF URL. |

### Create Lab Order

```json
{
  "member_id": "mem_01JZK7Q8MR5Y43TPXGT2P7C20C",
  "panel_code": "geviti_foundation",
  "collection_mode": "appointment",
  "reason": "initial_baseline"
}
```

```json
{
  "id": "labord_01JZK86VJ8ZQ2K0F5R9TQXJQW3",
  "member_id": "mem_01JZK7Q8MR5Y43TPXGT2P7C20C",
  "panel_code": "geviti_foundation",
  "status": "scheduling_required",
  "created_at": "2026-05-13T18:24:00Z"
}
```

### Find Availability

```json
{
  "address": {
    "line1": "100 Training Center Way",
    "city": "Phoenix",
    "region": "AZ",
    "postal_code": "85004",
    "country": "US"
  },
  "from": "2026-05-20",
  "to": "2026-05-30"
}
```

```json
{
  "slots": [
    {
      "slot_id": "slot_01JZK8F1SN6MRS9KEQ2G6YSC7Y",
      "starts_at": "2026-05-21T15:30:00Z",
      "ends_at": "2026-05-21T15:45:00Z",
      "location": {
        "name": "Lab Partner Phoenix",
        "line1": "200 Clinic Ave",
        "city": "Phoenix",
        "region": "AZ",
        "postal_code": "85004"
      }
    }
  ]
}
```

## Lab Results

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/lab-results` | List lab results visible to the caller. |
| `GET` | `/lab-results/{lab_result_id}` | Read normalized biomarkers and interpretation summary. |
| `GET` | `/lab-results/{lab_result_id}/pdf` | Return a short-lived result PDF URL when available. |
| `POST` | `/lab-results/uploads` | Upload an external bloodwork PDF for processing. |
| `GET` | `/lab-results/uploads/{upload_id}` | Read upload processing status. |

## Care Plans

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/care-plans` | List care plans by member or status. |
| `POST` | `/care-plans/generate` | Generate a care plan from a lab result or upload. |
| `GET` | `/care-plans/{care_plan_id}` | Read a care plan. |
| `PATCH` | `/care-plans/{care_plan_id}` | Modify draft recommendations. |
| `POST` | `/care-plans/{care_plan_id}/approve` | Practitioner approval. |
| `POST` | `/care-plans/{care_plan_id}/release` | Release approved plan to the member. |

### Modify Care Plan

```json
{
  "sections": [
    {
      "type": "lifestyle",
      "items": [
        {
          "id": "rec_01JZK92EXVFM0V2P28AKV8FZTX",
          "title": "Increase Zone 2 training",
          "body": "Add two 30 minute Zone 2 sessions per week.",
          "status": "active"
        }
      ]
    }
  ],
  "review_note": "Adjusted for in-season training load."
}
```

## Webhook Endpoints

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/webhook-endpoints` | List webhook endpoints. |
| `POST` | `/webhook-endpoints` | Create a webhook endpoint. |
| `PATCH` | `/webhook-endpoints/{webhook_endpoint_id}` | Update URL, status, or events. |
| `DELETE` | `/webhook-endpoints/{webhook_endpoint_id}` | Disable a webhook endpoint. |

## High-Value Events

- `member.created`
- `intake.completed`
- `lab_order.created`
- `lab_order.scheduled`
- `lab_order.drawn`
- `lab_result.ready`
- `care_plan.generated`
- `care_plan.approved`
- `care_plan.released`
- `lab_upload.processing_failed`
