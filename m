Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABFA3546DA;
	Tue, 16 Jun 2026 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593942; cv=none; b=EUhOu9LzudV1+Vo8UA9wkuXfVaGyZLVEHFT1KAqreaLxCjX/7zYxv+gMXLss58gQ3zJjf8OPD+WMXkvp9cPXyIgWVWN+QR8+TZzfpJbH+8TxcD2741rNwaUsCdSHL9OZYTb4h3fHLMj1GNuQq5VZKkS0H0KTC/y6J9SSSXO31Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593942; c=relaxed/simple;
	bh=4tMtRu5baxaZX14uRPTlE6SqL1qa3fYLyMwovPMOfig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpwLB+QfWHgvx6Ln3nHz0kTXPGoY+mGxIQQiLKpeCN2z7foat3BupYxSgBwtBJHmzxZyO5wU5JKW98OWWVSFNbD8nrjXrAhWYJt24ISi/etC+FD6T/uwOpwQViv52XrvCdoTHJPkuMjIBBzyQQa0Edy49cJa+uDhEzCvNdCvp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=N1kRIBgw; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N1kRIBgw"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G66Q7I2715622;
	Tue, 16 Jun 2026 00:11:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Uo/8hRa6SMsvDyocseJ33Veh0
	RccKirVBAdcKfEXzTY=; b=N1kRIBgwzip5Usoz7TLvhi/uLHRlxAuDiPnl4gFzQ
	UrEVyJntfgRzX3kGb4Dwb3z+UvhBDYwjF/z2BAfpvhO/x5cGgtzsM0b682xUhDge
	rOaMiWqVNbO+LpxVyda9PsFR3Robe5LUbVKrlpLYKfBf55ErsPo3dAKJeyeshegC
	W7rrbbpT6aJgtyRJzVpF8wvYgirO2tkkCyLSEbiCq2tuZR/4HbkVewAi4SCJTfV2
	8N6UPefSWKxjdfIf8GChu/vf8vHlj4twbg5Grm/9vJkiv4urQyYCQzvVtv5y5OUV
	vlOLm798CxfybQnjIGSF9RQTcQTB70C/qL6oM4mpqJxMQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qek0jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 00:11:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 00:11:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 00:11:56 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 54C5B3F7043;
	Tue, 16 Jun 2026 00:11:54 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH v3 1/3] perf: marvell: Add MPAM partid filtering to CN10K TAD PMU
Date: Tue, 16 Jun 2026 12:41:47 +0530
Message-ID: <20260616071149.12523-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260616071149.12523-1-gakula@marvell.com>
References: <20260616071149.12523-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 9wnTt69ZtmGgDnwrCglXeE_ujqi64ShP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA3MCBTYWx0ZWRfX3LkuW3I9J+7e
 S54sq8yogSn5uk+3t12omQMg6TERu1uyTdMoPfJ1ig/Mu5Gn5Ovsk8Ff+QPB51p1zL9oPXbHATr
 Ktntk9Surshw7xB0k/Q80YUoSd7T8vQ=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a30f73e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=vq2FkfN3LUNKyec-IwwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 9wnTt69ZtmGgDnwrCglXeE_ujqi64ShP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA3MCBTYWx0ZWRfX3ulmEtPmKg+T
 RM35UDZGQEJiS+ej2p7+SJhJSImY+FP8mLyxayEdS130MzhCwHCRrRXKHzNnvZJfVZGFXJQC2cE
 Z8sxb7MG6QhWtetzDewshK810tWsrziyE02lMlzax9NnMWDsH/3Q1BD5iehug/D+yxvGGSP7/EW
 kyMUJOPLkrgS4xmBnTrMQlp6jsJHkz/aigHX57suR6NslWU3o8GNPhuaHVlJD6zHNW5qI0Xyflt
 x5M4GXBtNkCRV87yvfzrjzw0HePMUkJqBHms6te4O2rPMnRojXxmhGnZAcGeloCNoIqYAfCp0r2
 fp5OowPx+mLAorTt2B9fqbzGKpr3ic57qjzOHTTZ5D0F5tX/4fDFCFf4gFnchCzd2nPxLLTGILj
 QQyBVyVNfdg6Wcv/YOML/IVUIp4bg2IsB6C5VgIE9xRA2SfZBQLjt4axkZor/+2QnBUlfei9Qn4
 7uydsRUyZ0Uy6TJ2WWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01

From: Tanmay Jagdale <tanmay@marvell.com>

The TAD PMU exposes counters that can be filtered by MPAM partition id
for a subset of allocation and hit events.

Add a 9-bit partid format attribute (config1) and route counter programming
through variant-specific ops so CN10K keeps MPAM-capable programming while
Odyssey keeps the reduced event set without advertising partid in sysfs.

Probe no longer mutates the platform_device MMIO resource (walk a local
map_start), rejects tad-cnt / page sizes of zero, validates the memory
window against tad-cnt, and registers the perf PMU before hotplug with
correct unwind.

Example:
  perf stat -e tad/tad_alloc_any,partid=0x12,partid_en=1/ -- <program>

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
Changelog (since v2)
--------------------
- Validate the eventId using an appropriate mask to ensure
  it is restricted to 8 bits 

Changelog (since v1)
--------------------
- Fix config1 filter enable to use bit 9 consistently with the PMU format
  string (partid_en) and reject reserved bits with GENMASK(9, 0).
- Register perf_pmu_register before cpuhp_state_add_instance_nocalls and
  unregister on hotplug failure.

 drivers/perf/marvell_cn10k_tad_pmu.c | 216 ++++++++++++++++++++-------
 1 file changed, 164 insertions(+), 52 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 51ccb0befa05..69a6648fa664 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "tad_pmu: " fmt
 
 #include <linux/io.h>
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/cpuhotplug.h>
@@ -14,12 +15,20 @@
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 
-#define TAD_PFC_OFFSET		0x800
-#define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
 #define TAD_PRF_OFFSET		0x900
-#define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
+#define TAD_PFC_OFFSET		0x800
+#define TAD_PFC(base, counter)	((base) | ((u64)(counter) << 3))
+#define TAD_PRF(base, counter)	((base) | ((u64)(counter) << 3))
 #define TAD_PRF_CNTSEL_MASK	0xFF
+#define TAD_PRF_MATCH_PARTID	BIT(8)
+#define TAD_PRF_PARTID_NS	BIT(10)
+/*
+ * config1: bits 0..8 MPAM partition id (including 0); bit 9 requests
+ * filtering for MPAM-capable events. All-zero config1 means no filter.
+ */
+#define TAD_PARTID_FILTER_EN	BIT(9)
 #define TAD_MAX_COUNTERS	8
+#define TAD_EVENT_SEL_MASK	GENMASK(7, 0)
 
 #define to_tad_pmu(p) (container_of(p, struct tad_pmu, pmu))
 
@@ -27,30 +36,92 @@ struct tad_region {
 	void __iomem	*base;
 };
 
+enum mrvl_tad_pmu_version {
+	TAD_PMU_V1 = 1,
+	TAD_PMU_V2,
+};
+
+struct tad_pmu_data {
+	int id;
+	u64 tad_prf_offset;
+	u64 tad_pfc_offset;
+};
+
 struct tad_pmu {
 	struct pmu pmu;
 	struct tad_region *regions;
 	u32 region_cnt;
 	unsigned int cpu;
+	const struct tad_pmu_ops *ops;
+	const struct tad_pmu_data *pdata;
 	struct hlist_node node;
 	struct perf_event *events[TAD_MAX_COUNTERS];
 	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS);
 };
 
-enum mrvl_tad_pmu_version {
-	TAD_PMU_V1 = 1,
-	TAD_PMU_V2,
-};
-
-struct tad_pmu_data {
-	int id;
+struct tad_pmu_ops {
+	void (*start_counter)(struct tad_pmu *pmu, struct perf_event *event);
 };
 
 static int tad_pmu_cpuhp_state;
 
+static void tad_pmu_start_counter(struct tad_pmu *pmu,
+				  struct perf_event *event)
+{
+	const struct tad_pmu_data *pdata = pmu->pdata;
+	struct hw_perf_event *hwc = &event->hw;
+	u32 event_idx = (u32)(event->attr.config & TAD_EVENT_SEL_MASK);
+	u32 counter_idx = hwc->idx;
+	u64 partid_filter = 0;
+	u64 reg_val;
+	u64 cfg1 = event->attr.config1;
+	bool use_mpam = cfg1 & TAD_PARTID_FILTER_EN;
+	u32 partid = (u32)(cfg1 & GENMASK(8, 0));
+	int i;
+
+	for (i = 0; i < pmu->region_cnt; i++)
+		writeq_relaxed(0, pmu->regions[i].base +
+			       TAD_PFC(pdata->tad_pfc_offset, counter_idx));
+
+	if (use_mpam && event_idx > 0x19 && event_idx < 0x21) {
+		partid_filter = TAD_PRF_MATCH_PARTID | TAD_PRF_PARTID_NS |
+				((u64)partid << 11);
+	}
+
+
+	for (i = 0; i < pmu->region_cnt; i++) {
+		reg_val = event_idx & 0xFF;
+		reg_val |= partid_filter;
+		writeq_relaxed(reg_val, pmu->regions[i].base +
+			       TAD_PRF(pdata->tad_prf_offset, counter_idx));
+	}
+}
+
+static void tad_pmu_v2_start_counter(struct tad_pmu *pmu,
+				     struct perf_event *event)
+{
+	const struct tad_pmu_data *pdata = pmu->pdata;
+	struct hw_perf_event *hwc = &event->hw;
+	u32 event_idx = (u32)(event->attr.config & TAD_EVENT_SEL_MASK);
+	u32 counter_idx = hwc->idx;
+	u64 reg_val;
+	int i;
+
+	for (i = 0; i < pmu->region_cnt; i++)
+		writeq_relaxed(0, pmu->regions[i].base +
+			       TAD_PFC(pdata->tad_pfc_offset, counter_idx));
+
+	for (i = 0; i < pmu->region_cnt; i++) {
+		reg_val = event_idx & 0xFF;
+		writeq_relaxed(reg_val, pmu->regions[i].base +
+			       TAD_PRF(pdata->tad_prf_offset, counter_idx));
+	}
+}
+
 static void tad_pmu_event_counter_read(struct perf_event *event)
 {
 	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	const struct tad_pmu_data *pdata = tad_pmu->pdata;
 	struct hw_perf_event *hwc = &event->hw;
 	u32 counter_idx = hwc->idx;
 	u64 prev, new;
@@ -60,7 +131,7 @@ static void tad_pmu_event_counter_read(struct perf_event *event)
 		prev = local64_read(&hwc->prev_count);
 		for (i = 0, new = 0; i < tad_pmu->region_cnt; i++)
 			new += readq(tad_pmu->regions[i].base +
-				     TAD_PFC(counter_idx));
+				     TAD_PFC(pdata->tad_pfc_offset, counter_idx));
 	} while (local64_cmpxchg(&hwc->prev_count, prev, new) != prev);
 
 	local64_add(new - prev, &event->count);
@@ -69,16 +140,14 @@ static void tad_pmu_event_counter_read(struct perf_event *event)
 static void tad_pmu_event_counter_stop(struct perf_event *event, int flags)
 {
 	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	const struct tad_pmu_data *pdata = tad_pmu->pdata;
 	struct hw_perf_event *hwc = &event->hw;
 	u32 counter_idx = hwc->idx;
 	int i;
 
-	/* TAD()_PFC() stop counting on the write
-	 * which sets TAD()_PRF()[CNTSEL] == 0
-	 */
 	for (i = 0; i < tad_pmu->region_cnt; i++) {
 		writeq_relaxed(0, tad_pmu->regions[i].base +
-			       TAD_PRF(counter_idx));
+			       TAD_PRF(pdata->tad_prf_offset, counter_idx));
 	}
 
 	tad_pmu_event_counter_read(event);
@@ -89,26 +158,10 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
 {
 	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	u32 event_idx = event->attr.config;
-	u32 counter_idx = hwc->idx;
-	u64 reg_val;
-	int i;
 
 	hwc->state = 0;
 
-	/* Typically TAD_PFC() are zeroed to start counting */
-	for (i = 0; i < tad_pmu->region_cnt; i++)
-		writeq_relaxed(0, tad_pmu->regions[i].base +
-			       TAD_PFC(counter_idx));
-
-	/* TAD()_PFC() start counting on the write
-	 * which sets TAD()_PRF()[CNTSEL] != 0
-	 */
-	for (i = 0; i < tad_pmu->region_cnt; i++) {
-		reg_val = event_idx & 0xFF;
-		writeq_relaxed(reg_val,	tad_pmu->regions[i].base +
-			       TAD_PRF(counter_idx));
-	}
+	tad_pmu->ops->start_counter(tad_pmu, event);
 }
 
 static void tad_pmu_event_counter_del(struct perf_event *event, int flags)
@@ -128,7 +181,6 @@ static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
 
-	/* Get a free counter for this event */
 	idx = find_first_zero_bit(tad_pmu->counters_map, TAD_MAX_COUNTERS);
 	if (idx == TAD_MAX_COUNTERS)
 		return -EAGAIN;
@@ -148,6 +200,9 @@ static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
 static int tad_pmu_event_init(struct perf_event *event)
 {
 	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	const struct tad_pmu_data *pdata = tad_pmu->pdata;
+	u32 event_idx = (u32)(event->attr.config & TAD_EVENT_SEL_MASK);
+	u64 cfg1 = event->attr.config1;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -158,6 +213,23 @@ static int tad_pmu_event_init(struct perf_event *event)
 	if (event->state != PERF_EVENT_STATE_OFF)
 		return -EINVAL;
 
+	if (event->attr.config & ~TAD_EVENT_SEL_MASK)
+		return -EINVAL;
+
+	if (pdata->id == TAD_PMU_V2) {
+		if (cfg1)
+			return -EINVAL;
+	} else {
+		if ((cfg1 & GENMASK(8, 0)) && !(cfg1 & TAD_PARTID_FILTER_EN))
+			return -EINVAL;
+		if (cfg1 & TAD_PARTID_FILTER_EN) {
+			if (event_idx <= 0x19 || event_idx >= 0x21)
+				return -EINVAL;
+		}
+		if (cfg1 & ~GENMASK(9, 0))
+			return -EINVAL;
+	}
+
 	event->cpu = tad_pmu->cpu;
 	event->hw.idx = -1;
 	event->hw.config_base = event->attr.config;
@@ -232,7 +304,7 @@ static struct attribute *ody_tad_pmu_event_attrs[] = {
 	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
 	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
 	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
-	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xFF),
+	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xff),
 	NULL
 };
 
@@ -242,9 +314,13 @@ static const struct attribute_group ody_tad_pmu_events_attr_group = {
 };
 
 PMU_FORMAT_ATTR(event, "config:0-7");
+PMU_FORMAT_ATTR(partid, "config1:0-8");
+PMU_FORMAT_ATTR(partid_en, "config1:9-9");
 
 static struct attribute *tad_pmu_format_attrs[] = {
 	&format_attr_event.attr,
+	&format_attr_partid.attr,
+	&format_attr_partid_en.attr,
 	NULL
 };
 
@@ -253,6 +329,16 @@ static struct attribute_group tad_pmu_format_attr_group = {
 	.attrs = tad_pmu_format_attrs,
 };
 
+static struct attribute *ody_tad_pmu_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL
+};
+
+static struct attribute_group ody_tad_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = ody_tad_pmu_format_attrs,
+};
+
 static ssize_t tad_pmu_cpumask_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -281,16 +367,25 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
 
 static const struct attribute_group *ody_tad_pmu_attr_groups[] = {
 	&ody_tad_pmu_events_attr_group,
-	&tad_pmu_format_attr_group,
+	&ody_tad_pmu_format_attr_group,
 	&tad_pmu_cpumask_attr_group,
 	NULL
 };
 
+static const struct tad_pmu_ops tad_pmu_ops = {
+	.start_counter = tad_pmu_start_counter,
+};
+
+static const struct tad_pmu_ops tad_pmu_v2_ops = {
+	.start_counter = tad_pmu_v2_start_counter,
+};
+
 static int tad_pmu_probe(struct platform_device *pdev)
 {
 	const struct tad_pmu_data *dev_data;
 	struct device *dev = &pdev->dev;
 	struct tad_region *regions;
+	resource_size_t map_start;
 	struct tad_pmu *tad_pmu;
 	struct resource *res;
 	u32 tad_pmu_page_size;
@@ -298,7 +393,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	u32 tad_cnt;
 	int version;
 	int i, ret;
-	char *name;
 
 	tad_pmu = devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
 	if (!tad_pmu)
@@ -312,6 +406,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	version = dev_data->id;
+	tad_pmu->pdata = dev_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -338,22 +433,31 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Can't find tad-cnt property\n");
 		return ret;
 	}
+	if (!tad_cnt || !tad_page_size || !tad_pmu_page_size) {
+		dev_err(&pdev->dev, "Invalid tad-cnt or page size\n");
+		return -EINVAL;
+	}
 
 	regions = devm_kcalloc(&pdev->dev, tad_cnt,
 			       sizeof(*regions), GFP_KERNEL);
 	if (!regions)
 		return -ENOMEM;
 
-	/* ioremap the distributed TAD pmu regions */
-	for (i = 0; i < tad_cnt && res->start < res->end; i++) {
-		regions[i].base = devm_ioremap(&pdev->dev,
-					       res->start,
+	map_start = res->start;
+	for (i = 0; i < tad_cnt; i++) {
+		if (map_start > res->end ||
+		    tad_pmu_page_size > (resource_size_t)(res->end - map_start + 1)) {
+			dev_err(&pdev->dev, "TAD PMU mem window too small for tad-cnt=%u\n",
+				tad_cnt);
+			return -EINVAL;
+		}
+		regions[i].base = devm_ioremap(&pdev->dev, map_start,
 					       tad_pmu_page_size);
 		if (!regions[i].base) {
 			dev_err(&pdev->dev, "TAD%d ioremap fail\n", i);
 			return -ENOMEM;
 		}
-		res->start += tad_page_size;
+		map_start += tad_page_size;
 	}
 
 	tad_pmu->regions = regions;
@@ -374,28 +478,31 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.read		= tad_pmu_event_counter_read,
 	};
 
-	if (version == TAD_PMU_V1)
+	if (version == TAD_PMU_V1) {
 		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
-	else
+		tad_pmu->ops		 = &tad_pmu_ops;
+	} else {
 		tad_pmu->pmu.attr_groups = ody_tad_pmu_attr_groups;
+		tad_pmu->ops		 = &tad_pmu_v2_ops;
+	}
 
 	tad_pmu->cpu = raw_smp_processor_id();
 
-	/* Register pmu instance for cpu hotplug */
+	ret = perf_pmu_register(&tad_pmu->pmu, "tad", -1);
+	if (ret) {
+		dev_err(&pdev->dev, "Error %d registering perf PMU\n", ret);
+		return ret;
+	}
+
 	ret = cpuhp_state_add_instance_nocalls(tad_pmu_cpuhp_state,
 					       &tad_pmu->node);
 	if (ret) {
 		dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
+		perf_pmu_unregister(&tad_pmu->pmu);
 		return ret;
 	}
 
-	name = "tad";
-	ret = perf_pmu_register(&tad_pmu->pmu, name, -1);
-	if (ret)
-		cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
-						    &tad_pmu->node);
-
-	return ret;
+	return 0;
 }
 
 static void tad_pmu_remove(struct platform_device *pdev)
@@ -410,12 +517,17 @@ static void tad_pmu_remove(struct platform_device *pdev)
 #if defined(CONFIG_OF) || defined(CONFIG_ACPI)
 static const struct tad_pmu_data tad_pmu_data = {
 	.id   = TAD_PMU_V1,
+	.tad_prf_offset = TAD_PRF_OFFSET,
+	.tad_pfc_offset = TAD_PFC_OFFSET,
 };
+
 #endif
 
 #ifdef CONFIG_ACPI
 static const struct tad_pmu_data tad_pmu_v2_data = {
 	.id   = TAD_PMU_V2,
+	.tad_prf_offset = TAD_PRF_OFFSET,
+	.tad_pfc_offset = TAD_PFC_OFFSET,
 };
 #endif
 
@@ -491,6 +603,6 @@ static void __exit tad_pmu_exit(void)
 module_init(tad_pmu_init);
 module_exit(tad_pmu_exit);
 
-MODULE_DESCRIPTION("Marvell CN10K LLC-TAD Perf driver");
+MODULE_DESCRIPTION("Marvell CN10K LLC-TAD perf driver");
 MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

