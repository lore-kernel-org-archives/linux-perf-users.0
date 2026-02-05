Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5E36EAA7;
	Thu,  5 Feb 2026 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282705; cv=none; b=YG/wuNzt1pIKvuUVaC5wNKzM+mEEMJ32eJjiqi4VVifFnhYm3Ocsr9id5gpWb6ozp3FWwl2e6ePS99Um5qlnpCVwybcQIQeQGSU+eCz5W/qL0QJhoZLIOabpceq2dL7OEzUymO/SPIWIM/LHxLhnGzyrDbir9oJ7c0VtYYuzDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282705; c=relaxed/simple;
	bh=V4isXmINHW5xXaLvx3rI/xCAlSq2dBZ5xN2A+xKYBho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l44ugqwE9VH9UB8b5Bh6kW838vMeY3MXDVJuBvrdZ21DA7zzWCGFsa+pdvUIGutzgZrm+33KdE1WQR3mpAnPs6ZLVWpSXd6yqGBnKJuCHaGX6zgcTNukK/h5uSJdsjsYi29uJtZUbZQdLEViWBE5TLVBIH42Psjw20IdR7+hSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=WkoW6uMR; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="WkoW6uMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770282641;
	bh=szDXuHRTv58RcibrQWg2BQbyoJuUV9RM1I/8/q75jjs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WkoW6uMR/q1gewMiuhiNYClmGDr9iq9rliUprW3sSHR9Gzb0583/I40+GGHliC7hG
	 DD9uADA5YDRxlcRpvDi6qAzErwnfYUhk87264/jWYa2DHeObcowNxc3SufZNBACdpH
	 lCG0iigBc9tVmzBoFO3rKJmQhd4hyDPYvpDdgE+I=
X-QQ-mid: esmtpgz16t1770282639t3ea419dc
X-QQ-Originating-IP: hdNWPytvkcT7raV9myQc/cshDy/TBTlBdX1W/tBsqt8=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Feb 2026 17:10:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4033490182122296899
EX-QQ-RecipientCnt: 20
From: Lv Zheng <lv.zheng@linux.spacemit.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 2/7] iommu/riscv: Add HPM support for performance monitoring
Date: Thu,  5 Feb 2026 17:10:34 +0800
Message-ID: <99ADEE3B3A72941E+544701d4b8e94725cf4080cd7a99e4d42420ebce.1770281596.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770281596.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770281596.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OJV4F5WcWfWaZtjm9SEqpPdMEMD+jhUWjy/sJ3PgNhdBr4pPy7iXHf1S
	GcS23zGs8aOnhkhj/VLFuJuAMOlNhPIM1IzMNHGZxRtz6q1nsq7xm4IHHUAIb91LAWWSVnm
	iDI450rBYC53kgWk6wEOlpCPmoD38z2KRB5WbfhusR92tF4o2OnEmKf9DFmDxdlGfRd0OHi
	RNZeprF40xzJJd2wBDZhzlK3KUlgy7gfPpw+lZvtHDGd8YCHhyxKyqiZuG08mab3+MjULG5
	Udv+S1TCPVxdbbDnxwYwwB9HibZNuy2spP7lSV7iM6Z0x3AtdS4fP2qBeXRr6TgPoSW2U9/
	aBQTNVUEaDhKzftIipUvR4K0V6YZ9bdj3nqZwlw7uOBDIbSXQcknlmrq0+q//yVxqzXtU4k
	xJjVbaNteGaLsEeYp3HdyhYtNMoq+TAx8SIvfSL4UIcVj4CA9UGW6fOel7NZlHg/SWPdmkC
	lDKciKhrVa9pzGYONogQNGkWCzNmZcmBz9KSAjWH5REL38o2YaYl3FHh9Od/QPV6j+KKG8S
	koe75GPYiFAxMq33I61KIBQZDBqPQoIU+VWmduhx5G/5uBk8vPKZYorgC2qXtTyCtER23UU
	U8pClvCLXcDm2wrEuEmiQq7oS/eCesUHXqmBi3o59SlEtjJB1aiy/bzVpZnVItKoHYBK/11
	AUDIrFeq3OsdgMxrLQiLxV2c/h+fjH5vvLIApG/yRz1QF0uJh9hpYpoLGdugp/SOnyxGVBN
	ejNEVBtTf9cxCBqL6EDSVKIKk3HqzNpPiPgclXOeieI5la//x6U6wozl+MJtrgxcz+00dOV
	79Pvycs2Mcsvk0Vk9IlUCMqgkCIL9RSCVLS1JB/NVWTF6TFtLnYScz0ddmFYlVzHJMvZBMU
	h+NBG4ZELYShFW/zgF7Uk9xNt7QqKjNSBdR7zyz2iJNAcG+sNZ9G9esuvHa1uHsgxxabdg+
	bmvM0M0AuuXt52MHErRQiizdJabCzGNrud2Rk1aeMow2qFCwm7JE1Hsyw0iHGbuLw07Is9D
	3Ue00THc81XA3Og+9wx/eqc2zaIVpnWJMDRDZADN/TLo8fHl5bQ6SwfJDuxp1g9Kgni00FC
	8bN8fR9OaRYR4SgPcUOTR39nw+0uUjQJA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

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

Also addresses community comments in the revision sent by "Zong Li".

Signed-off-by: Jingyu Li <joey.li@spacemit.com>
Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Link: https://github.com/riscv-non-isa/riscv-iommu
Link: https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Kconfig          |   9 +
 drivers/iommu/riscv/Makefile         |   1 +
 drivers/iommu/riscv/iommu-bits.h     |   6 +
 drivers/iommu/riscv/iommu-hpm.c      | 840 +++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu-pci.c      |  13 +-
 drivers/iommu/riscv/iommu-platform.c |   8 +-
 drivers/iommu/riscv/iommu.h          |  42 ++
 7 files changed, 916 insertions(+), 3 deletions(-)
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
 obj-y += iommu.o iommu-platform.o
 obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
+obj-$(CONFIG_RISCV_IOMMU_HPM) += iommu-hpm.o
diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 98daf0e1a306..cc6bea064d8f 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -207,6 +207,7 @@ enum riscv_iommu_ddtp_modes {
 /* 5.22 Performance monitoring event counters (31 * 64bits) */
 #define RISCV_IOMMU_REG_IOHPMCTR_BASE	0x0068
 #define RISCV_IOMMU_REG_IOHPMCTR(_n)	(RISCV_IOMMU_REG_IOHPMCTR_BASE + ((_n) * 0x8))
+#define RISCV_IOMMU_IOHPMEVENT_COUNTER	GENMASK_ULL(63, 0)
 
 /* 5.23 Performance monitoring event selectors (31 * 64bits) */
 #define RISCV_IOMMU_REG_IOHPMEVT_BASE	0x0160
@@ -222,6 +223,9 @@ enum riscv_iommu_ddtp_modes {
 
 /* Number of defined performance-monitoring event selectors */
 #define RISCV_IOMMU_IOHPMEVT_CNT	31
+/* Cycles counter is statically indexed as the last counter */
+#define RISCV_IOMMU_HPMCOUNTER_CYCLES	RISCV_IOMMU_IOHPMEVT_CNT
+#define RISCV_IOMMU_HPMCOUNTER_MAX	(RISCV_IOMMU_IOHPMEVT_CNT + 1)
 
 /**
  * enum riscv_iommu_hpmevent_id - Performance-monitoring event identifier
@@ -250,6 +254,8 @@ enum riscv_iommu_hpmevent_id {
 	RISCV_IOMMU_HPMEVENT_MAX        = 9
 };
 
+#define RISCV_IOMMU_HPMEVENT_CYCLES	RISCV_IOMMU_HPMEVENT_INVALID
+
 /* 5.24 Translation request IOVA (64bits) */
 #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
 #define RISCV_IOMMU_TR_REQ_IOVA_VPN	GENMASK_ULL(63, 12)
diff --git a/drivers/iommu/riscv/iommu-hpm.c b/drivers/iommu/riscv/iommu-hpm.c
new file mode 100644
index 000000000000..fe51f60c0c75
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-hpm.c
@@ -0,0 +1,840 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * iommu-hpm.c: RISC-V IOMMU Hardware Performance Monitor driver
+ *
+ *  Copyright (C) 2026 SpacemiT Technologies Inc.
+ *    Author: 2026 Jingyu Li <joey.li@spacemit.com>
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
+static atomic_t riscv_iommu_hpm_ids = ATOMIC_INIT(0);
+static int cpuhp_state_num = -1;
+static int cpuhp_refcnt;
+
+static inline void riscv_iommu_hpm_writel(struct riscv_iommu_hpm *hpm, u32 reg,
+					  u32 val)
+{
+	writel_relaxed(val, hpm->base + reg);
+}
+
+static inline u32 riscv_iommu_hpm_readl(struct riscv_iommu_hpm *hpm, u32 reg)
+{
+	return readl_relaxed(hpm->base + reg);
+}
+
+static inline void riscv_iommu_hpm_writeq(struct riscv_iommu_hpm *hpm, u32 reg,
+					  u64 val)
+{
+	writeq_relaxed(val, hpm->base + reg);
+}
+
+static inline u64 riscv_iommu_hpm_readq(struct riscv_iommu_hpm *hpm, u32 reg)
+{
+	return readq_relaxed(hpm->base + reg);
+}
+
+static inline void riscv_iommu_hpm_cycles_set_value(struct riscv_iommu_hpm *hpm,
+						    u64 value)
+{
+	riscv_iommu_hpm_writeq(hpm, RISCV_IOMMU_REG_IOHPMCYCLES,
+			       value & RISCV_IOMMU_IOHPMCYCLES_COUNTER);
+}
+
+static inline u64 riscv_iommu_hpm_cycles_get_value(struct riscv_iommu_hpm *hpm)
+{
+	return riscv_iommu_hpm_readq(hpm, RISCV_IOMMU_REG_IOHPMCYCLES) &
+	       RISCV_IOMMU_IOHPMCYCLES_COUNTER;
+}
+
+static inline void riscv_iommu_hpm_counter_set_value(struct riscv_iommu_hpm *hpm,
+						     u32 idx, u64 value)
+{
+	riscv_iommu_hpm_writeq(hpm, RISCV_IOMMU_REG_IOHPMCTR(idx), value);
+}
+
+static inline u64 riscv_iommu_hpm_counter_get_value(struct riscv_iommu_hpm *hpm,
+						    u32 idx)
+{
+	return riscv_iommu_hpm_readq(hpm, RISCV_IOMMU_REG_IOHPMCTR(idx));
+}
+
+static inline void riscv_iommu_hpm_cycles_enable(struct riscv_iommu_hpm *hpm)
+{
+	u32 val = riscv_iommu_hpm_readl(hpm, RISCV_IOMMU_REG_IOCOUNTINH);
+
+	val &= ~RISCV_IOMMU_IOCOUNTINH_CY;
+	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IOCOUNTINH, val);
+}
+
+static inline void riscv_iommu_hpm_cycles_disable(struct riscv_iommu_hpm *hpm)
+{
+	u32 val = riscv_iommu_hpm_readl(hpm, RISCV_IOMMU_REG_IOCOUNTINH);
+
+	val |= RISCV_IOMMU_IOCOUNTINH_CY;
+	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IOCOUNTINH, val);
+}
+
+static inline void riscv_iommu_hpm_counter_enable(struct riscv_iommu_hpm *hpm,
+						  u32 idx)
+{
+	u32 val = riscv_iommu_hpm_readl(hpm, RISCV_IOMMU_REG_IOCOUNTINH);
+
+	val &= ~BIT(idx + 1);
+	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IOCOUNTINH, val);
+}
+
+static inline void riscv_iommu_hpm_counter_disable(struct riscv_iommu_hpm *hpm,
+						   u32 idx)
+{
+	u32 val = riscv_iommu_hpm_readl(hpm, RISCV_IOMMU_REG_IOCOUNTINH);
+
+	val |= BIT(idx + 1);
+	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IOCOUNTINH, val);
+}
+
+static inline void riscv_iommu_hpm_cycles_clear_ovf(struct riscv_iommu_hpm *hpm)
+{
+	u64 val = riscv_iommu_hpm_readq(hpm, RISCV_IOMMU_REG_IOHPMCYCLES);
+
+	val &= ~RISCV_IOMMU_IOHPMCYCLES_OF;
+	riscv_iommu_hpm_writeq(hpm, RISCV_IOMMU_REG_IOHPMCYCLES, val);
+}
+
+static inline void riscv_iommu_hpm_counter_clear_ovf(struct riscv_iommu_hpm *hpm,
+						     u32 idx)
+{
+	u64 val = riscv_iommu_hpm_readq(hpm, RISCV_IOMMU_REG_IOHPMEVT(idx));
+
+	val &= ~RISCV_IOMMU_IOHPMEVT_OF;
+	riscv_iommu_hpm_writeq(hpm, RISCV_IOMMU_REG_IOHPMEVT(idx), val);
+}
+
+static inline void riscv_iommu_hpm_interrupt_clear(struct riscv_iommu_hpm *hpm)
+{
+	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP);
+}
+
+/**
+ * riscv_iommu_hpm_event_update() - Update and return RISC-V IOMMU HPM
+ *                                  event counters
+ *
+ * @event: IOMMU performance event
+ *
+ * This function can be used to implement the .read() interface of pmu.
+ */
+static void riscv_iommu_hpm_event_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct riscv_iommu_hpm *iommu_hpm = to_iommu_hpm(event->pmu);
+	u64 delta, prev, now;
+	u32 idx = hwc->idx;
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+		if (idx == RISCV_IOMMU_HPMCOUNTER_CYCLES)
+			now = riscv_iommu_hpm_cycles_get_value(iommu_hpm);
+		else
+			now = riscv_iommu_hpm_counter_get_value(iommu_hpm, idx);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
+
+	delta = now - prev;
+	if (idx == RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		delta &= RISCV_IOMMU_IOHPMCYCLES_COUNTER;
+	else
+		delta &= RISCV_IOMMU_IOHPMEVENT_COUNTER;
+
+	local64_add(delta, &event->count);
+}
+
+static void riscv_iommu_hpm_set_period(struct riscv_iommu_hpm *iommu_hpm,
+				       struct hw_perf_event *hwc)
+{
+	u32 idx = hwc->idx;
+	u64 new, max_period;
+
+	if (idx == RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		max_period = RISCV_IOMMU_IOHPMCYCLES_COUNTER;
+	else
+		max_period = RISCV_IOMMU_IOHPMEVENT_COUNTER;
+
+	/* Start at half the counter range */
+	new = max_period >> 1;
+
+	if (idx == RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		riscv_iommu_hpm_cycles_set_value(iommu_hpm, new);
+	else
+		riscv_iommu_hpm_counter_set_value(iommu_hpm, idx, new);
+
+	local64_set(&hwc->prev_count, new);
+}
+
+/**
+ * riscv_iommu_hpm_event_start() - Start RISC-V IOMMU HPM event
+ *
+ * @event: IOMMU performance event
+ * @flags: Performance event flags
+ *
+ * This function can be used to implement the .start() interface of pmu.
+ */
+static void riscv_iommu_hpm_event_start(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_hpm *iommu_hpm = to_iommu_hpm(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 idx = hwc->idx;
+
+	hwc->state = 0;
+	riscv_iommu_hpm_set_period(iommu_hpm, hwc);
+
+	if (idx == RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		riscv_iommu_hpm_cycles_enable(iommu_hpm);
+	else
+		riscv_iommu_hpm_counter_enable(iommu_hpm, idx);
+}
+
+/**
+ * riscv_iommu_hpm_event_stop() - Stop RISC-V IOMMU HPM event
+ *
+ * @event: IOMMU performance event
+ * @flags: Performance event flags
+ *
+ * This function can be used to implement the .stop() interface of pmu.
+ */
+static void riscv_iommu_hpm_event_stop(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_hpm *iommu_hpm = to_iommu_hpm(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 idx = hwc->idx;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	if (idx == RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		riscv_iommu_hpm_cycles_disable(iommu_hpm);
+	else
+		riscv_iommu_hpm_counter_disable(iommu_hpm, idx);
+
+	if (flags & PERF_EF_UPDATE)
+		riscv_iommu_hpm_event_update(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static void riscv_iommu_hpm_set_event_filter(struct perf_event *event, int idx,
+					     u32 pid_pscid, u32 did_gscid,
+					     u32 pv_pscv,
+					     u32 dv_gscv, u32 idt, u32 dmask)
+{
+	struct riscv_iommu_hpm *iommu_hpm = to_iommu_hpm(event->pmu);
+	u64 event_cfg;
+
+	/* Start with event ID */
+	event_cfg = get_event(event);
+	/* Set ID fields - values of 0 are valid */
+	event_cfg |= FIELD_PREP(RISCV_IOMMU_IOHPMEVT_PID_PSCID,
+				pid_pscid & 0xFFFFF);
+	event_cfg |= FIELD_PREP(RISCV_IOMMU_IOHPMEVT_DID_GSCID,
+				did_gscid & 0xFFFFFF);
+	/* Set control flags - 0 means disabled, 1 means enabled */
+	if (pv_pscv)
+		event_cfg |= RISCV_IOMMU_IOHPMEVT_PV_PSCV;
+	if (dv_gscv)
+		event_cfg |= RISCV_IOMMU_IOHPMEVT_DV_GSCV;
+	if (idt)
+		event_cfg |= RISCV_IOMMU_IOHPMEVT_IDT;
+	if (dmask)
+		event_cfg |= RISCV_IOMMU_IOHPMEVT_DMASK;
+
+	/* Write to the specific event register for this counter */
+	riscv_iommu_hpm_writeq(iommu_hpm,
+			       RISCV_IOMMU_REG_IOHPMEVT(idx), event_cfg);
+}
+
+static void riscv_iommu_hpm_apply_event_filter(struct riscv_iommu_hpm *iommu_hpm,
+					       struct perf_event *event, int idx)
+{
+	u32 pid_pscid, did_gscid, pv_pscv, dv_gscv, idt, dmask;
+
+	pid_pscid = get_filter_pid_pscid(event);
+	did_gscid = get_filter_did_gscid(event);
+	pv_pscv = get_filter_pv_pscv(event);
+	dv_gscv = get_filter_dv_gscv(event);
+	idt = get_filter_idt(event);
+	dmask = get_filter_dmask(event);
+
+	riscv_iommu_hpm_set_event_filter(event, idx, pid_pscid, did_gscid,
+					 pv_pscv, dv_gscv, idt, dmask);
+}
+
+static int riscv_iommu_hpm_get_event_idx(struct riscv_iommu_hpm *iommu_hpm,
+					 struct perf_event *event)
+{
+	int idx;
+	unsigned int num_ctrs = iommu_hpm->num_counters;
+	u16 event_id = get_event(event);
+
+	/* Handle cycles event specially */
+	if (event_id == RISCV_IOMMU_HPMEVENT_CYCLES) {
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
+	idx = find_first_zero_bit(iommu_hpm->used_counters, num_ctrs - 1);
+	if (idx == num_ctrs - 1) {
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
+/**
+ * riscv_iommu_hpm_event_add() - Add a RISC-V IOMMU HPM event
+ *
+ * @event - IOMMU performance event
+ * @flags - Performance event flags
+ *
+ * This function can be used to implement the .add() interface of pmu.
+ */
+static int riscv_iommu_hpm_event_add(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_hpm *iommu_hpm = to_iommu_hpm(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	idx = riscv_iommu_hpm_get_event_idx(iommu_hpm, event);
+	hwc->idx = idx;
+	if (idx == RISCV_IOMMU_HPMCOUNTER_CYCLES)
+		iommu_hpm->events[0] = event;
+	else
+		iommu_hpm->events[idx + 1] = event;
+
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+	if (flags & PERF_EF_START)
+		riscv_iommu_hpm_event_start(event, flags);
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+/**
+ * riscv_iommu_hpm_event_del() - Delete a RISC-V IOMMU HPM event
+ *
+ * @event: IOMMU performance event
+ * @flags: Performance event flags
+ *
+ * This function can be used to implement the .del() interface of pmu.
+ */
+static void riscv_iommu_hpm_event_del(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_hpm *iommu_hpm = to_iommu_hpm(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 idx = hwc->idx;
+
+	riscv_iommu_hpm_event_stop(event, flags | PERF_EF_UPDATE);
+
+	/* Clear the used counter bit and event array entry */
+	if (idx == RISCV_IOMMU_HPMCOUNTER_CYCLES) {
+		clear_bit(RISCV_IOMMU_HPMCOUNTER_CYCLES,
+			  iommu_hpm->used_counters);
+		iommu_hpm->events[0] = NULL;
+	} else {
+		clear_bit(idx, iommu_hpm->used_counters);
+		iommu_hpm->events[idx + 1] = NULL;
+	}
+
+	perf_event_update_userpage(event);
+}
+
+/**
+ * riscv_iommu_hpm_event_init() - Initialize HPM event attributes
+ *
+ * @event: IOMMU performance event
+ *
+ * This function can be used to implement the .event_init() interface of
+ * pmu.
+ */
+static int riscv_iommu_hpm_event_init(struct perf_event *event)
+{
+	struct riscv_iommu_hpm *iommu_hpm = to_iommu_hpm(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event *sibling;
+	int group_num_events = 1;
+	u16 event_id;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+	if (hwc->sample_period)
+		return -EINVAL;
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	event_id = get_event(event);
+	if (event_id >= RISCV_IOMMU_HPMEVENT_MAX ||
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
+	event->cpu = iommu_hpm->on_cpu;
+	hwc->idx = -1;
+
+	return 0;
+}
+
+static ssize_t riscv_iommu_hpm_cpumask_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct riscv_iommu_hpm *iommu_hpm = to_iommu_hpm(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(iommu_hpm->on_cpu));
+}
+
+static struct device_attribute riscv_iommu_hpm_cpumask_attr =
+	__ATTR(cpumask, 0444, riscv_iommu_hpm_cpumask_show, NULL);
+
+static struct attribute *riscv_iommu_hpm_cpumask_attrs[] = {
+	&riscv_iommu_hpm_cpumask_attr.attr,
+	NULL
+};
+
+static const struct attribute_group riscv_iommu_hpm_cpumask_group = {
+	.attrs = riscv_iommu_hpm_cpumask_attrs,
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
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+static struct attribute *riscv_iommu_hpm_events[] = {
+	IOMMU_HPM_EVENT_ATTR(cycles, RISCV_IOMMU_HPMEVENT_CYCLES),
+	IOMMU_HPM_EVENT_ATTR(untrans_rq, RISCV_IOMMU_HPMEVENT_URQ),
+	IOMMU_HPM_EVENT_ATTR(trans_rq, RISCV_IOMMU_HPMEVENT_TRQ),
+	IOMMU_HPM_EVENT_ATTR(ats_rq, RISCV_IOMMU_HPMEVENT_ATS_RQ),
+	IOMMU_HPM_EVENT_ATTR(tlb_mis, RISCV_IOMMU_HPMEVENT_TLB_MISS),
+	IOMMU_HPM_EVENT_ATTR(dd_walk, RISCV_IOMMU_HPMEVENT_DD_WALK),
+	IOMMU_HPM_EVENT_ATTR(pd_walk, RISCV_IOMMU_HPMEVENT_PD_WALK),
+	IOMMU_HPM_EVENT_ATTR(s_walk, RISCV_IOMMU_HPMEVENT_S_VS_WALKS),
+	IOMMU_HPM_EVENT_ATTR(g_walk, RISCV_IOMMU_HPMEVENT_G_WALKS),
+	NULL
+};
+
+static umode_t riscv_iommu_hpm_event_is_visible(struct kobject *kobj,
+						struct attribute *attr,
+						int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct riscv_iommu_hpm *iommu_hpm = to_iommu_hpm(dev_get_drvdata(dev));
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
+	if (test_bit(pmu_attr->id, iommu_hpm->supported_events))
+		return attr->mode;
+
+	return 0;
+}
+
+static const struct attribute_group riscv_iommu_hpm_events_group = {
+	.name = "events",
+	.attrs = riscv_iommu_hpm_events,
+	.is_visible = riscv_iommu_hpm_event_is_visible,
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
+static struct attribute *riscv_iommu_hpm_formats[] = {
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
+static const struct attribute_group riscv_iommu_hpm_format_group = {
+	.name = "format",
+	.attrs = riscv_iommu_hpm_formats,
+};
+
+static const struct attribute_group *riscv_iommu_hpm_attr_grps[] = {
+	&riscv_iommu_hpm_cpumask_group,
+	&riscv_iommu_hpm_events_group,
+	&riscv_iommu_hpm_format_group,
+	NULL
+};
+
+static irqreturn_t riscv_iommu_hpm_handle_irq(int irq_num, void *data)
+{
+	struct riscv_iommu_hpm *iommu_hpm = data;
+	struct riscv_iommu_device *iommu = iommu_hpm->iommu;
+	struct perf_event *event;
+	u32 val;
+	int idx;
+	u32 ovf;
+	DECLARE_BITMAP(ovs, 32);
+
+	val = riscv_iommu_hpm_readl(iommu_hpm, RISCV_IOMMU_REG_IPSR);
+	if (!(val & RISCV_IOMMU_IPSR_PMIP))
+		return IRQ_NONE;
+
+	ovf = riscv_iommu_hpm_readl(iommu_hpm, RISCV_IOMMU_REG_IOCOUNTOVF);
+	if (!ovf)
+		return IRQ_HANDLED;
+
+	/* Handle cycles counter overflow (always stored at index 0) */
+	if (ovf & RISCV_IOMMU_IOCOUNTOVF_CY) {
+		event = iommu_hpm->events[0];
+		if (event && event->hw.idx == RISCV_IOMMU_HPMCOUNTER_CYCLES) {
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
+		if (idx == 0)
+			continue;
+
+		/* IOCOUNTOVF bit N corresponds to counter N-1, stored in
+		 * events[N]
+		 */
+		event = iommu_hpm->events[idx];
+		if (WARN_ON_ONCE(!event))
+			continue;
+
+		dev_dbg(iommu->dev, "counter overflow: hw_idx=%d, counter=%d\n",
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
+	iommu_hpm = hlist_entry_safe(node, struct riscv_iommu_hpm, node);
+	if (cpu != iommu_hpm->on_cpu)
+		return 0;
+
+	if (!iommu_hpm->irq)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&iommu_hpm->pmu, cpu, target);
+	iommu_hpm->on_cpu = target;
+	if (iommu_hpm->irq > 0)
+		WARN_ON(irq_set_affinity(iommu_hpm->irq, cpumask_of(target)));
+
+	return 0;
+}
+
+static void riscv_iommu_hpm_reset(struct riscv_iommu_hpm *iommu_hpm)
+{
+	u64 counter_present_mask = (1ULL << iommu_hpm->num_counters) - 1;
+
+	/* Disable all counters */
+	riscv_iommu_hpm_writel(iommu_hpm, RISCV_IOMMU_REG_IOCOUNTINH,
+			       counter_present_mask);
+	/* Clear interrupt pending status */
+	riscv_iommu_hpm_interrupt_clear(iommu_hpm);
+}
+
+static void riscv_iommu_hpm_set_standard_events(struct riscv_iommu_hpm *iommu_hpm)
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
+	struct riscv_iommu_hpm *iommu_hpm = data;
+
+	riscv_iommu_remove_hpm(iommu_hpm->iommu);
+}
+
+static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
+					 struct riscv_iommu_hpm *iommu_hpm,
+					 u32 offset, int irq,
+					 const struct attribute_group **attr_groups,
+					 const char *prefix)
+{
+	struct device *dev = iommu->dev;
+	const char *pmu_name;
+	u32 val;
+	int err;
+	int unique_id;
+	void __iomem *base;
+
+	unique_id = atomic_fetch_inc(&riscv_iommu_hpm_ids);
+	memset(iommu_hpm, 0, sizeof(*iommu_hpm));
+	iommu_hpm->iommu = iommu;
+
+	if (offset + RISCV_IOMMU_REG_SIZE <= iommu->reg_size)
+		base = iommu->reg + offset;
+	else
+		base = devm_ioremap(dev, iommu->reg_phys + offset,
+				    RISCV_IOMMU_REG_SIZE);
+	if (!base)
+		return -ENOMEM;
+
+	iommu_hpm->base = base;
+	bitmap_zero(iommu_hpm->used_counters, RISCV_IOMMU_HPMCOUNTER_MAX);
+	bitmap_zero(iommu_hpm->supported_events, RISCV_IOMMU_HPMEVENT_MAX);
+
+	riscv_iommu_hpm_writel(iommu_hpm,
+			       RISCV_IOMMU_REG_IOCOUNTINH, 0xFFFFFFFF);
+	val = riscv_iommu_hpm_readl(iommu_hpm,
+				    RISCV_IOMMU_REG_IOCOUNTINH);
+	iommu_hpm->num_counters = hweight32(val & RISCV_IOMMU_IOCOUNTINH_HPM);
+	if (!iommu_hpm->num_counters)
+		return -ENODEV;
+
+	iommu_hpm->on_cpu = raw_smp_processor_id();
+	iommu_hpm->irq = irq;
+
+	riscv_iommu_hpm_reset(iommu_hpm);
+
+	riscv_iommu_hpm_set_standard_events(iommu_hpm);
+	pmu_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%02x",
+				  prefix, (u8)unique_id);
+	if (!pmu_name)
+		return -ENOMEM;
+
+	err = devm_request_threaded_irq(dev, iommu_hpm->irq, NULL,
+					riscv_iommu_hpm_handle_irq,
+					IRQF_SHARED | IRQF_ONESHOT,
+					pmu_name, iommu_hpm);
+	if (err)
+		return err;
+	WARN_ON(irq_set_affinity(iommu_hpm->irq,
+				 cpumask_of(iommu_hpm->on_cpu)));
+
+	iommu_hpm->pmu = (struct pmu) {
+		.name = pmu_name,
+		.module = THIS_MODULE,
+		.parent = dev,
+		.task_ctx_nr = perf_invalid_context,
+		.event_init = riscv_iommu_hpm_event_init,
+		.add = riscv_iommu_hpm_event_add,
+		.del = riscv_iommu_hpm_event_del,
+		.start = riscv_iommu_hpm_event_start,
+		.stop = riscv_iommu_hpm_event_stop,
+		.read = riscv_iommu_hpm_event_update,
+		.attr_groups = attr_groups,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+	};
+
+	err = perf_pmu_register(&iommu_hpm->pmu, pmu_name, -1);
+	if (err)
+		goto err_exit;
+
+	dev_set_drvdata(iommu_hpm->pmu.dev, &iommu_hpm->pmu);
+
+	mutex_lock(&riscv_iommu_hpm_lock);
+	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
+					       &iommu_hpm->node);
+	if (err) {
+		mutex_unlock(&riscv_iommu_hpm_lock);
+		goto err_perf;
+	}
+	cpuhp_refcnt++;
+	mutex_unlock(&riscv_iommu_hpm_lock);
+
+	err = devm_add_action_or_reset(dev, riscv_iommu_hpm_remove,
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
+	int ret = 0;
+
+	mutex_lock(&riscv_iommu_hpm_lock);
+	if (cpuhp_state_num < 0) {
+		cpuhp_state_num = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+							  "perf/riscv/iommu:online",
+							  NULL,
+							  riscv_iommu_hpm_offline_cpu);
+		if (cpuhp_state_num < 0)
+			ret = -EINVAL;
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
+	cpuhp_state_num = -1;
+	mutex_unlock(&riscv_iommu_hpm_lock);
+}
+
+/**
+ * riscv_iommu_add_hpm() - Add HPM support for RISC-V IOMMU
+ *
+ * @iommu: IOMMU device instance
+ *
+ * This API can be invoked from RISC-V IOMMU driver to probe and
+ * initialize the feature of HPM support.
+ */
+int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
+{
+	struct device *dev = iommu->dev;
+	int irq, rc;
+
+	if (!FIELD_GET(RISCV_IOMMU_CAPABILITIES_HPM, iommu->caps)) {
+		dev_dbg(dev, "HPM: Not supported\n");
+		return 0;
+	}
+	irq = iommu->irqs[FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec)];
+	if (irq <= 0) {
+		dev_err(dev, "HPM: No IRQ available (vector=%llu)\n",
+			(unsigned long long)FIELD_GET(RISCV_IOMMU_ICVEC_PMIV,
+						      iommu->icvec));
+		return -EINVAL;
+	}
+
+	rc = riscv_iommu_hpm_init();
+	if (rc < 0)
+		return rc;
+
+	rc = riscv_iommu_hpm_register_unit(iommu, &iommu->hpm, 0, irq,
+					   riscv_iommu_hpm_attr_grps,
+					   "riscv_iommu_hpm");
+	if (rc < 0)
+		goto err_module;
+	return 0;
+
+err_module:
+	riscv_iommu_hpm_exit();
+	return rc;
+}
+
+/**
+ * riscv_iommu_remove_hpm() - Remove HPM support for RISC-V IOMMU.
+ *
+ * @iommu: IOMMU device instance
+ *
+ * This API can be invoked from RISC-V IOMMU driver to finalize the
+ * feature of HPM support.
+ */
+void riscv_iommu_remove_hpm(struct riscv_iommu_device *iommu)
+{
+	mutex_lock(&riscv_iommu_hpm_lock);
+	if (cpuhp_state_num >= 0) {
+		cpuhp_refcnt--;
+		cpuhp_state_remove_instance_nocalls(cpuhp_state_num,
+						    &iommu->hpm.node);
+	}
+	mutex_unlock(&riscv_iommu_hpm_lock);
+	perf_pmu_unregister(&iommu->hpm.pmu);
+	riscv_iommu_hpm_exit();
+}
diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
index d82d2b00904c..71407aecbf92 100644
--- a/drivers/iommu/riscv/iommu-pci.c
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -34,6 +34,8 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
 {
 	struct device *dev = &pdev->dev;
 	struct riscv_iommu_device *iommu;
+	phys_addr_t reg_phys;
+	resource_size_t reg_size;
 	int rc, vec;
 
 	rc = pcim_enable_device(pdev);
@@ -43,7 +45,9 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
 	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
 		return -ENODEV;
 
-	if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
+	reg_phys = pci_resource_start(pdev, 0);
+	reg_size = pci_resource_len(pdev, 0);
+	if (reg_size < RISCV_IOMMU_REG_SIZE)
 		return -ENODEV;
 
 	rc = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
@@ -56,6 +60,8 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
 
 	iommu->dev = dev;
 	iommu->reg = pcim_iomap_table(pdev)[0];
+	iommu->reg_phys = reg_phys;
+	iommu->reg_size = reg_size;
 
 	pci_set_master(pdev);
 	dev_set_drvdata(dev, iommu);
@@ -91,7 +97,10 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
 		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
 	}
 
-	return riscv_iommu_init(iommu);
+	rc = riscv_iommu_init(iommu);
+	if (rc)
+		return rc;
+	return riscv_iommu_add_hpm(iommu);
 }
 
 static void riscv_iommu_pci_remove(struct pci_dev *pdev)
diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 83a28c83f991..684bc267ac30 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -62,6 +62,9 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(iommu->reg),
 				     "could not map register region\n");
 
+	iommu->reg_phys = res->start;
+	iommu->reg_size = resource_size(res);
+
 	dev_set_drvdata(dev, iommu);
 
 	/* Check device reported capabilities / features. */
@@ -134,7 +137,10 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -ENODEV, "invalid IGS\n");
 	}
 
-	return riscv_iommu_init(iommu);
+	ret = riscv_iommu_init(iommu);
+	if (ret)
+		return ret;
+	return riscv_iommu_add_hpm(iommu);
 };
 
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
 
 #include "iommu-bits.h"
 
@@ -33,6 +34,29 @@ struct riscv_iommu_queue {
 	u8 qid;					/* queue identifier, same as RISCV_IOMMU_INTR_XX */
 };
 
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
 
 	/* hardware control register space */
 	void __iomem *reg;
+	phys_addr_t reg_phys;
+	resource_size_t reg_size;
 
 	/* supported and enabled hardware capabilities */
 	u64 caps;
@@ -60,12 +86,28 @@ struct riscv_iommu_device {
 	unsigned int ddt_mode;
 	dma_addr_t ddt_phys;
 	u64 *ddt_root;
+
+	struct riscv_iommu_hpm hpm;
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
+#ifdef CONFIG_RISCV_IOMMU_HPM
+int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu);
+void riscv_iommu_remove_hpm(struct riscv_iommu_device *iommu);
+#else
+static inline int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
+{
+	return -ENODEV;
+}
+
+static inline void riscv_iommu_remove_hpm(struct riscv_iommu_device *iommu)
+{
+}
+#endif
+
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
 
-- 
2.43.0

