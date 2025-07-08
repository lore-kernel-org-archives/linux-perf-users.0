Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D12D94BE
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971267; cv=none; b=CGiUSUq4NOl4XxXL+vi6dkD7h3DyPAgexdEXq798NgaFdSNRyOX0/WRFkadjG3sEcmUA00KdlWmqOyhkSzceidvyzd5pbMfvc4GfkkOEOZYYKHWD8PNRmEFNFrQPuzYpyuquQ/0r6xfZIOxXnXkgxpalXWgY2nwpl9slSPCEswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971267; c=relaxed/simple;
	bh=hN2KM2LroQvebBOfXHVOMTXH6tYWJl+jeYKPSC9RtLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=jsAW3tAEWZ70YA87ZyMu/7AGF/BbIdWbyAmzLfhHHcGGpH0w4Q+uKAdIcIVK+1b/BA0A0KsWOJ2ZkxZeTlURM8rtFekMCw+uYnQzcMeKRrcWBr2z7kQq3eKjXuwNYSi7NmJMqvXYF5dcBaWUzEZIdU63MVzzhmvfVtKC5M0dvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=apuQPWmW; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="apuQPWmW"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250708104102epoutp0207048aa8f6b02318f00e9ded19cf39f7~QQJTS_hbC3238132381epoutp02O
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:41:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250708104102epoutp0207048aa8f6b02318f00e9ded19cf39f7~QQJTS_hbC3238132381epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751971263;
	bh=wcn3ekiEBh3bQUPBYv93o0+HsETSNyswVRcekmOQry4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apuQPWmW0bOj5O8TtWxlUeoYOmxX7AXD7AkcW1EccApUAWC0r8TU8mFJ+I3AEJF9r
	 W1HkFsa3IBUM7goY73bmWYeUmO+6ohxhu7v4oPrT0E/fz2i7HBBEyE6z0sOGwrrDq1
	 vFyEBtz3LPSlYwCupjs9wVbqdQ1Sa11/PHwn6kw4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250708104102epcas5p4c664b37db1e8127b70f8bc5cf5da7b4a~QQJScy5qv1624516245epcas5p4N;
	Tue,  8 Jul 2025 10:41:02 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.175]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bbyM04V5Fz6B9m6; Tue,  8 Jul
	2025 10:41:00 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250708103240epcas5p336539d4c3a1fb489708c61f9aae6bfa8~QQB-XgtaL1991119911epcas5p3B;
	Tue,  8 Jul 2025 10:32:40 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250708103237epsmtip1b822d2d396b2fc397bf990c9e1ae1d20~QQB8wDtVG2131121311epsmtip1n;
	Tue,  8 Jul 2025 10:32:37 +0000 (GMT)
From: Vivek Yadav <vivek.2311@samsung.com>
To: pankaj.dubey@samsung.com, ravi.patel@samsung.com, shradha.t@samsung.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, krzk@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, will@kernel.org,
	mark.rutland@arm.com, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, linux-fsd@tesla.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Vivek
	Yadav <vivek.2311@samsung.com>
Subject: [PATCH 4/6] drivers: perf: samsung: Add PPMU driver support
Date: Tue,  8 Jul 2025 16:02:06 +0530
Message-ID: <20250708103208.79444-5-vivek.2311@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708103208.79444-1-vivek.2311@samsung.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708103240epcas5p336539d4c3a1fb489708c61f9aae6bfa8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250708103240epcas5p336539d4c3a1fb489708c61f9aae6bfa8
References: <20250708103208.79444-1-vivek.2311@samsung.com>
	<CGME20250708103240epcas5p336539d4c3a1fb489708c61f9aae6bfa8@epcas5p3.samsung.com>

Add Samsung PPMU driver support in the Linux perf subsystem.

PPMU24 driver configures the PPMU24 hardware which is found
in the Samsung SoCs like Tesla FSD.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
---
 drivers/perf/Kconfig                 |   2 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/samsung/Kconfig         |  13 +
 drivers/perf/samsung/Makefile        |   2 +
 drivers/perf/samsung/ppmu.c          | 494 +++++++++++++++++++++++++++
 drivers/perf/samsung/ppmu_platform.c | 338 ++++++++++++++++++
 drivers/perf/samsung/samsung_ppmu.h  | 128 +++++++
 7 files changed, 978 insertions(+)
 create mode 100644 drivers/perf/samsung/Kconfig
 create mode 100644 drivers/perf/samsung/Makefile
 create mode 100644 drivers/perf/samsung/ppmu.c
 create mode 100644 drivers/perf/samsung/ppmu_platform.c
 create mode 100644 drivers/perf/samsung/samsung_ppmu.h

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 4e268de351c4..0852bcae6cd2 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -271,6 +271,8 @@ source "drivers/perf/arm_cspmu/Kconfig"
 
 source "drivers/perf/amlogic/Kconfig"
 
+source "drivers/perf/samsung/Kconfig"
+
 config CXL_PMU
 	tristate "CXL Performance Monitoring Unit"
 	depends on CXL_BUS
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index de71d2574857..5f764d9fc601 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -33,3 +33,4 @@ obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
 obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
 obj-$(CONFIG_CXL_PMU) += cxl_pmu.o
+obj-$(CONFIG_SAMSUNG_PPMU24) += samsung/
diff --git a/drivers/perf/samsung/Kconfig b/drivers/perf/samsung/Kconfig
new file mode 100644
index 000000000000..2088e2b7299d
--- /dev/null
+++ b/drivers/perf/samsung/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Programmable Performance Monitoring Unit (PPMU) driver
+#
+
+config SAMSUNG_PPMU24
+	tristate "Samsung PPMU24 drivers"
+	depends on ARM64 && ARCH_EXYNOS
+	help
+	 The Platform Performance Measuring Unit (PPMU) is an AMBA-compliant
+	 performance measurement tool designed to provide observability into
+	 system-level operations. It provides performance statistics such as
+	 as bandwidth, read and write request, transactions count for AXI masters.
diff --git a/drivers/perf/samsung/Makefile b/drivers/perf/samsung/Makefile
new file mode 100644
index 000000000000..c9ed1e1a986e
--- /dev/null
+++ b/drivers/perf/samsung/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SAMSUNG_PPMU24) += ppmu_platform.o ppmu.o
diff --git a/drivers/perf/samsung/ppmu.c b/drivers/perf/samsung/ppmu.c
new file mode 100644
index 000000000000..cacb9cdec79f
--- /dev/null
+++ b/drivers/perf/samsung/ppmu.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Samsung Platform Performance Measuring Unit (PPMU) driver
+ *
+ * Copyright (c) 2024-25 Samsung Electronics Co., Ltd.
+ *
+ * Authors: Vivek Yadav <vivek.2311@samsung.com>
+ *          Ravi Patel <ravi.patel@samsung.com>
+ */
+
+#include <linux/idr.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include "samsung_ppmu.h"
+
+#define PPMU_CLEAR_FLAG				(GENMASK(3, 0) | BIT(31))
+
+#define PPMU_PMCNT3_HIGH_VAL			(3)
+#define PPMU_PMCNT2_HIGH_VAL			(2)
+#define PPMU_RESET_CCNT				BIT(2)
+#define PPMU_RESET_PMCNT			BIT(1)
+
+#define PPMU_PMNC_OP_MODE_MASK			(GENMASK(21, 20))
+#define PPMU_PMNC_OP_MODE_OFF			(20)
+#define PPMU_MANUAL_MODE_VAL			(0x0)
+#define PPMU_PMNC_GLB_CNT_EN_VAL		(BIT(0))
+#define PPMU_PMNC_RESET_PMCNT_VAL		(BIT(1))
+#define PPMU_PMNC_RESET_CCNT_VAL		(BIT(2))
+
+#define PPMU_V24_IDENTIFIER			(0x45)
+
+#define PPMU_CCNT_IDX				(4)
+#define PPMU_CCNT_POS_OFF			(31)
+#define PPMU_VERSION_CHECK			(GENMASK(19, 12))
+
+#define PPMU_SM_ENABLE_ALL_CNT			(0xf)
+#define PPMU_ENABLE_CCNT			BIT(31)
+#define PPMU_FILTER_MASK			(0x7)
+
+/* ID of event type */
+enum {
+	PPMU_EVENT_READ_CHANNEL_ACTIVE		= (0x00),
+	PPMU_EVENT_WRITE_CHANNEL_ACTIVE		= (0x01),
+	PPMU_EVENT_READ_REQUEST			= (0x02),
+	PPMU_EVENT_WRITE_REQUEST		= (0x03),
+	PPMU_EVENT_READ_DATA			= (0x04),
+	PPMU_EVENT_WRITE_DATA			= (0x05),
+	PPMU_EVENT_WRITE_RESPONSE		= (0x06),
+	PPMU_EVENT_LAST_READ_DATA		= (0x07),
+	PPMU_EVENT_LAST_WRITE_DATA		= (0x08),
+	PPMU_EVENT_READ_REQUEST_BOLCKING	= (0x10),
+	PPMU_EVENT_WRITE_REQUEST_BOLCKING	= (0x11),
+	PPMU_EVENT_READ_DATA_BLOCKING		= (0x12),
+	PPMU_EVENT_WRITE_DATA_BLOCKING		= (0x13),
+	PPMU_EVENT_WRITE_RESPONSE_BLOCKING	= (0x14),
+	PPMU_EVENT_READ_BURST_LENGTH		= (0x2a),
+	PPMU_EVENT_WRITE_BURST_LENGTH		= (0x2b),
+	PPMU_EVENT_CCNT				= (0xfe),
+	PPMU_EVENT_MAX				= (0xff),
+};
+
+/* Register offsets */
+enum ppmu_reg {
+	PPMU_VERSION				= (0x0000),
+	PPMU_PMNC				= (0x0004),
+	PPMU_CNTENS				= (0x0008),
+	PPMU_CNTENC				= (0x000c),
+	PPMU_INTENS				= (0x0010),
+	PPMU_INTENC				= (0x0014),
+	PPMU_FLAG				= (0x0018),
+	PPMU_CIG_CFG0				= (0x001c),
+	PPMU_CIG_CFG1				= (0x0020),
+	PPMU_CIG_CFG2				= (0x0024),
+	PPMU_CIG_RESULT				= (0x0028),
+	PPMU_CNT_RESET				= (0x002c),
+	PPMU_CNT_AUTO				= (0x0030),
+	PPMU_PMCNT0				= (0x0034),
+	PPMU_PMCNT1				= (0x0038),
+	PPMU_PMCNT2				= (0x003c),
+	PPMU_PMCNT3_LOW				= (0x0040),
+	PPMU_PMCNT3_HIGH			= (0x0044),
+	PPMU_CCNT				= (0x0048),
+	PPMU_PMCNT2_HIGH			= (0x0054),
+	PPMU_CONFIG_INFO			= (0X005c),
+	PPMU_INTERRUPT_TEST			= (0x0060),
+	PPMU_EVENT_EV0_TYPE			= (0x0200),
+	PPMU_EVENT_EV1_TYPE			= (0x0204),
+	PPMU_EVENT_EV2_TYPE			= (0x0208),
+	PPMU_EVENT_EV3_TYPE			= (0x020c),
+	PPMU_EVENT_SM_ID_MASK			= (0x0220),
+	PPMU_EVENT_SM_ID_VALUE			= (0x0224),
+	PPMU_EVENT_SM_ID_A			= (0x0228),
+	PPMU_EVENT_SM_OTHERS_V			= (0x022c),
+	PPMU_EVENT_SM_OTHERS_A			= (0x0230),
+	PPMU_EVENT_SAMPLE_RD_ID_MASK		= (0x0234),
+	PPMU_EVENT_SAMPLE_RD_ID_VALUE		= (0x0238),
+	PPMU_EVENT_SAMPLE_WR_ID_MASK		= (0x023c),
+	PPMU_EVENT_SAMPLE_WD_ID_VALUE		= (0x0240),
+	PPMU_EVENT_AXI_CH_TYPE			= (0x0244),
+	PPMU_EVENT_MO_INFO			= (0x0250),
+	PPMU_EVENT_MO_INFO_SM_ID		= (0x0254),
+	PPMU_EVENT_MO_INFO_SAMPLE		= (0x0258),
+	PPMU_EVENT_IMPRECISE_ERR		= (0x0260),
+};
+
+static const u32 ppmu_pmcnt_offset[PPMU_MAX_COUNTERS][2] = {
+	{ PPMU_PMCNT0,		PPMU_EVENT_EV0_TYPE },
+	{ PPMU_PMCNT1,		PPMU_EVENT_EV1_TYPE },
+	{ PPMU_PMCNT2,		PPMU_EVENT_EV2_TYPE },
+	{ PPMU_PMCNT3_LOW,	PPMU_EVENT_EV3_TYPE },
+	{ PPMU_CCNT,		0 },
+};
+
+static DEFINE_IDR(my_idr);
+
+static void samsung_ppmu_write_evtype(struct samsung_ppmu *s_ppmu,
+				      int idx, u32 type)
+{
+	/* Configure event */
+	if (idx != PPMU_CCNT_IDX)
+		writel(type, s_ppmu->base + ppmu_pmcnt_offset[idx][1]);
+}
+
+static int samsung_ppmu_get_event_idx(struct perf_event *event)
+{
+	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(event->pmu);
+	unsigned long *used_mask = samsung_ppmu->pmu_events.used_mask;
+	u32 num_counters = samsung_ppmu->num_counters;
+	DECLARE_BITMAP(buf, PPMU_MAX_COUNTERS);
+	int idx;
+
+	if (event->attr.config == PPMU_EVENT_CCNT)
+		*buf = *used_mask | (~BIT(PPMU_CCNT_IDX));
+	else
+		*buf = *used_mask;
+
+	idx = find_first_zero_bit(buf, num_counters);
+	if (idx == num_counters)
+		return -EAGAIN;
+
+	set_bit(idx, used_mask);
+
+	return idx;
+}
+
+static u64 samsung_ppmu_get_read_counter(struct samsung_ppmu *s_ppmu,
+					 struct hw_perf_event *hwc)
+{
+	u64 counter_val, prev_overflow_val;
+	u64 high_val = 0;
+
+	counter_val = (u64)readl(s_ppmu->base + ppmu_pmcnt_offset[hwc->idx][0]);
+	prev_overflow_val = (u64)s_ppmu->counter_overflow[hwc->idx] << 32;
+
+	/*
+	 * PMCNT2 and PMCNT3 are 40-bit counters
+	 * its value are divided in two 32-bit registers
+	 */
+	if (hwc->idx == PPMU_PMCNT3_HIGH_VAL || hwc->idx == PPMU_PMCNT2_HIGH_VAL) {
+		prev_overflow_val = prev_overflow_val << 8;
+
+		if (hwc->idx == PPMU_PMCNT3_HIGH_VAL)
+			high_val = (u64)(readl(s_ppmu->base + PPMU_PMCNT3_HIGH) & 0xFF);
+		else
+			high_val = (u64)(readl(s_ppmu->base + PPMU_PMCNT2_HIGH) & 0xFF);
+	}
+
+	counter_val = counter_val + (high_val << 32);
+
+	/* Clear overflow status */
+	s_ppmu->counter_overflow[hwc->idx] = 0;
+
+	/* Read previous counter */
+	s_ppmu->prev_counter[hwc->idx] = counter_val;
+
+	return (counter_val | prev_overflow_val);
+}
+
+static void samsung_ppmu_get_enable_counter(struct samsung_ppmu *s_ppmu,
+					    struct hw_perf_event *hwc)
+{
+	u32 val;
+	int idx = hwc->idx;
+
+	if (idx == PPMU_CCNT_IDX)
+		idx = PPMU_CCNT_POS_OFF;
+
+	/* Enabling counters */
+	writel(BIT(idx), s_ppmu->base + PPMU_CNTENS);
+
+	/* Enabling interrupt */
+	writel(BIT(idx), s_ppmu->base + PPMU_INTENS);
+
+	/* Manual mode enabled */
+	val = readl(s_ppmu->base + PPMU_PMNC);
+	val &= (~PPMU_PMNC_OP_MODE_MASK);
+	val |= (PPMU_MANUAL_MODE_VAL << PPMU_PMNC_OP_MODE_OFF);
+	writel(val, s_ppmu->base + PPMU_PMNC);
+}
+
+static void samsung_ppmu_get_disable_counter(struct samsung_ppmu *s_ppmu,
+					     struct hw_perf_event *hwc)
+{
+	int idx = hwc->idx;
+
+	if (idx == PPMU_CCNT_IDX)
+		idx = PPMU_CCNT_POS_OFF;
+
+	/* Disabling interrupt */
+	writel(BIT(idx), s_ppmu->base + PPMU_INTENC);
+
+	/* Disabling counter */
+	writel(BIT(idx), s_ppmu->base + PPMU_CNTENC);
+
+	/* Reset counter */
+	writel(BIT(idx), s_ppmu->base + PPMU_CNT_RESET);
+}
+
+static void samsung_ppmu_get_start_counters(struct samsung_ppmu *s_ppmu)
+{
+	u32 val;
+
+	/* Clearing all overflow status */
+	writel(PPMU_CLEAR_FLAG, s_ppmu->base + PPMU_FLAG);
+
+	/* Resetting all counters */
+	val = readl(s_ppmu->base + PPMU_PMNC);
+	val |= (PPMU_PMNC_RESET_PMCNT_VAL | PPMU_PMNC_RESET_CCNT_VAL);
+	writel(val, s_ppmu->base + PPMU_PMNC);
+
+	/* Start counters */
+	val = readl(s_ppmu->base + PPMU_PMNC);
+	val |= PPMU_PMNC_GLB_CNT_EN_VAL;
+	writel(val, s_ppmu->base + PPMU_PMNC);
+
+	s_ppmu->status = PPMU_START;
+}
+
+static void samsung_ppmu_get_stop_counters(struct samsung_ppmu *s_ppmu)
+{
+	u32 val;
+
+	/* Stop counters */
+	val = readl(s_ppmu->base + PPMU_PMNC);
+	val &= (~PPMU_PMNC_GLB_CNT_EN_VAL);
+	writel(val, s_ppmu->base + PPMU_PMNC);
+
+	s_ppmu->status = PPMU_STOP;
+}
+
+static u32 samsung_ppmu_get_int_status(struct samsung_ppmu *s_ppmu)
+{
+	u32 regvalue, i;
+
+	/* Read status register */
+	regvalue = readl(s_ppmu->base + PPMU_FLAG);
+
+	for (i = 0; i < PPMU_MAX_COUNTERS; i++) {
+		if (regvalue & BIT(i))
+			s_ppmu->counter_overflow[i] += 1;
+	}
+
+	if (regvalue & BIT(PPMU_CCNT_POS_OFF)) {
+		s_ppmu->counter_overflow[PPMU_CCNT_IDX] += 1;
+		regvalue &= (~BIT(PPMU_CCNT_POS_OFF));
+		regvalue |= BIT(PPMU_CCNT_IDX);
+	}
+
+	return regvalue;
+}
+
+static void samsung_ppmu_clear_int_status(struct samsung_ppmu *s_ppmu, int idx)
+{
+	if (idx == PPMU_CCNT_IDX)
+		idx = PPMU_CCNT_POS_OFF;
+
+	/* Clear the interrupt status */
+	writel(BIT(idx), s_ppmu->base + PPMU_FLAG);
+}
+
+static struct attribute *samsung_ppmu_format_attr[] = {
+	SAMSUNG_PPMU_FORMAT_ATTR(event, "config:0-7"),
+	NULL
+};
+
+static const struct attribute_group samsung_ppmu_format_group = {
+	.name = "format",
+	.attrs = samsung_ppmu_format_attr,
+};
+
+static struct attribute *samsung_ppmu_events_attr[] = {
+	SAMSUNG_PPMU_EVENT_ATTR(rd_channel_active,	PPMU_EVENT_READ_CHANNEL_ACTIVE),
+	SAMSUNG_PPMU_EVENT_ATTR(wr_channel_active,	PPMU_EVENT_WRITE_CHANNEL_ACTIVE),
+	SAMSUNG_PPMU_EVENT_ATTR(read_request,		PPMU_EVENT_READ_REQUEST),
+	SAMSUNG_PPMU_EVENT_ATTR(write_request,		PPMU_EVENT_WRITE_REQUEST),
+	SAMSUNG_PPMU_EVENT_ATTR(read_data,		PPMU_EVENT_READ_DATA),
+	SAMSUNG_PPMU_EVENT_ATTR(write_data,		PPMU_EVENT_WRITE_DATA),
+	SAMSUNG_PPMU_EVENT_ATTR(wr_response,		PPMU_EVENT_WRITE_RESPONSE),
+	SAMSUNG_PPMU_EVENT_ATTR(last_rd_data,		PPMU_EVENT_LAST_READ_DATA),
+	SAMSUNG_PPMU_EVENT_ATTR(last_wr_data,		PPMU_EVENT_LAST_WRITE_DATA),
+	SAMSUNG_PPMU_EVENT_ATTR(rd_request_blk,		PPMU_EVENT_READ_REQUEST_BOLCKING),
+	SAMSUNG_PPMU_EVENT_ATTR(wr_request_blk,		PPMU_EVENT_WRITE_REQUEST_BOLCKING),
+	SAMSUNG_PPMU_EVENT_ATTR(rd_data_blk,		PPMU_EVENT_READ_DATA_BLOCKING),
+	SAMSUNG_PPMU_EVENT_ATTR(wr_data_blk,		PPMU_EVENT_WRITE_DATA_BLOCKING),
+	SAMSUNG_PPMU_EVENT_ATTR(wr_response_blk,	PPMU_EVENT_WRITE_RESPONSE_BLOCKING),
+	SAMSUNG_PPMU_EVENT_ATTR(rd_burst_length,	PPMU_EVENT_READ_BURST_LENGTH),
+	SAMSUNG_PPMU_EVENT_ATTR(wr_burst_length,	PPMU_EVENT_WRITE_BURST_LENGTH),
+	SAMSUNG_PPMU_EVENT_ATTR(ccnt,			PPMU_EVENT_CCNT),
+	NULL
+};
+
+static const struct attribute_group samsung_ppmu_events_group = {
+	.name = "events",
+	.attrs = samsung_ppmu_events_attr,
+};
+
+struct device_attribute dev_attr_cpumask =
+	__ATTR(cpumask, 0444, samsung_ppmu_cpumask_sysfs_show, NULL);
+
+static struct attribute *samsung_ppmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static const struct attribute_group samsung_ppmu_cpumask_attr_group = {
+	.attrs = samsung_ppmu_cpumask_attrs,
+};
+
+static struct device_attribute samsung_ppmu_identifier_attr =
+	__ATTR(identifier, 0444, samsung_ppmu_identifier_attr_show, NULL);
+
+static struct attribute *samsung_ppmu_identifier_attrs[] = {
+	&samsung_ppmu_identifier_attr.attr,
+	NULL
+};
+
+static const struct attribute_group samsung_ppmu_identifier_group = {
+	.attrs = samsung_ppmu_identifier_attrs,
+};
+
+static const struct attribute_group *samsung_ppmu_v24_attr_groups[] = {
+	&samsung_ppmu_format_group,
+	&samsung_ppmu_events_group,
+	&samsung_ppmu_cpumask_attr_group,
+	&samsung_ppmu_identifier_group,
+	NULL
+};
+
+static struct samsung_ppmu_drv_data samsung_ppmu_v24_data = {
+	.ppmu_attr_group = samsung_ppmu_v24_attr_groups
+};
+
+static const struct samsung_ppmu_ops samsung_ppmu_plat_ops = {
+	.write_evtype		= samsung_ppmu_write_evtype,
+	.get_event_idx		= samsung_ppmu_get_event_idx,
+	.read_counter		= samsung_ppmu_get_read_counter,
+	.enable_counter		= samsung_ppmu_get_enable_counter,
+	.disable_counter	= samsung_ppmu_get_disable_counter,
+	.start_counters		= samsung_ppmu_get_start_counters,
+	.stop_counters		= samsung_ppmu_get_stop_counters,
+	.get_int_status		= samsung_ppmu_get_int_status,
+	.clear_int_status	= samsung_ppmu_clear_int_status,
+};
+
+static int ppmu_clock_init(struct samsung_ppmu *s_ppmu)
+{
+	int ret = 0;
+	struct device *dev = s_ppmu->dev;
+
+	s_ppmu->clks[PPMU_ACLK].id = "aclk";
+	s_ppmu->clks[PPMU_PCLK].id = "pclk";
+
+	ret = devm_clk_bulk_get(dev, PPMU_CLK_COUNT, s_ppmu->clks);
+	if (ret) {
+		dev_err(dev, "Failed to get clocks. Err %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_bulk_prepare_enable(PPMU_CLK_COUNT, s_ppmu->clks);
+	if (ret)
+		dev_err(dev, "Clock enable failed. Err %d\n", ret);
+
+	return ret;
+}
+
+static int samsung_ppmu_probe(struct platform_device *pdev)
+{
+	struct samsung_ppmu *s_ppmu;
+	struct device *dev = &pdev->dev;
+	u32 version;
+	char *name;
+	int ret;
+
+	s_ppmu = devm_kzalloc(dev, sizeof(*s_ppmu), GFP_KERNEL);
+	if (!s_ppmu)
+		return -ENOMEM;
+
+	s_ppmu->dev = &pdev->dev;
+
+	s_ppmu->id = idr_alloc(&my_idr, dev, 0, 2, GFP_KERNEL);
+	if (s_ppmu->id < 0) {
+		dev_err(dev, "Failed to allocate ID dynamically\n");
+		return s_ppmu->id;
+	}
+
+	/* Register base address */
+	s_ppmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(s_ppmu->base)) {
+		dev_err(dev, "IO remap failed\n");
+		return PTR_ERR(s_ppmu->base);
+	}
+
+	/* Register IRQ */
+	ret = samsung_ppmu_init_irq(s_ppmu, pdev);
+	if (ret)
+		return ret;
+
+	s_ppmu->check_event = PPMU_EVENT_MAX;
+	s_ppmu->num_counters = PPMU_MAX_COUNTERS;
+	s_ppmu->on_cpu = 0;
+	s_ppmu->identifier = PPMU_V24_IDENTIFIER;
+
+	s_ppmu->ppmu_data = device_get_match_data(&pdev->dev);
+	if (!s_ppmu->ppmu_data) {
+		dev_err(&pdev->dev, "No matching device data found\n");
+		return -ENODEV;
+	}
+
+	/* Register PPMU driver ops */
+	s_ppmu->pmu_events.attr_groups = s_ppmu->ppmu_data->ppmu_attr_group;
+	s_ppmu->ops = &samsung_ppmu_plat_ops;
+
+	/* Set private data to platform_device structure */
+	platform_set_drvdata(pdev, s_ppmu);
+
+	/* Initialize the PPMU */
+	samsung_ppmu_init(s_ppmu, THIS_MODULE);
+
+	ret = ppmu_clock_init(s_ppmu);
+	if (ret)
+		return ret;
+
+	version = readl(s_ppmu->base + PPMU_VERSION);
+	version &= PPMU_VERSION_CHECK;
+	version >>= 12;
+	s_ppmu->samsung_ppmu_version = version;
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ppmu_v_%x_%d", version, s_ppmu->id);
+	if (!name)
+		return -ENOMEM;
+
+	ret = perf_pmu_register(&s_ppmu->pmu, name, -1);
+	if (ret) {
+		clk_bulk_disable_unprepare(PPMU_CLK_COUNT, s_ppmu->clks);
+		dev_err(dev, "Failed to register PPMU in perf. Err %d\n", ret);
+	}
+
+	return ret;
+}
+
+static void samsung_ppmu_remove(struct platform_device *pdev)
+{
+	struct samsung_ppmu *s_ppmu = platform_get_drvdata(pdev);
+
+	clk_bulk_disable_unprepare(PPMU_CLK_COUNT, s_ppmu->clks);
+
+	perf_pmu_unregister(&s_ppmu->pmu);
+
+	idr_remove(&my_idr, s_ppmu->id);
+}
+
+static const struct of_device_id ppmu_of_match[] = {
+	{ .compatible = "samsung,ppmu-v2", .data = &samsung_ppmu_v24_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ppmu_of_match);
+
+static struct platform_driver samsung_ppmu_driver = {
+	.probe = samsung_ppmu_probe,
+	.remove = samsung_ppmu_remove,
+	.driver	= {
+		.name = "samsung-ppmu",
+		.of_match_table	= ppmu_of_match,
+	},
+};
+
+module_platform_driver(samsung_ppmu_driver);
+
+MODULE_ALIAS("perf:samsung-ppmu");
+MODULE_DESCRIPTION("Samsung Platform Performance Measuring Unit (PPMU) driver");
+MODULE_AUTHOR("Vivek Yadav <vivek.2311@samsung.com>");
+MODULE_AUTHOR("Ravi Patel <ravi.patel@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/perf/samsung/ppmu_platform.c b/drivers/perf/samsung/ppmu_platform.c
new file mode 100644
index 000000000000..ee11311d5a61
--- /dev/null
+++ b/drivers/perf/samsung/ppmu_platform.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Samsung Platform Performance Measuring Unit (PPMU) core file
+ *
+ * Copyright (c) 2024-25 Samsung Electronics Co., Ltd.
+ *
+ * Authors: Vivek Yadav <vivek.2311@samsung.com>
+ *          Ravi Patel <ravi.patel@samsung.com>
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/perf_event.h>
+#include "samsung_ppmu.h"
+
+/*
+ * PMU format attributes
+ */
+ssize_t samsung_ppmu_format_sysfs_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_format_sysfs_show);
+
+/*
+ * PMU event attributes
+ */
+ssize_t samsung_ppmu_event_sysfs_show(struct device *dev,
+				      struct device_attribute *attr, char *page)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+
+	return sysfs_emit(page, "config=0x%lx\n", (unsigned long)eattr->var);
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_event_sysfs_show);
+
+/*
+ * sysfs cpumask attributes. For PPMU, we only have a single CPU to show
+ */
+ssize_t samsung_ppmu_cpumask_sysfs_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%d\n", samsung_ppmu->on_cpu);
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_cpumask_sysfs_show);
+
+ssize_t samsung_ppmu_identifier_attr_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *page)
+{
+	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(dev_get_drvdata(dev));
+
+	return sysfs_emit(page, "0x%08x\n", samsung_ppmu->identifier);
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_identifier_attr_show);
+
+static irqreturn_t samsung_ppmu_isr(int irq, void *data)
+{
+	struct samsung_ppmu *samsung_ppmu = data;
+	unsigned long overflown;
+	int idx;
+
+	overflown = samsung_ppmu->ops->get_int_status(samsung_ppmu);
+	if (!overflown)
+		return IRQ_NONE;
+
+	/*
+	 * Find the counter index which overflowed if the bit was set
+	 * and handle it.
+	 */
+	for_each_set_bit(idx, &overflown, samsung_ppmu->num_counters)
+		samsung_ppmu->ops->clear_int_status(samsung_ppmu, idx);
+
+	return IRQ_HANDLED;
+}
+
+int samsung_ppmu_init_irq(struct samsung_ppmu *samsung_ppmu,
+			  struct platform_device *pdev)
+{
+	int irq0, irq1, ret, irq_count;
+
+	irq0 = platform_get_irq(pdev, 0);
+	if (irq0 < 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ 0\n");
+		return irq0;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq0, samsung_ppmu_isr,
+			       IRQF_NOBALANCING | IRQF_NO_THREAD | IRQF_SHARED,
+			       dev_name(&pdev->dev), samsung_ppmu);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Fail to request IRQ: %d ret: %d.\n", irq0, ret);
+		return ret;
+	}
+
+	samsung_ppmu->irq0 = irq0;
+
+	irq_count = of_property_count_elems_of_size(pdev->dev.of_node, "interrupts", sizeof(u32));
+	if (irq_count > 1) {
+		irq1 = platform_get_irq(pdev, 1);
+		if (irq1 < 0) {
+			dev_err(&pdev->dev, "Failed to get IRQ 0\n");
+			return irq1;
+		}
+
+		ret = devm_request_irq(&pdev->dev, irq1, samsung_ppmu_isr,
+				       IRQF_NOBALANCING | IRQF_NO_THREAD | IRQF_SHARED,
+				       dev_name(&pdev->dev), samsung_ppmu);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Fail to request IRQ: %d ret: %d.\n", irq1, ret);
+			return ret;
+		}
+		samsung_ppmu->irq1 = irq1;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_init_irq);
+
+int samsung_ppmu_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct samsung_ppmu *samsung_ppmu;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/*
+	 * We do not support sampling as the counters are all
+	 * shared by all CPU cores in a CPU die. Also we
+	 * do not support attach to a task(per-process mode)
+	 */
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
+	/* PPMU counters not specific to any CPU, so cannot support per-task */
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	/* Check if events in group does not exceed the available counters */
+	samsung_ppmu = to_samsung_ppmu(event->pmu);
+	if (event->attr.config > samsung_ppmu->check_event)
+		return -EINVAL;
+
+	/*
+	 * We don't assign an index until we actually place the event onto
+	 * hardware. Use -1 to signify that we haven't decided where to put it
+	 * yet.
+	 */
+	hwc->idx = -1;
+	hwc->config_base = event->attr.config;
+
+	/* Enforce to use the same CPU for all events in this PMU */
+	event->cpu = samsung_ppmu->on_cpu;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_event_init);
+
+/*
+ * Set the counter to count the event that we're interested in,
+ * and enable interrupt and counter.
+ */
+static void samsung_ppmu_enable_event(struct perf_event *event)
+{
+	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	samsung_ppmu->ops->write_evtype(samsung_ppmu, hwc->idx,
+					SAMSUNG_PPMU_GET_EVENTID(event));
+
+	samsung_ppmu->ops->enable_counter(samsung_ppmu, hwc);
+}
+
+/*
+ * Disable counter and interrupt.
+ */
+static void samsung_ppmu_disable_event(struct perf_event *event)
+{
+	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	samsung_ppmu->ops->disable_counter(samsung_ppmu, hwc);
+}
+
+void samsung_ppmu_event_update(struct perf_event *event)
+{
+	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev_raw_count, new_raw_count;
+
+	/* read previous counter value */
+	prev_raw_count = samsung_ppmu->prev_counter[hwc->idx];
+
+	/* Read the count from the counter register */
+	new_raw_count = samsung_ppmu->ops->read_counter(samsung_ppmu, hwc);
+
+	/* compute the delta */
+	delta = new_raw_count - prev_raw_count;
+
+	local64_add(delta, &event->count);
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_event_update);
+
+void samsung_ppmu_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+	hwc->state = 0;
+
+	samsung_ppmu_enable_event(event);
+	perf_event_update_userpage(event);
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_start);
+
+void samsung_ppmu_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	samsung_ppmu_disable_event(event);
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+
+	if (hwc->state & PERF_HES_UPTODATE)
+		return;
+
+	/* Read hardware counter and update the perf counter statistics */
+	samsung_ppmu_event_update(event);
+	hwc->state |= PERF_HES_UPTODATE;
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_stop);
+
+int samsung_ppmu_add(struct perf_event *event, int flags)
+{
+	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	/* Get an available counter index for counting */
+	idx = samsung_ppmu->ops->get_event_idx(event);
+	if (idx < 0)
+		return idx;
+
+	event->hw.idx = idx;
+	samsung_ppmu->pmu_events.hw_events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		samsung_ppmu_start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_add);
+
+void samsung_ppmu_del(struct perf_event *event, int flags)
+{
+	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	samsung_ppmu_stop(event, PERF_EF_UPDATE);
+
+	samsung_ppmu->prev_counter[hwc->idx] = 0;
+
+	/* Clear the event bit */
+	clear_bit(hwc->idx, samsung_ppmu->pmu_events.used_mask);
+	perf_event_update_userpage(event);
+	samsung_ppmu->pmu_events.hw_events[hwc->idx] = NULL;
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_del);
+
+void samsung_ppmu_read(struct perf_event *event)
+{
+	/* Read hardware counter and update the perf counter statistics */
+	samsung_ppmu_event_update(event);
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_read);
+
+void samsung_ppmu_enable(struct pmu *pmu)
+{
+	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(pmu);
+	bool enabled = !bitmap_empty(samsung_ppmu->pmu_events.used_mask,
+				     samsung_ppmu->num_counters);
+
+	if (!enabled)
+		return;
+
+	samsung_ppmu->ops->start_counters(samsung_ppmu);
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_enable);
+
+void samsung_ppmu_disable(struct pmu *pmu)
+{
+	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(pmu);
+
+	samsung_ppmu->ops->stop_counters(samsung_ppmu);
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_disable);
+
+void samsung_ppmu_init(struct samsung_ppmu *s_ppmu, struct module *module)
+{
+	struct pmu *pmu = &s_ppmu->pmu;
+
+	pmu->module		= module;
+	pmu->task_ctx_nr	= perf_invalid_context;
+	pmu->event_init		= samsung_ppmu_event_init;
+	pmu->pmu_enable		= samsung_ppmu_enable;
+	pmu->pmu_disable	= samsung_ppmu_disable;
+	pmu->add		= samsung_ppmu_add;
+	pmu->del		= samsung_ppmu_del;
+	pmu->start		= samsung_ppmu_start;
+	pmu->stop		= samsung_ppmu_stop;
+	pmu->read		= samsung_ppmu_read;
+	pmu->attr_groups	= s_ppmu->pmu_events.attr_groups;
+	pmu->capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+}
+EXPORT_SYMBOL_GPL(samsung_ppmu_init);
+
+MODULE_ALIAS("perf:samsung-ppmu-core");
+MODULE_DESCRIPTION("Samsung Platform Performance Measuring Unit (PPMU) driver");
+MODULE_AUTHOR("Vivek Yadav <vivek.2311@samsung.com>");
+MODULE_AUTHOR("Ravi Patel <ravi.patel@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/perf/samsung/samsung_ppmu.h b/drivers/perf/samsung/samsung_ppmu.h
new file mode 100644
index 000000000000..2cad75cfa97b
--- /dev/null
+++ b/drivers/perf/samsung/samsung_ppmu.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Samsung Platform Performance Measuring Unit (PPMU) headers
+ *
+ * Copyright (c) 2024-25 Samsung Electronics Co., Ltd.
+ *
+ * Authors: Vivek Yadav <vivek.2311@samsung.com>
+ *          Ravi Patel <ravi.patel@samsung.com>
+ */
+
+#ifndef __SAMSUNG_PPMU_H__
+#define __SAMSUNG_PPMU_H__
+
+#include <linux/clk.h>
+
+#define PPMU_MAX_COUNTERS	(5)
+
+#define to_samsung_ppmu(p)	(container_of(p, struct samsung_ppmu, pmu))
+
+#define SAMSUNG_PPMU_ATTR(_name, _func, _config)			\
+	(&((struct dev_ext_attribute[]) {				\
+		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }	\
+	})[0].attr.attr)
+
+#define SAMSUNG_PPMU_FORMAT_ATTR(_name, _config)		\
+	SAMSUNG_PPMU_ATTR(_name, samsung_ppmu_format_sysfs_show, (void *)_config)
+#define SAMSUNG_PPMU_EVENT_ATTR(_name, _config)		\
+	SAMSUNG_PPMU_ATTR(_name, samsung_ppmu_event_sysfs_show, (unsigned long)_config)
+
+#define SAMSUNG_PPMU_GET_EVENTID(ev) ((ev)->hw.config_base & 0xff)
+
+enum ppmu_clock_type {
+	PPMU_ACLK,
+	PPMU_PCLK,
+	PPMU_CLK_COUNT,
+};
+
+enum ppmu_status {
+	PPMU_STOP,
+	PPMU_START,
+};
+
+struct samsung_ppmu;
+
+struct samsung_ppmu_ops {
+	void (*write_evtype)(struct samsung_ppmu *s_ppmu, int idx, u32 type);
+	int (*get_event_idx)(struct perf_event *event);
+	u64 (*read_counter)(struct samsung_ppmu *s_ppmu, struct hw_perf_event *event);
+	void (*enable_counter)(struct samsung_ppmu *s_ppmu, struct hw_perf_event *event);
+	void (*disable_counter)(struct samsung_ppmu *s_ppmu, struct hw_perf_event *event);
+	void (*start_counters)(struct samsung_ppmu *s_ppmu);
+	void (*stop_counters)(struct samsung_ppmu *s_ppmu);
+	u32 (*get_int_status)(struct samsung_ppmu *s_ppmu);
+	void (*clear_int_status)(struct samsung_ppmu *s_ppmu, int idx);
+};
+
+/* Describes the Samsung PPMU features information */
+struct samsung_ppmu_dev_info {
+	const char *name;
+	const struct attribute_group **attr_groups;
+	void *private;
+};
+
+struct samsung_ppmu_hwevents {
+	struct perf_event *hw_events[PPMU_MAX_COUNTERS];
+	DECLARE_BITMAP(used_mask, PPMU_MAX_COUNTERS);
+	const struct attribute_group **attr_groups;
+};
+
+struct samsung_ppmu_drv_data {
+	const struct attribute_group **ppmu_attr_group;
+};
+
+/* Generic pmu struct for different pmu types */
+struct samsung_ppmu {
+	struct pmu pmu;
+	const struct samsung_ppmu_ops *ops;
+	const struct samsung_ppmu_dev_info *dev_info;
+	struct samsung_ppmu_hwevents pmu_events;
+	const struct samsung_ppmu_drv_data *ppmu_data;
+	u32 samsung_ppmu_version;
+	u32 samsung_ppmu_master_id_val;
+	u8 status;
+	u8 id;
+	/* CPU used for counting */
+	int on_cpu;
+	int irq0;
+	int irq1;
+	struct device *dev;
+	struct hlist_node node;
+	void __iomem *base;
+	int num_counters;
+	u32 counter_overflow[PPMU_MAX_COUNTERS];
+	u64 prev_counter[PPMU_MAX_COUNTERS];
+	/* check event code range */
+	int check_event;
+	u32 identifier;
+	struct clk_bulk_data clks[PPMU_CLK_COUNT];
+};
+
+void samsung_ppmu_read(struct perf_event *event);
+int samsung_ppmu_add(struct perf_event *event, int flags);
+void samsung_ppmu_del(struct perf_event *event, int flags);
+void samsung_ppmu_start(struct perf_event *event, int flags);
+void samsung_ppmu_stop(struct perf_event *event, int flags);
+void samsung_ppmu_set_event_period(struct perf_event *event);
+void samsung_ppmu_event_update(struct perf_event *event);
+int samsung_ppmu_event_init(struct perf_event *event);
+void samsung_ppmu_enable(struct pmu *pmu);
+void samsung_ppmu_disable(struct pmu *pmu);
+ssize_t samsung_ppmu_event_sysfs_show(struct device *dev,
+				      struct device_attribute *attr, char *buf);
+ssize_t samsung_ppmu_format_sysfs_show(struct device *dev,
+				       struct device_attribute *attr, char *buf);
+ssize_t samsung_ppmu_cpumask_sysfs_show(struct device *dev,
+					struct device_attribute *attr, char *buf);
+int samsung_ppmu_online_cpu(unsigned int cpu, struct hlist_node *node);
+int samsung_ppmu_offline_cpu(unsigned int cpu, struct hlist_node *node);
+
+ssize_t samsung_ppmu_identifier_attr_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *page);
+int samsung_ppmu_init_irq(struct samsung_ppmu *samsung_ppmu,
+			  struct platform_device *pdev);
+
+void samsung_ppmu_init(struct samsung_ppmu *samsung_ppmu, struct module *module);
+
+#endif /* __SAMSUNG_PPMU_H__ */
-- 
2.49.0

