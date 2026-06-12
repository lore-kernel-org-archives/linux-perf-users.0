Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEB320393;
	Fri, 12 Jun 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258286; cv=none; b=rnRYaAbKiHVEa+oKs4mPBoz2vH+F98a9e6HNafzb2cxQ+QsncclHnWf41mpMX32QvynsESXJBXXJTkHJ4gwxlPnFcS8uYFrkfzpj4g1srn2CqU9tK6LDW9o4V9cCJl/+h4fb9VrvCwilkhN7bh01XlD9freGqaMHVQfWqgdKF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258286; c=relaxed/simple;
	bh=coy1KA3pghMzYIfPRLyfHhTrSJUPpm5HsO4dXgyFgxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVQGVqxSXxps4877DnUtTSzY2ZdI1v6/+G+x7Xelet623lvntxtmpZuP80F/c9N/+HpMxCSTMfeucTZolUgo7xLk0YPiC7IM2lJdTzrkQae+o7Pmhs6IvZn0mgAJEXO4WLuYb4NACLuOPdD8uTP1a5hXdBE7v3YmFSyAlEEycBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aV3OKLpr; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aV3OKLpr"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39qC23679423;
	Fri, 12 Jun 2026 02:57:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=UjUZXCIGJHveSjbKSojn9VBV8
	BbVzh2bLSXbKJXkILY=; b=aV3OKLprZLl5GcdTn8R1270CeyMGT36o5WZDjmJBs
	oRr7c9RLPdoNfzKdesASzb3uCFRguLaiHIqIlkBNnm9LIoD046biStj3ARYToyfE
	DH2+OAkOcgZKVDtYo36mfKi0eXLNhZHJ9lT+evmly0oJf8rVIF0ceFxu2Kn+piSL
	Hvr4UFYu5ZDV0j5ylgZhyO2PPguV0wwVCyGEHaJrmtFHGPDfctLu5HoZFwOa1Ofb
	OBoT3n+6g9sdApzraBJY/hsBDLMvnV2xy9n7aWaLKB1b4bo0kezrC3BACkFXLsYc
	ZdA+tExq6ltYu3fVRKX/SGlhgOI8C1Y0yebXg4nO1c0Fw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4er9qn92r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 02:57:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 12 Jun 2026 02:57:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 12 Jun 2026 02:57:52 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id A05C93F7040;
	Fri, 12 Jun 2026 02:57:50 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH v2 1/3] perf: marvell: Add MPAM partid filtering to CN10K TAD PMU
Date: Fri, 12 Jun 2026 15:27:44 +0530
Message-ID: <20260612095746.19679-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260612095746.19679-1-gakula@marvell.com>
References: <20260612095746.19679-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2baUWWw1EVs5ljdioM8ssFrpjGvCgYso
X-Authority-Analysis: v=2.4 cv=Y9HIdBeN c=1 sm=1 tr=0 ts=6a2bd822 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=vq2FkfN3LUNKyec-IwwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MCBTYWx0ZWRfX4NHSgjJ0BZbr
 A/JkJhiwbHDMtTTL0Q1zXsj5L/9mmfm9QiURAFlMpkv9GKxlMZgKJEiCSBQxgNgGdRcN5AAxGbv
 wyhmjEir67U5hLg6DiZx5voTWQmT/80=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MCBTYWx0ZWRfX94LOOKnyvK83
 KV0BHSMQ1jCscepM5+s94evXkIAcPNa874Q7AoWPan7W9T0gdcf0+9WaoU9Ti7EN5UEIFNtTIu1
 pjjEqGoDwi+8lWI0Z0MotU/tS1BaAY5AK6fiq6RyoU61QY5L0l8RDd2HuSXusPmH63idMuX1M8a
 Vx6gsbG0YlZ90uuT0M/otFgeSe9mGBbXCsH+K0QqtRX+qb+E2sbubE15Y9ZHRpzV4P+Gezg92B7
 8IW/dinUR4FLsfNjeQYjLQqOC0Cvm7PC2uYAHPY+NvGRQjg4pqchJPLuJghfnhAOcSZ0RXO+lt+
 aZIbxhm/tMHo60sDwTimPQfqdRqDDbCwCB2ALEfdhaEgGT51WloP2DSUSR83Y4LChG4x2rWEYw2
 77cQQdfehJNV/ZHWbCMq5jwwNHwLz4IOGkwNqZH0B5R0hW/4XQ2qdOKLRUKqGUrt9yX/6E0puBL
 ZH/wcOhd6HxZ44JVcIg==
X-Proofpoint-GUID: 2baUWWw1EVs5ljdioM8ssFrpjGvCgYso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01

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

Changelog (since v1)
--------------------
- Fix config1 filter enable to use bit 9 consistently with the PMU format
  string (partid_en) and reject reserved bits with GENMASK(9, 0).
- Register perf_pmu_register before cpuhp_state_add_instance_nocalls and
  unregister on hotplug failure.

 drivers/perf/marvell_cn10k_tad_pmu.c | 212 ++++++++++++++++++++-------
 1 file changed, 160 insertions(+), 52 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 51ccb0befa05..af706b890bf1 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "tad_pmu: " fmt
 
 #include <linux/io.h>
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/cpuhotplug.h>
@@ -14,11 +15,18 @@
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
 
 #define to_tad_pmu(p) (container_of(p, struct tad_pmu, pmu))
@@ -27,30 +35,92 @@ struct tad_region {
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
+	u32 event_idx = event->attr.config;
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
+	u32 event_idx = event->attr.config;
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
@@ -60,7 +130,7 @@ static void tad_pmu_event_counter_read(struct perf_event *event)
 		prev = local64_read(&hwc->prev_count);
 		for (i = 0, new = 0; i < tad_pmu->region_cnt; i++)
 			new += readq(tad_pmu->regions[i].base +
-				     TAD_PFC(counter_idx));
+				     TAD_PFC(pdata->tad_pfc_offset, counter_idx));
 	} while (local64_cmpxchg(&hwc->prev_count, prev, new) != prev);
 
 	local64_add(new - prev, &event->count);
@@ -69,16 +139,14 @@ static void tad_pmu_event_counter_read(struct perf_event *event)
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
@@ -89,26 +157,10 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
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
@@ -128,7 +180,6 @@ static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
 
-	/* Get a free counter for this event */
 	idx = find_first_zero_bit(tad_pmu->counters_map, TAD_MAX_COUNTERS);
 	if (idx == TAD_MAX_COUNTERS)
 		return -EAGAIN;
@@ -148,6 +199,9 @@ static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
 static int tad_pmu_event_init(struct perf_event *event)
 {
 	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	const struct tad_pmu_data *pdata = tad_pmu->pdata;
+	u32 event_idx = (u32)(event->attr.config & GENMASK(7, 0));
+	u64 cfg1 = event->attr.config1;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -158,6 +212,20 @@ static int tad_pmu_event_init(struct perf_event *event)
 	if (event->state != PERF_EVENT_STATE_OFF)
 		return -EINVAL;
 
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
@@ -232,7 +300,7 @@ static struct attribute *ody_tad_pmu_event_attrs[] = {
 	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
 	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
 	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
-	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xFF),
+	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xff),
 	NULL
 };
 
@@ -242,9 +310,13 @@ static const struct attribute_group ody_tad_pmu_events_attr_group = {
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
 
@@ -253,6 +325,16 @@ static struct attribute_group tad_pmu_format_attr_group = {
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
@@ -281,16 +363,25 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
 
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
@@ -298,7 +389,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	u32 tad_cnt;
 	int version;
 	int i, ret;
-	char *name;
 
 	tad_pmu = devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
 	if (!tad_pmu)
@@ -312,6 +402,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	version = dev_data->id;
+	tad_pmu->pdata = dev_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -338,22 +429,31 @@ static int tad_pmu_probe(struct platform_device *pdev)
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
@@ -374,28 +474,31 @@ static int tad_pmu_probe(struct platform_device *pdev)
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
@@ -410,12 +513,17 @@ static void tad_pmu_remove(struct platform_device *pdev)
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
 
@@ -491,6 +599,6 @@ static void __exit tad_pmu_exit(void)
 module_init(tad_pmu_init);
 module_exit(tad_pmu_exit);
 
-MODULE_DESCRIPTION("Marvell CN10K LLC-TAD Perf driver");
+MODULE_DESCRIPTION("Marvell CN10K LLC-TAD perf driver");
 MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

