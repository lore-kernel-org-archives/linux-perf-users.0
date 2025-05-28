Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7411FAA
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438708; cv=none; b=CfOD7dEOHSZJHMxrXDHT1A4NcHkrT1/oFazYzjWkMxhRNJrOitNRfN0V4gf2mTRKAFfJdr9555DOQFQDGvghTnpfikRZDDBa3rcELzW6k44L5r05UO7AkSPjQej+Xod83t18He+CYwPQRjo0br93SWAllWXymNQRFQf5L5cj8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438708; c=relaxed/simple;
	bh=pgUX/6wv2h9UGOue60s725HniUj4sD7+r4HH9pIxXRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F0EP0mrEhtseE0xfbjajtvve4/v1ND/JHkIhQ7xVNFD/MQDvJx1fTdVBRy+sfqrWJIfNLZCwZd1EclFDuH1rm2iVFo9K+mkze09ztgelrZupeTleXtQCNyLkVySZgpGoaz0pPkDOdIVVXagz+kCFBs2l8wrTAZeZG3Y4w1zM31M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BAB51A2D;
	Wed, 28 May 2025 06:24:50 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3DA33F5A1;
	Wed, 28 May 2025 06:25:05 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2] perf: arm_spe: Relax period restriction
Date: Wed, 28 May 2025 14:25:01 +0100
Message-Id: <20250528132501.129586-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The minimum interval specified the PMSIDR_EL1.Interval field is a
hardware recommendation. However, this value is set by hardware designer
before the production. It may not accurately reflects actual hardware
limitations, and tools currently have no way to test shorter periods.

This change relaxes the limitation by allowing any non-zero periods.
This gives chance for experimenting smaller periods.

The downside is that small periods may increase the risk of AUX ring
buffer overruns. When an overrun occurs, the perf core layer will
trigger an irq work to disable the event and wake up the tool in user
space to read the trace data. After the tool finishes reading, it will
re-enable the AUX event.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---

Changes from v1:
- Shifted bits with FIELD_PREP().
- Removed warning log which is not quite useful. (James Clark)

 drivers/perf/arm_spe_pmu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 3efed8839a4e..e40e5daa838d 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -308,12 +308,16 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 
 static void arm_spe_event_sanitise_period(struct perf_event *event)
 {
-	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
 	u64 period = event->hw.sample_period;
 	u64 max_period = PMSIRR_EL1_INTERVAL_MASK;
 
-	if (period < spe_pmu->min_period)
-		period = spe_pmu->min_period;
+	/*
+	 * As per the Arm ARM (DDI 0487 L.a), section D24.7.12 PMSIRR_EL1,
+	 * Sampling Interval Reload Register, the INTERVAL field (bits [31:8])
+	 * states: "Software must set this to a nonzero value."
+	 */
+	if (period < FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1))
+		period = FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1);
 	else if (period > max_period)
 		period = max_period;
 	else
-- 
2.34.1

