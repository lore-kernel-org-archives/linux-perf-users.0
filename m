Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA7E29D293
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803911; cv=none; b=LLnZL25d6aJTW/Ko6TSjHXen7e5RsKgsdpjlS6gMFzHOb0uuP9ByLTYBfLZzKXy5BR37nDaWdY5cHITqclegeUvpr7D31iMCHukX9ZAMYhKDtS72G4lBSabsuuHzfhFq535e40ezMcfxA9t9d23JXGJfKqQFxuVVHkGCRTyJjTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803911; c=relaxed/simple;
	bh=HOkfPv1YtQ8Gs+1G8Fam+OBMZyZrMbsL5SDrVXNRVJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRpPJnjSOgJArRck1MrXoB0aYAslD2225IMtuz+xOwFrALHFO77wF1Ho7aiPV6pfan5KG4ORAtl482eFuYEqkJbStbrSwgx0/Ls1kkFNoLKjy5Dz1Q/reZiLWmWMwz/JzTx3fB4MQAx686BsR2cPDLapnLVmCc23mkoKG8Xkdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88B01FEC;
	Mon, 15 Dec 2025 05:05:01 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B329F3F73B;
	Mon, 15 Dec 2025 05:05:07 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf/arm_dsu: Support DSU-110
Date: Mon, 15 Dec 2025 13:04:58 +0000
Message-Id: <5aa884a673f7a53f4793176662e64e4851e394d8.1765802897.git.robin.murphy@arm.com>
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

DSU-110 sneakily made all the event counters 64-bit, perhaps related
to no longer having AArch32 EL1 to worry about. While the DSU version
itself is not easily discoverable, the size of a counter certainly is.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_dsu_pmu.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index cb4fb59fe04b..8663721ee018 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -66,13 +66,6 @@
  */
 #define DSU_PMU_IDX_CYCLE_COUNTER	31
 
-/* All event counters are 32bit, with a 64bit Cycle counter */
-#define DSU_PMU_COUNTER_WIDTH(idx)	\
-	(((idx) == DSU_PMU_IDX_CYCLE_COUNTER) ? 64 : 32)
-
-#define DSU_PMU_COUNTER_MASK(idx)	\
-	GENMASK_ULL((DSU_PMU_COUNTER_WIDTH((idx)) - 1), 0)
-
 #define DSU_EXT_ATTR(_name, _func, _config)		\
 	(&((struct dev_ext_attribute[]) {				\
 		{							\
@@ -107,6 +100,7 @@ struct dsu_hw_events {
  * @num_counters	: Number of event counters implemented by the PMU,
  *			  excluding the cycle counter.
  * @irq			: Interrupt line for counter overflow.
+ * @has_32b_pmevcntr	: Are the non-cycle counters only 32-bit?
  * @cpmceid_bitmap	: Bitmap for the availability of architected common
  *			  events (event_code < 0x40).
  */
@@ -120,6 +114,7 @@ struct dsu_pmu {
 	struct hlist_node		cpuhp_node;
 	s8				num_counters;
 	int				irq;
+	bool				has_32b_pmevcntr;
 	DECLARE_BITMAP(cpmceid_bitmap, DSU_PMU_MAX_COMMON_EVENTS);
 };
 
@@ -328,6 +323,11 @@ static inline void dsu_pmu_set_event(struct dsu_pmu *dsu_pmu,
 	raw_spin_unlock_irqrestore(&dsu_pmu->pmu_lock, flags);
 }
 
+static u64 dsu_pmu_counter_mask(struct hw_perf_event *hw)
+{
+	return (hw->flags && hw->idx != DSU_PMU_IDX_CYCLE_COUNTER) ? U32_MAX : U64_MAX;
+}
+
 static void dsu_pmu_event_update(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -339,7 +339,7 @@ static void dsu_pmu_event_update(struct perf_event *event)
 		new_count = dsu_pmu_read_counter(event);
 	} while (local64_cmpxchg(&hwc->prev_count, prev_count, new_count) !=
 			prev_count);
-	delta = (new_count - prev_count) & DSU_PMU_COUNTER_MASK(hwc->idx);
+	delta = (new_count - prev_count) & dsu_pmu_counter_mask(hwc);
 	local64_add(delta, &event->count);
 }
 
@@ -362,8 +362,7 @@ static inline u32 dsu_pmu_get_reset_overflow(void)
  */
 static void dsu_pmu_set_event_period(struct perf_event *event)
 {
-	int idx = event->hw.idx;
-	u64 val = DSU_PMU_COUNTER_MASK(idx) >> 1;
+	u64 val = dsu_pmu_counter_mask(&event->hw) >> 1;
 
 	local64_set(&event->hw.prev_count, val);
 	dsu_pmu_write_counter(event, val);
@@ -564,6 +563,7 @@ static int dsu_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	event->hw.config_base = event->attr.config;
+	event->hw.flags = dsu_pmu->has_32b_pmevcntr;
 	return 0;
 }
 
@@ -664,6 +664,10 @@ static void dsu_pmu_probe_pmu(struct dsu_pmu *dsu_pmu)
 	cpmceid[1] = __dsu_pmu_read_pmceid(1);
 	bitmap_from_arr32(dsu_pmu->cpmceid_bitmap, cpmceid,
 			  DSU_PMU_MAX_COMMON_EVENTS);
+	/* Newer DSUs have 64-bit counters */
+	__dsu_pmu_write_counter(0, U64_MAX);
+	if (__dsu_pmu_read_counter(0) != U64_MAX)
+		dsu_pmu->has_32b_pmevcntr = true;
 }
 
 static void dsu_pmu_set_active_cpu(int cpu, struct dsu_pmu *dsu_pmu)
-- 
2.39.2.101.g768bb238c484.dirty

