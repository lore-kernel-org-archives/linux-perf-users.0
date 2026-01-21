Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3393D3003;
	Wed, 21 Jan 2026 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995227; cv=none; b=a/gKtgBlZmyjz2V5b5IVKNzoluMeXpnnvyhKc5gdNB+EqdWhT6m843uopp5oktTLUCcit7qAxG30wrbJ6DJ2V1b94St9sASxZZhnp3lVphe8Dcy4+zep2GrKPgk9QfNf68KorSmdROlGP4zhApwkCih5TWX9vt8yh1rxxR+FQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995227; c=relaxed/simple;
	bh=LmaBYsW9FqbnsXv7SfDorSFPOjfm3Ijv1uXk0j4TWBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BCNJ0dIz7Z2xfXT+wK1POM4+ZjzCX23z3HIaS9ohCX7AzTFOHFvfU6VQgbS9UkYq2e1qqk+9vZWuMlw/sMhOe5p5U+4ygr3pVKcHBSl7u3VLruHG0DWappWSecVfngJLtI1P0wylv1Ql3dpvlYhro9d7alumQrSyrQ5I/xUQc0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BFC51476;
	Wed, 21 Jan 2026 03:33:36 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0BFC3F632;
	Wed, 21 Jan 2026 03:33:41 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 21 Jan 2026 11:33:21 +0000
Subject: [PATCH v3] perf: arm_spe: Properly set hw.state on failures
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-arm_spe_fix_truncated_flag-v3-1-214747f68b50@arm.com>
X-B4-Tracking: v=1; b=H4sIAIC5cGkC/43NTQ6CMBAF4KuYrq3ptA6CK+9hTFPKAE3kJy02G
 sLdLWzYGZfvzcs3MwvkHQV2PczMU3TBDX0K6nhgtjV9Q9xVKTMpJIIA5MZ3Ooyka/fWk3/11kx
 U6fppGg4GS5VJYZQpWQJGT2m14fdHyq0L0+A/268Ia/sXG4EDR0RSMrelEXhL45MdOraiUe4Qg
 PgJSZ7umSwuZ1HkaO0OLcvyBTsgsGILAQAA
X-Change-ID: 20251015-arm_spe_fix_truncated_flag-1a5b3620a3ab
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768995221; l=4365;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=LmaBYsW9FqbnsXv7SfDorSFPOjfm3Ijv1uXk0j4TWBk=;
 b=uwAGDsaU4MXHVWZAV63Or2xC/4jiAeXBNq4FasdQPwNvTulHkgnC9FegBPw2zOgD9VbFSYWBw
 HHKJ+0jebN4Au8jUWmoVRI/X1Fscax5W22fjEqgQUUE8oKlCzVSnoCF
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

When arm_spe_pmu_next_off() fails to calculate a valid limit, it returns
zero to indicate that tracing should not start.  However, the caller
arm_spe_perf_aux_output_begin() does not propagate this failure by
updating hwc->state, cause the error to be silently ignored by upper
layers.

Because hwc->state remains zero after a failure, arm_spe_pmu_start()
continues to programs filter registers unnecessarily.  The driver
still reports success to the perf core, so the core assumes the SPE
event was enabled and proceeds to enable other events.  This breaks
event group semantics: SPE is already stopped while other events in the
same group are enabled.

Fix this by updating arm_spe_perf_aux_output_begin() to return a status
code indicating success (0) or failure (-EAGAIN).  Both the interrupt
handler and arm_spe_pmu_start() check the return value and call
arm_spe_pmu_stop() to set PERF_HES_STOPPED in hwc->state.

In the interrupt handler, the period (e.g., period_left) needs to be
updated, so PERF_EF_UPDATE is passed to arm_spe_pmu_stop().  When the
error occurs during event start, the trace unit is not yet enabled, so
a flag '0' is used to drain buffer and update state only.

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
This change has been verified on Orion6 board.
---
Changes in v3:
- Updated arm_spe_perf_aux_output_begin() for returning error and used
  arm_spe_pmu_stop() for setting hw_state properly (Will).
- Link to v2: https://lore.kernel.org/r/20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com
---
 drivers/perf/arm_spe_pmu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 4801115f2b54052d584b59881f458c2640e974ff..b9a6748827cc5557c42023f323a90b5826eadb54 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -106,6 +106,8 @@ struct arm_spe_pmu {
 /* Keep track of our dynamic hotplug state */
 static enum cpuhp_state arm_spe_pmu_online;
 
+static void arm_spe_pmu_stop(struct perf_event *event, int flags);
+
 enum arm_spe_pmu_buf_fault_action {
 	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
 	SPE_PMU_BUF_FAULT_ACT_FATAL,
@@ -607,8 +609,8 @@ static u64 arm_spe_pmu_next_off(struct perf_output_handle *handle)
 	return limit;
 }
 
-static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
-					  struct perf_event *event)
+static int arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
+					 struct perf_event *event)
 {
 	u64 base, limit;
 	struct arm_spe_pmu_buf *buf;
@@ -622,7 +624,6 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	/* Start a new aux session */
 	buf = perf_aux_output_begin(handle, event);
 	if (!buf) {
-		event->hw.state |= PERF_HES_STOPPED;
 		/*
 		 * We still need to clear the limit pointer, since the
 		 * profiler might only be disabled by virtue of a fault.
@@ -642,6 +643,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 
 out_write_limit:
 	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
+	return (limit & PMBLIMITR_EL1_E) ? 0 : -EAGAIN;
 }
 
 static void arm_spe_perf_aux_output_end(struct perf_output_handle *handle)
@@ -781,7 +783,10 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 		 * when we get to it.
 		 */
 		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
-			arm_spe_perf_aux_output_begin(handle, event);
+			if (arm_spe_perf_aux_output_begin(handle, event)) {
+				arm_spe_pmu_stop(event, PERF_EF_UPDATE);
+				break;
+			}
 			isb();
 		}
 		break;
@@ -880,9 +885,10 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 	struct perf_output_handle *handle = this_cpu_ptr(spe_pmu->handle);
 
 	hwc->state = 0;
-	arm_spe_perf_aux_output_begin(handle, event);
-	if (hwc->state)
+	if (arm_spe_perf_aux_output_begin(handle, event)) {
+		arm_spe_pmu_stop(event, 0);
 		return;
+	}
 
 	reg = arm_spe_event_to_pmsfcr(event);
 	write_sysreg_s(reg, SYS_PMSFCR_EL1);

---
base-commit: c03e9c42ae8f9be76a0cf55ef3f88663f0f6a63a
change-id: 20251015-arm_spe_fix_truncated_flag-1a5b3620a3ab

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

