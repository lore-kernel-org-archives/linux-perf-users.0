Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8D330650;
	Thu, 18 Jun 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797001; cv=none; b=ElwWUQFR7nOPRULFzxuREou1W6q4ByuLS+OBHiVAKg92BtU+FAxPsMfp9zHpaLJtUckvokOAAEDACayJSssd30G8QtYzFEzy+bCPyll6jrhRZhpjPbYb8yMSYEZMTdCdUkXWScDgui8EZ0ilAqHMwnmBhqmCPM1cRVkmJOtGk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797001; c=relaxed/simple;
	bh=JriKJM8DE8yX5l6sX+Mh3JSRzKEPjzxVcIjwUZyz6bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzZyffx/fhUUCuBHStG6zt+MgeHKhcH2s8Bvn/xItMEUyO8cvBGLRKBSaqXAST+rF8/JUQYq6b05irxJAfgP0hv+JbAaFdsrBbHkL8ZFlqALIth444LCRL+eCBXxcV1PPb0SH8NYWYMZE8n1Py2ZuIPi+Fp2kfOzJt5vFV4GU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kbT+nTLj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kbT+nTLj"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFHpCd4167775;
	Thu, 18 Jun 2026 08:36:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=TKaz1E3waEnisbh3fs7/K9icz
	WLZ4JE9L9V9TnlycPI=; b=kbT+nTLjfsP8RC3uZyrTsrdTNY1rcJkpL6SBatpfe
	RQDhl3yrVXkOHb5tDv5SnOmSOP5iG5WK88tPmstKZOJYaXAxlMTbJPwK7HClaTBc
	rPPjSpxYUahJTBifDVqORfXAGnLd1sV+rwvOrTUSirDVUcVbjn0oWEKgNXtw/3HT
	VcbeLwIRwEcQ8Kq1HIEYwrfMuFn0kiAk3SSqEwsSDI9pxOTUeUdd7ANt5oTN6/Ao
	K//1qBb3ZS2ali/ZagsIWPBL1XBHthgcuLHXdM7qNxZnxSoYG4WXNGRo4RGE2G88
	NVUJgc9vwOeihb12ETlnrgQDkpGb3m2SVlZXqv1PMPA7w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ev59daga2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 08:36:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Jun 2026 08:36:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Jun 2026 08:36:17 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 7A8A53F7041;
	Thu, 18 Jun 2026 08:36:14 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH v4 1/3] perf: marvell: Add MPAM partid filtering to CN10K TAD PMU
Date: Thu, 18 Jun 2026 21:06:08 +0530
Message-ID: <20260618153610.13649-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260618153610.13649-1-gakula@marvell.com>
References: <20260618153610.13649-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: BqKWDyrvcGYfmZ1UBM3PyWu5W88Ws2So
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0NSBTYWx0ZWRfXwtw1e2eAcrD+
 BGkG8cJGa9OgKmUiMUxe4msXP/DFtDIBt4SHQt1owYxiz0hiPGDwML6kkrJ+GInEoIeOQHyen2s
 kgrdW5sdkab135qSeCWhxqG/ZOVnNKP0kMbqv0XqmBjjjQWHRlrpw1Q8T3uGCK3+1HVwv71dpxk
 aX0LHz6ST2AaCiLCHxXIJkkyCHmZn5erOxrW+1yJVG0OvR4GZKYwdbDiI9Z+Ycgt7n87QNaunxX
 Kg3IddW9rVQJwM1RIxysOjLUNDSjIzfHzpSYVR6nexA2aHX/xhoCPjcz6VrBTxa/xncQuTBxVu+
 b1IraVp8Hdzbr3xI6kkanc8qorVfyd3v8suNM8nBajNGRGUmf7cDPtf1bgnzfRVP8H0X/wYFf2c
 J89R5TEnT+vOtYj5ql5dn2whnutWgjA53wQPdGVDSc7vhLEJs5I0qbAO0lEeYDooTecErIvbMkn
 zAZGncTZ05cJUB3XghA==
X-Authority-Analysis: v=2.4 cv=c4Cbhx9l c=1 sm=1 tr=0 ts=6a341072 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=7bZ9RLrLMXeIL53QXhgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BqKWDyrvcGYfmZ1UBM3PyWu5W88Ws2So
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0NSBTYWx0ZWRfX88vsI18BohXD
 IvmeIGAqWtmvCP9RO49+DLxkNxkInLT17MfrljmkU9jK0OQ9zPdyd6VtwqVRfmZ/WKv3HZ3GfLg
 IDfb0nP4toJ2VyCcQLMib1CA7rXpn2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01

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
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---

Changelog (since v3)
--------------------
- Restore cpuhp_state_add_instance_nocalls before perf_pmu_register in probe
  so users cannot attach events before the hotplug instance exists; unwind
  removes the hotplug instance if perf registration fails.
- Add perf_ready: tad_pmu_offline_cpu skips perf_pmu_migrate_context until after
  successful perf_pmu_register, so a CPU offline between hotplug add and perf
  register does not touch perf core state for an unregistered PMU.

Changelog (since v2)
--------------------
- Validate the eventId using an appropriate mask to ensure
  it is restricted to 8 bits.

Changelog (since v1)
--------------------
- Fix config1 filter enable to use bit 9 consistently with the PMU format
  string (partid_en) and reject reserved bits with GENMASK(9, 0).
- Register perf_pmu_register before cpuhp_state_add_instance_nocalls and
  unregister on hotplug failure.

 drivers/perf/marvell_cn10k_tad_pmu.c | 220 +++++++++++++++++++++------
 1 file changed, 171 insertions(+), 49 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 51ccb0befa05..340be3776fe7 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -7,6 +7,8 @@
 #define pr_fmt(fmt) "tad_pmu: " fmt
 
 #include <linux/io.h>
+#include <linux/bits.h>
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/cpuhotplug.h>
@@ -14,12 +16,20 @@
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
 
@@ -27,30 +37,94 @@ struct tad_region {
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
+	/* Set after successful perf_pmu_register(); gates offline migration. */
+	bool perf_ready;
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
@@ -60,7 +134,7 @@ static void tad_pmu_event_counter_read(struct perf_event *event)
 		prev = local64_read(&hwc->prev_count);
 		for (i = 0, new = 0; i < tad_pmu->region_cnt; i++)
 			new += readq(tad_pmu->regions[i].base +
-				     TAD_PFC(counter_idx));
+				     TAD_PFC(pdata->tad_pfc_offset, counter_idx));
 	} while (local64_cmpxchg(&hwc->prev_count, prev, new) != prev);
 
 	local64_add(new - prev, &event->count);
@@ -69,16 +143,14 @@ static void tad_pmu_event_counter_read(struct perf_event *event)
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
@@ -89,26 +161,10 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
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
@@ -128,7 +184,6 @@ static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
 
-	/* Get a free counter for this event */
 	idx = find_first_zero_bit(tad_pmu->counters_map, TAD_MAX_COUNTERS);
 	if (idx == TAD_MAX_COUNTERS)
 		return -EAGAIN;
@@ -148,6 +203,9 @@ static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
 static int tad_pmu_event_init(struct perf_event *event)
 {
 	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	const struct tad_pmu_data *pdata = tad_pmu->pdata;
+	u32 event_idx = (u32)(event->attr.config & TAD_EVENT_SEL_MASK);
+	u64 cfg1 = event->attr.config1;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -158,6 +216,23 @@ static int tad_pmu_event_init(struct perf_event *event)
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
@@ -232,7 +307,7 @@ static struct attribute *ody_tad_pmu_event_attrs[] = {
 	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
 	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
 	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
-	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xFF),
+	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xff),
 	NULL
 };
 
@@ -242,9 +317,13 @@ static const struct attribute_group ody_tad_pmu_events_attr_group = {
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
 
@@ -253,6 +332,16 @@ static struct attribute_group tad_pmu_format_attr_group = {
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
@@ -281,16 +370,25 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
 
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
@@ -298,7 +396,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	u32 tad_cnt;
 	int version;
 	int i, ret;
-	char *name;
 
 	tad_pmu = devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
 	if (!tad_pmu)
@@ -312,6 +409,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	version = dev_data->id;
+	tad_pmu->pdata = dev_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -338,22 +436,31 @@ static int tad_pmu_probe(struct platform_device *pdev)
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
@@ -374,14 +481,16 @@ static int tad_pmu_probe(struct platform_device *pdev)
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
 	ret = cpuhp_state_add_instance_nocalls(tad_pmu_cpuhp_state,
 					       &tad_pmu->node);
 	if (ret) {
@@ -389,19 +498,24 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	name = "tad";
-	ret = perf_pmu_register(&tad_pmu->pmu, name, -1);
-	if (ret)
+	ret = perf_pmu_register(&tad_pmu->pmu, "tad", -1);
+	if (ret) {
+		dev_err(&pdev->dev, "Error %d registering perf PMU\n", ret);
 		cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
 						    &tad_pmu->node);
+		return ret;
+	}
 
-	return ret;
+	WRITE_ONCE(tad_pmu->perf_ready, true);
+
+	return 0;
 }
 
 static void tad_pmu_remove(struct platform_device *pdev)
 {
 	struct tad_pmu *pmu = platform_get_drvdata(pdev);
 
+	WRITE_ONCE(pmu->perf_ready, false);
 	cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
 						&pmu->node);
 	perf_pmu_unregister(&pmu->pmu);
@@ -410,12 +524,17 @@ static void tad_pmu_remove(struct platform_device *pdev)
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
 
@@ -451,6 +570,9 @@ static int tad_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	struct tad_pmu *pmu = hlist_entry_safe(node, struct tad_pmu, node);
 	unsigned int target;
 
+	if (!READ_ONCE(pmu->perf_ready))
+		return 0;
+
 	if (cpu != pmu->cpu)
 		return 0;
 
@@ -491,6 +613,6 @@ static void __exit tad_pmu_exit(void)
 module_init(tad_pmu_init);
 module_exit(tad_pmu_exit);
 
-MODULE_DESCRIPTION("Marvell CN10K LLC-TAD Perf driver");
+MODULE_DESCRIPTION("Marvell CN10K LLC-TAD perf driver");
 MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

