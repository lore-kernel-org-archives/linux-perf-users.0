Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125133DEF9;
	Thu, 18 Jun 2026 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797002; cv=none; b=ocX43C30DV+Sx/k2GQ2bRMEy5jwaZNcvBGewUCpmWfuTKOQ11Afj8jMvZw3JMiNjrtHTvVgeGnZqqNq5bc5jUk6vMxNI0Wu1QLFXPnSPkfHJuqiBDNzWca+BMkkV6qV5w2B/LYv5+WJcBCsKKehljPHiUsO+t3DmVfCAH3YU5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797002; c=relaxed/simple;
	bh=vepuFclj1qYwiq1RCHZQBbbFVrav5Bnpxj2bUBT2zSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqTjp7PRebVJhHt/Uz0Rz/028mNTg57fpfCu0O64zLUqR1BaF5dceGUoe9o/WoqB/t+zEje1lHFAsJSbjEz2Z8GRzvryKOryau3kZNWAX3tbT8iyDoPeJg6oAVWdm3HVf8SSA6cuBRRHewPEHraslUqB97AIXLXPvGq4SgFRPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I4c+xxgB; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I4c+xxgB"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFHlII885433;
	Thu, 18 Jun 2026 08:36:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=bLLQfSRhUG8zcGdseNMA5ZGxO
	/yRJx2j+5jE5Pm3w64=; b=I4c+xxgBuwcOhhoC7Vm7pGdJt1TR+mvDDK4DhJYJO
	1p/uK5TJklssUoSBAcvaqNdIvE0YAjV9CUC4+e4vAYfbhk7UZUVMOdI3PRRLPYVU
	fN3ocTV77u2hDVDroX6zDI+xO3wvcB1q1ZkU68BC+fqgvncCugcF53+LT2heNTp+
	1jWpjwWiqIgcxWv1l1BsVMQNZVKxMuX9pp2xVGBBFCdHHMyNjZOvG5IvLON7OTid
	jRHihrIc6LG1JtXydBSl8rzUtBXzyJdHBdfHvwFJlSYVXlpROm+aO4x5wql/3b99
	6RlI0d+8zhv0A0+szGvRpn5cNOGz/YufwBh6XLg+7/WKQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4evc8th945-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 08:36:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Jun 2026 08:36:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Jun 2026 08:36:20 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id A27243F707F;
	Thu, 18 Jun 2026 08:36:17 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH v4 2/3] perf: marvell: Add CN20K LLC-TAD PMU support
Date: Thu, 18 Jun 2026 21:06:09 +0530
Message-ID: <20260618153610.13649-3-gakula@marvell.com>
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
X-Proofpoint-ORIG-GUID: 4fdmSmmBUZDxW8crQFlvZGI5qnF3Ty5Y
X-Authority-Analysis: v=2.4 cv=XqrK/1F9 c=1 sm=1 tr=0 ts=6a341075 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=yk21Q0SZhpILLZZ3dkMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0NSBTYWx0ZWRfX/6SkUA4faK08
 nop7cvzOocyaIXM05WcVw2/SfN6WWHGDWZ4TFXmEPldKdI/sY9pcKS4G4lhfwT4+1HyMbN7xGyi
 4AQg1Hmzmdy/MR6cHGtPuadquN8XbQCqD6Fp3+h96ymH0ZXb57Zefr/aTY3e1W14YdA+C+hK5HL
 dtMmqAiId7S6y0IVVVBo2ZRMM9rr7NCM/nvpxbAIJhkBisuAKkxrVIaEO/aJwBK1rK4kxvHKGLL
 d2WNOJrYgxFA8EXaR9wc4ygwBRqT55LSdWt5z+50Ur0P8Y+xqNdesnEQshUe+YBvTeqwrT9F8dT
 Jj1WfnM7NEDDZYfcLMI/LBiXHGBq34a9FV4RUJAYXy/F1qVvwpD5Jiel4thNV74F8n/rhS4iU2/
 7e8OYsnReR79/6Fd5xoJ7DnA1DWbqhIVTQ0N/0jGkJvG2uZgO0D3hsAB5Hf6txvi6lJ4qcbTvBC
 3N4x79WjyD8G/lQQZWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0NSBTYWx0ZWRfXy0Qr1+DAwamk
 gFlyQoSHG7p8Wl4yAA9l9dL551nFvIC79BSDMIpe4nR6UA5RoYIP+gSmsh2mrIvmDlGOJ+1OqNh
 z5uMpJp/x76FEX74YtIPpr5e9P5HqMs=
X-Proofpoint-GUID: 4fdmSmmBUZDxW8crQFlvZGI5qnF3Ty5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01

Add support for the LLC Tag-and-Data (TAD) PMU present in
Marvell CN20K SoCs.

The CN20K TAD PMU is based on the CN10K design but differs in the
layout of PFC/PRF register offsets relative to each TAD base, and
introduces additional events. These offsets are selected by the driver
based on the compatible string and are not described via DT properties.

Because of this, "marvell,cn10k-tad-pmu" cannot be used as a fallback
for CN20K, as it would result in incorrect register programming.

Add support for "marvell,cn20k-tad-pmu" by:
  - Introducing a TAD_PMU_V3 profile with CN20K-specific register bases
  - Extending the event map for new CN20K events
  - Matching the PMU via OF and ACPI (MRVL000F)

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---

Changelog (since v2)
--------------------
- Validate the eventId using an appropriate mask to ensure
  it is restricted to 8 bits.

Changelog (since v1)
--------------------
- Hide V3-only events on CN10K via sysfs is_visible and reject them in
  event_init.
- Use CN20K-specific MPAM PRF bits (MATCH_MPAMNS, partid << 10) for V3;
  software partid is limited to nine bits so this does not collide with
  the fixed bit at 25.
- Reset hwc->prev_count when starting counters so reads match cleared HW.

 drivers/perf/marvell_cn10k_tad_pmu.c | 54 ++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 340be3776fe7..b73ee2f58fd4 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -18,11 +18,14 @@
 
 #define TAD_PRF_OFFSET		0x900
 #define TAD_PFC_OFFSET		0x800
+#define TAD_PRF_NS_OFFSET	0x30900
+#define TAD_PFC_NS_OFFSET	0x30800
 #define TAD_PFC(base, counter)	((base) | ((u64)(counter) << 3))
 #define TAD_PRF(base, counter)	((base) | ((u64)(counter) << 3))
 #define TAD_PRF_CNTSEL_MASK	0xFF
 #define TAD_PRF_MATCH_PARTID	BIT(8)
 #define TAD_PRF_PARTID_NS	BIT(10)
+#define TAD_PRF_MATCH_MPAMNS	BIT(25)
 /*
  * config1: bits 0..8 MPAM partition id (including 0); bit 9 requests
  * filtering for MPAM-capable events. All-zero config1 means no filter.
@@ -40,6 +43,7 @@ struct tad_region {
 enum mrvl_tad_pmu_version {
 	TAD_PMU_V1 = 1,
 	TAD_PMU_V2,
+	TAD_PMU_V3,
 };
 
 struct tad_pmu_data {
@@ -89,8 +93,15 @@ static void tad_pmu_start_counter(struct tad_pmu *pmu,
 	if (use_mpam && event_idx > 0x19 && event_idx < 0x21) {
 		partid_filter = TAD_PRF_MATCH_PARTID | TAD_PRF_PARTID_NS |
 				((u64)partid << 11);
+
+		if (pdata->id == TAD_PMU_V3)
+			partid_filter = TAD_PRF_MATCH_PARTID | TAD_PRF_MATCH_MPAMNS |
+				((u64)partid << 10);
 	}
 
+	/* CN10K support events 0:24*/
+	if (pdata->id == TAD_PMU_V1 && event_idx >= 0x25)
+		return;
 
 	for (i = 0; i < pmu->region_cnt; i++) {
 		reg_val = event_idx & 0xFF;
@@ -163,6 +174,7 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 
 	hwc->state = 0;
+	local64_set(&hwc->prev_count, 0);
 
 	tad_pmu->ops->start_counter(tad_pmu, event);
 }
@@ -223,6 +235,8 @@ static int tad_pmu_event_init(struct perf_event *event)
 		if (cfg1)
 			return -EINVAL;
 	} else {
+		if (pdata->id == TAD_PMU_V1 && event_idx >= 0x25)
+			return -EINVAL;
 		if ((cfg1 & GENMASK(8, 0)) && !(cfg1 & TAD_PARTID_FILTER_EN))
 			return -EINVAL;
 		if (cfg1 & TAD_PARTID_FILTER_EN) {
@@ -249,6 +263,22 @@ static ssize_t tad_pmu_event_show(struct device *dev,
 	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+static umode_t tad_pmu_event_attr_is_visible(struct kobject *kobj,
+					     struct attribute *attr, int unused)
+{
+	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
+	struct tad_pmu *t = to_tad_pmu(pmu);
+	struct device_attribute *da = container_of(attr, struct device_attribute,
+						   attr);
+	struct perf_pmu_events_attr *e = container_of(da, struct perf_pmu_events_attr,
+						      attr);
+	u64 id = e->id;
+
+	if (t->pdata->id != TAD_PMU_V3 && id >= 0x25)
+		return 0;
+	return attr->mode;
+}
+
 #define TAD_PMU_EVENT_ATTR(name, config)			\
 	PMU_EVENT_ATTR_ID(name, tad_pmu_event_show, config)
 
@@ -290,12 +320,25 @@ static struct attribute *tad_pmu_event_attrs[] = {
 	TAD_PMU_EVENT_ATTR(tad_dat_rd_byp, 0x22),
 	TAD_PMU_EVENT_ATTR(tad_ifb_occ, 0x23),
 	TAD_PMU_EVENT_ATTR(tad_req_occ, 0x24),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dtg_evict, 0x25),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_ltg_evict, 0x26),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_mpam, 0x28),
+	TAD_PMU_EVENT_ATTR(tad_replays, 0x29),
+	TAD_PMU_EVENT_ATTR(tad_req_byp0, 0x2a),
+	TAD_PMU_EVENT_ATTR(tad_req_byp1, 0x2b),
+	TAD_PMU_EVENT_ATTR(tad_txreq_byp, 0x2c),
+	TAD_PMU_EVENT_ATTR(tad_time_in_dslp, 0x2d),
+	TAD_PMU_EVENT_ATTR(tad_time_elapsed, 0x2e),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dss_rd_128mrg, 0x2f),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dss_wr_128mrg, 0x30),
+	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xff),
 	NULL
 };
 
 static const struct attribute_group tad_pmu_events_attr_group = {
 	.name = "events",
 	.attrs = tad_pmu_event_attrs,
+	.is_visible = tad_pmu_event_attr_is_visible,
 };
 
 static struct attribute *ody_tad_pmu_event_attrs[] = {
@@ -481,7 +524,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.read		= tad_pmu_event_counter_read,
 	};
 
-	if (version == TAD_PMU_V1) {
+	if (version == TAD_PMU_V1 || version == TAD_PMU_V3) {
 		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
 		tad_pmu->ops		 = &tad_pmu_ops;
 	} else {
@@ -528,6 +571,11 @@ static const struct tad_pmu_data tad_pmu_data = {
 	.tad_pfc_offset = TAD_PFC_OFFSET,
 };
 
+static const struct tad_pmu_data tad_pmu_cn20k_data = {
+	.id   = TAD_PMU_V3,
+	.tad_prf_offset = TAD_PRF_NS_OFFSET,
+	.tad_pfc_offset = TAD_PFC_NS_OFFSET,
+};
 #endif
 
 #ifdef CONFIG_ACPI
@@ -541,6 +589,7 @@ static const struct tad_pmu_data tad_pmu_v2_data = {
 #ifdef CONFIG_OF
 static const struct of_device_id tad_pmu_of_match[] = {
 	{ .compatible = "marvell,cn10k-tad-pmu", .data = &tad_pmu_data },
+	{ .compatible = "marvell,cn20k-tad-pmu", .data = &tad_pmu_cn20k_data },
 	{},
 };
 #endif
@@ -549,6 +598,7 @@ static const struct of_device_id tad_pmu_of_match[] = {
 static const struct acpi_device_id tad_pmu_acpi_match[] = {
 	{"MRVL000B", (kernel_ulong_t)&tad_pmu_data},
 	{"MRVL000D", (kernel_ulong_t)&tad_pmu_v2_data},
+	{"MRVL000F", (kernel_ulong_t)&tad_pmu_cn20k_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
@@ -613,6 +663,6 @@ static void __exit tad_pmu_exit(void)
 module_init(tad_pmu_init);
 module_exit(tad_pmu_exit);
 
-MODULE_DESCRIPTION("Marvell CN10K LLC-TAD perf driver");
+MODULE_DESCRIPTION("Marvell CN10K/CN20K LLC-TAD perf driver");
 MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

