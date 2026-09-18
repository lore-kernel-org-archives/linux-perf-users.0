Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80B3F8ECA
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716040; cv=none; b=Gpv0BpnD1hjsp3zx4bxIcmOt2rpG4TQK6fPY3qascCeGITgSsc2Zw5eTiTN40OxaHckemDDaY0EcEQ47mLYgUtx+Mz9l9lpiiWL5M+Qp6SItdr+zDmPy5pHRP12kBW+PrrGxG14m+MswvotTqum6nCDd3ZEI9OZdLDE6vVUuv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716040; c=relaxed/simple;
	bh=UqPId6jb6l0sLDzO84vch+HicDBNM00yv6NG6uH2nI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fe1nQ3XFhHrDjX0rp4S74h4+yyH/AkMAJQwf5OtEYF1aMEW+AuZXGp8203DI0X6L0ZqMCHSR7Wvq1rJhV2M/5j6WoCWCzial1KZuKDgcH5Caag6l/yrKvzOKDkeva6VuMU7lbjhg5WGgeOac8hmGGy6E1OWpEeuoV5lUI54+xv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LmZpc0ud; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LmZpc0ud"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso388417a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 00:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789716037; x=1790320837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5morBbtErWa5otLcXt+JNOCo/wmVqxA0b2FZVi2wCzg=;
        b=LmZpc0udZj4vWIZPQwIG6JaqDGztgyLlu7ONRCgR2kqf4L2l0JmJLhAnTHusRiGvet
         zfZYzWvAtht/NK1CsxkZWusK41k+V09kiPTNBkkAFxSDpMPxD41dv2ucjUh/jDHfMJYa
         x5zZ5f35JBWEW1cNRuSylSoeLK+GmPgBdu2eFZlmITsurWccTmFukxaNIDdGcaaBKh8G
         JTglbFViiK8SOAKnYo/oidZ5dfnOIj5Z4YxRLssuqCfYY+T0T544BDrfQfh1+O3wcygI
         F5U2ac2Ql+tmFppYHWpHXD9hC2k/9g6L3AAZeLr0WFFGDltNmEzWzJjKuNsdw04D6ZSv
         n3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789716037; x=1790320837;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5morBbtErWa5otLcXt+JNOCo/wmVqxA0b2FZVi2wCzg=;
        b=LnhaFAhnR09pcpSrUBnoKbwPPorZTH6T2oWLBGk8BcdK9FzlVCjD1RK5DJaOFsj7dX
         adRIiAhqLFyGhKFUtvAfzuNRLCpiGUxPqsd0YguLMNxmhYwxagDAIvMmUlVUrRjrJqB0
         LbQGSDDAbGPYwmRzBqggZ/RBpzHU7d9sg8yicZJInFwr/YQMrjJvzGmrYJeVceUBW/TQ
         d83fEYJw4BsgiVwStKCZl7lteRnQgSoJWSJaHVCod8s3xb/MVo469yjF/NtULqa5keKG
         zPLZU4BIbO8thjOnQA8PtBjoEdqWcEADXLsBixNTUzJrOrBmnPcbm61UwcYSAfo7J1ch
         +SLg==
X-Forwarded-Encrypted: i=1; AKwUvBw6Z7NI8+ysB4RPbPZ5ERakvidkFuxODFo+Fmh6+d0//0xDy8Kg+vmTUKgaa6k5bXLTGCZnGlML5o/kiQHhlTPB@vger.kernel.org
X-Gm-Message-State: AFuF++kzhKYJoUjTJ44lFKoCR7J+tdpJHpJZCj+MDWqDXJCYwJ3K3Mfz
	l9OXEuLwv+vqBE+DwgBXoKi+KyeYaR6SPGKi3NPXTnLXwSjNKIZr58orCM7E+uJCP0g=
X-Gm-Gg: AYBFou2sBXlOoROTn/urObjME7uPFuzyIwWrGRo5yS6kI0JEsoa87hyd5p008Lq84E+
	sTl8SLF/SCXtxJRF1BVlxb/OBpQEtxtmWrV2MI9pEj5cWmkU+lSx+mnbJBsMXDYJ84BYRbg4dLE
	2BJTUpu4zAoYtpmhrwscNFLJMfMXyHZRUmf1NuOPXg8TqccYGykSutC6FiwrC3Rr2zcnYznCQaT
	KRrh10hOuESf4hsDjMkbfSx2CWvkkveCgc2aM1mnQUSlJZ+f++wqlfbodWEoim2gL7jthHgbwMD
	2vWkJxnY0pZSlntqeFG9j7X1K7DNpUbKxZMCvvAB1xEJk7LF9FG46SjqCrM4bWReuNpquZe/NLF
	pMybaWYTHU6ZWmyUsTFKgxCCz9LyFjYr7QRBbrFF7whGIsfv+W30o4D9fZlKYkkp2Gt/6GxkpmW
	J/H8XQXfVj074A+GzPHY6HapodCYaArF8JG6mNjedXaQ0RTZUDOgKX2XAsucRmEOgEIZfuW/hZD
	RI1B8xKYH8=
X-Received: by 2002:a17:90b:4484:b0:39d:f97c:bb2f with SMTP id 98e67ed59e1d1-39e54b66cf5mr3925957a91.3.1789716036866;
        Fri, 18 Sep 2026 00:20:36 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce03c682sm4416046c88.10.2026.09.18.00.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:20:36 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	andrew.jones@oss.qualcomm.com,
	guoren@kernel.org,
	david.laight.linux@gmail.com,
	zhangzhanpeng.jasper@bytedance.com,
	yang.yicong@picoheart.com,
	nutty.liu@hotmail.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v12 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu driver
Date: Fri, 18 Sep 2026 00:20:25 -0700
Message-ID: <20260918072027.639239-2-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260918072027.639239-1-zong.li@sifive.com>
References: <20260918072027.639239-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliary
device driver created by the parent RISC-V IOMMU driver.

The performance monitor provides counters with filtering support to
collect events for specific device ID/process ID, or GSCID/PSCID.

The RISC-V IOMMU PMU separates the cycle counter from the event counters.
The cycle counter is not associated with iohpmevt0, so a software-defined
cycle event is required for the perf subsystem.

The number and width of the counters are hardware-implemented and must
be detected at runtime.

Leave out all the dead cleanup code (i.e. .remove() operation) if the
PMU driver is tied to the IOMMU driver and can never realistically be
removed.

PMU-related definitions are moved into the perf driver, where they are
used exclusively.

According to RISC-V IOMMU specification Chapter 6:
Whether an 8 byte access to an IOMMU register is single-copy atomic is
UNSPECIFIED. Use two separate 4 byte accesses for hardware
compatibility.

Use raw spin lock to avoid CPU hotplug race and IRQCHIP_MOVE_DEFERRED

 - CPU hotplug race: serialises used_counters/events[]/IOCOUNTINH against
   riscv_iommu_pmu_offline_cpu()'s perf_pmu_migrate_context()
 - PCI MSI/MSI-X on IMSIC sets IRQCHIP_MOVE_DEFERRED, so
   irq_set_affinity() reports success while only recording the request
   and the move is applied later, in interrupt context. Until then the
   interrupt is still routed to the CPU the irqchip picked initially,
   which is not the CPU the events are bound to.

Tested-by: Chen Pei <cp0613@linux.alibaba.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Suggested-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu-bits.h |  61 --
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 994 +++++++++++++++++++++++++++++++
 4 files changed, 1007 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index f2ef9bd3cde9..6b5de913a032 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -192,67 +192,6 @@ enum riscv_iommu_ddtp_modes {
 #define RISCV_IOMMU_IPSR_PMIP		BIT(RISCV_IOMMU_INTR_PM)
 #define RISCV_IOMMU_IPSR_PIP		BIT(RISCV_IOMMU_INTR_PQ)
 
-/* 5.19 Performance monitoring counter overflow status (32bits) */
-#define RISCV_IOMMU_REG_IOCOUNTOVF	0x0058
-#define RISCV_IOMMU_IOCOUNTOVF_CY	BIT(0)
-#define RISCV_IOMMU_IOCOUNTOVF_HPM	GENMASK_ULL(31, 1)
-
-/* 5.20 Performance monitoring counter inhibits (32bits) */
-#define RISCV_IOMMU_REG_IOCOUNTINH	0x005C
-#define RISCV_IOMMU_IOCOUNTINH_CY	BIT(0)
-#define RISCV_IOMMU_IOCOUNTINH_HPM	GENMASK(31, 1)
-
-/* 5.21 Performance monitoring cycles counter (64bits) */
-#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
-#define RISCV_IOMMU_IOHPMCYCLES_COUNTER	GENMASK_ULL(62, 0)
-#define RISCV_IOMMU_IOHPMCYCLES_OF	BIT_ULL(63)
-
-/* 5.22 Performance monitoring event counters (31 * 64bits) */
-#define RISCV_IOMMU_REG_IOHPMCTR_BASE	0x0068
-#define RISCV_IOMMU_REG_IOHPMCTR(_n)	(RISCV_IOMMU_REG_IOHPMCTR_BASE + ((_n) * 0x8))
-
-/* 5.23 Performance monitoring event selectors (31 * 64bits) */
-#define RISCV_IOMMU_REG_IOHPMEVT_BASE	0x0160
-#define RISCV_IOMMU_REG_IOHPMEVT(_n)	(RISCV_IOMMU_REG_IOHPMEVT_BASE + ((_n) * 0x8))
-#define RISCV_IOMMU_IOHPMEVT_EVENTID	GENMASK_ULL(14, 0)
-#define RISCV_IOMMU_IOHPMEVT_DMASK	BIT_ULL(15)
-#define RISCV_IOMMU_IOHPMEVT_PID_PSCID	GENMASK_ULL(35, 16)
-#define RISCV_IOMMU_IOHPMEVT_DID_GSCID	GENMASK_ULL(59, 36)
-#define RISCV_IOMMU_IOHPMEVT_PV_PSCV	BIT_ULL(60)
-#define RISCV_IOMMU_IOHPMEVT_DV_GSCV	BIT_ULL(61)
-#define RISCV_IOMMU_IOHPMEVT_IDT	BIT_ULL(62)
-#define RISCV_IOMMU_IOHPMEVT_OF		BIT_ULL(63)
-
-/* Number of defined performance-monitoring event selectors */
-#define RISCV_IOMMU_IOHPMEVT_CNT	31
-
-/**
- * enum riscv_iommu_hpmevent_id - Performance-monitoring event identifier
- *
- * @RISCV_IOMMU_HPMEVENT_INVALID: Invalid event, do not count
- * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
- * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
- * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
- * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
- * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
- * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
- * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table walks
- * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walks
- * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
- */
-enum riscv_iommu_hpmevent_id {
-	RISCV_IOMMU_HPMEVENT_INVALID    = 0,
-	RISCV_IOMMU_HPMEVENT_URQ        = 1,
-	RISCV_IOMMU_HPMEVENT_TRQ        = 2,
-	RISCV_IOMMU_HPMEVENT_ATS_RQ     = 3,
-	RISCV_IOMMU_HPMEVENT_TLB_MISS   = 4,
-	RISCV_IOMMU_HPMEVENT_DD_WALK    = 5,
-	RISCV_IOMMU_HPMEVENT_PD_WALK    = 6,
-	RISCV_IOMMU_HPMEVENT_S_VS_WALKS = 7,
-	RISCV_IOMMU_HPMEVENT_G_WALKS    = 8,
-	RISCV_IOMMU_HPMEVENT_MAX        = 9
-};
-
 /* 5.24 Translation request IOVA (64bits) */
 #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
 #define RISCV_IOMMU_TR_REQ_IOVA_VPN	GENMASK_ULL(63, 12)
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 245e7bb763b9..8cce6c2ea626 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -105,6 +105,18 @@ config RISCV_PMU_SBI
 	  full perf feature support i.e. counter overflow, privilege mode
 	  filtering, counter configuration.
 
+config RISCV_IOMMU_PMU
+	depends on RISCV || COMPILE_TEST
+	depends on RISCV_IOMMU
+	bool "RISC-V IOMMU Hardware Performance Monitor"
+	default y
+	help
+	  Say Y if you want to use the RISC-V IOMMU performance monitor
+	  implementation. The performance monitor is an optional hardware
+	  feature, and whether it is actually enabled depends on IOMMU
+	  hardware support. If the underlying hardware does not implement
+	  the PMU, this option will have no effect.
+
 config STARFIVE_STARLINK_PMU
 	depends on ARCH_STARFIVE || COMPILE_TEST
 	depends on 64BIT
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index eb8a022dad9a..90c75f3c0ac1 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
+obj-$(CONFIG_RISCV_IOMMU_PMU) += riscv_iommu_pmu.o
 obj-$(CONFIG_STARFIVE_STARLINK_PMU) += starfive_starlink_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pmu.c
new file mode 100644
index 000000000000..ac4d225cca85
--- /dev/null
+++ b/drivers/perf/riscv_iommu_pmu.c
@@ -0,0 +1,994 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 SiFive
+ *
+ * Authors
+ *	Zong Li <zong.li@sifive.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/perf_event.h>
+
+#include "../iommu/riscv/iommu.h"
+
+/* 5.19 Performance monitoring counter overflow status (32bits) */
+#define RISCV_IOMMU_REG_IOCOUNTOVF	0x0058
+#define RISCV_IOMMU_IOCOUNTOVF_CY	BIT(0)
+#define RISCV_IOMMU_IOCOUNTOVF_HPM	GENMASK_ULL(31, 1)
+
+/* 5.20 Performance monitoring counter inhibits (32bits) */
+#define RISCV_IOMMU_REG_IOCOUNTINH	0x005C
+#define RISCV_IOMMU_IOCOUNTINH_CY	BIT(0)
+#define RISCV_IOMMU_IOCOUNTINH_HPM	GENMASK(31, 0)
+
+/* 5.21 Performance monitoring cycles counter (64bits) */
+#define RISCV_IOMMU_REG_IOHPMCYCLES	0x0060
+#define RISCV_IOMMU_IOHPMCYCLES_COUNTER	GENMASK_ULL(62, 0)
+#define RISCV_IOMMU_IOHPMCYCLES_OF	BIT_ULL(63)
+#define RISCV_IOMMU_REG_IOHPMCTR(_n)	(RISCV_IOMMU_REG_IOHPMCYCLES + ((_n) * 0x8))
+
+/* 5.22 Performance monitoring event counters (31 * 64bits) */
+#define RISCV_IOMMU_REG_IOHPMCTR_BASE	0x0068
+#define RISCV_IOMMU_IOHPMCTR_COUNTER	GENMASK_ULL(63, 0)
+
+/* 5.23 Performance monitoring event selectors (31 * 64bits) */
+#define RISCV_IOMMU_REG_IOHPMEVT_BASE	0x0160
+#define RISCV_IOMMU_REG_IOHPMEVT(_n)	(RISCV_IOMMU_REG_IOHPMEVT_BASE + ((_n) * 0x8))
+#define RISCV_IOMMU_IOHPMEVT_EVENTID	GENMASK_ULL(14, 0)
+#define RISCV_IOMMU_IOHPMEVT_DMASK	BIT_ULL(15)
+#define RISCV_IOMMU_IOHPMEVT_PID_PSCID	GENMASK_ULL(35, 16)
+#define RISCV_IOMMU_IOHPMEVT_DID_GSCID	GENMASK_ULL(59, 36)
+#define RISCV_IOMMU_IOHPMEVT_PV_PSCV	BIT_ULL(60)
+#define RISCV_IOMMU_IOHPMEVT_DV_GSCV	BIT_ULL(61)
+#define RISCV_IOMMU_IOHPMEVT_IDT	BIT_ULL(62)
+#define RISCV_IOMMU_IOHPMEVT_OF		BIT_ULL(63)
+#define RISCV_IOMMU_IOHPMEVT_EVENT	GENMASK_ULL(62, 0)
+
+/* The total number of counters is 31 event counters plus 1 cycle counter */
+#define RISCV_IOMMU_HPM_COUNTER_NUM	32
+
+/* Counter index 0 is the cycle counter, the event counters start at index 1 */
+#define RISCV_IOMMU_HPM_CYCLE_IDX	0
+
+static int cpuhp_state;
+
+/**
+ * enum riscv_iommu_hpmevent_id - Performance-monitoring event identifier
+ *
+ * @RISCV_IOMMU_HPMEVENT_CYCLE: Clock cycle counter
+ * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
+ * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
+ * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
+ * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
+ * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
+ * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
+ * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table walks
+ * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walks
+ * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
+ *
+ * The specification does not define an event ID for counting the
+ * number of clock cycles, meaning there is no associated 'iohpmevt0'.
+ * Event ID 0 is an invalid event and does not overlap with any valid
+ * event ID. Let's repurpose ID 0 as the cycle for perf, the cycle
+ * event is not actually written into any register, it serves solely
+ * as an identifier.
+ */
+enum riscv_iommu_hpmevent_id {
+	RISCV_IOMMU_HPMEVENT_CYCLE	= 0,
+	RISCV_IOMMU_HPMEVENT_URQ        = 1,
+	RISCV_IOMMU_HPMEVENT_TRQ        = 2,
+	RISCV_IOMMU_HPMEVENT_ATS_RQ     = 3,
+	RISCV_IOMMU_HPMEVENT_TLB_MISS   = 4,
+	RISCV_IOMMU_HPMEVENT_DD_WALK    = 5,
+	RISCV_IOMMU_HPMEVENT_PD_WALK    = 6,
+	RISCV_IOMMU_HPMEVENT_S_VS_WALKS = 7,
+	RISCV_IOMMU_HPMEVENT_G_WALKS    = 8,
+	RISCV_IOMMU_HPMEVENT_MAX        = 9
+};
+
+struct riscv_iommu_pmu {
+	struct pmu pmu;
+	struct hlist_node node;
+	void __iomem *reg;
+	int on_cpu;
+	unsigned int irq;
+	int numa_node;
+	unsigned int num_counters;
+	u64 cycle_cntr_mask;
+	u64 event_cntr_mask;
+	struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
+	DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
+	/*
+	 * Serialises used_counters/events[]/IOCOUNTINH for
+	 * CPU hotplug race and IRQCHIP_MOVE_DEFERRED (PCI MSI/MSI-X on IMSIC)
+	 */
+	raw_spinlock_t lock;
+};
+
+#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu, pmu))
+
+#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)			\
+	static inline u32 get_##_name(struct perf_event *event)		\
+	{								\
+		return FIELD_GET(_mask, event->attr.config);		\
+	}								\
+
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOHPMEVT_DMASK);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_PID_PSCID);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_DID_GSCID);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOHPMEVT_PV_PSCV);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOHPMEVT_DV_GSCV);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPMEVT_IDT);
+
+/* Formats */
+PMU_FORMAT_ATTR(event,            "config:0-14");
+PMU_FORMAT_ATTR(partial_matching, "config:15");
+PMU_FORMAT_ATTR(pid_pscid,        "config:16-35");
+PMU_FORMAT_ATTR(did_gscid,        "config:36-59");
+PMU_FORMAT_ATTR(filter_pid_pscid, "config:60");
+PMU_FORMAT_ATTR(filter_did_gscid, "config:61");
+PMU_FORMAT_ATTR(filter_id_type,   "config:62");
+
+static struct attribute *riscv_iommu_pmu_formats[] = {
+	&format_attr_event.attr,
+	&format_attr_partial_matching.attr,
+	&format_attr_pid_pscid.attr,
+	&format_attr_did_gscid.attr,
+	&format_attr_filter_pid_pscid.attr,
+	&format_attr_filter_did_gscid.attr,
+	&format_attr_filter_id_type.attr,
+	NULL,
+};
+
+static const struct attribute_group riscv_iommu_pmu_format_group = {
+	.name = "format",
+	.attrs = riscv_iommu_pmu_formats,
+};
+
+/* Events */
+static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define RISCV_IOMMU_PMU_EVENT_ATTR(name, id)			\
+	PMU_EVENT_ATTR_ID(name, riscv_iommu_pmu_event_show, id)
+
+static struct attribute *riscv_iommu_pmu_events[] = {
+	RISCV_IOMMU_PMU_EVENT_ATTR(cycle, RISCV_IOMMU_HPMEVENT_CYCLE),
+	RISCV_IOMMU_PMU_EVENT_ATTR(untranslated_req, RISCV_IOMMU_HPMEVENT_URQ),
+	RISCV_IOMMU_PMU_EVENT_ATTR(translated_req, RISCV_IOMMU_HPMEVENT_TRQ),
+	RISCV_IOMMU_PMU_EVENT_ATTR(ats_trans_req, RISCV_IOMMU_HPMEVENT_ATS_RQ),
+	RISCV_IOMMU_PMU_EVENT_ATTR(tlb_miss, RISCV_IOMMU_HPMEVENT_TLB_MISS),
+	RISCV_IOMMU_PMU_EVENT_ATTR(ddt_walks, RISCV_IOMMU_HPMEVENT_DD_WALK),
+	RISCV_IOMMU_PMU_EVENT_ATTR(pdt_walks, RISCV_IOMMU_HPMEVENT_PD_WALK),
+	RISCV_IOMMU_PMU_EVENT_ATTR(s_vs_pt_walks, RISCV_IOMMU_HPMEVENT_S_VS_WALKS),
+	RISCV_IOMMU_PMU_EVENT_ATTR(g_pt_walks, RISCV_IOMMU_HPMEVENT_G_WALKS),
+	NULL,
+};
+
+static const struct attribute_group riscv_iommu_pmu_events_group = {
+	.name = "events",
+	.attrs = riscv_iommu_pmu_events,
+};
+
+/* cpumask */
+static ssize_t riscv_iommu_cpumask_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(dev_get_drvdata(dev));
+	int on_cpu = pmu->on_cpu;
+
+	/*
+	 * riscv_iommu_pmu_offline_cpu() leaves on_cpu at -1 when it cannot
+	 * find another online CPU to migrate to. Report an empty mask rather
+	 * than feeding -1 to cpumask_of(), which indexes out of bounds.
+	 */
+	if (on_cpu < 0)
+		return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_none_mask));
+
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(on_cpu)));
+}
+
+static struct device_attribute riscv_iommu_cpumask_attr =
+	__ATTR(cpumask, 0444, riscv_iommu_cpumask_show, NULL);
+
+static struct attribute *riscv_iommu_cpumask_attrs[] = {
+	&riscv_iommu_cpumask_attr.attr,
+	NULL
+};
+
+static const struct attribute_group riscv_iommu_pmu_cpumask_group = {
+	.attrs = riscv_iommu_cpumask_attrs,
+};
+
+static const struct attribute_group *riscv_iommu_pmu_attr_grps[] = {
+	&riscv_iommu_pmu_cpumask_group,
+	&riscv_iommu_pmu_format_group,
+	&riscv_iommu_pmu_events_group,
+	NULL,
+};
+
+/*
+ * Register access wrapper
+ *
+ * According to RISC-V IOMMU specification Chapter 6:
+ * A 4 byte access to an IOMMU register must be single-copy atomic.
+ * Whether an 8 byte access to an IOMMU register is single-copy atomic is UNSPECIFIED
+ *
+ * Use two separate 4 byte accesses for hardware compatibility
+ */
+static u64 riscv_iommu_pmu_readq(void __iomem *addr)
+{
+	return hi_lo_readq(addr);
+}
+
+static void riscv_iommu_pmu_writeq(u64 value, void __iomem *addr)
+{
+	hi_lo_writeq(value, addr);
+}
+
+/* PMU Operations */
+static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu, u32 idx,
+					u64 value)
+{
+	u64 counter_mask = idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
+
+	riscv_iommu_pmu_writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(idx));
+}
+
+/*
+ * As stated in the RISC-V IOMMU Specification, Chapter 6:
+ * Whether an 8 byte access to an IOMMU register is single-copy atomic
+ * is UNSPECIFIED, and such an access may appear, internally to the
+ * IOMMU, as if two separate 4 byte accesses - first to the high half
+ * and second to the low half - were performed
+ *
+ * To make sure the driver works correctly on different hardware,
+ * the software will always use two 4-byte access for the counter.
+ *
+ * This function implements the hi-lo-hi pattern to detect and handle
+ * wraparound during the read operation:
+ *   1. Read high half (hi)
+ *   2. Read low half (lo)
+ *   3. Read high half again (hi_again)
+ *
+ * If both reads of the high half agree, then the low half did not carry
+ * into the high half in between, so the two halves belong together. If
+ * they differ, the low half wrapped during the read and the whole
+ * sequence is retried. A single re-read of the low half is not enough:
+ * if the caller (or a hypervisor running it) is preempted for long enough,
+ * the counter may wrap again before that re-read completes, pairing a
+ * stale high half with a low half from yet another wrap. Retrying the
+ * full hi/lo/hi sequence until two consecutive high-half reads agree
+ * converges on a consistent pair regardless of how long the preemption
+ * lasts.
+ */
+static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(idx);
+	u64 value, counter_mask = idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
+	u32 hi, lo, hi_again;
+
+	do {
+		hi = readl(addr + 4);
+		lo = readl(addr);
+		hi_again = readl(addr + 4);
+	} while (hi_again != hi);
+
+	value = (((u64)hi << 32) | lo) & counter_mask;
+
+	/* The bit 63 of cycle counter (i.e., idx == 0) is OF bit */
+	return idx ? value : (value & ~RISCV_IOMMU_IOHPMCYCLES_OF);
+}
+
+static bool is_cycle_event(u64 event)
+{
+	return FIELD_GET(RISCV_IOMMU_IOHPMEVT_EVENTID, event) ==
+	       RISCV_IOMMU_HPMEVENT_CYCLE;
+}
+
+static void riscv_iommu_pmu_set_event(struct riscv_iommu_pmu *pmu, u32 idx,
+				      u64 value)
+{
+	/* There is no associated IOHPMEVT0 for IOHPMCYCLES */
+	if (is_cycle_event(value))
+		return;
+
+	/* Event counter start from idx 1 */
+	riscv_iommu_pmu_writeq(FIELD_GET(RISCV_IOMMU_IOHPMEVT_EVENT, value),
+			       pmu->reg + RISCV_IOMMU_REG_IOHPMEVT(idx - 1));
+}
+
+static void riscv_iommu_pmu_enable_counter(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
+	u32 value = readl(addr);
+
+	writel(value & ~BIT(idx), addr);
+}
+
+static void riscv_iommu_pmu_disable_counter(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
+	u32 value = readl(addr);
+
+	writel(value | BIT(idx), addr);
+}
+
+static void riscv_iommu_pmu_clear_ovf(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	u64 value;
+
+	/* Counter is disabled here, making it safe to read and write registers */
+	if (idx == RISCV_IOMMU_HPM_CYCLE_IDX) {
+		value = riscv_iommu_pmu_readq(pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES) &
+					      ~RISCV_IOMMU_IOHPMCYCLES_OF;
+		riscv_iommu_pmu_writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES);
+	} else {
+		/* Event counter start from idx 1 */
+		value = riscv_iommu_pmu_readq(pmu->reg + RISCV_IOMMU_REG_IOHPMEVT(idx - 1)) &
+					      ~RISCV_IOMMU_IOHPMEVT_OF;
+		riscv_iommu_pmu_writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMEVT(idx - 1));
+	}
+}
+
+static void riscv_iommu_pmu_start_all(struct riscv_iommu_pmu *pmu, u32 inhibit)
+{
+	writel(inhibit, pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH);
+}
+
+/* Returns the inhibit state prior to stopping, so callers can restore it later */
+static u32 riscv_iommu_pmu_stop_all(struct riscv_iommu_pmu *pmu)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
+	u32 inhibit = readl(addr);
+
+	writel(GENMASK_U32(pmu->num_counters - 1, 0), addr);
+
+	return inhibit;
+}
+
+/* PMU APIs */
+static void riscv_iommu_pmu_set_period(struct perf_event *event)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 counter_mask = hwc->idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
+	u64 period;
+
+	/*
+	 * Limit the maximum period to prevent the counter value
+	 * from overtaking the one we are about to program.
+	 * In effect we are reducing max_period to account for
+	 * interrupt latency (and we are being very conservative).
+	 */
+	period = counter_mask >> 1;
+	riscv_iommu_pmu_set_counter(pmu, hwc->idx, period);
+	local64_set(&hwc->prev_count, period);
+}
+
+/*
+ * Tally @config against what the hardware implements: one cycle counter plus
+ * pmu->num_counters - 1 event counters. Returns false once the group would need
+ * more of either than exist, so that groups which could never be scheduled are
+ * rejected in ->event_init() instead of failing with -EAGAIN in ->add() forever.
+ */
+static bool riscv_iommu_pmu_claim_counter(struct riscv_iommu_pmu *pmu, u64 config,
+					  unsigned int *nr_cycles,
+					  unsigned int *nr_events)
+{
+	if (is_cycle_event(config))
+		return ++(*nr_cycles) <= 1;
+
+	return ++(*nr_events) <= pmu->num_counters - 1;
+}
+
+static int riscv_iommu_pmu_event_init(struct perf_event *event)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event *sibling;
+	unsigned int nr_cycles = 0;
+	unsigned int nr_events = 0;
+	int on_cpu;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event))
+		return -EOPNOTSUPP;
+
+	if (event->cpu < 0)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Reject event IDs this driver does not know about. Programming one
+	 * into IOHPMEVT would be accepted by the hardware but would never
+	 * count anything, which is indistinguishable from an idle counter.
+	 */
+	if (get_event(event) >= RISCV_IOMMU_HPMEVENT_MAX)
+		return -EINVAL;
+
+	/*
+	 * There is no IOHPMEVT register associated with IOHPMCYCLES, so none
+	 * of the filtering fields can be programmed for the cycle event.
+	 * Reject them here instead of counting unfiltered cycles behind the
+	 * user's back.
+	 */
+	if (is_cycle_event(event->attr.config) &&
+	    (event->attr.config & ~RISCV_IOMMU_IOHPMEVT_EVENTID))
+		return -EINVAL;
+
+	/*
+	 * All events are bound to the CPU the interrupt is affine to. That
+	 * CPU is unset while no online CPU could be found for this PMU, and
+	 * assigning -1 here would turn this into a task bound event, which is
+	 * not something this PMU can serve.
+	 */
+	on_cpu = pmu->on_cpu;
+	if (on_cpu < 0)
+		return -ENODEV;
+
+	event->cpu = on_cpu;
+
+	hwc->idx = -1;
+	hwc->config = event->attr.config;
+
+	/*
+	 * Account for this event itself first. It has to be done before the
+	 * check below, otherwise an event which is on its own would never be
+	 * matched against the number of counters the hardware implements.
+	 */
+	if (!riscv_iommu_pmu_claim_counter(pmu, event->attr.config,
+					   &nr_cycles, &nr_events))
+		return -EINVAL;
+
+	/* On its own, so there is no group to validate */
+	if (event->group_leader == event)
+		return 0;
+
+	/*
+	 * Software events never occupy a hardware counter, so they do not have
+	 * to sit on this pmu and do not consume any of its budget. Anything
+	 * else in the group does, starting with the leader.
+	 */
+	if (!is_software_event(event->group_leader)) {
+		/* A hardware leader has to share this pmu's counters */
+		if (event->group_leader->pmu != event->pmu)
+			return -EINVAL;
+
+		if (!riscv_iommu_pmu_claim_counter(pmu,
+						   event->group_leader->attr.config,
+						   &nr_cycles, &nr_events))
+			return -EINVAL;
+	}
+
+	/*
+	 * Then the rest of the group. This walks group_leader->sibling_list,
+	 * which does not contain the event being initialised yet - hence
+	 * accounting for it separately above.
+	 */
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (is_software_event(sibling))
+			continue;
+
+		if (sibling->pmu != event->pmu)
+			return -EINVAL;
+
+		if (!riscv_iommu_pmu_claim_counter(pmu, sibling->attr.config,
+						   &nr_cycles, &nr_events))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void riscv_iommu_pmu_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	u64 delta, prev, now;
+	u32 idx = hwc->idx;
+	u64 counter_mask = idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
+
+	/*
+	 * riscv_iommu_pmu_set_period() resets the hardware counter and
+	 * prev_count as two separate writes.
+	 * Pairing a "prev" read from before that reset with a "now" read from
+	 * after it would produce a nonsensical, possibly huge, delta.
+	 * Re-checking prev_count after the hardware read detects that torn
+	 * pairing and retries.
+	 */
+	do {
+		prev = local64_read(&hwc->prev_count);
+		now = riscv_iommu_pmu_get_counter(pmu, idx);
+	} while (prev != local64_read(&hwc->prev_count) ||
+		 local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
+
+	delta = (now - prev) & counter_mask;
+	local64_add(delta, &event->count);
+}
+
+static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long irqflags;
+
+	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
+
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
+	hwc->state = 0;
+	riscv_iommu_pmu_set_period(event);
+	riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
+	riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
+
+	perf_event_update_userpage(event);
+}
+
+static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long irqflags;
+	int idx = hwc->idx;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
+	riscv_iommu_pmu_disable_counter(pmu, idx);
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE))
+		riscv_iommu_pmu_update(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
+}
+
+static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned int num_counters = pmu->num_counters;
+	unsigned long irqflags;
+	unsigned int idx;
+
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
+
+	/* Reserve index zero for iohpmcycles */
+	if (is_cycle_event(event->attr.config))
+		idx = RISCV_IOMMU_HPM_CYCLE_IDX;
+	else
+		idx = find_next_zero_bit(pmu->used_counters, num_counters, 1);
+
+	/* All event counters or cycle counter are in use */
+	if (idx == num_counters || pmu->events[idx]) {
+		raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
+		return -EAGAIN;
+	}
+
+	set_bit(idx, pmu->used_counters);
+
+	pmu->events[idx] = event;
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	local64_set(&hwc->prev_count, 0);
+
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
+
+	if (flags & PERF_EF_START)
+		riscv_iommu_pmu_start(event, flags);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void riscv_iommu_pmu_read(struct perf_event *event)
+{
+	riscv_iommu_pmu_update(event);
+}
+
+static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long irqflags;
+	int idx = hwc->idx;
+
+	riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
+
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
+	pmu->events[idx] = NULL;
+	clear_bit(idx, pmu->used_counters);
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
+
+	perf_event_update_userpage(event);
+}
+
+/*
+ * Pick the CPU perf assigns these events to: riscv_iommu_pmu_event_init()
+ * sets event->cpu to pmu->on_cpu, and perf_pmu_migrate_context() moves
+ * already-installed events to a new on_cpu when this changes. This has no
+ * bearing on which CPU riscv_iommu_pmu_irq_handler() itself runs on -
+ * pmu->lock serialises the two regardless of that, rather than requiring
+ * them to run on the same CPU. Only consider CPUs which the irqchip
+ * actually accepts - committing on_cpu to a CPU which irq_set_affinity()
+ * then rejects would leave events bound to a CPU whose interrupt the
+ * irqchip refuses to deliver.
+ *
+ * cpumask_local_spread() walks the online CPUs in order of NUMA distance from
+ * the iommu, so the closest usable one wins.
+ *
+ * Returns the chosen CPU, or nr_cpu_ids if none could be used.
+ */
+static unsigned int riscv_iommu_pmu_bind_cpu(struct riscv_iommu_pmu *pmu,
+					     unsigned int skip_cpu)
+{
+	unsigned int cpu, i;
+
+	for (i = 0; i < num_online_cpus(); i++) {
+		cpu = cpumask_local_spread(i, pmu->numa_node);
+		if (cpu == skip_cpu)
+			continue;
+		if (!irq_set_affinity(pmu->irq, cpumask_of(cpu)))
+			return cpu;
+	}
+
+	return nr_cpu_ids;
+}
+
+static int riscv_iommu_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct riscv_iommu_pmu *iommu_pmu;
+	unsigned int target_cpu;
+
+	iommu_pmu = hlist_entry_safe(node, struct riscv_iommu_pmu, node);
+
+	if (READ_ONCE(iommu_pmu->on_cpu) != -1)
+		return 0;
+
+	target_cpu = riscv_iommu_pmu_bind_cpu(iommu_pmu, nr_cpu_ids);
+	if (target_cpu >= nr_cpu_ids) {
+		/* on_cpu stays unset, so a later callback tries again */
+		pr_debug("failed to point irq %u at any online cpu\n",
+			 iommu_pmu->irq);
+		return 0;
+	}
+
+	WRITE_ONCE(iommu_pmu->on_cpu, target_cpu);
+
+	return 0;
+}
+
+static int riscv_iommu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct riscv_iommu_pmu *iommu_pmu;
+	unsigned int target_cpu;
+
+	iommu_pmu = hlist_entry_safe(node, struct riscv_iommu_pmu, node);
+
+	if (READ_ONCE(iommu_pmu->on_cpu) != (int)cpu)
+		return 0;
+
+	/*
+	 * The last online CPU cannot be taken offline, and this callback runs
+	 * before __cpu_disable() clears the outgoing CPU from cpu_online_mask,
+	 * so there is always another online CPU to move to.
+	 *
+	 * Should that ever fail, unset on_cpu rather than leaving it pointing at
+	 * the CPU which is going away. That keeps events from being bound to a
+	 * dead CPU and lets riscv_iommu_pmu_online_cpu() pick again once a CPU
+	 * comes back.
+	 */
+	target_cpu = riscv_iommu_pmu_bind_cpu(iommu_pmu, cpu);
+	if (WARN_ON_ONCE(target_cpu >= nr_cpu_ids)) {
+		WRITE_ONCE(iommu_pmu->on_cpu, -1);
+	} else {
+		WRITE_ONCE(iommu_pmu->on_cpu, target_cpu);
+		/*
+		 * perf_pmu_migrate_context() runs ->del() on cpu and ->add()
+		 * on target_cpu with a synchronize_rcu() gap in between.
+		 * riscv_iommu_pmu_irq_handler() can run concurrently with
+		 * either step, on whichever CPU the interrupt physically
+		 * lands on - pmu->lock serialises it against them instead of
+		 * racing.
+		 */
+		perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target_cpu);
+	}
+
+	return 0;
+}
+
+/*
+ * pmu->lock serialises this against ->add()/->del()/->start()/->stop(),
+ * which can run on a different CPU than this while
+ * riscv_iommu_pmu_offline_cpu() is migrating events across a
+ * perf_pmu_migrate_context() call.
+ */
+static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
+{
+	struct riscv_iommu_pmu *pmu = (struct riscv_iommu_pmu *)dev_id;
+	DECLARE_BITMAP(ovf_bitmap, BITS_PER_TYPE(u64));
+	unsigned long irqflags;
+	u32 ovf, idx, inhibit;
+
+	/* Check whether this interrupt is for PMU */
+	if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR_PMIP))
+		return IRQ_NONE;
+
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
+
+	inhibit = riscv_iommu_pmu_stop_all(pmu);
+
+	ovf = readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
+	if (ovf) {
+		bitmap_from_u64(ovf_bitmap, ovf);
+		for_each_set_bit(idx, ovf_bitmap, pmu->num_counters) {
+			struct perf_event *event = pmu->events[idx];
+
+			/*
+			 * pmu->events[idx] only means the counter is allocated,
+			 * not that it is counting. A counter which has not been
+			 * started has no valid prev_count to compute a delta
+			 * against, and one which has been stopped must not be
+			 * reprogrammed here. The overflow bit still has to be
+			 * cleared below in either case, including when the event
+			 * was already removed by riscv_iommu_pmu_del(),
+			 * otherwise the interrupt would stay pending forever.
+			 */
+			if (event && !(event->hw.state & PERF_HES_STOPPED)) {
+				riscv_iommu_pmu_update(event);
+				riscv_iommu_pmu_set_period(event);
+			}
+
+			riscv_iommu_pmu_clear_ovf(pmu, idx);
+		}
+	}
+
+	/* Clear performance monitoring interrupt pending bit */
+	writel_relaxed(RISCV_IOMMU_IPSR_PMIP, pmu->reg + RISCV_IOMMU_REG_IPSR);
+
+	riscv_iommu_pmu_start_all(pmu, inhibit);
+
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
+
+	return IRQ_HANDLED;
+}
+
+static unsigned int riscv_iommu_pmu_get_irq_num(struct riscv_iommu_device *iommu)
+{
+	/* Reuse ICVEC.CIV mask for all interrupt vectors mapping */
+	int vec = (iommu->icvec >> (RISCV_IOMMU_INTR_PM * 4)) & RISCV_IOMMU_ICVEC_CIV;
+
+	return iommu->irqs[vec];
+}
+
+static int riscv_iommu_pmu_request_irq(struct auxiliary_device *auxdev,
+				       struct riscv_iommu_device *iommu,
+				       struct riscv_iommu_pmu *pmu)
+{
+	/*
+	 * Bind the handler to the auxiliary device, which is the same devres
+	 * scope that frees @pmu. Requesting it on the parent iommu device
+	 * would keep the handler registered with a dangling dev_id once @pmu
+	 * is freed, either on a later probe failure or on device removal.
+	 *
+	 * IRQF_SHARED is required because ICVEC maps the performance
+	 * monitoring source onto one of the vectors the iommu driver already
+	 * requested for its queues whenever fewer than RISCV_IOMMU_INTR_COUNT
+	 * vectors are available. Both requesters have to agree on sharing, or
+	 * this one is rejected with -EBUSY. IRQF_ONESHOT does not have to be
+	 * matched by hand: devm_request_irq() adds IRQF_COND_ONESHOT, so this
+	 * handler adopts whatever the first requester picked.
+	 */
+	return devm_request_irq(&auxdev->dev, pmu->irq, riscv_iommu_pmu_irq_handler,
+				IRQF_SHARED | IRQF_NOBALANCING,
+				dev_name(iommu->dev), pmu);
+}
+
+static void riscv_iommu_pmu_remove_cpuhp_instance(void *data)
+{
+	struct riscv_iommu_pmu *pmu = data;
+
+	cpuhp_state_remove_instance_nocalls(cpuhp_state, &pmu->node);
+}
+
+static void riscv_iommu_pmu_do_unregister(void *data)
+{
+	struct riscv_iommu_pmu *pmu = data;
+
+	perf_pmu_unregister(&pmu->pmu);
+}
+
+static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
+				 const struct auxiliary_device_id *id)
+{
+	struct riscv_iommu_device *iommu_dev = dev_get_platdata(&auxdev->dev);
+	struct riscv_iommu_pmu *iommu_pmu;
+	void __iomem *addr;
+	char *name;
+	int ret;
+
+	iommu_pmu = devm_kzalloc(&auxdev->dev, sizeof(*iommu_pmu), GFP_KERNEL);
+	if (!iommu_pmu)
+		return -ENOMEM;
+
+	iommu_pmu->reg = iommu_dev->reg;
+
+	raw_spin_lock_init(&iommu_pmu->lock);
+
+	/*
+	 * Counter number and width are hardware-implemented, detect them by
+	 * writing 1s and reading back which bits stuck.
+	 *
+	 * The specification requires a minimum of one programmable event
+	 * counter besides the cycles counter when capabilities.HPM is 1,
+	 * which is the condition under which this device is created. So a
+	 * compliant implementation always reports at least two counters, and
+	 * both IOHPMCYCLES and the first IOHPMCTR are always present. A
+	 * readback which says otherwise is non-compliant hardware and is
+	 * rejected rather than worked around.
+	 *
+	 * The implemented counters are assumed to be consecutive, so that
+	 * hweight32() of the IOCOUNTINH readback can be used as the bound on
+	 * valid counter indices.
+	 *
+	 * The counter masks are also assumed to be a contiguous run of bits
+	 * starting at bit 0, which is what riscv_iommu_pmu_update() relies on
+	 * when it masks the difference of two samples to handle wraparound.
+	 */
+	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
+	writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
+	iommu_pmu->num_counters = hweight32(readl(addr));
+	if (iommu_pmu->num_counters < 2) {
+		dev_err(&auxdev->dev, "hardware reports %u counter(s)\n",
+			iommu_pmu->num_counters);
+		return -ENODEV;
+	}
+
+	/* Bit 63 of IOHPMCYCLES is the OF bit, not part of the counter */
+	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
+	riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
+	iommu_pmu->cycle_cntr_mask = riscv_iommu_pmu_readq(addr) &
+				     RISCV_IOMMU_IOHPMCYCLES_COUNTER;
+	if (!iommu_pmu->cycle_cntr_mask) {
+		dev_err(&auxdev->dev, "cycles counter is not implemented\n");
+		return -ENODEV;
+	}
+
+	/* Assume the width of all event counters are the same */
+	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCTR_BASE;
+	riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
+	iommu_pmu->event_cntr_mask = riscv_iommu_pmu_readq(addr);
+	if (!iommu_pmu->event_cntr_mask) {
+		dev_err(&auxdev->dev, "event counter is not implemented\n");
+		return -ENODEV;
+	}
+
+	iommu_pmu->pmu = (struct pmu) {
+		.module		= THIS_MODULE,
+		.parent		= &auxdev->dev,
+		.task_ctx_nr	= perf_invalid_context,
+		.event_init	= riscv_iommu_pmu_event_init,
+		.add		= riscv_iommu_pmu_add,
+		.del		= riscv_iommu_pmu_del,
+		.start		= riscv_iommu_pmu_start,
+		.stop		= riscv_iommu_pmu_stop,
+		.read		= riscv_iommu_pmu_read,
+		.attr_groups	= riscv_iommu_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	};
+
+	auxiliary_set_drvdata(auxdev, iommu_pmu);
+
+	name = devm_kasprintf(&auxdev->dev, GFP_KERNEL,
+			      "riscv_iommu_pmu_%u", auxdev->id);
+	if (!name) {
+		dev_err(&auxdev->dev, "Failed to create name riscv_iommu_pmu_%u\n",
+			auxdev->id);
+		return -ENOMEM;
+	}
+
+	iommu_pmu->numa_node = dev_to_node(iommu_dev->dev);
+	iommu_pmu->irq = riscv_iommu_pmu_get_irq_num(iommu_dev);
+
+	ret = riscv_iommu_pmu_request_irq(auxdev, iommu_dev, iommu_pmu);
+	if (ret) {
+		dev_err(&auxdev->dev, "Failed to request irq %s: %d\n", name, ret);
+		return ret;
+	}
+
+	/*
+	 * Bind all events to the same cpu context to avoid race enabling.
+	 * riscv_iommu_pmu_online_cpu() picks the CPU and sets the irq
+	 * affinity for us once the instance is registered below.
+	 */
+	iommu_pmu->on_cpu = -1;
+
+	ret = cpuhp_state_add_instance(cpuhp_state, &iommu_pmu->node);
+	if (ret) {
+		dev_err(&auxdev->dev, "Failed to register hotplug %s: %d\n", name, ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&auxdev->dev,
+				       riscv_iommu_pmu_remove_cpuhp_instance,
+				       iommu_pmu);
+	if (ret)
+		return ret;
+
+	ret = perf_pmu_register(&iommu_pmu->pmu, name, -1);
+	if (ret) {
+		dev_err(&auxdev->dev, "Failed to register %s: %d\n", name, ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&auxdev->dev,
+				       riscv_iommu_pmu_do_unregister,
+				       iommu_pmu);
+	if (ret)
+		return ret;
+
+	/*
+	 * The PMU name only carries the aux dev id, not the iommu dev name, so
+	 * find the iommu dev name here to map this PMU back to its iommu dev.
+	 */
+	dev_info(&auxdev->dev, "%s: Registered with %u counters (iommu %s)\n",
+		 name, iommu_pmu->num_counters, dev_name(iommu_dev->dev));
+
+	return 0;
+}
+
+static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] = {
+	{ .name = "riscv-iommu.pmu" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
+
+static struct auxiliary_driver iommu_pmu_driver = {
+	.driver = {
+		.suppress_bind_attrs = true,
+	},
+	.probe		= riscv_iommu_pmu_probe,
+	.id_table	= riscv_iommu_pmu_id_table,
+};
+
+static int __init riscv_iommu_pmu_init(void)
+{
+	int ret;
+
+	cpuhp_state = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+					      "perf/riscv/iommu:online",
+					      riscv_iommu_pmu_online_cpu,
+					      riscv_iommu_pmu_offline_cpu);
+	if (cpuhp_state < 0)
+		return cpuhp_state;
+
+	ret = auxiliary_driver_register(&iommu_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(cpuhp_state);
+
+	return ret;
+}
+module_init(riscv_iommu_pmu_init);
+
+MODULE_DESCRIPTION("RISC-V IOMMU PMU");
+MODULE_LICENSE("GPL");
-- 
2.43.7

