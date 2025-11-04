Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E73299A94
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280991; cv=none; b=cTRsSAWPceb9+yyXkS58MmJZH4a6AAbVI9Csfi6YlPbDod5fwnPF0S+8dcrkiro3G8F9qdKIRB19Pc1YgeJfrXrGRQDZAzotZPObz2sgpWk0/FwP/3B/9k5p9MqvrRW9esOUkAA3sYOk4xUvyzMEq+MTIWZGW1ejjFW4mVj//6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280991; c=relaxed/simple;
	bh=yYH8xZ0Jz65IWgdyabY4SB+cEF8Iq+weMAOkGBSCulA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XyjeanEkE1XnaDwXtoca58bzxjJMrDak39NBFQqzzCcVfa8/g/wly0lBY9RkEA6fBknBU6koLOVELicHeA8Os3eR1eszezvxkU4MJ5iP8ma8c9C44VxplZl4vr7/QcXiIJRWVp9M/YK/81GV9dV9rMBcqO5bPZ/TtsUfqK9pMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C69A61CE0;
	Tue,  4 Nov 2025 10:29:40 -0800 (PST)
Received: from 010265703453.cambridge.arm.com (010265703453.cambridge.arm.com [10.1.33.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D22D23F694;
	Tue,  4 Nov 2025 10:29:47 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] perf/arm-ni: Fix and optimise register offset calculation
Date: Tue,  4 Nov 2025 18:29:40 +0000
Message-Id: <5db610facd51b81af04b1afee53191836315b17a.1762264719.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LKP points out an operator precedence oversight in the new NoC S3
support that, annoyingly, my local W=1 build didn't flag. In fixing
that, we can also take the similarly-missed opportunity to cache the
version check itself at event_init time.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511041749.ok8zDP6u-lkp@intel.com/
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-ni.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index aa824abc629e..66858c65215d 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -323,9 +323,15 @@ static int arm_ni_validate_group(struct perf_event *event)
 	return 0;
 }
 
+static bool arm_ni_is_7xx(const struct arm_ni *ni)
+{
+	return ni->part == PART_NI_700 || ni->part == PART_NI_710AE;
+}
+
 static int arm_ni_event_init(struct perf_event *event)
 {
 	struct arm_ni_cd *cd = pmu_to_cd(event->pmu);
+	struct arm_ni *ni;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -333,7 +339,10 @@ static int arm_ni_event_init(struct perf_event *event)
 	if (is_sampling_event(event))
 		return -EINVAL;
 
-	event->cpu = cd_to_ni(cd)->cpu;
+	ni = cd_to_ni(cd);
+	event->cpu = ni->cpu;
+	event->hw.flags = arm_ni_is_7xx(ni);
+
 	if (NI_EVENT_TYPE(event) == NI_PMU)
 		return arm_ni_validate_group(event);
 
@@ -411,18 +420,12 @@ static void arm_ni_init_evcnt(struct hw_perf_event *hw)
 	writel_relaxed(S32_MIN, (void __iomem *)hw->event_base);
 }
 
-static bool arm_ni_is_7xx(const struct arm_ni *ni)
-{
-	return ni->part == PART_NI_700 || ni->part == PART_NI_710AE;
-}
-
 static int arm_ni_event_add(struct perf_event *event, int flags)
 {
 	struct arm_ni_cd *cd = pmu_to_cd(event->pmu);
 	struct hw_perf_event *hw = &event->hw;
 	struct arm_ni_unit *unit;
 	enum ni_node_type type = NI_EVENT_TYPE(event);
-	bool is_7xx = arm_ni_is_7xx(cd_to_ni(cd));
 	u32 reg;
 
 	if (type == NI_PMU) {
@@ -430,7 +433,7 @@ static int arm_ni_event_add(struct perf_event *event, int flags)
 			return -ENOSPC;
 		hw->idx = NI_CCNT_IDX;
 		hw->event_base = (unsigned long)cd->pmu_base +
-				 is_7xx ? NI700_PMCCNTR_L : NI_PMCCNTR_L;
+				 (hw->flags ? NI700_PMCCNTR_L : NI_PMCCNTR_L);
 		cd->ccnt = event;
 		arm_ni_init_ccnt(hw);
 	} else {
@@ -443,7 +446,7 @@ static int arm_ni_event_add(struct perf_event *event, int flags)
 		unit = (void *)hw->config_base;
 		unit->event[hw->idx] = NI_EVENT_EVENTID(event);
 		hw->event_base = (unsigned long)cd->pmu_base +
-				 is_7xx ? NI700_PMEVCNTR(hw->idx) : NI_PMEVCNTR(hw->idx);
+				 (hw->flags ? NI700_PMEVCNTR(hw->idx) : NI_PMEVCNTR(hw->idx));
 		arm_ni_init_evcnt(hw);
 		lo_hi_writeq_relaxed(le64_to_cpu(unit->pmusel), unit->pmusela);
 
-- 
2.34.1

