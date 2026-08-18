Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11368448B9A;
	Tue, 18 Aug 2026 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046266; cv=none; b=AcXj/5pfxOyeDv08df1ojsjGIP1jDGUg5ldRUeia4eLFXJ7wmB9n9QB8zwAaYgqFbtbKycE2vWL/PQydXa1qTSYuCgOyRLssBH8DyNNnXTZxvkvb2khaX5ZsJz+WPCU8Vy25nfuaqpyEHlMMKP7dJfdscIMxEwOsamwq8aSNjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046266; c=relaxed/simple;
	bh=+NlAcR9Xot/qrtblrGS2ZXJqxEpstEcu6m44vnGnB7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMLj4dG4nq2gBC+VMUfo4fc9AYj0c7wBeYlyhqP315yZs8684jitsL8WNYvEK7kWZgdKx5sY649U4mfHQRQHU/ZjcaJ1DnxyYOOP7EbQ2WyQJuojr8yh694qcOSnd8ghdKYl0Qt+sWYCCDoFcT3dsEf9sP+tKKmAOjZ68BDTaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 60c2f81c9ae911f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:10c2699f-1ac5-4ebe-9e77-cd577d86eece,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:fa69c7c4ded2daf118ea4f197c639993,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 60c2f81c9ae911f19a56ed5b684f684d-20260818
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1797780881; Tue, 18 Aug 2026 17:44:16 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-riscv@lists.infradead.org
Cc: atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v2 2/2] perf: RISC-V: store available counter mask as bitmap
Date: Tue, 18 Aug 2026 17:10:00 +0800
Message-ID: <prpmask02cmap.v2.1786434000.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.v2.1786434000.git.liuxixin@kylinos.cn>
References: <cover.1786092600.git.liuxixin@kylinos.cn> <cover.v2.1786434000.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

The available-counter mask was a single unsigned long, but iteration
uses RISCV_MAX_COUNTERS, which is 64. On RV32 that reads past the object.
Filling with an unsigned-long bit at index 32 and above is also wrong.

Use DECLARE_BITMAP and set_bit/bitmap helpers. Walk each bitmap word
into CFG_MATCH when checking events, when allocating an index, and when
stopping all counters. Set the counter base to i times BITS_PER_LONG.
Share the CFG_MATCH ecall through a small helper so the 32-bit argument
split is not duplicated. On qemu-system-riscv32 the probe bitmap has bits
above XLEN set, so the first word alone is not enough.

Fixes: e9991434596f ("RISC-V: Add perf platform driver based on SBI PMU extension")
Assisted-by: DeepSeek:deepseek-v3
Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/perf/riscv_pmu_legacy.c         | 5 +-
 drivers/perf/riscv_pmu_sbi.c            | 88 ++++++++++++++++++++++++++++------------
 include/linux/perf/riscv_pmu.h          | 2
 3 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -111,8 +111,9 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 {
 	pr_info("Legacy PMU implementation is available\n");
 
-	pmu->cmask = BIT(RISCV_PMU_LEGACY_CYCLE) |
-		BIT(RISCV_PMU_LEGACY_INSTRET);
+	bitmap_zero(pmu->cmask, RISCV_MAX_COUNTERS);
+	set_bit(RISCV_PMU_LEGACY_CYCLE, pmu->cmask);
+	set_bit(RISCV_PMU_LEGACY_INSTRET, pmu->cmask);
 	pmu->ctr_start = pmu_legacy_ctr_start;
 	pmu->ctr_stop = NULL;
 	pmu->event_map = pmu_legacy_event_map;
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -97,7 +97,7 @@ static unsigned int riscv_pmu_irq_mask;
 static unsigned int riscv_pmu_irq;
 
 /* Cache the available counters in a bitmask */
-static unsigned long cmask;
+static DECLARE_BITMAP(cmask, RISCV_MAX_COUNTERS);
 
 struct sbi_pmu_event_data {
 	union {
@@ -298,16 +298,38 @@ static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
 	},
 };
 
+static struct sbiret pmu_sbi_ctr_cfg_match(unsigned long cbase,
+					    unsigned long ctr_mask,
+					    unsigned long cflags,
+					    unsigned long event_idx,
+					    u64 config)
+{
+#if defined(CONFIG_32BIT)
+	return sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
+			 ctr_mask, cflags, event_idx, config, config >> 32);
+#else
+	return sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
+			 ctr_mask, cflags, event_idx, config, 0);
+#endif
+}
+
 static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
 {
-	struct sbiret ret;
+	struct sbiret ret = { .error = SBI_ERR_NOT_SUPPORTED };
+	int i;
 
-	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
-			0, cmask, 0, edata->event_idx, 0, 0);
-	if (!ret.error) {
-		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-			  ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
-	} else if (ret.error == SBI_ERR_NOT_SUPPORTED) {
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+		if (!cmask[i])
+			continue;
+		ret = pmu_sbi_ctr_cfg_match(i * BITS_PER_LONG, cmask[i], 0,
+					    edata->event_idx, 0);
+		if (!ret.error) {
+			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+				  ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+			return;
+		}
+	}
+	if (ret.error == SBI_ERR_NOT_SUPPORTED) {
 		/* This event cannot be monitored by any counter */
 		edata->event_idx = -ENOENT;
 	}
@@ -353,10 +375,10 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr)
 	union sbi_pmu_ctr_info *info;
 	u32 hpm_width = 0, hpm_count = 0;
 
-	if (!cmask)
+	if (bitmap_empty(cmask, RISCV_MAX_COUNTERS))
 		return -EINVAL;
 
-	for_each_set_bit(i, &cmask, RISCV_MAX_COUNTERS) {
+	for_each_set_bit(i, cmask, RISCV_MAX_COUNTERS) {
 		info = &pmu_ctr_list[i];
 		if (!info)
 			continue;
@@ -405,8 +427,8 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
 	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
 	struct sbiret ret;
-	int idx;
-	uint64_t cbase = 0, cmask = rvpmu->cmask;
+	int idx, i;
+	uint64_t cbase = 0, cmask = 0;
 	unsigned long cflags = 0;
 
 	cflags = pmu_sbi_get_filter_flags(event);
@@ -427,14 +449,21 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 	}
 
 	/* retrieve the available counter index */
-#if defined(CONFIG_32BIT)
-	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
-			cmask, cflags, hwc->event_base, hwc->config,
-			hwc->config >> 32);
-#else
-	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
-			cmask, cflags, hwc->event_base, hwc->config, 0);
-#endif
+	if (cmask) {
+		ret = pmu_sbi_ctr_cfg_match(cbase, cmask, cflags, hwc->event_base,
+					   hwc->config);
+	} else {
+		ret.error = SBI_ERR_NOT_SUPPORTED;
+		for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+			if (!rvpmu->cmask[i])
+				continue;
+			cbase = i * BITS_PER_LONG;
+			ret = pmu_sbi_ctr_cfg_match(cbase, rvpmu->cmask[i], cflags,
+						   hwc->event_base, hwc->config);
+			if (!ret.error)
+				break;
+		}
+	}
 	if (ret.error) {
 		pr_debug("Not able to find a counter for event %lx config %llx\n",
 			hwc->event_base, hwc->config);
@@ -442,7 +471,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 	}
 
 	idx = ret.value;
-	if (!test_bit(idx, &rvpmu->cmask) || !pmu_ctr_list[idx].value)
+	if (!test_bit(idx, rvpmu->cmask) || !pmu_ctr_list[idx].value)
 		return -ENOENT;
 
 	/* Additional sanity check for the counter id */
@@ -794,7 +823,7 @@ static int pmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
 			/* The logical counter ids are not expected to be contiguous */
 			continue;
 
-		*mask |= BIT(i);
+		set_bit(i, mask);
 
 		cinfo.value = ret.value;
 		if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
@@ -811,12 +840,19 @@ static int pmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
 
 static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 {
+	int i;
+
 	/*
 	 * No need to check the error because we are disabling all the counters
 	 * which may include counters that are not enabled yet.
 	 */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+		if (!pmu->cmask[i])
+			continue;
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+			  i * BITS_PER_LONG, pmu->cmask[i],
+			  SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+	}
 }
 
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
@@ -1353,7 +1389,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	}
 
 	/* cache all the information about counters now */
-	if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
+	if (pmu_sbi_get_ctrinfo(num_counters, cmask))
 		goto out_free;
 
 	ret = pmu_sbi_setup_irqs(pmu, pdev);
@@ -1365,7 +1401,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 
 	pmu->pmu.attr_groups = riscv_pmu_attr_groups;
 	pmu->pmu.parent = &pdev->dev;
-	pmu->cmask = cmask;
+	bitmap_copy(pmu->cmask, cmask, RISCV_MAX_COUNTERS);
 	pmu->ctr_start = pmu_sbi_ctr_start;
 	pmu->ctr_stop = pmu_sbi_ctr_stop;
 	pmu->event_map = pmu_sbi_event_map;
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -55,7 +55,7 @@ struct riscv_pmu {
 
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 
-	unsigned long	cmask;
+	DECLARE_BITMAP(cmask, RISCV_MAX_COUNTERS);
 	u64		(*ctr_read)(struct perf_event *event);
 	int		(*ctr_get_idx)(struct perf_event *event);
 	int		(*ctr_get_width)(int idx);

-- 
2.43.0

