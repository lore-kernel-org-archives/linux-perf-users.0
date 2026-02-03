Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53143AA1B5;
	Tue,  3 Feb 2026 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129669; cv=none; b=YEpKDV0BAbLRyCYEwdiOpR0KnFRrK2ugZojM9faYb3dfz1571hys5l/85Izzce812PoHITd+vkAbXSN+3R6Lf/XkMAFmWPLbfk+k8s6mlL32Bzy6pSRCfxyC9AUHtUnp/pRli6N+bQPddiFzkSVUBVGTpdBGbL2EAdlN5e3pmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129669; c=relaxed/simple;
	bh=K9XYeWANGub/KS9iu16G02JqEfjtpdfOf/pUXSMaTkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WC11rpC3cOBDtljK/0U8EarlfXlgliBhWZNnr6a8UwwI23jtMJFdH8+KZlUEt8tbGlB7j0h85FMF77KcnfIuGG4H9g/13307oCV4ItaSMPQZUyhp503kACUoU/NqybB5YRcxVwBUGw+NPV2JfQxFSVYNJ3fItrn7jI3bYnJKywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76258339;
	Tue,  3 Feb 2026 06:41:00 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DCBF3F740;
	Tue,  3 Feb 2026 06:41:05 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 03 Feb 2026 14:40:43 +0000
Subject: [PATCH v4] perf: arm_spe: Properly set hw.state on failures
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-arm_spe_fix_truncated_flag-v4-1-1e07df317584@arm.com>
X-B4-Tracking: v=1; b=H4sIAOoIgmkC/43OTQrCMBAF4KuUrI1kJp22uvIeIiVN0xqwPyQ1K
 KV3NxVE3BSXb+bxzczMG2eNZ8dkZs4E6+3Qx5DuEqavqm8Nt3XMDAUSCCCuXFf60ZSNfZSTu/d
 aTaYum5tqOSiqZIZCSVWxCIzOxNYbP19ivlo/De75vhVgnf7FBuDAichILHSlBJ1iea+Hjq1ow
 C8EIDYh5HGf4SFPxaEgrX8h+YEyAQibkIwfIaR5mjdZUZH4QsuyvADOswUxVAEAAA==
X-Change-ID: 20251015-arm_spe_fix_truncated_flag-1a5b3620a3ab
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770129665; l=4499;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=K9XYeWANGub/KS9iu16G02JqEfjtpdfOf/pUXSMaTkI=;
 b=414Wm7nwF7m5PI5VB9b4+jb8mW6Tn63d0Wrt5rIeZMhTQcVnARbrXXMCjvU2rEnJ5v4nlzEA9
 3YR9LuLnsFfDlbJI69Z5iAKBUoRFMQiyDrDAx1UbJIo9vrXn3uJFwJV
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
code indicating success (0) or failure (-EIO).  Both the interrupt
handler and arm_spe_pmu_start() check the return value and call
arm_spe_pmu_stop() to set PERF_HES_STOPPED in hwc->state.

In the interrupt handler, the period (e.g., period_left) needs to be
updated, so PERF_EF_UPDATE is passed to arm_spe_pmu_stop().  When the
error occurs during event start, the trace unit is not yet enabled, so
a flag '0' is used to drain buffer and update state only.

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v4:
- Updated error number (-EIO) in arm_spe_perf_aux_output_begin (Will).
- Link to v3: https://lore.kernel.org/r/20260121-arm_spe_fix_truncated_flag-v3-1-214747f68b50@arm.com

Changes in v3:
- Updated arm_spe_perf_aux_output_begin() for returning error and used
  arm_spe_pmu_stop() for setting hw_state properly (Will).
- Link to v2: https://lore.kernel.org/r/20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com
---
 drivers/perf/arm_spe_pmu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 4801115f2b54052d584b59881f458c2640e974ff..5410fb7428d0e4226a2488f1763bdadf4c995e00 100644
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
+	return (limit & PMBLIMITR_EL1_E) ? 0 : -EIO;
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
base-commit: 6bd9ed02871f22beb0e50690b0c3caf457104f7c
change-id: 20251015-arm_spe_fix_truncated_flag-1a5b3620a3ab

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

