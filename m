Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684023314DE;
	Mon, 13 Apr 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099402; cv=none; b=K6O90JsJagM+qCuVh2LQTCWr2f/i5bNvVAG0GD/DXDp4ccmrwXFelj/2aEGANkZ6UCbaaIGq2+3iz1AJCnjM/WV3avC0oJzstrm/rjrrkq0bd6Ex71nAkhKF1KenIkqE1h7MjSe299X7qZo+NUNfzLF1XthNKqYPXhu5JMw9M/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099402; c=relaxed/simple;
	bh=mDmU413Hofnp5EuNr51HbuDNOg4Z9nCzMGgKeNlpdFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1umhMjPoSdWfmyPMR87N9vgXapkIZal4d8p/esDA/PbqB1074GeqV79PyB6Ovb/wvFYVlPpdBANklJ4HNjoKErsoa/u+H5fgRTbBdS2WcYRhSHcCbOvfJoZMv/uSw3FkSMShHXhFRLc7Fi0bssvY46T06RNvfAVwNH4WJ9XRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eKzQeoVd; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eKzQeoVd"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D8f6Lf3064202;
	Mon, 13 Apr 2026 09:56:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XR5W7IC7PTwbtzXT+qz9wbcg8
	9OB5tTvO2gREmT5x5k=; b=eKzQeoVdD1PY7bbFbk4FBk7z0S03I9k4qByCFyfjB
	fyDUsUuYRR9pPT450AXwWa+5Fwrec3hyucGxZeDmBLW2tvY1MimxdmMvxsBi6wKR
	Wd1aDlrB1e352YYA05eDJdl/lNKxxvG8IEOjenIUsg9JZSF979BE69USZWPZLu7c
	uoR7PYtPTbgGCchu8dfNpqr1daZujNBiSqv0/3i6NetXZaeTEdmL3QKlrgf+LORG
	0TwpvsYr1Uk4k7jbvyF6vqta8i/MOZ7h1xBGEun0HCYJwMMI6PSo96UY1hXRp62H
	Pia+Y0EnxkqZaUykYMy47Ck/NbE/fw4pK0qJXAPg+DJsQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dgw6hh3sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 09:56:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Apr 2026 09:56:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Apr 2026 09:56:31 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id C8A8B3F7075;
	Mon, 13 Apr 2026 09:56:28 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v5 2/2] perf: marvell: Add CN20K DDR PMU support
Date: Mon, 13 Apr 2026 22:26:21 +0530
Message-ID: <20260413165621.10921-3-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260413165621.10921-1-gakula@marvell.com>
References: <20260413165621.10921-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BY7oFLt2 c=1 sm=1 tr=0 ts=69dd2040 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=WnYttJQ71G5mWjJxUIAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: PRe6_xLqo2FA7to9v0-h4uvl5eYWB_ZS
X-Proofpoint-ORIG-GUID: PRe6_xLqo2FA7to9v0-h4uvl5eYWB_ZS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NyBTYWx0ZWRfX5zjXDHEQqyGY
 x2JeyG35VxBWXgYZvQlsc9uz/4TeMcWniIeIUXFHI1co9BxBN/ahOvngS9Wo5L/f8kvQzx1ce7G
 aF/6EmqgpK0DsWbw90xd3qVAFOWAbTBlKx1FreccEhp2JuERGuVRN+PnJuf0OdsIa0xR9u/CAis
 lHgGtUZY7PwwKQarMiIHS0eDImoiM/Un/ym/NS8+zKeq8mdjZPEFZGvqmYOJ9EcP5IQAjKk+zVI
 R9ye0+ihHYNMgpTtIQ5kheEdG056QvClMmqvNVqRUz1tkuk0Qlf9BkDNVKx/i0FYn+v/CXAPhbJ
 xEpNwXR511LPKs2cvpZr+kUaMtBiMlVPUlneFgLQkpxNabBQiBSl2k2VNB78uIw3jxgymHT2hC/
 jGVd80b95L7Q5OI2pPimSct906J2C/4gCHiL74Mo5NAIwUmY7Mqd2MvFbSkQO3Q2Shokyz12I5o
 QgG1xKY5rJlE8P1k6YQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01

The CN20K DRAM Subsystem exposes eight programmable
performance counters and two fixed counters for DDR
read and write traffic.  Software selects events for
the programmable counters from traffic at the DDR PHY
interface, the CHI interconnect, or inside the DDR controller.

Add CN20K register offsets, event maps, and sysfs attributes;
match the device via OF (marvell,cn20k-ddr-pmu) and ACPI (MRVL000B).
Represent the SoC variant in platform data with bit flags so
CN20K can reuse the CN10K PMU code path where appropriate.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 187 ++++++++++++++++++++++++---
 1 file changed, 171 insertions(+), 16 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 72ac17efd846..7e2e1823b009 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -13,31 +13,43 @@
 #include <linux/hrtimer.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/bits.h>
+
+/* SoC variant flags for struct ddr_pmu_platform_data (mutually exclusive in pdata) */
+#define IS_CN10K	BIT(0)
+#define IS_ODY		BIT(1)
+#define IS_CN20K	BIT(2)
 
 /* Performance Counters Operating Mode Control Registers */
 #define CN10K_DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
 #define ODY_DDRC_PERF_CNT_OP_MODE_CTRL		0x20020
+#define CN20K_DDRC_PERF_CNT_OP_MODE_CTRL	0x20000
 #define OP_MODE_CTRL_VAL_MANUAL	0x1
 
 /* Performance Counters Start Operation Control Registers */
 #define CN10K_DDRC_PERF_CNT_START_OP_CTRL	0x8028
 #define ODY_DDRC_PERF_CNT_START_OP_CTRL		0x200A0
+#define CN20K_DDRC_PERF_CNT_START_OP_CTRL	0x20080
 #define START_OP_CTRL_VAL_START		0x1ULL
 #define START_OP_CTRL_VAL_ACTIVE	0x2
 
 /* Performance Counters End Operation Control Registers */
 #define CN10K_DDRC_PERF_CNT_END_OP_CTRL	0x8030
 #define ODY_DDRC_PERF_CNT_END_OP_CTRL	0x200E0
+#define CN20K_DDRC_PERF_CNT_END_OP_CTRL	0x200C0
 #define END_OP_CTRL_VAL_END		0x1ULL
 
 /* Performance Counters End Status Registers */
 #define CN10K_DDRC_PERF_CNT_END_STATUS		0x8038
 #define ODY_DDRC_PERF_CNT_END_STATUS		0x20120
+#define CN20K_DDRC_PERF_CNT_END_STATUS		0x20100
 #define END_STATUS_VAL_END_TIMER_MODE_END	0x1
 
 /* Performance Counters Configuration Registers */
 #define CN10K_DDRC_PERF_CFG_BASE		0x8040
 #define ODY_DDRC_PERF_CFG_BASE			0x20160
+#define CN20K_DDRC_PERF_CFG_BASE		0x20140
+#define CN20K_DDRC_PERF_CFG1_BASE		0x20180
 
 /* 8 Generic event counter + 2 fixed event counters */
 #define DDRC_PERF_NUM_GEN_COUNTERS	8
@@ -61,6 +73,23 @@
  * DO NOT change these event-id numbers, they are used to
  * program event bitmap in h/w.
  */
+
+/* CN20K specific events */
+#define EVENT_PERF_OP_IS_RD16			61
+#define EVENT_PERF_OP_IS_RD32			60
+#define EVENT_PERF_OP_IS_WR16			59
+#define EVENT_PERF_OP_IS_WR32			58
+#define EVENT_OP_IS_ENTER_DSM			44
+#define EVENT_OP_IS_RFM				43
+
+#define EVENT_CN20K_OP_IS_TCR_MRR			50
+#define EVENT_CN20K_OP_IS_DQSOSC_MRR			49
+#define EVENT_CN20K_OP_IS_DQSOSC_MPC			48
+#define EVENT_CN20K_VISIBLE_WIN_LIMIT_REACHED_WR	47
+#define EVENT_CN20K_VISIBLE_WIN_LIMIT_REACHED_RD	46
+#define EVENT_CN20K_OP_IS_ZQLATCH			21
+#define EVENT_CN20K_OP_IS_ZQSTART			22
+
 #define EVENT_DFI_CMD_IS_RETRY			61
 #define EVENT_RD_UC_ECC_ERROR			60
 #define EVENT_RD_CRC_ERROR			59
@@ -87,6 +116,9 @@
 #define EVENT_OP_IS_SPEC_REF			41
 #define EVENT_OP_IS_CRIT_REF			40
 #define EVENT_OP_IS_REFRESH			39
+#define EVENT_OP_IS_CAS_WCK_SUS			38
+#define EVENT_OP_IS_CAS_WS_OFF			37
+#define EVENT_OP_IS_CAS_WS			36
 #define EVENT_OP_IS_ENTER_MPSM			35
 #define EVENT_OP_IS_ENTER_POWERDOWN		31
 #define EVENT_OP_IS_ENTER_SELFREF		27
@@ -183,8 +215,8 @@ struct ddr_pmu_platform_data {
 	u64 cnt_freerun_clr;
 	u64 cnt_value_wr_op;
 	u64 cnt_value_rd_op;
-	bool is_cn10k;
-	bool is_ody;
+	u64 cfg1_base;
+	unsigned int silicon_flags; /* IS_CN10K, IS_ODY, or IS_CN20K */
 };
 
 static ssize_t cn10k_ddr_pmu_event_show(struct device *dev,
@@ -336,6 +368,80 @@ static struct attribute *odyssey_ddr_perf_events_attrs[] = {
 	NULL
 };
 
+static struct attribute *cn20k_ddr_perf_events_attrs[] = {
+	/* Programmable */
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_or_wr_access, EVENT_HIF_RD_OR_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_wr_access, EVENT_HIF_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_access, EVENT_HIF_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rmw_access, EVENT_HIF_RMW),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_pri_rdaccess, EVENT_HIF_HI_PRI_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_bypass_access, EVENT_READ_BYPASS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_act_bypass_access, EVENT_ACT_BYPASS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_wr_data_access,
+				 EVENT_DFI_WR_DATA_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_rd_data_access,
+				 EVENT_DFI_RD_DATA_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpri_sched_rd_crit_access,
+				 EVENT_HPR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpri_sched_rd_crit_access,
+				 EVENT_LPR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_wr_trxn_crit_access,
+				 EVENT_WR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_active_access, EVENT_OP_IS_ACTIVATE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_or_wr_access,
+				 EVENT_OP_IS_RD_OR_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_active_access,
+				 EVENT_OP_IS_RD_ACTIVATE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_read, EVENT_OP_IS_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_write, EVENT_OP_IS_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_mwr, EVENT_OP_IS_MWR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge, EVENT_OP_IS_PRECHARGE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_rdwr,
+				 EVENT_PRECHARGE_FOR_RDWR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_other,
+				 EVENT_PRECHARGE_FOR_OTHER),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rdwr_transitions, EVENT_RDWR_TRANSITIONS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_write_combine, EVENT_WRITE_COMBINE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_war_hazard, EVENT_WAR_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_raw_hazard, EVENT_RAW_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_waw_hazard, EVENT_WAW_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_selfref, EVENT_OP_IS_ENTER_SELFREF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_powerdown,
+				 EVENT_OP_IS_ENTER_POWERDOWN),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cas_ws, EVENT_OP_IS_CAS_WS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cas_ws_off, EVENT_OP_IS_CAS_WS_OFF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cas_wck_sus, EVENT_OP_IS_CAS_WCK_SUS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_refresh, EVENT_OP_IS_REFRESH),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_crit_ref, EVENT_OP_IS_CRIT_REF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_spec_ref, EVENT_OP_IS_SPEC_REF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_load_mode, EVENT_OP_IS_LOAD_MODE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rfm, EVENT_OP_IS_RFM),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_dsm, EVENT_OP_IS_ENTER_DSM),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_cycles, EVENT_DFI_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_rd,
+				 EVENT_CN20K_VISIBLE_WIN_LIMIT_REACHED_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_wr,
+				 EVENT_CN20K_VISIBLE_WIN_LIMIT_REACHED_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mpc, EVENT_CN20K_OP_IS_DQSOSC_MPC),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mrr, EVENT_CN20K_OP_IS_DQSOSC_MRR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_tcr_mrr, EVENT_CN20K_OP_IS_TCR_MRR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqstart, EVENT_CN20K_OP_IS_ZQSTART),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqlatch, EVENT_CN20K_OP_IS_ZQLATCH),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_read16, EVENT_PERF_OP_IS_RD16),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_read32, EVENT_PERF_OP_IS_RD32),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_write16, EVENT_PERF_OP_IS_WR16),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_write32, EVENT_PERF_OP_IS_WR32),
+	/* Free run event counters */
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_reads, EVENT_DDR_READS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_writes, EVENT_DDR_WRITES),
+	NULL
+};
+
+static struct attribute_group cn20k_ddr_perf_events_attr_group = {
+	.name = "events",
+	.attrs = cn20k_ddr_perf_events_attrs,
+};
+
 static struct attribute_group odyssey_ddr_perf_events_attr_group = {
 	.name = "events",
 	.attrs = odyssey_ddr_perf_events_attrs,
@@ -393,6 +499,13 @@ static const struct attribute_group *odyssey_attr_groups[] = {
 	NULL
 };
 
+static const struct attribute_group *cn20k_attr_groups[] = {
+	&cn20k_ddr_perf_events_attr_group,
+	&cn10k_ddr_perf_format_attr_group,
+	&cn10k_ddr_perf_cpumask_attr_group,
+	NULL
+};
+
 /* Default poll timeout is 100 sec, which is very sufficient for
  * 48 bit counter incremented max at 5.6 GT/s, which may take many
  * hours to overflow.
@@ -412,7 +525,7 @@ static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
 
 	switch (eventid) {
 	case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:
-		if (!ddr_pmu->p_data->is_ody) {
+		if (!(ddr_pmu->p_data->silicon_flags & IS_ODY)) {
 			err = -EINVAL;
 			break;
 		}
@@ -524,9 +637,9 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 					  int counter, bool enable)
 {
 	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	unsigned int silicon_flags = pmu->p_data->silicon_flags;
 	u64 ctrl_reg = pmu->p_data->cnt_op_mode_ctrl;
 	const struct ddr_pmu_ops *ops = pmu->ops;
-	bool is_ody = pmu->p_data->is_ody;
 	u32 reg;
 	u64 val;
 
@@ -546,7 +659,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 
 		writeq_relaxed(val, pmu->base + reg);
 
-		if (is_ody) {
+		if (silicon_flags & IS_ODY) {
 			if (enable) {
 				/*
 				 * Setup the PMU counter to work in
@@ -621,6 +734,7 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
 	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	unsigned int silicon_flags = pmu->p_data->silicon_flags;
 	const struct ddr_pmu_ops *ops = pmu->ops;
 	struct hw_perf_event *hwc = &event->hw;
 	u8 config = event->attr.config;
@@ -642,10 +756,17 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
 		/* Generic counters, configure event id */
 		reg_offset = DDRC_PERF_CFG(p_data->cfg_base, counter);
-		ret = ddr_perf_get_event_bitmap(config, &val, pmu);
-		if (ret)
-			return ret;
 
+		if (silicon_flags & IS_CN20K) {
+			val =  (1ULL << (config - 1));
+			if (config == EVENT_CN20K_OP_IS_ZQSTART ||
+			    config == EVENT_CN20K_OP_IS_ZQLATCH)
+				reg_offset = DDRC_PERF_CFG(p_data->cfg1_base, counter);
+		} else {
+			ret = ddr_perf_get_event_bitmap(config, &val, pmu);
+			if (ret)
+				return ret;
+		}
 		writeq_relaxed(val, pmu->base + reg_offset);
 	} else {
 		/* fixed event counter, clear counter value */
@@ -952,7 +1073,25 @@ static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
 	.cnt_freerun_clr = 0,
 	.cnt_value_wr_op = CN10K_DDRC_PERF_CNT_VALUE_WR_OP,
 	.cnt_value_rd_op = CN10K_DDRC_PERF_CNT_VALUE_RD_OP,
-	.is_cn10k = TRUE,
+	.silicon_flags = IS_CN10K,
+};
+
+static const struct ddr_pmu_platform_data cn20k_ddr_pmu_pdata = {
+	.counter_overflow_val = 0,
+	.counter_max_val = GENMASK_ULL(63, 0),
+	.cnt_base = ODY_DDRC_PERF_CNT_VALUE_BASE,
+	.cfg_base = CN20K_DDRC_PERF_CFG_BASE,
+	.cfg1_base = CN20K_DDRC_PERF_CFG1_BASE,
+	.cnt_op_mode_ctrl = CN20K_DDRC_PERF_CNT_OP_MODE_CTRL,
+	.cnt_start_op_ctrl = CN20K_DDRC_PERF_CNT_START_OP_CTRL,
+	.cnt_end_op_ctrl = CN20K_DDRC_PERF_CNT_END_OP_CTRL,
+	.cnt_end_status = CN20K_DDRC_PERF_CNT_END_STATUS,
+	.cnt_freerun_en = 0,
+	.cnt_freerun_ctrl = ODY_DDRC_PERF_CNT_FREERUN_CTRL,
+	.cnt_freerun_clr = ODY_DDRC_PERF_CNT_FREERUN_CLR,
+	.cnt_value_wr_op = ODY_DDRC_PERF_CNT_VALUE_WR_OP,
+	.cnt_value_rd_op = ODY_DDRC_PERF_CNT_VALUE_RD_OP,
+	.silicon_flags = IS_CN20K,
 };
 #endif
 
@@ -979,7 +1118,7 @@ static const struct ddr_pmu_platform_data odyssey_ddr_pmu_pdata = {
 	.cnt_freerun_clr = ODY_DDRC_PERF_CNT_FREERUN_CLR,
 	.cnt_value_wr_op = ODY_DDRC_PERF_CNT_VALUE_WR_OP,
 	.cnt_value_rd_op = ODY_DDRC_PERF_CNT_VALUE_RD_OP,
-	.is_ody = TRUE,
+	.silicon_flags = IS_ODY,
 };
 #endif
 
@@ -989,8 +1128,7 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	struct cn10k_ddr_pmu *ddr_pmu;
 	struct resource *res;
 	void __iomem *base;
-	bool is_cn10k;
-	bool is_ody;
+	unsigned int silicon_flags;
 	char *name;
 	int ret;
 
@@ -1014,10 +1152,9 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	ddr_pmu->base = base;
 
 	ddr_pmu->p_data = dev_data;
-	is_cn10k = ddr_pmu->p_data->is_cn10k;
-	is_ody = ddr_pmu->p_data->is_ody;
+	silicon_flags = ddr_pmu->p_data->silicon_flags;
 
-	if (is_cn10k) {
+	if (silicon_flags & IS_CN10K) {
 		ddr_pmu->ops = &ddr_pmu_ops;
 		/* Setup the PMU counter to work in manual mode */
 		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
@@ -1039,7 +1176,7 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 		};
 	}
 
-	if (is_ody) {
+	if (silicon_flags & IS_ODY) {
 		ddr_pmu->ops = &ddr_pmu_ody_ops;
 
 		ddr_pmu->pmu = (struct pmu) {
@@ -1056,6 +1193,22 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 		};
 	}
 
+	if (silicon_flags & IS_CN20K) {
+		ddr_pmu->ops = &ddr_pmu_ody_ops;
+
+		ddr_pmu->pmu = (struct pmu) {
+			.module       = THIS_MODULE,
+			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr = perf_invalid_context,
+			.attr_groups = cn20k_attr_groups,
+			.event_init  = cn10k_ddr_perf_event_init,
+			.add         = cn10k_ddr_perf_event_add,
+			.del         = cn10k_ddr_perf_event_del,
+			.start       = cn10k_ddr_perf_event_start,
+			.stop        = cn10k_ddr_perf_event_stop,
+			.read        = cn10k_ddr_perf_event_update,
+		};
+	}
 	/* Choose this cpu to collect perf data */
 	ddr_pmu->cpu = raw_smp_processor_id();
 
@@ -1098,6 +1251,7 @@ static void cn10k_ddr_perf_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
 	{ .compatible = "marvell,cn10k-ddr-pmu", .data = &cn10k_ddr_pmu_pdata },
+	{ .compatible = "marvell,cn20k-ddr-pmu", .data = &cn20k_ddr_pmu_pdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
@@ -1107,6 +1261,7 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
 static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] = {
 	{"MRVL000A", (kernel_ulong_t)&cn10k_ddr_pmu_pdata },
 	{"MRVL000C", (kernel_ulong_t)&odyssey_ddr_pmu_pdata},
+	{"MRVL000B", (kernel_ulong_t)&cn20k_ddr_pmu_pdata},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);
-- 
2.25.1

