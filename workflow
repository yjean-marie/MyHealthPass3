Ahh, I see now — thanks for clarifying 👍. You don’t want a full technical spec, you want a business-friendly “before vs after” summary that compares what the old SendSMS did versus what the new SendSMSnew does, written in plain language that a stakeholder can quickly grasp.

Here’s a prompt template you can use (and reuse whenever you swap functions) that will give you that style of output:


---

Prompt

I have two functions: SendSMS (old) and SendSMSnew (new).
I want you to create a business-friendly comparison of what each function does.

Please:

Break it down into steps of the workflow.

For each step, explain what the old version did and what the new version does now.

Highlight the main differences in plain English (e.g., “Previously, the system stored the message in one place, now it stores it in two for better tracking”).

Keep the tone non-technical — easy to understand for managers, product owners, and business stakeholders.

Summarize the benefits/risks of the new version.


Here’s the old code:

<SendSMS code>

Here’s the new code:

<SendSMSnew code>


---

Example Output (style)

Old SendSMS

Validated the phone number in a basic way.

Sent the SMS through one provider only.

Logged only success/failure without details.


New SendSMSnew

Validates phone numbers more thoroughly, reducing failed sends.

Chooses between two SMS providers, improving reliability.

Keeps detailed logs of delivery time and provider response for auditing.


Key Change:
The new version improves reliability (messages less likely to fail), provides better tracking for compliance, but is slightly more complex since it manages multiple providers.


---

👉 Would you like me to shrink the original “workflow diff” prompt into this business-friendly style for you (so it’s reusable), or should I draft a ready-to-go comparison template you can drop code into and hand straight to stakeholders?

