Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D1314B72;
	Tue, 16 Jun 2026 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593941; cv=none; b=PpGfZU6KmJmtRkLC0Q2qNSb1jQ/Pdkla4osEZQyFNDJdp06E3535MhOl2i2UJhcJILF8elQhOPkkocSOP1LjGSHgALiBfXRNMxAxVGx8KfxpN1nknjGQoOLgeGF1LPGG1DTAqGA6FAhAJ7c6ojhWezCA6psEoQrlPElK5eD85Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593941; c=relaxed/simple;
	bh=HNn4cHqBpCtGDl+FkssqbFStXgCx58oYRPciHFUOQ90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezHwvJvdN2+22YYDH0HmkIzmw2Vtf6rlWvb3hfUrS52i8YnBnI7UG8xwSj5v9ModmXqdi2m9dJA23Z2cR2wQFn2rZp2Y4G/WxU+68o/piZr/alUrY6EDRVgfCR13BuXS9xlfwEVJwI6kYssrSgp/BsTt7w2JBQOn41c3JomCkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gsYlNMAM; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gsYlNMAM"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G66We81879963;
	Tue, 16 Jun 2026 00:12:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=BCCh8aaDxHpVtvwcE5JHgMmnl
	cx0WypafvNdbmAdGjg=; b=gsYlNMAMdrhJ0O+DJ51R+DB3vRGXkxb00wbRP9hIH
	2nS4RpIqkjayrNA7AwoRJ1rV9YPIxrTl8wcSbvt4MGcaO7sHg06FKUrV4WOR1fth
	1wUcsBsuxF2VuNylNsF4YK2j9pLUR4XCP9RsTY+74SK4mUi5xjPpnXYC+JPsE4Ze
	BbM03Z+rcz0xTntZqnsAmTMl9Y9ycDhRBxPQjLBfoglrgj/FnwbrMnZUaSVT2z0e
	KZo7V5y3fJ+rH82kCQP0S3lExkoMX6B7AMny7XmmyLtBqg7sQUCLiE/2q3/O/FwK
	NJ/noBF3BQOvpI6GH8VVvDy1Jg2mIbefmU5GltYRuN1eA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4esuf8yxep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 00:12:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 00:12:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 00:12:00 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 7A5813F7043;
	Tue, 16 Jun 2026 00:11:57 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH v3 2/3] perf: marvell: Add CN20K LLC-TAD PMU support
Date: Tue, 16 Jun 2026 12:41:48 +0530
Message-ID: <20260616071149.12523-3-gakula@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA3MCBTYWx0ZWRfX+rIxtvYq+z1R
 LF9suGKbpC6tTex5r2cB4sJPsGjS/CmxLrzgbSXcO4AbgsgJgaqsLspR8P0MizGYJLKxkHX5xoM
 7lSrA5TrweTxUjxzJsJ3mqcIUVm0gmQnaIqG6B6wXYX1jH0FNR/4HXcHvtN6kKrcG/+0O1ly/2P
 p32oh6OYD46VcRAUbRKj7BTU84A+ysW6OcEZI+g0IzqK2N1Y1P1WtfO1BsJX5Xsef9HWt+kQMuH
 chgzOTL4G8htRCjRpdrJZ4UctdYVAOwHJoyp/iyHc9REIWso+FTKFlHwsldC21z3iVWKt8QeGra
 loBOI+w6EW8siC4ubyNLW6sng8C5hPug/pLRV/o/Ln4QBtm0b5X2IqWdwM8EJxBqKPC3aJjw6Ur
 QwptjOtRMVrkEgj6wBJGEmdkFpb9ZuuLG3LZK2s5pPYnfLsAFH6kxJCYaUdvhIIwPClDC7cNbks
 9/hYmlUaYdLPgmVHy1A==
X-Proofpoint-ORIG-GUID: WFOyGqObjHGQPNgVA_OrcEBBnNhBhht8
X-Proofpoint-GUID: WFOyGqObjHGQPNgVA_OrcEBBnNhBhht8
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a30f741 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=yk21Q0SZhpILLZZ3dkMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA3MCBTYWx0ZWRfXxrafQsyLW3CD
 rxO1+ksNkCbbgl2VDJ1shvfcUejXxM2woHY/whW6BsAB/dfmuDWLoaVPcge24eE3O0Yg7DpSDWT
 lMUNnyKFVvkj2Rv8GmlrRkdanYLsHGQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01

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
index 69a6648fa664..cd81bf8ff569 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -17,11 +17,14 @@
 
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
@@ -39,6 +42,7 @@ struct tad_region {
 enum mrvl_tad_pmu_version {
 	TAD_PMU_V1 = 1,
 	TAD_PMU_V2,
+	TAD_PMU_V3,
 };
 
 struct tad_pmu_data {
@@ -86,8 +90,15 @@ static void tad_pmu_start_counter(struct tad_pmu *pmu,
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
@@ -160,6 +171,7 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 
 	hwc->state = 0;
+	local64_set(&hwc->prev_count, 0);
 
 	tad_pmu->ops->start_counter(tad_pmu, event);
 }
@@ -220,6 +232,8 @@ static int tad_pmu_event_init(struct perf_event *event)
 		if (cfg1)
 			return -EINVAL;
 	} else {
+		if (pdata->id == TAD_PMU_V1 && event_idx >= 0x25)
+			return -EINVAL;
 		if ((cfg1 & GENMASK(8, 0)) && !(cfg1 & TAD_PARTID_FILTER_EN))
 			return -EINVAL;
 		if (cfg1 & TAD_PARTID_FILTER_EN) {
@@ -246,6 +260,22 @@ static ssize_t tad_pmu_event_show(struct device *dev,
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
 
@@ -287,12 +317,25 @@ static struct attribute *tad_pmu_event_attrs[] = {
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
@@ -478,7 +521,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.read		= tad_pmu_event_counter_read,
 	};
 
-	if (version == TAD_PMU_V1) {
+	if (version == TAD_PMU_V1 || version == TAD_PMU_V3) {
 		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
 		tad_pmu->ops		 = &tad_pmu_ops;
 	} else {
@@ -521,6 +564,11 @@ static const struct tad_pmu_data tad_pmu_data = {
 	.tad_pfc_offset = TAD_PFC_OFFSET,
 };
 
+static const struct tad_pmu_data tad_pmu_cn20k_data = {
+	.id   = TAD_PMU_V3,
+	.tad_prf_offset = TAD_PRF_NS_OFFSET,
+	.tad_pfc_offset = TAD_PFC_NS_OFFSET,
+};
 #endif
 
 #ifdef CONFIG_ACPI
@@ -534,6 +582,7 @@ static const struct tad_pmu_data tad_pmu_v2_data = {
 #ifdef CONFIG_OF
 static const struct of_device_id tad_pmu_of_match[] = {
 	{ .compatible = "marvell,cn10k-tad-pmu", .data = &tad_pmu_data },
+	{ .compatible = "marvell,cn20k-tad-pmu", .data = &tad_pmu_cn20k_data },
 	{},
 };
 #endif
@@ -542,6 +591,7 @@ static const struct of_device_id tad_pmu_of_match[] = {
 static const struct acpi_device_id tad_pmu_acpi_match[] = {
 	{"MRVL000B", (kernel_ulong_t)&tad_pmu_data},
 	{"MRVL000D", (kernel_ulong_t)&tad_pmu_v2_data},
+	{"MRVL000F", (kernel_ulong_t)&tad_pmu_cn20k_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
@@ -603,6 +653,6 @@ static void __exit tad_pmu_exit(void)
 module_init(tad_pmu_init);
 module_exit(tad_pmu_exit);
 
-MODULE_DESCRIPTION("Marvell CN10K LLC-TAD perf driver");
+MODULE_DESCRIPTION("Marvell CN10K/CN20K LLC-TAD perf driver");
 MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

