# Quickstart

Use this page as the first integration path for a partner UI or third-party system.

## 1. Authenticate

Partner UI users authenticate through WorkOS. Server-to-server integrations use a machine token with scopes approved for one partner organization.

Every request must resolve to one partner organization.

```http
GET /partner/v1/me HTTP/1.1
Host: api.gogeviti.com
Authorization: Bearer <token>
```

## 2. Create Or Find A Member

Create partner members with a stable `external_id` from the partner system. The Partner API returns an opaque `mem_` ID for all future calls.

```json
{
  "external_id": "athlete-2048",
  "email": "jordan@example.edu",
  "first_name": "Jordan",
  "last_name": "Lee",
  "date_of_birth": "2001-05-12",
  "sex_at_birth": "female"
}
```

## 3. Complete Intake

Fetch the active intake template, then submit the member's response.

```http
GET /partner/v1/intake-template
PUT /partner/v1/members/{member_id}/intake
```

## 4. Order Bloodwork

Create a lab order for an approved panel. The order moves through a normalized public status model even when internal providers use different state names.

```json
{
  "member_id": "mem_01JZK7Q8MR5Y43TPXGT2P7C20C",
  "panel_code": "geviti_foundation",
  "collection_mode": "appointment",
  "reason": "initial_baseline"
}
```

## 5. Schedule Or Use Walk-In

For appointment-based collection, fetch availability and book a slot. For walk-in flows, retrieve the requisition PDF.

```http
POST /partner/v1/lab-orders/{lab_order_id}/availability
POST /partner/v1/lab-orders/{lab_order_id}/appointments
GET /partner/v1/lab-orders/{lab_order_id}/requisition
```

## 6. Review Results And Care Plan

Authorized admins and practitioners can read lab result status, review generated care plans, approve changes, and release care plans to members.

```http
GET /partner/v1/lab-results/{lab_result_id}
POST /partner/v1/care-plans/generate
POST /partner/v1/care-plans/{care_plan_id}/approve
POST /partner/v1/care-plans/{care_plan_id}/release
```

## 7. Subscribe To Webhooks

Use webhooks for long-running state changes such as results readiness and care plan release.

```json
{
  "url": "https://partner.example.com/webhooks/geviti",
  "events": [
    "lab_order.scheduled",
    "lab_result.ready",
    "care_plan.released"
  ]
}
```
