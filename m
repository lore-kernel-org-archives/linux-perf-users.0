Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750B35E95A
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018215; cv=none; b=icmgLTrcSXyIB0ysoMiyguL8NSQ/2p83ldDbicEJtTyAiDN2NKhGOKC6VR3iobjoYVjE2akTB4Cd5fEvUS6gx6/Ti3REKkPynL4vt7/Ikr60pJPqpzOdw+LpIGjIkVE9BnZch55PJcSNZnDpHqWGKwBDwC470uiFkXWlV5XnQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018215; c=relaxed/simple;
	bh=GZFUxS4vOIz5VnZijVPSMbrC2DboRWOy/tvHY5doaVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5HEO73d6fX48IYKBCfeVQm5O/uI7exIzHOvoAcJQEn5JvfdGQX4dX8oRfvFw8QZ+wHA0w3ka/3lwqJNGbANFn0fN2/HZd/PiILJ3Sa2dZ3UZOY5hBTCy4qiKwiAfbXEap5DM8HJA1RY9DJL3oXpwvtBNHm5P/FnuFHb4g4gLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WWxI12wf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WWxI12wf"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca12086c06eso3408171a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784018190; x=1784622990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IYliHngKTm/r3WLIk/edipoinMTNFJKIe35ODQLWJEM=;
        b=WWxI12wfLurrZb/IwiKAHnQv4KaOw7OORGCbEs9xwWdCsF6gGVC4V2vvRt+gQKCbXC
         pHfy1c8blVlqqO/AUkq9g35dRbWSySwc3+bs8PYavGaoB/kwiYs4GpqQvoWe9GzuKatk
         ZWfs7PMr/Ul2Zmbn5JKefh+7kk+rJIXf3cJMtisd6MZAj77CnE+H5vSjO6g0xGGLlrUO
         8N6o1P0ScTVO80XV0sM23ivR8IvfIFb/sTit9QRRbT/5B3bWFkUzpr7jE9MzBCkHHW0Q
         JtbgAk8JKRDjZ5QFu4EumMxpHVsBOAM7LWjUaY6hitdyYySswrqlhE17Ne0+ESKofIbd
         wUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784018190; x=1784622990;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYliHngKTm/r3WLIk/edipoinMTNFJKIe35ODQLWJEM=;
        b=pCPfhZaeiGcOYP99tGvWIhgDQmq9Q0top9pOfkYZ27FkopjD6XpwvMTGK8aqTVrRVD
         FC/dnN5u+pbY1eTbK1XwQzFbJI+JkaBZ2nGQY7ZieAUFKALI44eGTuZZKjdk426rxJRe
         cErLqztcyjqiyOsNzX6Nfj5zX7G+T/klp1r7ZtwupFT2y8fwFVvpPEwvSjXwRZT1k45r
         dzeT4c3TmnXIdYH/yzSbveIP/a+LHP0ASA6+2kDb8AB9nNs4CSf0ZZFNEAd7Iw2c7Xgz
         k1PLBO2PRyFyPzlaePoGnJVOp1REHkiEvKTfwJU2z9/EK0+Uoa91NKN1IYQgHk2ZA+74
         b7Dg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1g1BnpMYtxK71U1erHocuo93Kd3lo23GB+Hd498AxvOdmnaWIufYfEsfN/CXs0UNkRkPvZsYPI1g569HgjgR9@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+hWepnqPfVl6pi0taHRVPTz5fKb8UEef/gwPluQCEqxxuPbe
	Dlf4VXe4vHPbuQ2FFes2Nppcs/MiVmSuJounCfx1FTPEa8iWmNR8E6akfC9K7abmdCU=
X-Gm-Gg: AfdE7ckn/1f4l/6iave2y9lZQy3vSpx+Y5zVoJgl3EzwGzwCJpMd0BIgbwgFqTmhrSb
	za9DVC4LWTYqevkFn3X39Z+kF2QQ3gqqbZBwaxTeVTzHf51P7MUXVOSz+xNPC0bjKku8gZToTIY
	SApkiG0BTEtYWor8tHeHnRF3CzyUOfs0N4zPwJIbhE4/GmGT3GtknH9Sgs6D/3w3zpOitvUIBjl
	xA4O01hkK9T5jxpx3ouqMshMYvumHSTx9oEitBn9BMAuVpsYO54Jh/yxeJl2BFefmZiPRO5VKkJ
	+hkX8+F9Sz75lfU2dS70p5lxPAi+95MFOnq/FUaznLv70WbcTxn4EykvJF6h/9b+KKcUgXt9bn1
	Hopo67vbWy3AKFbTjp+Ophk89vG4waIic2cte9EWBE2/wnFOhLDuJJvwNbtzrhPrvOJtpLCjzlA
	ngqeG1KZRWztdXLUhH+kq38jzI
X-Received: by 2002:a05:6a21:46c5:b0:3bf:b40b:def2 with SMTP id adf61e73a8af0-3c11003092dmr13139046637.9.1784018189981;
        Tue, 14 Jul 2026 01:36:29 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311950eb930sm55932938eec.8.2026.07.14.01.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:36:29 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu driver
Date: Tue, 14 Jul 2026 01:36:21 -0700
Message-ID: <20260714083625.1083606-2-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260714083625.1083606-1-zong.li@sifive.com>
References: <20260714083625.1083606-1-zong.li@sifive.com>
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

The RISC-V IOMMU PMU separates the cycle counter from the event counters.
The cycle counter is not associated with iohpmevt0, so a software-defined
cycle event is required for the perf subsystem.

The number and width of the counters are hardware-implemented and must
be detected at runtime.

The performance monitor provides counters with filtering support to
collect events for specific device ID/process ID, or GSCID/PSCID.

According to RISC-V IOMMU specification Chapter 6:
Whether an 8 byte access to an IOMMU register is single-copy atomic is
UNSPECIFIED. Use two separate 4 byte accesses for hardware
compatibility.

PMU-related definitions are moved into the perf driver, where they are
used exclusively.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Suggested-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu-bits.h |  61 ---
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 722 +++++++++++++++++++++++++++++++
 4 files changed, 735 insertions(+), 61 deletions(-)
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
index 000000000000..eb331d4633e1
--- /dev/null
+++ b/drivers/perf/riscv_iommu_pmu.c
@@ -0,0 +1,722 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 SiFive
+ *
+ * Authors
+ *	Zong Li <zong.li@sifive.com>
+ */
+
+#include <linux/auxiliary_bus.h>
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
+	unsigned int on_cpu;
+	unsigned int irq;
+	int num_counters;
+	u64 cycle_cntr_mask;
+	u64 event_cntr_mask;
+	struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
+	DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
+	u32 hi_prev[RISCV_IOMMU_HPM_COUNTER_NUM];
+	u32 lo_prev[RISCV_IOMMU_HPM_COUNTER_NUM];
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
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->on_cpu));
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
+ *   3. Check if low half wrapped or high half changed:
+ *      - If lo <= lo_prev: possible wraparound occurred
+ *      - If hi != hi_prev: high half changed during read
+ *   4. If wraparound detected, re-read high half and assume low half is 0
+ *   5. Update previous values for next read
+ */
+static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(idx);
+	u64 value, counter_mask = idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
+	u32 hi, lo;
+
+	hi = readl(addr + 4);
+	lo = readl(addr);
+
+	if (lo <= pmu->lo_prev[idx] || hi != pmu->hi_prev[idx]) {
+		u32 hi_tmp = readl(addr + 4);
+
+		/*
+		 * If hi changes, then hi+1:0 must have happened while
+		 * the code was running so it is a safe return value
+		 */
+		if (hi_tmp != hi) {
+			hi = hi_tmp;
+			lo = 0;
+		}
+		pmu->lo_prev[idx] = ~0u;
+		pmu->hi_prev[idx] = hi;
+	}
+	pmu->lo_prev[idx] = lo;
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
+	/* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
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
+static void riscv_iommu_pmu_clear_ovf(struct perf_event *event, u32 idx)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	u64 value;
+
+	/* Counter is disabled here, making it safe to read and write registers */
+	if (is_cycle_event(get_event(event))) {
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
+static void riscv_iommu_pmu_start_all(struct riscv_iommu_pmu *pmu)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
+	u32 used_cntr = 0;
+
+	/* The performance-monitoring counter inhibits is a 32-bit WARL register */
+	bitmap_to_arr32(&used_cntr, pmu->used_counters, pmu->num_counters);
+
+	writel(~used_cntr, addr);
+}
+
+static void riscv_iommu_pmu_stop_all(struct riscv_iommu_pmu *pmu)
+{
+	writel(GENMASK_ULL(pmu->num_counters - 1, 0),
+	       pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH);
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
+static int riscv_iommu_pmu_event_init(struct perf_event *event)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event *sibling;
+	int total_event_counters = pmu->num_counters - 1;
+	int counters = 0;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (hwc->sample_period)
+		return -EOPNOTSUPP;
+
+	if (event->cpu < 0)
+		return -EOPNOTSUPP;
+
+	event->cpu = pmu->on_cpu;
+
+	hwc->idx = -1;
+	hwc->config = event->attr.config;
+
+	if (event->group_leader == event)
+		return 0;
+
+	if (!is_cycle_event(get_event(event->group_leader)))
+		if (++counters > total_event_counters)
+			return -EINVAL;
+
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (is_cycle_event(get_event(sibling)) || is_software_event(sibling))
+			continue;
+
+		if (sibling->pmu != event->pmu)
+			return -EINVAL;
+
+		if (++counters > total_event_counters)
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
+	do {
+		prev = local64_read(&hwc->prev_count);
+		now = riscv_iommu_pmu_get_counter(pmu, idx);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
+
+	delta = (now - prev) & counter_mask;
+	local64_add(delta, &event->count);
+}
+
+static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
+	riscv_iommu_pmu_set_period(event);
+	riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
+	riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
+
+	perf_event_update_userpage(event);
+}
+
+static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	riscv_iommu_pmu_disable_counter(pmu, idx);
+
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE))
+		riscv_iommu_pmu_update(event);
+
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned int num_counters = pmu->num_counters;
+	int idx;
+
+	/* Reserve index zero for iohpmcycles */
+	if (is_cycle_event(get_event(event)))
+		idx = 0;
+	else
+		idx = find_next_zero_bit(pmu->used_counters, num_counters, 1);
+
+	/* All event counters or cycle counter are in use */
+	if (idx == num_counters || pmu->events[idx])
+		return -EAGAIN;
+
+	set_bit(idx, pmu->used_counters);
+
+	pmu->events[idx] = event;
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	local64_set(&hwc->prev_count, 0);
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
+	int idx = hwc->idx;
+
+	riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
+	pmu->events[idx] = NULL;
+	clear_bit(idx, pmu->used_counters);
+
+	perf_event_update_userpage(event);
+}
+
+static int riscv_iommu_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct riscv_iommu_pmu *iommu_pmu;
+
+	iommu_pmu = hlist_entry_safe(node, struct riscv_iommu_pmu, node);
+
+	if (iommu_pmu->on_cpu == -1)
+		iommu_pmu->on_cpu = cpu;
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
+	if (cpu != iommu_pmu->on_cpu)
+		return 0;
+
+	iommu_pmu->on_cpu = -1;
+
+	target_cpu = cpumask_any_but(cpu_online_mask, cpu);
+	if (target_cpu >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target_cpu);
+	iommu_pmu->on_cpu = target_cpu;
+	WARN_ON(irq_set_affinity(iommu_pmu->irq, cpumask_of(target_cpu)));
+
+	return 0;
+}
+
+static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
+{
+	struct riscv_iommu_pmu *pmu = (struct riscv_iommu_pmu *)dev_id;
+	DECLARE_BITMAP(ovf_bitmap, RISCV_IOMMU_HPM_COUNTER_NUM);
+	u32 ovf, idx;
+
+	/* Check whether this interrupt is for PMU */
+	if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR_PMIP))
+		return IRQ_NONE;
+
+	/* Process PMU IRQ */
+	riscv_iommu_pmu_stop_all(pmu);
+
+	ovf = readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
+	if (!ovf)
+		return IRQ_NONE;
+
+	bitmap_from_u64(ovf_bitmap, ovf);
+	for_each_set_bit(idx, ovf_bitmap, pmu->num_counters) {
+		struct perf_event *event = pmu->events[idx];
+
+		if (WARN_ON_ONCE(!event))
+			continue;
+
+		riscv_iommu_pmu_update(event);
+		riscv_iommu_pmu_set_period(event);
+		riscv_iommu_pmu_clear_ovf(event, idx);
+	}
+
+	/* Clear performance monitoring interrupt pending bit */
+	writel_relaxed(RISCV_IOMMU_IPSR_PMIP, pmu->reg + RISCV_IOMMU_REG_IPSR);
+
+	riscv_iommu_pmu_start_all(pmu);
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
+static int riscv_iommu_pmu_request_irq(struct riscv_iommu_device *iommu,
+				       struct riscv_iommu_pmu *pmu)
+{
+	return devm_request_irq(iommu->dev, pmu->irq, riscv_iommu_pmu_irq_handler,
+				IRQF_NOBALANCING | IRQF_SHARED, dev_name(iommu->dev), pmu);
+}
+
+static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
+				 const struct auxiliary_device_id *id)
+{
+	struct  riscv_iommu_device *iommu_dev = dev_get_platdata(&auxdev->dev);
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
+	/* Counter number and width are hardware-implemented. Detect them by write 1s */
+	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
+	writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
+	iommu_pmu->num_counters = hweight32(readl(addr));
+
+	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
+	riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
+	iommu_pmu->cycle_cntr_mask = riscv_iommu_pmu_readq(addr);
+
+	/* Assume the width of all event counters are the same */
+	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCTR_BASE;
+	riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
+	iommu_pmu->event_cntr_mask = riscv_iommu_pmu_readq(addr);
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
+			      "riscv_iommu_pmu_%s", dev_name(iommu_dev->dev));
+	if (!name) {
+		dev_err(&auxdev->dev, "Failed to create name riscv_iommu_pmu_%s\n",
+			dev_name(iommu_dev->dev));
+		return -ENOMEM;
+	}
+
+	/* Bind all events to the same cpu context to avoid race enabling */
+	iommu_pmu->on_cpu = raw_smp_processor_id();
+	iommu_pmu->irq = riscv_iommu_pmu_get_irq_num(iommu_dev);
+	WARN_ON(irq_set_affinity(iommu_pmu->irq, cpumask_of(iommu_pmu->on_cpu)));
+
+	ret = riscv_iommu_pmu_request_irq(iommu_dev, iommu_pmu);
+	if (ret) {
+		dev_err(&auxdev->dev, "Failed to request irq %s: %d\n", name, ret);
+		return ret;
+	}
+
+	ret = cpuhp_state_add_instance_nocalls(cpuhp_state, &iommu_pmu->node);
+	if (ret) {
+		dev_err(&auxdev->dev, "Failed to register hotplug %s: %d\n", name, ret);
+		return ret;
+	}
+
+	ret = perf_pmu_register(&iommu_pmu->pmu, name, -1);
+	if (ret) {
+		dev_err(&auxdev->dev, "Failed to registe %s: %d\n", name, ret);
+		goto err_unregister;
+	}
+
+	dev_info(&auxdev->dev, "%s: Registered with %d counters\n",
+		 name, iommu_pmu->num_counters);
+
+	return 0;
+
+err_unregister:
+	cpuhp_state_remove_instance_nocalls(cpuhp_state, &iommu_pmu->node);
+	return ret;
+}
+
+static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] = {
+	{ .name = "iommu.pmu" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
+
+static struct auxiliary_driver iommu_pmu_driver = {
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

