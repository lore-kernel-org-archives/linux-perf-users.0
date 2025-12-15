Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA016272E41
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803912; cv=none; b=Hvhec9P7AzYi6ZHKuh9uckRD8saF891uQxQSKetJyw63NX8DSb+mWaSIXyy2TYAu/EdBkx5D8MkGWRNwCNeFfTg75IvRZFQ07qcOO3MD6u/yjfCHMZFt/L4nzhP+rZtM0Le1GG1k24BOIV7QW3b7vSfDt9Gl5Ctx8RNDVapN7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803912; c=relaxed/simple;
	bh=nsSdo/5bGDq6dsN29Sus6hDLxXNJ52/XzmD0nzBiniY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiibkTo8YDneH4MS6FuTm0USZjuxZxgk8rLhgKSNkioC1VFYSzwrd4yEu3cNnEURZCCJy4Z/j9Xa9/hFngnt3cEdQ1n/GDmk3rRFmF5RzukJDFRFE2ZQIuojn0pY1GUeaaR8eI4eQzKnXtwJpjh2ePBhSadmstN/CCyJ25QeO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCA3D1655;
	Mon, 15 Dec 2025 05:05:02 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E6453F73B;
	Mon, 15 Dec 2025 05:05:08 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf/arm_dsu: Support DSU-120
Date: Mon, 15 Dec 2025 13:04:59 +0000
Message-Id: <346d4d9cda0e6c8dec44c28b8911e2bd944c389c.1765802897.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1765802897.git.robin.murphy@arm.com>
References: <cover.1765802897.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DSU-120 has the same system register interface as previous DSUs, but
no longer offers a dedicated cycle counter. While this is not directly
discoverable via PMCR, the PMCCNTR register is still defined to exist
with RAZ/WI behaviour, allowing for a straightforward heuristic.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_dsu_pmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 8663721ee018..56c592f0dae3 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -101,6 +101,7 @@ struct dsu_hw_events {
  *			  excluding the cycle counter.
  * @irq			: Interrupt line for counter overflow.
  * @has_32b_pmevcntr	: Are the non-cycle counters only 32-bit?
+ * @has_pmccntr		: Do we even have a dedicated cycle counter?
  * @cpmceid_bitmap	: Bitmap for the availability of architected common
  *			  events (event_code < 0x40).
  */
@@ -115,6 +116,7 @@ struct dsu_pmu {
 	s8				num_counters;
 	int				irq;
 	bool				has_32b_pmevcntr;
+	bool				has_pmccntr;
 	DECLARE_BITMAP(cpmceid_bitmap, DSU_PMU_MAX_COMMON_EVENTS);
 };
 
@@ -281,7 +283,7 @@ static int dsu_pmu_get_event_idx(struct dsu_hw_events *hw_events,
 	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
 	unsigned long *used_mask = hw_events->used_mask;
 
-	if (evtype == DSU_PMU_EVT_CYCLES) {
+	if (evtype == DSU_PMU_EVT_CYCLES && dsu_pmu->has_pmccntr) {
 		if (test_and_set_bit(DSU_PMU_IDX_CYCLE_COUNTER, used_mask))
 			return -EAGAIN;
 		return DSU_PMU_IDX_CYCLE_COUNTER;
@@ -668,6 +670,10 @@ static void dsu_pmu_probe_pmu(struct dsu_pmu *dsu_pmu)
 	__dsu_pmu_write_counter(0, U64_MAX);
 	if (__dsu_pmu_read_counter(0) != U64_MAX)
 		dsu_pmu->has_32b_pmevcntr = true;
+	/* On even newer DSUs, PMCCNTR is RAZ/WI */
+	__dsu_pmu_write_pmccntr(U64_MAX);
+	if (__dsu_pmu_read_pmccntr() == U64_MAX)
+		dsu_pmu->has_pmccntr = true;
 }
 
 static void dsu_pmu_set_active_cpu(int cpu, struct dsu_pmu *dsu_pmu)
-- 
2.39.2.101.g768bb238c484.dirty

