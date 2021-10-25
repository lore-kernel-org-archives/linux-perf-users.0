Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82C5C43219
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 19:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B108660C4B
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 19:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhJYUCT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:02:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9211 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhJYUAQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 16:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635191874; x=1666727874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zy2WWD3zNoMKMhlq1EblY2ePvkK4uzHr+UUi+KjrBGo=;
  b=YuSORXG2QcbrL8+UAMe7S5vh/+skA9T6Ch/yXM5bMDMqImFJIDPbvsHL
   TArZDdBHcTcxAU3lpeGxPQtbMCQ+9NSS3pjYL+Kih1k2HNlXkHqYogmUS
   GqXS+CUe/YgSyvHm3yBJHY75v1o7i84BIX6CIDlCu8iJhO/ibsIob07zY
   ANigtwEaxDx99EEXViPdRkGIQg+DA1hDpocd/faxRlDbCkYAu+2+cuf/5
   uoHQYqZkbdx22wl+8TnAJnq2CcCPV1yxhxeS57M7rdzqvXnWZdRWO3hH/
   EpzxMYhyMgPkLqfQyvcLDaZfmTy1ryNYAp+yEvvc7xjnIVzuMtq27GOlz
   w==;
X-IronPort-AV: E=Sophos;i="5.87,181,1631548800"; 
   d="scan'208";a="295545858"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2021 03:53:58 +0800
IronPort-SDR: nSJ7UQARKTNi6qw+arq9vVjHSNDhnO4IWusWPfwHDUVx3fDDZhf7JdGpizOw1KUECFiiRvSztt
 3J0yNKnUlq/KJUYUM6/pjCcuD9YsMP0RgY/Z6KnWjcK5bxAx8QA9FpuCkYt1IkOjOjF8n/THrI
 wQRVm2q3rBqLaz/5o++/ePEhWkA6l4KEpQiqAhs+xK4SnUgM5DDqmHFannSVGTTxtZJUciM/GW
 JpI3PCDZ/LE9r7rTaMU88v2tmOM4VQQ1QekzAXYmoeKQP0GZ20I4aR0pRKFOodX70Lrk69AdFb
 N4FPTo8nAlOUDFIxcDYU5LxL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:27:56 -0700
IronPort-SDR: FgWSGi+QqMi/M5HvsDkSKNgoZWQA1QkuhjmLvtS8fi00ccAI1jRsKqLJZsEEH936GwR1vP4NLS
 xVZ5iPEHWa2jiM0KUeor43in66XzcXsGkRksT6YJyLu1swyNwQu9hiivOQEjFiXSCcdIDRYYjk
 jgsMzEHW2iDMp3gU7eIsmqDsN7AqZN6BTqH/aDz/YjRcU1nvdj//R8jA7T+pUpA/qzFLQPjZT/
 7XFSnt447f9xK3vhP+McXhM/lAV96X72jT2svBm402HyiFQMWxUMs8fYKdafflb/W0bDi+JddX
 auo=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.27])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2021 12:53:58 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [v4 07/11] RISC-V: Add perf platform driver based on SBI PMU extension
Date:   Mon, 25 Oct 2021 12:53:46 -0700
Message-Id: <20211025195350.242914-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025195350.242914-1-atish.patra@wdc.com>
References: <20211025195350.242914-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

RISC-V SBI specification added a PMU extension that allows to configure
/start/stop any pmu counter. The RISC-V perf can use most of the generic
perf features except interrupt overflow and event filtering based on
privilege mode which will be added in future.

It also allows to monitor a handful of firmware counters that can provide
insights into firmware activity during a performance analysis.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/perf/Kconfig         |   8 +
 drivers/perf/Makefile        |   1 +
 drivers/perf/riscv_pmu.c     |   2 +
 drivers/perf/riscv_pmu_sbi.c | 553 +++++++++++++++++++++++++++++++++++
 4 files changed, 564 insertions(+)
 create mode 100644 drivers/perf/riscv_pmu_sbi.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 1546a487d970..4e030ba6e7f5 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -73,6 +73,14 @@ config RISCV_PMU_LEGACY
 	  implementation on RISC-V based systems. This only allows counting
 	  of cycle/instruction counter and will be removed in future.
 
+config RISCV_PMU_SBI
+	depends on RISCV_PMU && RISCV_SBI
+	bool "RISC-V PMU based on SBI PMU extension"
+	default y
+	help
+	  Say y if you want to use the CPU performance monitor
+	  using SBI PMU extension on RISC-V based systems.
+
 config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index e8aa666a9d28..7bcac4b5a983 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
 ifeq ($(CONFIG_RISCV_PMU), y)
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
+obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
 endif
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 9c4ebcabca6e..0c853e23f679 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -15,6 +15,8 @@
 #include <linux/printk.h>
 #include <linux/smp.h>
 
+#include <asm/sbi.h>
+
 static unsigned long csr_read_num(int csr_num)
 {
 #define switchcase_csr_read(__csr_num, __val)		{\
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
new file mode 100644
index 000000000000..7a274aeff51e
--- /dev/null
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -0,0 +1,553 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V performance counter support.
+ *
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ *
+ * This code is based on ARM perf event code which is in turn based on
+ * sparc64 and x86 code.
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/perf/riscv_pmu.h>
+#include <linux/platform_device.h>
+
+#include <asm/sbi.h>
+
+union sbi_pmu_ctr_info {
+	unsigned long value;
+	struct {
+		unsigned long csr:12;
+		unsigned long width:6;
+#if __riscv_xlen == 32
+		unsigned long reserved:13;
+#else
+		unsigned long reserved:45;
+#endif
+		unsigned long type:1;
+	};
+};
+
+/**
+ * RISC-V doesn't have hetergenous harts yet. This need to be part of
+ * per_cpu in case of harts with different pmu counters
+ */
+static union sbi_pmu_ctr_info *pmu_ctr_list;
+
+struct pmu_event_data {
+	union {
+		union {
+			struct hw_gen_event {
+				uint32_t event_code:16;
+				uint32_t event_type:4;
+				uint32_t reserved:12;
+			} hw_gen_event;
+			struct hw_cache_event {
+				uint32_t result_id:1;
+				uint32_t op_id:2;
+				uint32_t cache_id:13;
+				uint32_t event_type:4;
+				uint32_t reserved:12;
+			} hw_cache_event;
+		};
+		uint32_t event_idx;
+	};
+};
+
+static const struct pmu_event_data pmu_hw_event_map[] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= {.hw_gen_event = {
+							SBI_PMU_HW_CPU_CYCLES,
+							SBI_PMU_EVENT_TYPE_HW, 0}},
+	[PERF_COUNT_HW_INSTRUCTIONS]		= {.hw_gen_event = {
+							SBI_PMU_HW_INSTRUCTIONS,
+							SBI_PMU_EVENT_TYPE_HW, 0}},
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= {.hw_gen_event = {
+							SBI_PMU_HW_CACHE_REFERENCES,
+							SBI_PMU_EVENT_TYPE_HW, 0}},
+	[PERF_COUNT_HW_CACHE_MISSES]		= {.hw_gen_event = {
+							SBI_PMU_HW_CACHE_MISSES,
+							SBI_PMU_EVENT_TYPE_HW, 0}},
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= {.hw_gen_event = {
+							SBI_PMU_HW_BRANCH_INSTRUCTIONS,
+							SBI_PMU_EVENT_TYPE_HW, 0}},
+	[PERF_COUNT_HW_BRANCH_MISSES]		= {.hw_gen_event = {
+							SBI_PMU_HW_BRANCH_MISSES,
+							SBI_PMU_EVENT_TYPE_HW, 0}},
+	[PERF_COUNT_HW_BUS_CYCLES]		= {.hw_gen_event = {
+							SBI_PMU_HW_BUS_CYCLES,
+							SBI_PMU_EVENT_TYPE_HW, 0}},
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= {.hw_gen_event = {
+							SBI_PMU_HW_STALLED_CYCLES_FRONTEND,
+							SBI_PMU_EVENT_TYPE_HW, 0}},
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= {.hw_gen_event = {
+							SBI_PMU_HW_STALLED_CYCLES_BACKEND,
+							SBI_PMU_EVENT_TYPE_HW, 0}},
+	[PERF_COUNT_HW_REF_CPU_CYCLES]		= {.hw_gen_event = {
+							SBI_PMU_HW_REF_CPU_CYCLES,
+							SBI_PMU_EVENT_TYPE_HW, 0}},
+};
+
+#define C(x) PERF_COUNT_HW_CACHE_##x
+static const struct pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
+[PERF_COUNT_HW_CACHE_OP_MAX]
+[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(L1D)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_READ), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_READ), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_WRITE), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_WRITE), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_PREFETCH), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_PREFETCH), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+	},
+	[C(L1I)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event =	{C(RESULT_ACCESS),
+					C(OP_READ), C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS), C(OP_READ),
+					C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_WRITE), C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_WRITE), C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_PREFETCH), C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_PREFETCH), C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+	},
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_READ), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_READ), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_WRITE), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_WRITE), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_PREFETCH), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_PREFETCH), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+	},
+	[C(DTLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_READ), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_READ), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_WRITE), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_WRITE), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_PREFETCH), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_PREFETCH), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+	},
+	[C(ITLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_READ), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_READ), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_WRITE), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_WRITE), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_PREFETCH), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_PREFETCH), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+	},
+	[C(BPU)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_READ), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_READ), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_WRITE), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_WRITE), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_PREFETCH), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_PREFETCH), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+	},
+	[C(NODE)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_READ), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_READ), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_WRITE), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_WRITE), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
+					C(OP_PREFETCH), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+			[C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
+					C(OP_PREFETCH), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
+		},
+	},
+};
+
+static int pmu_sbi_ctr_get_width(int idx)
+{
+	return pmu_ctr_list[idx].width;
+}
+
+static int pmu_sbi_ctr_get_idx(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
+	struct sbiret ret;
+	int idx;
+	uint64_t cbase = 0;
+	uint64_t cmask = GENMASK_ULL(rvpmu->num_counters - 1, 0);
+	unsigned long cflags = 0;
+
+	/* retrieve the available counter index */
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase, cmask,
+			cflags, hwc->event_base, hwc->config, 0);
+	if (ret.error) {
+		pr_debug("Not able to find a counter for event %lx config %llx\n",
+			hwc->event_base, hwc->config);
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
+	idx = ret.value;
+	if (idx >= rvpmu->num_counters || !pmu_ctr_list[idx].value)
+		return -ENOENT;
+
+	/* Additional sanity check for the counter id */
+	if (!test_and_set_bit(idx, cpuc->used_event_ctrs))
+		return idx;
+	else
+		return -ENOENT;
+}
+
+static void pmu_sbi_ctr_clear_idx(struct perf_event *event)
+{
+
+	struct hw_perf_event *hwc = &event->hw;
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
+	int idx = hwc->idx;
+
+	clear_bit(idx, cpuc->used_event_ctrs);
+}
+
+static int pmu_event_find_cache(u64 config)
+{
+	unsigned int cache_type, cache_op, cache_result, ret;
+
+	cache_type = (config >>  0) & 0xff;
+	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
+		return -EINVAL;
+
+	cache_op = (config >>  8) & 0xff;
+	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
+		return -EINVAL;
+
+	cache_result = (config >> 16) & 0xff;
+	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
+		return -EINVAL;
+
+	ret = pmu_cache_event_map[cache_type][cache_op][cache_result].event_idx;
+
+	return ret;
+}
+
+static bool pmu_sbi_is_fw_event(struct perf_event *event)
+{
+	u32 type = event->attr.type;
+	u64 config = event->attr.config;
+
+	if ((type == PERF_TYPE_RAW) && ((config >> 63) == 1))
+		return true;
+	else
+		return false;
+}
+
+static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
+{
+	u32 type = event->attr.type;
+	u64 config = event->attr.config;
+	int bSoftware;
+	u64 raw_config_val;
+	int ret;
+
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+		if (config >= PERF_COUNT_HW_MAX)
+			return -EINVAL;
+		ret = pmu_hw_event_map[event->attr.config].event_idx;
+		break;
+	case PERF_TYPE_HW_CACHE:
+		ret = pmu_event_find_cache(config);
+		break;
+	case PERF_TYPE_RAW:
+		/*
+		 * As per SBI specification, the upper 16 bits must be unused for
+		 * a raw event. Use the MSB (63b) to distinguish between hardware
+		 * raw event and firmware events.
+		 */
+		bSoftware = config >> 63;
+		raw_config_val = config & RISCV_PMU_RAW_EVENT_MASK;
+		if (bSoftware) {
+			if (raw_config_val < SBI_PMU_FW_MAX)
+				ret = (raw_config_val & 0xFFFF) |
+				      (SBI_PMU_EVENT_TYPE_FW << 16);
+			else
+				return -EINVAL;
+		} else {
+			ret = RISCV_PMU_RAW_EVENT_IDX;
+			*econfig = raw_config_val;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static u64 pmu_sbi_ctr_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+	struct sbiret ret;
+	union sbi_pmu_ctr_info info;
+	u64 val = 0;
+
+	if (pmu_sbi_is_fw_event(event)) {
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
+				hwc->idx, 0, 0, 0, 0, 0);
+		if (!ret.error)
+			val = ret.value;
+	} else {
+		info = pmu_ctr_list[idx];
+		val = riscv_pmu_ctr_read_csr(info.csr);
+		if (IS_ENABLED(CONFIG_32BIT))
+			val = ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
+	}
+
+	return val;
+}
+
+static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
+{
+	struct sbiret ret;
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
+
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
+			1, flag, ival, ival >> 32, 0);
+	if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
+		pr_err("Starting counter idx %d failed with error %d\n",
+			hwc->idx, sbi_err_map_linux_errno(ret.error));
+}
+
+static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
+{
+	struct sbiret ret;
+	struct hw_perf_event *hwc = &event->hw;
+
+	//disable IRQ
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
+	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
+		flag != SBI_PMU_STOP_FLAG_RESET)
+		pr_err("Stopping counter idx %d failed with error %d\n",
+			hwc->idx, sbi_err_map_linux_errno(ret.error));
+}
+
+static int pmu_sbi_find_num_ctrs(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_NUM_COUNTERS, 0, 0, 0, 0, 0, 0);
+	if (!ret.error)
+		return ret.value;
+	else
+		return sbi_err_map_linux_errno(ret.error);
+}
+
+static int pmu_sbi_get_ctrinfo(int nctr)
+{
+	struct sbiret ret;
+	int i, num_hw_ctr = 0, num_fw_ctr = 0;
+	union sbi_pmu_ctr_info cinfo;
+
+	pmu_ctr_list = kcalloc(nctr, sizeof(*pmu_ctr_list), GFP_KERNEL);
+	if (!pmu_ctr_list)
+		return -ENOMEM;
+
+	for (i = 0; i <= nctr; i++) {
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
+		if (ret.error)
+			/* The logical counter ids are not expected to be contiguous */
+			continue;
+		cinfo.value = ret.value;
+		if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
+			num_fw_ctr++;
+		else
+			num_hw_ctr++;
+		pmu_ctr_list[i].value = cinfo.value;
+	}
+
+	pr_info("There are %d firmware & %d hardware counters available\n",
+		num_fw_ctr, num_hw_ctr);
+
+	return 0;
+}
+
+static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
+
+	/* Enable the access for TIME csr only from the user mode now */
+	csr_write(CSR_SCOUNTEREN, 0x2);
+
+	/* Stop all the counters so that they can be enabled from perf */
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+		  0, GENMASK_ULL(pmu->num_counters - 1, 0), 0, 0, 0, 0);
+
+	return 0;
+}
+
+static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	/* Disable all counters access for user mode now */
+	csr_write(CSR_SCOUNTEREN, 0x0);
+
+	return 0;
+}
+
+static int pmu_sbi_device_probe(struct platform_device *pdev)
+{
+	struct riscv_pmu *pmu = NULL;
+	int num_counters;
+	int ret;
+
+	pr_info("SBI PMU extension is available\n");
+	/* Notify legacy implementation that SBI pmu is available*/
+	riscv_pmu_legacy_init(true);
+	pmu = riscv_pmu_alloc();
+	if (!pmu)
+		return -ENOMEM;
+
+	num_counters = pmu_sbi_find_num_ctrs();
+	if (num_counters < 0) {
+		pr_err("SBI PMU extension doesn't provide any counters\n");
+		return -ENODEV;
+	}
+
+	/* cache all the information about counters now */
+	if (pmu_sbi_get_ctrinfo(num_counters))
+		return -ENODEV;
+
+	pmu->num_counters = num_counters;
+	pmu->ctr_start = pmu_sbi_ctr_start;
+	pmu->ctr_stop = pmu_sbi_ctr_stop;
+	pmu->event_map = pmu_sbi_event_map;
+	pmu->ctr_get_idx = pmu_sbi_ctr_get_idx;
+	pmu->ctr_get_width = pmu_sbi_ctr_get_width;
+	pmu->ctr_clear_idx = pmu_sbi_ctr_clear_idx;
+	pmu->ctr_read = pmu_sbi_ctr_read;
+
+	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
+	if (ret)
+		return ret;
+
+	ret = perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
+	if (ret) {
+		cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver pmu_sbi_driver = {
+	.probe		= pmu_sbi_device_probe,
+	.driver		= {
+		.name	= RISCV_PMU_PDEV_NAME,
+	},
+};
+
+static int __init pmu_sbi_devinit(void)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	if (((sbi_major_version() == 0) && (sbi_minor_version() < 3)) ||
+		sbi_probe_extension(SBI_EXT_PMU) <= 0) {
+		return 0;
+	}
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
+				      "perf/riscv/pmu:starting",
+				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
+	if (ret) {
+		pr_err("CPU hotplug notifier for RISC-V PMU could not be registered: %d\n",
+		       ret);
+		return ret;
+	}
+
+	ret = platform_driver_register(&pmu_sbi_driver);
+	if (ret)
+		return ret;
+
+	pdev = platform_device_register_simple(RISCV_PMU_PDEV_NAME, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&pmu_sbi_driver);
+		return PTR_ERR(pdev);
+	}
+
+	return ret;
+}
+device_initcall(pmu_sbi_devinit)
-- 
2.31.1

