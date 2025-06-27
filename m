Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325E881720
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041848; cv=none; b=npPTZfa/iIb5hkE+b1cN9uH1HxpoRxLUBIHfXLisYSj8LfxTW5gPA2hg6rhMtqwBrcW6ogBr8H/BL8vUq/nvvt4qJ3i0775yd7PrcCqijlZBemuYvJG8zqUuVUDtpjOCCxEQ5uzX11X02BNRoSXecDJDePROZbhgvk+ozCbIzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041848; c=relaxed/simple;
	bh=+FXNxRrQ6V77aSNL/iiikn/tHD3Cwr8BO4PxLQssfsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kuQryEeaZupuJujw1y1cL/ZirbPZF8Zcrr0LAuj8Y2m6soT8grUtqoidZZQ0qQidYJeoMDpZiJG+SOddkFNLKgh0YaFep3JqkIKoAWPahYmeLtqzqza0IzkJqVfKHJM6ldKASagV/W0OZfngBOgiuRB6BM3bamkpafC6W5tA3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B0A91A00;
	Fri, 27 Jun 2025 09:30:28 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 207E03F58B;
	Fri, 27 Jun 2025 09:30:43 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3] perf: arm_spe: Relax period restriction
Date: Fri, 27 Jun 2025 17:30:28 +0100
Message-Id: <20250627163028.3503122-1-leo.yan@arm.com>
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
before the production. It is not actual hardware limitation but tools
currently have no way to test shorter periods.

This change relaxes the limitation by allowing any non-zero periods,
with simplifying code with clamp_t().

The downside is that small periods may increase the risk of AUX ring
buffer overruns. When an overrun occurs, the perf core layer will
trigger an irq work to disable the event and wake up the tool in user
space to read the trace data. After the tool finishes reading, it will
re-enable the AUX event.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---

Changes from v2:
- Updated comment for the difference between minimum interval
  recommendation and hardware limitation (Anshuman).
- Refactored with clamp_t().
- Removed review tag as the refactoring.

 drivers/perf/arm_spe_pmu.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 3efed8839a4e..369e77ad5f13 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -308,17 +308,21 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 
 static void arm_spe_event_sanitise_period(struct perf_event *event)
 {
-	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
 	u64 period = event->hw.sample_period;
 	u64 max_period = PMSIRR_EL1_INTERVAL_MASK;
 
-	if (period < spe_pmu->min_period)
-		period = spe_pmu->min_period;
-	else if (period > max_period)
-		period = max_period;
-	else
-		period &= max_period;
+	/*
+	 * The PMSIDR_EL1.Interval field (stored in spe_pmu->min_period) is a
+	 * recommendation for the minimum interval, not a hardware limitation.
+	 *
+	 * According to the Arm ARM (DDI 0487 L.a), section D24.7.12 PMSIRR_EL1,
+	 * Sampling Interval Reload Register, the INTERVAL field (bits [31:8])
+	 * states: "Software must set this to a nonzero value". Use 1 as the
+	 * minimum value.
+	 */
+	u64 min_period = FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1);
 
+	period = clamp_t(u64, period, min_period, max_period) & max_period;
 	event->hw.sample_period = period;
 }
 
-- 
2.34.1

