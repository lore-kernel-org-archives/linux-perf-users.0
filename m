Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4F377545
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666967; cv=none; b=huAqPkCIS4jRLNmWmPwe9X2uXorU1uVYWhGOX3NT7R5dKYGgNV0xKavFi7yoF8uGYIM9hiC9o+dYu/qrfsxUnFQ/xRIf9W6GrenfAWwk1ik7HprE4S0Uu/MHxulQTuqt+5clSvNSJSaq/0m+tanuAEHvrya5O+4gTAXg3eXpjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666967; c=relaxed/simple;
	bh=FMCHdjlew4gWz8vmIcb1JhSt7l+ysie2JIQtDpCw7fY=;
	h=From:Mime-Version:Message-Id:To:Cc:Subject:Date:In-Reply-To:
	 References:Content-Type; b=kMhtLonRNBpW/B1kmT5oj3jcbE0/YyHuXyJV+oX5PTIgbhc252n8+omhxwUvTnwaEwhlVPI51AQxuB0HNqNE/R4NaYhAza0Zupq2p3628ZnKyH3VziRHy1rBNzzKy2qzUiZ8BUK9MR+WfWfFnbkOKI26kQ5yLhk5q/G4dTHF+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=mIZdpk8O; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="mIZdpk8O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769666952; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=a8eeGtFaP0DMj1yL9o5SmT6HEpVuryupoWfKg5wSt9w=;
 b=mIZdpk8OIEk3L0a/d+ZGBnXUDF0gHpznWgewfzPsr4+FFaqFHJLqT5CqicOYP1wn1FM4iQ
 VABpyGdR77oVtGNuFofQbueP8VD22vfqcVQ5zI0rMV3ufNi+P0fqINkSZfFKh1t/5Scdq/
 Z7Oy2svmY/N1MJHEkDqrtk2HcGgPmFfnD7PD7KKgxCBwltugpW7ajUf0TQlalJzn8QvpjE
 b1d70BQ8GifpU7dWt4KS1BqRuORH9CgTtXxEZMTZ4Ix4m3PiUH7wwVIWPeRVkwyeRagtG+
 D/fDaJz9bQ8LVVb+YjXp4IMRQMcImC9UwjFf4NG1XxaiNLbAh617FJS1SACsEg==
From: "Lv Zheng" <lv.zheng@spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+2697af986+671c14+vger.kernel.org+lv.zheng@spacemit.com>
Message-Id: <2016355f67708d6117d7fc830113b13fd1165430.1769666438.git.lv.zheng@spacemit.com>
X-Original-From: Lv Zheng <lv.zheng@spacemit.com>
X-Mailer: git-send-email 2.43.0
To: "Tomasz Jeznach" <tjeznach@rivosinc.com>, 
	"Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, 
	"Robin Murphy" <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
Cc: "Jingyu Li" <joey.li@spacemit.com>, "Lv Zheng" <lv.zheng@spacemit.com>, 
	"Zhijian Chen" <zhijian@spacemit.com>, <iommu@lists.linux.dev>, 
	<linux-perf-users@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<spacemit@lists.linux.dev>, <devicetree@vger.kernel.org>
Subject: [PATCH v1.1 3/7] iommu/riscv: Add HPM support for performance monitoring
Date: Thu, 29 Jan 2026 14:08:58 +0800
In-Reply-To: <cover.1769666438.git.lv.zheng@spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1769666438.git.lv.zheng@spacemit.com>
Received: from SurfaceBook2-B.localdomain ([122.224.183.70]) by smtp.feishu.cn with ESMTPS; Thu, 29 Jan 2026 14:09:09 +0800
Content-Type: text/plain; charset=UTF-8

From: Jingyu Li <joey.li@spacemit.com>

Introduces perf-based HPM driver for RISC-V IOMMU, enabling performance
monitoring capabilities.

Note that the RISC-V IOMMU HPM module uses COUNTER_MAX-1 as a static
counter index of HPMCYCLES, and 0~COUNTER_MAX-2 as the dynamic counter
indexes of other HPMEVENTS in order to correctly index into IOHPMEVT and
IOHPMCTR registers that have already been defined in the iommu-bits.h.
However the users treat 0 as the index of HPMCYCLES and 1~COUNTER_MAX-1 as
the indexes of other HPMEVENTS, thus care should be taken in dealing with
counter indexes between userspace and kernel space.

Signed-off-by: Jingyu Li <joey.li@spacemit.com>
Signed-off-by: Lv Zheng <lv.zheng@spacemit.com>
Link: https://github.com/riscv-non-isa/riscv-iommu
---
 drivers/iommu/riscv/Kconfig          |   9 +
 drivers/iommu/riscv/Makefile         |   1 +
 drivers/iommu/riscv/iommu-bits.h     |   6 +
 drivers/iommu/riscv/iommu-hpm.c      | 799 +++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu-pci.c      |  13 +-
 drivers/iommu/riscv/iommu-platform.c |   8 +-
 drivers/iommu/riscv/iommu.h          |  42 ++
 7 files changed, 875 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-hpm.c

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index c071816f59a6..2d06a1ef11c9 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -18,3 +18,12 @@ config RISCV_IOMMU_PCI
 	def_bool y if RISCV_IOMMU && PCI_MSI
 	help
 	  Support for the PCIe implementation of RISC-V IOMMU architecture.
+
+config RISCV_IOMMU_HPM
+	tristate "RISCV IOMMU HPM support"
+	depends on RISCV_IOMMU
+	help
+	  Provides support for the RISC-V IOMMU Hardware Performance Monitor
+	  (HPM), which provide monitoring of transactions passing through the
+	  IOMMU and allow the resulting information to be filtered based on
+	  the device/process ID of the corresponding master.
diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index b5929f9f23e6..53db3ef62bdd 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y +=3D iommu.o iommu-platform.o
 obj-$(CONFIG_RISCV_IOMMU_PCI) +=3D iommu-pci.o
+obj-$(CONFIG_RISCV_IOMMU_HPM) +=3D iommu-hpm.o
diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-b=
its.h
index 98daf0e1a306..cc6bea064d8f 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -207,6 +207,7 @@ enum riscv_iommu_ddtp_modes {
 /* 5.22 Performance monitoring event counters (31 * 64bits) */
 #define RISCV_IOMMU_REG_IOHPMCTR_BASE	0x0068
 #define RISCV_IOMMU_REG_IOHPMCTR(_n)	(RISCV_IOMMU_REG_IOHPMCTR_BASE + ((_n=
) * 0x8))
+#define RISCV_IOMMU_IOHPMEVENT_COUNTER	GENMASK_ULL(63, 0)
=20
 /* 5.23 Performance monitoring event selectors (31 * 64bits) */
 #define RISCV_IOMMU_REG_IOHPMEVT_BASE	0x0160
@@ -222,6 +223,9 @@ enum riscv_iommu_ddtp_modes {
=20
 /* Number of defined performance-monitoring event selectors */
 #define RISCV_IOMMU_IOHPMEVT_CNT	31
+/* Cycles counter is statically indexed as the last counter */
+#define RISCV_IOMMU_HPMCOUNTER_CYCLES	RISCV_IOMMU_IOHPMEVT_CNT
+#define RISCV_IOMMU_HPMCOUNTER_MAX	(RISCV_IOMMU_IOHPMEVT_CNT + 1)
=20
 /**
  * enum riscv_iommu_hpmevent_id - Performance-monitoring event identifier
@@ -250,6 +254,8 @@ enum riscv_iommu_hpmevent_id {
 	RISCV_IOMMU_HPMEVENT_MAX        =3D 9
 };
=20
+#define RISCV_IOMMU_HPMEVENT_CYCLES	RISCV_IOMMU_HPMEVENT_INVALID
+
 /* 5.24 Translation request IOVA (64bits) */
 #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
 #define RISCV_IOMMU_TR_REQ_IOVA_VPN	GENMASK_ULL(63, 12)
diff --git a/drivers/iommu/riscv/iommu-hpm.c b/drivers/iommu/riscv/iommu-hp=
m.c
new file mode 100644
index 000000000000..67827b4c1d26
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-hpm.c
@@ -0,0 +1,799 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * riscv-hpm.c: RISC-V IOMMU Hardware Performance Monitor driver
+ *
+ *  Copyright (C) 2025 SpacemiT Technologies Inc.
+ *    Author: 2025 Jingyu Li <joey.li@spacemit.com>
+ *                 Lv Zheng <lv.zheng@spacemit.com>
+ */
+
+#include "iommu.h"
+
+#define to_iommu_hpm(p) (container_of(p, struct riscv_iommu_hpm, pmu))
+
+#define RISCV_IOMMU_HPM_EVENT_EXTRACTOR(_n, _c, _s, _e)		\
+	static inline u32 get_##_n(struct perf_event *event)	\
+	{							\
+		return FIELD_GET(GENMASK_ULL(_e, _s),		\
+				 event->attr._c);		\
+	}
+
+RISCV_IOMMU_HPM_EVENT_EXTRACTOR(event, config, 0, 14);
+RISCV_IOMMU_HPM_EVENT_EXTRACTOR(filter_dmask, config1, 15, 15);
+RISCV_IOMMU_HPM_EVENT_EXTRACTOR(filter_pid_pscid, config1, 16, 35);
+RISCV_IOMMU_HPM_EVENT_EXTRACTOR(filter_did_gscid, config1, 36, 59);
+RISCV_IOMMU_HPM_EVENT_EXTRACTOR(filter_pv_pscv, config1, 60, 60);
+RISCV_IOMMU_HPM_EVENT_EXTRACTOR(filter_dv_gscv, config1, 61, 61);
+RISCV_IOMMU_HPM_EVENT_EXTRACTOR(filter_idt, config1, 62, 62);
+
+static DEFINE_MUTEX(riscv_iommu_hpm_lock);
+static atomic_t riscv_iommu_hpm_ids =3D ATOMIC_INIT(0);
+static int cpuhp_state_num =3D -1;
+static int cpuhp_refcnt;
+
+static inline void riscv_iommu_hpm_writel(struct riscv_iommu_hpm *hpm, u32=
 reg,
+					  u32 val)
+{
+	writel_relaxed(val, hpm->base + reg);
+}
+
+static inline u32 riscv_iommu_hpm_readl(struct riscv_iommu_hpm *hpm, u32 r=
eg)
+{
+	return readl_relaxed(hpm->base + reg);
+}
+
+static inline void riscv_iommu_hpm_writeq(struct riscv_iommu_hpm *hpm, u32=
 reg,
+					  u64 val)
+{
+	writeq_relaxed(val, hpm->base + reg);
+}
+
+static inline u64 riscv_iommu_hpm_readq(struct riscv_iommu_hpm *hpm, u32 r=
eg)
+{
+	return readq_relaxed(hpm->base + reg);
+}
+
+static inline void riscv_iommu_hpm_cycles_set_value(struct riscv_iommu_hpm=
 *hpm,
+						    u64 value)
+{
+	riscv_iommu_hpm_writeq(hpm, RISCV_IOMMU_REG_IOHPMCYCLES,
+			       value & RISCV_IOMMU_IOHPMCYCLES_COUNTER);
+}
+
+static inline u64 riscv_iommu_hpm_cycles_get_value(struct riscv_iommu_hpm =
*hpm)
+{
+	return riscv_iommu_hpm_readq(hpm, RISCV_IOMMU_REG_IOHPMCYCLES) &
+	       RISCV_IOMMU_IOHPMCYCLES_COUNTER;
+}
+
+static inline void riscv_iommu_hpm_counter_set_value(struct riscv_iommu_hp=
m *hpm,
+						     u32 idx, u64 value)
+{
+	riscv_iommu_hpm_writeq(hpm, RISCV_IOMMU_REG_IOHPMCTR(idx), value);
+}
+
+static inline u64 riscv_iommu_hpm_counter_get_value(struct riscv_iommu_hpm=
 *hpm,
+						    u32 idx)
+{
+	return riscv_iommu_hpm_readq(hpm, RISCV_IOMMU_REG_IOHPMCTR(idx));
+}
+
+static inline void riscv_iommu_hpm_cycles_enable(struct riscv_iommu_hpm *h=
pm)
+{
+	u32 val =3D riscv_iommu_hpm_readl(hpm, RISCV_IOMMU_REG_IOCOUNTINH);
+
+	val &=3D ~RISCV_IOMMU_IOCOUNTINH_CY;
+	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IOCOUNTINH, val);
+}
+
+static inline void riscv_iommu_hpm_cycles_disable(struct riscv_iommu_hpm *=
hpm)
+{
+	u32 val =3D riscv_iommu_hpm_readl(hpm, RISCV_IOMMU_REG_IOCOUNTINH);
+
+	val |=3D RISCV_IOMMU_IOCOUNTINH_CY;
+	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IOCOUNTINH, val);
+}
+
+static inline void riscv_iommu_hpm_counter_enable(struct riscv_iommu_hpm *=
hpm,
+						  u32 idx)
+{
+	u32 val =3D riscv_iommu_hpm_readl(hpm, RISCV_IOMMU_REG_IOCOUNTINH);
+
+	val &=3D ~BIT(idx + 1);
+	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IOCOUNTINH, val);
+}
+
+static inline void riscv_iommu_hpm_counter_disable(struct riscv_iommu_hpm =
*hpm,
+						   u32 idx)
+{
+	u32 val =3D riscv_iommu_hpm_readl(hpm, RISCV_IOMMU_REG_IOCOUNTINH);
+
+	val |=3D BIT(idx + 1);
+	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IOCOUNTINH, val);
+}
+
+static inline void riscv_iommu_hpm_cycles_clear_ovf(struct riscv_iommu_hpm=
 *hpm)
+{
+	u64 val =3D riscv_iommu_hpm_readq(hpm, RISCV_IOMMU_REG_IOHPMCYCLES);
+
+	val &=3D ~RISCV_IOMMU_IOHPMCYCLES_OF;
+	riscv_iommu_hpm_writeq(hpm, RISCV_IOMMU_REG_IOHPMCYCLES, val);
+}
+
+static inline void riscv_iommu_hpm_counter_clear_ovf(struct riscv_iommu_hp=
m *hpm,
+						     u32 idx)
+{
+	u64 val =3D riscv_iommu_hpm_readq(hpm, RISCV_IOMMU_REG_IOHPMEVT(idx));
+
+	val &=3D ~RISCV_IOMMU_IOHPMEVT_OF;
+	riscv_iommu_hpm_writeq(hpm, RISCV_IOMMU_REG_IOHPMEVT(idx), val);
+}
+
+static inline void riscv_iommu_hpm_interrupt_clear(struct riscv_iommu_hpm =
*hpm)
+{
+	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP);
+}
+
+static void riscv_iommu_hpm_event_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
+	struct riscv_iommu_hpm *iommu_hpm =3D to_iommu_hpm(event->pmu);
+	u64 delta, prev, now;
+	u32 idx =3D hwc->idx;
+
+	do {
+		prev =3D local64_read(&hwc->prev_count);
+		if (idx =3D=3D RISCV_IOMMU_HPMCOUNTER_CYCLES)
+			now =3D riscv_iommu_hpm_cycles_get_value(iommu_hpm);
+		else
+			now =3D riscv_iommu_hpm_counter_get_value(iommu_hpm, idx);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, now) !=3D prev);
+
+	delta =3D now - prev;
+	if (idx =3D=3D RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		delta &=3D RISCV_IOMMU_IOHPMCYCLES_COUNTER;
+	else
+		delta &=3D RISCV_IOMMU_IOHPMEVENT_COUNTER;
+
+	local64_add(delta, &event->count);
+}
+
+static void riscv_iommu_hpm_set_period(struct riscv_iommu_hpm *iommu_hpm,
+				       struct hw_perf_event *hwc)
+{
+	u32 idx =3D hwc->idx;
+	u64 new, max_period;
+
+	if (idx =3D=3D RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		max_period =3D RISCV_IOMMU_IOHPMCYCLES_COUNTER;
+	else
+		max_period =3D RISCV_IOMMU_IOHPMEVENT_COUNTER;
+
+	/* Start at half the counter range */
+	new =3D max_period >> 1;
+
+	if (idx =3D=3D RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		riscv_iommu_hpm_cycles_set_value(iommu_hpm, new);
+	else
+		riscv_iommu_hpm_counter_set_value(iommu_hpm, idx, new);
+
+	local64_set(&hwc->prev_count, new);
+}
+
+static void riscv_iommu_hpm_event_start(struct perf_event *event, int flag=
s)
+{
+	struct riscv_iommu_hpm *iommu_hpm =3D to_iommu_hpm(event->pmu);
+	struct hw_perf_event *hwc =3D &event->hw;
+	u32 idx =3D hwc->idx;
+
+	hwc->state =3D 0;
+	riscv_iommu_hpm_set_period(iommu_hpm, hwc);
+
+	/* Enable counter */
+	if (idx =3D=3D RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		riscv_iommu_hpm_cycles_enable(iommu_hpm);
+	else
+		riscv_iommu_hpm_counter_enable(iommu_hpm, idx);
+}
+
+static void riscv_iommu_hpm_event_stop(struct perf_event *event, int flags=
)
+{
+	struct riscv_iommu_hpm *iommu_hpm =3D to_iommu_hpm(event->pmu);
+	struct hw_perf_event *hwc =3D &event->hw;
+	u32 idx =3D hwc->idx;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	/* Disable counter */
+	if (idx =3D=3D RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		riscv_iommu_hpm_cycles_disable(iommu_hpm);
+	else
+		riscv_iommu_hpm_counter_disable(iommu_hpm, idx);
+
+	if (flags & PERF_EF_UPDATE)
+		riscv_iommu_hpm_event_update(event);
+	hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static void riscv_iommu_hpm_set_event_filter(struct perf_event *event, int=
 idx,
+					     u32 pid_pscid, u32 did_gscid,
+					     u32 pv_pscv,
+					     u32 dv_gscv, u32 idt, u32 dmask)
+{
+	struct riscv_iommu_hpm *iommu_hpm =3D to_iommu_hpm(event->pmu);
+	u64 event_cfg;
+
+	/* Start with event ID */
+	event_cfg =3D get_event(event);
+	/* Set ID fields - values of 0 are valid */
+	event_cfg |=3D FIELD_PREP(RISCV_IOMMU_IOHPMEVT_PID_PSCID,
+				pid_pscid & 0xFFFFF);
+	event_cfg |=3D FIELD_PREP(RISCV_IOMMU_IOHPMEVT_DID_GSCID,
+				did_gscid & 0xFFFFFF);
+	/* Set control flags - 0 means disabled, 1 means enabled */
+	if (pv_pscv)
+		event_cfg |=3D RISCV_IOMMU_IOHPMEVT_PV_PSCV;
+	if (dv_gscv)
+		event_cfg |=3D RISCV_IOMMU_IOHPMEVT_DV_GSCV;
+	if (idt)
+		event_cfg |=3D RISCV_IOMMU_IOHPMEVT_IDT;
+	if (dmask)
+		event_cfg |=3D RISCV_IOMMU_IOHPMEVT_DMASK;
+
+	/* Write to the specific event register for this counter */
+	riscv_iommu_hpm_writeq(iommu_hpm,
+			       RISCV_IOMMU_REG_IOHPMEVT(idx), event_cfg);
+}
+
+static void riscv_iommu_hpm_apply_event_filter(struct riscv_iommu_hpm *iom=
mu_hpm,
+					       struct perf_event *event, int idx)
+{
+	u32 pid_pscid, did_gscid, pv_pscv, dv_gscv, idt, dmask;
+
+	pid_pscid =3D get_filter_pid_pscid(event);
+	did_gscid =3D get_filter_did_gscid(event);
+	pv_pscv =3D get_filter_pv_pscv(event);
+	dv_gscv =3D get_filter_dv_gscv(event);
+	idt =3D get_filter_idt(event);
+	dmask =3D get_filter_dmask(event);
+
+	riscv_iommu_hpm_set_event_filter(event, idx, pid_pscid, did_gscid,
+					 pv_pscv, dv_gscv, idt, dmask);
+}
+
+static int riscv_iommu_hpm_get_event_idx(struct riscv_iommu_hpm *iommu_hpm=
,
+					 struct perf_event *event)
+{
+	int idx;
+	unsigned int num_ctrs =3D iommu_hpm->num_counters;
+	u16 event_id =3D get_event(event);
+
+	/* Handle cycles event specially */
+	if (event_id =3D=3D RISCV_IOMMU_HPMEVENT_CYCLES) {
+		/* Check if cycles counter is already in use */
+		if (test_and_set_bit(RISCV_IOMMU_HPMCOUNTER_CYCLES,
+				     iommu_hpm->used_counters)) {
+			dev_dbg(iommu_hpm->pmu.dev,
+				"Cycles counter already in use\n");
+			return -EAGAIN;
+		}
+		return RISCV_IOMMU_HPMCOUNTER_CYCLES;
+	}
+
+	idx =3D find_first_zero_bit(iommu_hpm->used_counters, num_ctrs - 1);
+	if (idx =3D=3D num_ctrs - 1) {
+		dev_dbg(iommu_hpm->pmu.dev, "All counters already in use\n");
+		return -EAGAIN;
+	}
+
+	riscv_iommu_hpm_apply_event_filter(iommu_hpm, event, idx);
+	set_bit(idx, iommu_hpm->used_counters);
+
+	return idx;
+}
+
+static int riscv_iommu_hpm_event_add(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_hpm *iommu_hpm =3D to_iommu_hpm(event->pmu);
+	struct hw_perf_event *hwc =3D &event->hw;
+	int idx;
+
+	idx =3D riscv_iommu_hpm_get_event_idx(iommu_hpm, event);
+	hwc->idx =3D idx;
+	if (idx =3D=3D RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		iommu_hpm->events[0] =3D event;
+	else
+		iommu_hpm->events[idx + 1] =3D event;
+
+	hwc->state =3D PERF_HES_UPTODATE | PERF_HES_STOPPED;
+	if (flags & PERF_EF_START)
+		riscv_iommu_hpm_event_start(event, flags);
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void riscv_iommu_hpm_event_del(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_hpm *iommu_hpm =3D to_iommu_hpm(event->pmu);
+	struct hw_perf_event *hwc =3D &event->hw;
+	u32 idx =3D hwc->idx;
+
+	riscv_iommu_hpm_event_stop(event, flags | PERF_EF_UPDATE);
+
+	/* Clear the used counter bit and event array entry */
+	if (idx =3D=3D RISCV_IOMMU_HPMCOUNTER_CYCLES) {
+		clear_bit(RISCV_IOMMU_HPMCOUNTER_CYCLES,
+			  iommu_hpm->used_counters);
+		iommu_hpm->events[0] =3D NULL;
+	} else {
+		clear_bit(idx, iommu_hpm->used_counters);
+		iommu_hpm->events[idx + 1] =3D NULL;
+	}
+
+	perf_event_update_userpage(event);
+}
+
+static int riscv_iommu_hpm_event_init(struct perf_event *event)
+{
+	struct riscv_iommu_hpm *iommu_hpm =3D to_iommu_hpm(event->pmu);
+	struct hw_perf_event *hwc =3D &event->hw;
+	struct perf_event *sibling;
+	int group_num_events =3D 1;
+	u16 event_id;
+
+	if (event->attr.type !=3D event->pmu->type)
+		return -ENOENT;
+	if (hwc->sample_period) {
+		dev_dbg(iommu_hpm->pmu.dev, "Sampling not supported\n");
+		return -EOPNOTSUPP;
+	}
+	if (event->cpu < 0) {
+		dev_dbg(iommu_hpm->pmu.dev, "Per-task mode not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	event_id =3D get_event(event);
+	if (event_id >=3D RISCV_IOMMU_HPMEVENT_MAX ||
+	    !test_bit(event_id, iommu_hpm->supported_events)) {
+		dev_dbg(iommu_hpm->pmu.dev, "Invalid event %d for this PMU\n",
+			event_id);
+		return -EINVAL;
+	}
+
+	if (!is_software_event(event->group_leader)) {
+		if (++group_num_events > iommu_hpm->num_counters)
+			return -EINVAL;
+	}
+
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (is_software_event(sibling))
+			continue;
+		if (++group_num_events > iommu_hpm->num_counters)
+			return -EINVAL;
+	}
+
+	event->cpu =3D iommu_hpm->on_cpu;
+	hwc->idx =3D -1;
+
+	return 0;
+}
+
+static ssize_t riscv_iommu_hpm_cpumask_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct riscv_iommu_hpm *iommu_hpm =3D to_iommu_hpm(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(iommu_hpm->on_cpu));
+}
+
+static struct device_attribute riscv_iommu_hpm_cpumask_attr =3D
+	__ATTR(cpumask, 0444, riscv_iommu_hpm_cpumask_show, NULL);
+
+static struct attribute *riscv_iommu_hpm_cpumask_attrs[] =3D {
+	&riscv_iommu_hpm_cpumask_attr.attr,
+	NULL
+};
+
+static const struct attribute_group riscv_iommu_hpm_cpumask_group =3D {
+	.attrs =3D riscv_iommu_hpm_cpumask_attrs,
+};
+
+#define IOMMU_HPM_EVENT_ATTR(name, config)		\
+	PMU_EVENT_ATTR_ID(name, riscv_iommu_hpm_event_show, config)
+
+static ssize_t riscv_iommu_hpm_event_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr->id);
+}
+
+static struct attribute *riscv_iommu_hpm_events[] =3D {
+	IOMMU_HPM_EVENT_ATTR(cycles, RISCV_IOMMU_HPMEVENT_CYCLES),
+	IOMMU_HPM_EVENT_ATTR(untrans_rq, RISCV_IOMMU_HPMEVENT_URQ),
+	IOMMU_HPM_EVENT_ATTR(trans_rq, RISCV_IOMMU_HPMEVENT_TRQ),
+	IOMMU_HPM_EVENT_ATTR(ats_rq,
+			     RISCV_IOMMU_HPMEVENT_ATS_RQ),
+	IOMMU_HPM_EVENT_ATTR(tlb_miss,
+			     RISCV_IOMMU_HPMEVENT_TLB_MISS),
+	IOMMU_HPM_EVENT_ATTR(device_dir_walks,
+			     RISCV_IOMMU_HPMEVENT_DD_WALK),
+	IOMMU_HPM_EVENT_ATTR(process_dir_walks,
+			     RISCV_IOMMU_HPMEVENT_PD_WALK),
+	IOMMU_HPM_EVENT_ATTR(s_stage_walks,
+			     RISCV_IOMMU_HPMEVENT_S_VS_WALKS),
+	IOMMU_HPM_EVENT_ATTR(g_stage_walks,
+			     RISCV_IOMMU_HPMEVENT_G_WALKS),
+	NULL
+};
+
+static umode_t riscv_iommu_hpm_event_is_visible(struct kobject *kobj,
+						struct attribute *attr,
+						int unused)
+{
+	struct device *dev =3D kobj_to_dev(kobj);
+	struct riscv_iommu_hpm *iommu_hpm =3D to_iommu_hpm(dev_get_drvdata(dev));
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr.attr);
+	if (test_bit(pmu_attr->id, iommu_hpm->supported_events))
+		return attr->mode;
+
+	return 0;
+}
+
+static const struct attribute_group riscv_iommu_hpm_events_group =3D {
+	.name =3D "events",
+	.attrs =3D riscv_iommu_hpm_events,
+	.is_visible =3D riscv_iommu_hpm_event_is_visible,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-14");
+PMU_FORMAT_ATTR(filter_pid_pscid, "config1:16-35");
+PMU_FORMAT_ATTR(filter_did_gscid, "config1:36-59");
+PMU_FORMAT_ATTR(filter_pv_pscv, "config1:60");
+PMU_FORMAT_ATTR(filter_dv_gscv, "config1:61");
+PMU_FORMAT_ATTR(filter_idt, "config1:62");
+PMU_FORMAT_ATTR(filter_dmask, "config1:15");
+
+static struct attribute *riscv_iommu_hpm_formats[] =3D {
+	&format_attr_event.attr,
+	&format_attr_filter_pid_pscid.attr,
+	&format_attr_filter_did_gscid.attr,
+	&format_attr_filter_pv_pscv.attr,
+	&format_attr_filter_dv_gscv.attr,
+	&format_attr_filter_idt.attr,
+	&format_attr_filter_dmask.attr,
+	NULL
+};
+
+static const struct attribute_group riscv_iommu_hpm_format_group =3D {
+	.name =3D "format",
+	.attrs =3D riscv_iommu_hpm_formats,
+};
+
+static const struct attribute_group *riscv_iommu_hpm_attr_grps[] =3D {
+	&riscv_iommu_hpm_cpumask_group,
+	&riscv_iommu_hpm_events_group,
+	&riscv_iommu_hpm_format_group,
+	NULL
+};
+
+static irqreturn_t riscv_iommu_hpm_handle_irq(int irq_num, void *data)
+{
+	struct riscv_iommu_hpm *iommu_hpm =3D data;
+	struct riscv_iommu_device *iommu =3D iommu_hpm->iommu;
+	struct perf_event *event;
+	u32 val;
+	int idx;
+	u32 ovf;
+	DECLARE_BITMAP(ovs, 32);
+
+	val =3D riscv_iommu_hpm_readl(iommu_hpm, RISCV_IOMMU_REG_IPSR);
+	if (!(val & RISCV_IOMMU_IPSR_PMIP))
+		return IRQ_NONE;
+
+	ovf =3D riscv_iommu_hpm_readl(iommu_hpm, RISCV_IOMMU_REG_IOCOUNTOVF);
+	if (!ovf)
+		return IRQ_HANDLED;
+
+	/* Handle cycles counter overflow (always stored at index 0) */
+	if (ovf & RISCV_IOMMU_IOCOUNTOVF_CY) {
+		event =3D iommu_hpm->events[0];
+		if (event && event->hw.idx =3D=3D RISCV_IOMMU_HPMCOUNTER_CYCLES) {
+			riscv_iommu_hpm_cycles_clear_ovf(iommu_hpm);
+			riscv_iommu_hpm_event_update(event);
+			riscv_iommu_hpm_set_period(iommu_hpm, &event->hw);
+		}
+	}
+
+	/*
+	 * Handle regular HPM counter overflows.
+	 * IOCOUNTOVF bit mapping:
+	 *   bit 0: cycles (already handled above)
+	 *   bit 1: counter 0 -> events[1]
+	 *   bit 2: counter 1 -> events[2]
+	 *   ...
+	 *   bit N: counter N-1 -> events[N]
+	 * We need to check bits [1..num_counters] and skip bit 0.
+	 */
+	bitmap_from_u64(ovs, ovf);
+	for_each_set_bit(idx, ovs, iommu_hpm->num_counters) {
+		/* Skip bit 0 (cycles counter, already handled) */
+		if (idx =3D=3D 0)
+			continue;
+
+		/* IOCOUNTOVF bit N corresponds to counter N-1, stored in
+		 * events[N]
+		 */
+		event =3D iommu_hpm->events[idx];
+		if (WARN_ON_ONCE(!event))
+			continue;
+
+		dev_dbg(iommu->dev, "counter overflow: hw_idx=3D%d, counter=3D%d\n",
+			idx, idx - 1);
+		riscv_iommu_hpm_counter_clear_ovf(iommu_hpm, idx - 1);
+		riscv_iommu_hpm_event_update(event);
+		riscv_iommu_hpm_set_period(iommu_hpm, &event->hw);
+	}
+
+	riscv_iommu_hpm_interrupt_clear(iommu_hpm);
+
+	return IRQ_HANDLED;
+}
+
+static int riscv_iommu_hpm_offline_cpu(unsigned int cpu,
+				       struct hlist_node *node)
+{
+	struct riscv_iommu_hpm *iommu_hpm;
+	unsigned int target;
+
+	iommu_hpm =3D hlist_entry_safe(node, struct riscv_iommu_hpm, node);
+	if (cpu !=3D iommu_hpm->on_cpu)
+		return 0;
+
+	if (!iommu_hpm->irq)
+		return 0;
+
+	target =3D cpumask_any_but(cpu_online_mask, cpu);
+	if (target >=3D nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&iommu_hpm->pmu, cpu, target);
+	iommu_hpm->on_cpu =3D target;
+	if (iommu_hpm->irq > 0)
+		WARN_ON(irq_set_affinity(iommu_hpm->irq, cpumask_of(target)));
+
+	return 0;
+}
+
+static void riscv_iommu_hpm_reset(struct riscv_iommu_hpm *iommu_hpm)
+{
+	u64 counter_present_mask =3D (1ULL << iommu_hpm->num_counters) - 1;
+
+	/* Disable all counters */
+	riscv_iommu_hpm_writel(iommu_hpm, RISCV_IOMMU_REG_IOCOUNTINH,
+			       counter_present_mask);
+	/* Clear interrupt pending status */
+	riscv_iommu_hpm_interrupt_clear(iommu_hpm);
+}
+
+static void riscv_iommu_hpm_set_standard_events(struct riscv_iommu_hpm *io=
mmu_hpm)
+{
+	/* Cycles counter is always supported */
+	set_bit(RISCV_IOMMU_HPMEVENT_CYCLES, iommu_hpm->supported_events);
+
+	/* Standard RISC-V IOMMU HPM events */
+	set_bit(RISCV_IOMMU_HPMEVENT_URQ, iommu_hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_TRQ, iommu_hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_ATS_RQ, iommu_hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_TLB_MISS, iommu_hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_DD_WALK, iommu_hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_PD_WALK, iommu_hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_S_VS_WALKS, iommu_hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_G_WALKS, iommu_hpm->supported_events);
+}
+
+static void riscv_iommu_hpm_remove(void *data)
+{
+	struct riscv_iommu_hpm *iommu_hpm =3D data;
+
+	riscv_iommu_remove_hpm(iommu_hpm->iommu);
+}
+
+static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
+					 struct riscv_iommu_hpm *iommu_hpm,
+					 u32 offset, int irq,
+					 const struct attribute_group **attr_groups,
+					 const char *prefix, int index)
+{
+	struct device *dev =3D iommu->dev;
+	const char *pmu_name;
+	u32 val;
+	int err;
+	int unique_id =3D atomic_fetch_inc(&riscv_iommu_hpm_ids);
+	void __iomem *base;
+
+	memset(iommu_hpm, 0, sizeof(*iommu_hpm));
+	iommu_hpm->iommu =3D iommu;
+
+	if (offset + RISCV_IOMMU_REG_SIZE <=3D iommu->reg_size)
+		base =3D iommu->reg + offset;
+	else
+		base =3D devm_ioremap(dev, iommu->reg_phys + offset,
+				    RISCV_IOMMU_REG_SIZE);
+	if (!base)
+		return -ENOMEM;
+
+	iommu_hpm->base =3D base;
+	bitmap_zero(iommu_hpm->used_counters, RISCV_IOMMU_HPMCOUNTER_MAX);
+	bitmap_zero(iommu_hpm->supported_events, RISCV_IOMMU_HPMEVENT_MAX);
+
+	riscv_iommu_hpm_writel(iommu_hpm,
+			       RISCV_IOMMU_REG_IOCOUNTINH, 0xFFFFFFFF);
+	val =3D riscv_iommu_hpm_readl(iommu_hpm,
+				    RISCV_IOMMU_REG_IOCOUNTINH);
+	iommu_hpm->num_counters =3D hweight32(val & RISCV_IOMMU_IOCOUNTINH_HPM);
+	if (!iommu_hpm->num_counters)
+		return -ENODEV;
+
+	iommu_hpm->on_cpu =3D raw_smp_processor_id();
+	iommu_hpm->irq =3D irq;
+
+	riscv_iommu_hpm_set_standard_events(iommu_hpm);
+	riscv_iommu_hpm_reset(iommu_hpm);
+
+	if (index >=3D 0)
+		pmu_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s%d_%d",
+					  prefix, index, unique_id);
+	else
+		pmu_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_%d",
+					  prefix, unique_id);
+	if (!pmu_name)
+		return -ENOMEM;
+
+	err =3D devm_request_threaded_irq(dev, iommu_hpm->irq, NULL,
+					riscv_iommu_hpm_handle_irq,
+					IRQF_SHARED | IRQF_ONESHOT,
+					pmu_name, iommu_hpm);
+	if (err)
+		return err;
+	WARN_ON(irq_set_affinity(iommu_hpm->irq,
+				 cpumask_of(iommu_hpm->on_cpu)));
+
+	iommu_hpm->pmu =3D (struct pmu) {
+		.name =3D pmu_name,
+		.module =3D THIS_MODULE,
+		.task_ctx_nr =3D perf_invalid_context,
+		.event_init =3D riscv_iommu_hpm_event_init,
+		.add =3D riscv_iommu_hpm_event_add,
+		.del =3D riscv_iommu_hpm_event_del,
+		.start =3D riscv_iommu_hpm_event_start,
+		.stop =3D riscv_iommu_hpm_event_stop,
+		.read =3D riscv_iommu_hpm_event_update,
+		.attr_groups =3D attr_groups,
+		.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
+	};
+
+	err =3D perf_pmu_register(&iommu_hpm->pmu, pmu_name, -1);
+	if (err)
+		goto err_exit;
+
+	mutex_lock(&riscv_iommu_hpm_lock);
+	err =3D cpuhp_state_add_instance_nocalls(cpuhp_state_num,
+					       &iommu_hpm->node);
+	if (err) {
+		mutex_unlock(&riscv_iommu_hpm_lock);
+		goto err_perf;
+	}
+	cpuhp_refcnt++;
+	mutex_unlock(&riscv_iommu_hpm_lock);
+
+	err =3D devm_add_action_or_reset(dev, riscv_iommu_hpm_remove,
+				       iommu_hpm);
+	if (err)
+		goto err_cpuhp;
+
+	dev_info(dev, "HPM: Registered %s (%d counters, IRQ %d)\n",
+		 pmu_name, iommu_hpm->num_counters, iommu_hpm->irq);
+	return 0;
+
+err_cpuhp:
+	mutex_lock(&riscv_iommu_hpm_lock);
+	cpuhp_state_remove_instance_nocalls(cpuhp_state_num,
+					    &iommu_hpm->node);
+	mutex_unlock(&riscv_iommu_hpm_lock);
+err_perf:
+	perf_pmu_unregister(&iommu_hpm->pmu);
+err_exit:
+	return err;
+}
+
+static int riscv_iommu_hpm_init(void)
+{
+	int ret =3D 0;
+
+	mutex_lock(&riscv_iommu_hpm_lock);
+	if (cpuhp_state_num < 0) {
+		cpuhp_state_num =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+							  "perf/riscv/iommu:online",
+							  NULL,
+							  riscv_iommu_hpm_offline_cpu);
+		if (cpuhp_state_num < 0)
+			ret =3D -EINVAL;
+	}
+	mutex_unlock(&riscv_iommu_hpm_lock);
+
+	return ret;
+}
+
+static void riscv_iommu_hpm_exit(void)
+{
+	mutex_lock(&riscv_iommu_hpm_lock);
+	cpuhp_remove_multi_state(cpuhp_state_num);
+	cpuhp_state_num =3D -1;
+	mutex_unlock(&riscv_iommu_hpm_lock);
+}
+
+/*
+ * Add HPM support for RISC-V IOMMU.
+ *
+ * @iommu - IOMMU device instance.
+ */
+int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
+{
+	struct device *dev =3D iommu->dev;
+	int irq;
+	int rc;
+
+	if (!FIELD_GET(RISCV_IOMMU_CAPABILITIES_HPM, iommu->caps)) {
+		dev_dbg(dev, "HPM: Not supported\n");
+		return 0;
+	}
+	irq =3D iommu->irqs[FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec)];
+	if (irq <=3D 0) {
+		dev_err(dev, "HPM: No IRQ available (vector=3D%llu)\n",
+			(unsigned long long)FIELD_GET(RISCV_IOMMU_ICVEC_PMIV,
+						      iommu->icvec));
+		return -EINVAL;
+	}
+
+	rc =3D riscv_iommu_hpm_init();
+	if (rc < 0)
+		return rc;
+
+	rc =3D riscv_iommu_hpm_register_unit(iommu, &iommu->hpm, 0, irq,
+					   riscv_iommu_hpm_attr_grps,
+					   "riscv_iommu_hpm", -1);
+	if (rc < 0)
+		goto err_module;
+	return 0;
+
+err_module:
+	riscv_iommu_hpm_exit();
+	return rc;
+}
+
+/*
+ * Remove HPM support for RISC-V IOMMU.
+ *
+ * @iommu - IOMMU device instance.
+ */
+void riscv_iommu_remove_hpm(struct riscv_iommu_device *iommu)
+{
+	mutex_lock(&riscv_iommu_hpm_lock);
+	if (cpuhp_state_num >=3D 0) {
+		cpuhp_refcnt--;
+		cpuhp_state_remove_instance_nocalls(cpuhp_state_num,
+						    &iommu->hpm.node);
+	}
+	mutex_unlock(&riscv_iommu_hpm_lock);
+	perf_pmu_unregister(&iommu->hpm.pmu);
+	riscv_iommu_hpm_exit();
+}
diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pc=
i.c
index d82d2b00904c..71407aecbf92 100644
--- a/drivers/iommu/riscv/iommu-pci.c
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -34,6 +34,8 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, co=
nst struct pci_device_i
 {
 	struct device *dev =3D &pdev->dev;
 	struct riscv_iommu_device *iommu;
+	phys_addr_t reg_phys;
+	resource_size_t reg_size;
 	int rc, vec;
=20
 	rc =3D pcim_enable_device(pdev);
@@ -43,7 +45,9 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, co=
nst struct pci_device_i
 	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
 		return -ENODEV;
=20
-	if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
+	reg_phys =3D pci_resource_start(pdev, 0);
+	reg_size =3D pci_resource_len(pdev, 0);
+	if (reg_size < RISCV_IOMMU_REG_SIZE)
 		return -ENODEV;
=20
 	rc =3D pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
@@ -56,6 +60,8 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, co=
nst struct pci_device_i
=20
 	iommu->dev =3D dev;
 	iommu->reg =3D pcim_iomap_table(pdev)[0];
+	iommu->reg_phys =3D reg_phys;
+	iommu->reg_size =3D reg_size;
=20
 	pci_set_master(pdev);
 	dev_set_drvdata(dev, iommu);
@@ -91,7 +97,10 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, c=
onst struct pci_device_i
 		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
 	}
=20
-	return riscv_iommu_init(iommu);
+	rc =3D riscv_iommu_init(iommu);
+	if (rc)
+		return rc;
+	return riscv_iommu_add_hpm(iommu);
 }
=20
 static void riscv_iommu_pci_remove(struct pci_dev *pdev)
diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iom=
mu-platform.c
index 83a28c83f991..684bc267ac30 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -62,6 +62,9 @@ static int riscv_iommu_platform_probe(struct platform_dev=
ice *pdev)
 		return dev_err_probe(dev, PTR_ERR(iommu->reg),
 				     "could not map register region\n");
=20
+	iommu->reg_phys =3D res->start;
+	iommu->reg_size =3D resource_size(res);
+
 	dev_set_drvdata(dev, iommu);
=20
 	/* Check device reported capabilities / features. */
@@ -134,7 +137,10 @@ static int riscv_iommu_platform_probe(struct platform_=
device *pdev)
 		return dev_err_probe(dev, -ENODEV, "invalid IGS\n");
 	}
=20
-	return riscv_iommu_init(iommu);
+	ret =3D riscv_iommu_init(iommu);
+	if (ret)
+		return ret;
+	return riscv_iommu_add_hpm(iommu);
 };
=20
 static void riscv_iommu_platform_remove(struct platform_device *pdev)
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..0ad9f5cad4de 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
+#include <linux/perf_event.h>
=20
 #include "iommu-bits.h"
=20
@@ -33,6 +34,29 @@ struct riscv_iommu_queue {
 	u8 qid;					/* queue identifier, same as RISCV_IOMMU_INTR_XX */
 };
=20
+struct riscv_iommu_hpm {
+	struct riscv_iommu_device *iommu;
+	struct pmu pmu;
+	void __iomem *base;
+	int irq;
+	int on_cpu;
+	struct hlist_node node;
+	/*
+	 * Layout of events:
+	 * 0       -> HPMCYCLES
+	 * 1...n-1 -> HPMEVENTS
+	 */
+	struct perf_event *events[RISCV_IOMMU_HPMCOUNTER_MAX];
+	DECLARE_BITMAP(supported_events, RISCV_IOMMU_HPMCOUNTER_MAX);
+	/*
+	 * Layout of counters:
+	 * 0...min(MAX,n)-2 -> HPMEVENTS
+	 * MAX-1            -> HPMCYCLES
+	 */
+	DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPMCOUNTER_MAX);
+	unsigned int num_counters;
+};
+
 struct riscv_iommu_device {
 	/* iommu core interface */
 	struct iommu_device iommu;
@@ -42,6 +66,8 @@ struct riscv_iommu_device {
=20
 	/* hardware control register space */
 	void __iomem *reg;
+	phys_addr_t reg_phys;
+	resource_size_t reg_size;
=20
 	/* supported and enabled hardware capabilities */
 	u64 caps;
@@ -60,12 +86,28 @@ struct riscv_iommu_device {
 	unsigned int ddt_mode;
 	dma_addr_t ddt_phys;
 	u64 *ddt_root;
+
+	struct riscv_iommu_hpm hpm;
 };
=20
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
=20
+#ifdef CONFIG_RISCV_IOMMU_HPM
+int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu);
+void riscv_iommu_remove_hpm(struct riscv_iommu_device *iommu);
+#else
+static inline int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
+{
+	return -ENODEV;
+}
+
+static inline void riscv_iommu_remove_hpm(struct riscv_iommu_device *iommu=
)
+{
+}
+#endif
+
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
=20
--=20
2.43.0

This message and any attachment are confidential and may be privileged or o=
therwise protected from disclosure. If you are not an intended recipient of=
 this message, please delete it and any attachment from your system and not=
ify the sender immediately by reply e-mail. Unintended recipients should no=
t use, copy, disclose or take any action based on this message or any infor=
mation contained in this message. Emails cannot be guaranteed to be secure =
or error free as they can be intercepted, amended, lost or destroyed, and y=
ou should take full responsibility for security checking.=20
=20
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=E9=99=84=E4=
=BB=B6=E5=85=B7=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=B9=
=B6=E5=8F=AF=E8=83=BD=E5=8F=97=E5=85=B6=E4=BB=96=E4=BF=9D=E6=8A=A4=E6=88=96=
=E4=B8=8D=E5=85=81=E8=AE=B8=E8=A2=AB=E6=8A=AB=E9=9C=B2=E7=BB=99=E7=AC=AC=E4=
=B8=89=E6=96=B9=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E8=AF=AF=E6=94=B6=E5=88=
=B0=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E6=95=AC=E8=AF=B7=E7=AB=8B=E5=8D=B3=
=E4=BB=A5=E5=9B=9E=E5=A4=8D=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E6=
=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=B9=
=B6=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=
=E9=99=84=E4=BB=B6=E4=BB=8E=E9=98=81=E4=B8=8B=E7=B3=BB=E7=BB=9F=E4=B8=AD=E4=
=BA=88=E4=BB=A5=E5=88=A0=E9=99=A4=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E5=B9=
=B6=E9=9D=9E=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=86=99=E6=98=8E=E4=B9=8B=E6=94=B6=
=E4=BB=B6=E4=BA=BA=EF=BC=8C=E6=95=AC=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BD=BF=E7=
=94=A8=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=8C=
=E4=BA=A6=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BE=9D=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E8=80=8C=E9=87=87=E5=8F=
=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=E3=80=82=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E6=97=A0=E6=B3=95=E4=BF=9D=E8=AF=81=E6=98=AF=E4=B8=80=E7=A7=8D=E5=
=AE=89=E5=85=A8=E5=92=8C=E4=B8=8D=E4=BC=9A=E5=87=BA=E7=8E=B0=E4=BB=BB=E4=BD=
=95=E5=B7=AE=E9=94=99=E7=9A=84=E9=80=9A=E4=BF=A1=E6=96=B9=E5=BC=8F=EF=BC=8C=
=E5=8F=AF=E8=83=BD=E4=BC=9A=E8=A2=AB=E6=8B=A6=E6=88=AA=E3=80=81=E4=BF=AE=E6=
=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E6=88=96=E6=8D=9F=E5=9D=8F=EF=BC=8C=E6=94=
=B6=E4=BB=B6=E4=BA=BA=E9=9C=80=E8=87=AA=E8=A1=8C=E8=B4=9F=E8=B4=A3=E5=81=9A=
=E5=A5=BD=E5=AE=89=E5=85=A8=E6=A3=80=E6=9F=A5=E3=80=82
