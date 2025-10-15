Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C80325481;
	Wed, 15 Oct 2025 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552639; cv=none; b=gPgIEhwKRTBvfgVLEAhR7QyOhqPnE75cMR6dQSUiKSQD+JbVY7rK2yhMOrdDd4cQK5NIaUUiKJlNAJxQU7GF/UBamQBgXu15+0IdjhaJ641THb5K9y4aQ6LFYBCoEehJSA90BErvuMj2zKQKrsHBvu87LqalL1gMxi7RuWy6GNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552639; c=relaxed/simple;
	bh=hobg/DGsST/n4PHeoRQSc4GShXGVL6XzTZGQU8Mhvt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GzHGaGR6Ta1nPwqC/Nrc8mI4Ue/NmE7hGoFZoepKDY3FpmPdfwJ6Zk9vi4Wa6FllWRgKJ/IH/nGFdUSJfRbwG8EvH3hIbHqSKYCoOGzfBPBXjadXDgnmu5hHFxO1rvOM03T++vdFvhaesXqZon9672fZcxE2kWFvMKrmK5JOM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40C241688;
	Wed, 15 Oct 2025 11:23:48 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 024083F66E;
	Wed, 15 Oct 2025 11:23:54 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 15 Oct 2025 19:23:37 +0100
Subject: [PATCH] perf: arm_spe: Ensure trace is disabled when TRUNCATED
 flag is set
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm_spe_fix_truncated_flag-v1-1-555e328cba05@arm.com>
X-B4-Tracking: v=1; b=H4sIAKjm72gC/x3MQQqAIBBA0avErBPUsEVXiZCxphooi7EiiO6et
 Hzw+Q8kEqYETfGA0MWJt5hhygL6GeNEiodssNo6o41TKKtPO/mRb3/IGXs8aPDjgpMy6EJVW40
 VBsiDXShX/7zt3vcD6uwxF2wAAAA=
X-Change-ID: 20251015-arm_spe_fix_truncated_flag-1a5b3620a3ab
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760552634; l=1992;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=hobg/DGsST/n4PHeoRQSc4GShXGVL6XzTZGQU8Mhvt8=;
 b=5Ia7UVEN++q+1LfrKDFKIJROBP5XWebRE+b9jgrDT+esrW89DjFTQCwQZX3URbk6tVUAjN1h3
 vAAGHyUEVfaBzs1Y1ClAKHn85pKjW+H4VEmLft4Z/TtmWEJ8TDFUIM3
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The TRUNCATED flag can be set in the following cases:

 1. When data loss is detected (PMBSR_EL1.DL == 0b1).
 2. When arm_spe_perf_aux_output_begin() fails to find a valid limit
    because it runs out of free space.

Currently, only the first case invokes irq_work_run() to execute the
event disable callback, while the second case does not.

Move the call to irq_work_run() later with checking the TRUNCATED flag,
so that both cases are handled and redundant calls are avoided.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fa50645feddadbea5dc1e404f80f62cf5aa96fd4..05ba977f75d607a1d524f68694db9ea18a6ef20c 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -731,12 +731,6 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 	if (act == SPE_PMU_BUF_FAULT_ACT_SPURIOUS)
 		return IRQ_NONE;
 
-	/*
-	 * Ensure perf callbacks have completed, which may disable the
-	 * profiling buffer in response to a TRUNCATION flag.
-	 */
-	irq_work_run();
-
 	switch (act) {
 	case SPE_PMU_BUF_FAULT_ACT_FATAL:
 		/*
@@ -765,6 +759,15 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 		break;
 	}
 
+	/*
+	 * The TRUNCATED flag is set when data loss is detected by PMBSR_EL1.DL,
+	 * or arm_spe_perf_aux_output_begin() sets the flag if runs out of free
+	 * space. Ensure that all perf callbacks have completed for disabling
+	 * the profiling buffer.
+	 */
+	if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
+		irq_work_run();
+
 	/* The buffer pointers are now sane, so resume profiling. */
 	write_sysreg_s(0, SYS_PMBSR_EL1);
 	return IRQ_HANDLED;

---
base-commit: 1f4a222b0e334540343fbb5d3eac4584a6bfe180
change-id: 20251015-arm_spe_fix_truncated_flag-1a5b3620a3ab

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

