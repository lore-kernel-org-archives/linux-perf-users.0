Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116382D3A70
	for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956386; cv=none; b=IWr1Bi7K9Bl8whqs2r28gliz3sgq1VlOP3vFge+pYyJOqmnLzqp3HZdcNUzr4o9XHqDONdTW9rv/74aKuv2VOCU8ps5ocSRF9KxrJjWjPTmb35IhNbnZodyIBksRcF5R5l3t4tjQewju3kgvrS9b1n1a9yhAjfgIOMIdHguEruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956386; c=relaxed/simple;
	bh=NnsJw3tsE5qEf7zlNhdIYIjmmA5oVtcXKuz+F5ZXS3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hU3yW7HlK1eLPYWakJizIuadMde9aQtLrrrTAsIJCJR2qJmXaeAx0lk9QKY+ys7yZ15k3By7JfA7vIO5gRkBQOxo85zdN+qfw8euXZ8vKCDbSnRZ0/3kM340zPNzHGVH675625DzE3mqDnV96mYSe9UVmhmWCO8nwXXFVpX/RNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wW5tIt87; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wW5tIt87"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so72077765e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747956381; x=1748561181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaHH5mdttUKdT56VwAZFcB+tyeGK0bZqC8g5F8EkAt4=;
        b=wW5tIt871uipboy61je+eWM3u36WqyR/4NTK6ziHhRT5VTOYDpaorXASv5nEVvEEqJ
         M3pnTMe5gfL1OziB1PJS+VmIXpzFKtTfCsz45O/YFMZoY1Y3f5kOmYdikaNgk5KErscr
         00bI+LxIYOIM/sDFoDaHHX/AGso/ouXrDW4ucItvkQ+zSRYZxTOgW+FsodF+BxhYO1zr
         CBUQAsvEzwDrouIGQNIyUxPsRgysF7RXLgK9kTfHzW2MSPcCbpVBdrFDO2fIa1vAqeNL
         XFoElWP1lWJocJrRvM0OABr69MShm/TxRbMwi/PxC/dfBG+ZgiC48iAc2Lzo0AEOxxtz
         +75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956381; x=1748561181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaHH5mdttUKdT56VwAZFcB+tyeGK0bZqC8g5F8EkAt4=;
        b=QTxDLLbPqwxK8XgTwrA9GIycaFxHEdOuwqsmmNwd5QUz+Tz2raWZP4RBuYa+LohWKd
         svS5JM/3krDpYT6VOxaZGACEKqoNLaPzqsjXsopzKnLSaVcwXZCJYdZcIsU5BV/z62r8
         GTFap8kTRHO8EftXo4bkBlEg7JK0doPu3lv5sskUX62xzzf0zKy/s9g/eVkoYRMJBEgb
         rcG87RVKzTSJeB41YYmARF/U8tW0QHn6BzCQI4IBa3ADOpvwaLqeWkSojv4FweVRuOXm
         TvsvsgivYbq1qoYHwRqaRYs+PwZgkC5HFIlyO3h8NSiEstGsUeTLkzenf8AtVO/SRpK2
         gicg==
X-Gm-Message-State: AOJu0YzUCye0ydQwA21DTloLJYiTFta62Jls77IfzYi+1z9kq7TnbTh6
	xBVYdHFnSY/PwTtxzNKJ+LrsBDPppZ88dCENP8q4R2yY3T5GeflFIHEHKe3imEWVzRw=
X-Gm-Gg: ASbGncthnwK9q3yF1feQ7IoqbAmBMxcuoMGw+twYnSjIuLI84VG+V0ipD41sg6Qbuyh
	IpqnOqhLsENeCIpUh8R90EzkehZPDdxFOhetbwytJtDajyp5ZBIcIVStIbkH3jzvIAxt82ksG+F
	IIYhxqclPEXj+UcRToWa3cwB71jTbcRQX4hMnzBZl90Q/Ucip8S+qlPGMEfcXEaQmB8301JHGK4
	lbN75A/iZr0vqyrP61PxXk1zxwaFblw0Yw96htTnMT7+J2stfHpgYR51xaP3BrI6AU2lYHIwwMy
	pRyA0XNecv5eepZTqQuWlDEs68tjMgojXF07z7tQ/gGeOp2dBetemg==
X-Google-Smtp-Source: AGHT+IFZPYtZlMvLNPpZSsfDsdXLSnpyPxXG8MdaKWwvWmT8+dPpiTqI3MYbIJ9zpijJPQyyR5h5zg==
X-Received: by 2002:a05:600c:3592:b0:448:e8c0:c778 with SMTP id 5b1f17b1804b1-44b6e85ee5dmr8150675e9.22.1747956381260;
        Thu, 22 May 2025 16:26:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a02:c7c:75ac:6300:c05a:35d:17ae:e731])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f04334sm117825395e9.10.2025.05.22.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 16:26:21 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Fri, 23 May 2025 00:25:11 +0100
Subject: [PATCH v3 5/7] riscv: pmu: Add driver for Control Transfer Records
 Ext.
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-b4-ctr_upstream_v3-v3-5-ad355304ba1c@rivosinc.com>
References: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
In-Reply-To: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beeman Strong <beeman@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, Rajnesh Kanwal <rkanwal@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747956375; l=22286;
 i=rkanwal@rivosinc.com; s=20250522; h=from:subject:message-id;
 bh=NnsJw3tsE5qEf7zlNhdIYIjmmA5oVtcXKuz+F5ZXS3c=;
 b=cMYOBsyXODB7J7Ss9gbknZ07PSyPklzm7tzpmLwUX5oluH/clO7tuujGi1Of4ypJbGEQVQETF
 UB7eG70mlAeBnHpANo6kc/iKKozP9fbnvddyXXQd3BdVCU/5t+wU0QV
X-Developer-Key: i=rkanwal@rivosinc.com; a=ed25519;
 pk=aw8nvncslGKHEmTBTJqvkP/4tj6pijL8fwRRym/GuS8=

This adds support for CTR Ext defined in [0]. The extension
allows to records a maximum for 256 last branch records.

CTR extension depends on s[m|s]csrind and Sscofpmf extensions.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 MAINTAINERS                    |   1 +
 drivers/perf/Kconfig           |  11 +
 drivers/perf/Makefile          |   1 +
 drivers/perf/riscv_ctr.c       | 612 +++++++++++++++++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h |  37 +++
 5 files changed, 662 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6d174f7735e6d8e4c3c2eac91450e38f8b48519..068994eff9fdfda82f61f607e76ecacb54809792 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20406,6 +20406,7 @@ M:	Atish Patra <atishp@atishpatra.org>
 R:	Anup Patel <anup@brainfault.org>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	drivers/perf/riscv_ctr.c
 F:	drivers/perf/riscv_pmu_common.c
 F:	drivers/perf/riscv_pmu_dev.c
 F:	drivers/perf/riscv_pmu_legacy.c
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index b3bdff2a99a4a160718a322ed3b0a6af2b01a750..9107c5208bf5eba6c9db378ae8ed596f2b27498c 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -129,6 +129,17 @@ config ANDES_CUSTOM_PMU
 
 	  If you don't know what to do here, say "Y".
 
+config RISCV_CTR
+       bool "Enable support for Control Transfer Records (CTR)"
+       depends on PERF_EVENTS && RISCV_PMU
+       default y
+       help
+         Enable support for Control Transfer Records (CTR) which
+         allows recording branches, Jumps, Calls, returns etc taken in an
+         execution path. This also supports privilege based filtering. It
+         captures additional relevant information such as cycle count,
+         branch misprediction etc.
+
 config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 0805d740c773f51263c94cf97c9fb4339bcd6767..755609f184fe4b4ad7cd77de10cc56319489f495 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RISCV_PMU_COMMON) += riscv_pmu_common.o
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu_dev.o
 obj-$(CONFIG_STARFIVE_STARLINK_PMU) += starfive_starlink_pmu.o
+obj-$(CONFIG_RISCV_CTR) += riscv_ctr.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/riscv_ctr.c b/drivers/perf/riscv_ctr.c
new file mode 100644
index 0000000000000000000000000000000000000000..4bbac1ce29c5dd558a3ebd89d6efef9db3a405b8
--- /dev/null
+++ b/drivers/perf/riscv_ctr.c
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Control transfer records extension Helpers.
+ *
+ * Copyright (C) 2024 Rivos Inc.
+ *
+ * Author: Rajnesh Kanwal <rkanwal@rivosinc.com>
+ */
+
+#define pr_fmt(fmt) "CTR: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+#include <linux/perf_event.h>
+#include <linux/perf/riscv_pmu.h>
+#include <linux/cpufeature.h>
+#include <asm/hwcap.h>
+#include <asm/csr_ind.h>
+#include <asm/csr.h>
+
+#define CTR_BRANCH_FILTERS_INH  (CTRCTL_EXCINH       | \
+				 CTRCTL_INTRINH      | \
+				 CTRCTL_TRETINH      | \
+				 CTRCTL_TKBRINH      | \
+				 CTRCTL_INDCALL_INH  | \
+				 CTRCTL_DIRCALL_INH  | \
+				 CTRCTL_INDJUMP_INH  | \
+				 CTRCTL_DIRJUMP_INH  | \
+				 CTRCTL_CORSWAP_INH  | \
+				 CTRCTL_RET_INH      | \
+				 CTRCTL_INDOJUMP_INH | \
+				 CTRCTL_DIROJUMP_INH)
+
+#define CTR_BRANCH_ENABLE_BITS (CTRCTL_KERNEL_ENABLE | CTRCTL_U_ENABLE)
+
+/* Branch filters not-supported by CTR extension. */
+#define CTR_EXCLUDE_BRANCH_FILTERS (PERF_SAMPLE_BRANCH_ABORT_TX	        | \
+				    PERF_SAMPLE_BRANCH_IN_TX		| \
+				    PERF_SAMPLE_BRANCH_PRIV_SAVE        | \
+				    PERF_SAMPLE_BRANCH_NO_TX            | \
+				    PERF_SAMPLE_BRANCH_COUNTERS)
+
+/* Branch filters supported by CTR extension. */
+#define CTR_ALLOWED_BRANCH_FILTERS (PERF_SAMPLE_BRANCH_USER		| \
+				    PERF_SAMPLE_BRANCH_KERNEL		| \
+				    PERF_SAMPLE_BRANCH_HV		| \
+				    PERF_SAMPLE_BRANCH_ANY		| \
+				    PERF_SAMPLE_BRANCH_ANY_CALL	        | \
+				    PERF_SAMPLE_BRANCH_ANY_RETURN	| \
+				    PERF_SAMPLE_BRANCH_IND_CALL	        | \
+				    PERF_SAMPLE_BRANCH_COND		| \
+				    PERF_SAMPLE_BRANCH_IND_JUMP	        | \
+				    PERF_SAMPLE_BRANCH_HW_INDEX	        | \
+				    PERF_SAMPLE_BRANCH_NO_FLAGS	        | \
+				    PERF_SAMPLE_BRANCH_NO_CYCLES	| \
+				    PERF_SAMPLE_BRANCH_CALL_STACK       | \
+				    PERF_SAMPLE_BRANCH_CALL		| \
+				    PERF_SAMPLE_BRANCH_TYPE_SAVE)
+
+#define CTR_PERF_BRANCH_FILTERS    (CTR_ALLOWED_BRANCH_FILTERS	        | \
+				    CTR_EXCLUDE_BRANCH_FILTERS)
+
+static u64 allowed_filters __read_mostly;
+
+struct ctr_regset {
+	unsigned long src;
+	unsigned long target;
+	unsigned long ctr_data;
+};
+
+enum {
+	CTR_STATE_NONE,
+	CTR_STATE_VALID,
+};
+
+/* Head is the idx of the next available slot. The slot may be already populated
+ * by an old entry which will be lost on new writes.
+ */
+struct riscv_perf_task_context {
+	int callstack_users;
+	int stack_state;
+	unsigned int num_entries;
+	uint32_t ctr_status;
+	uint64_t ctr_control;
+	struct ctr_regset store[MAX_BRANCH_RECORDS];
+};
+
+static inline u64 get_ctr_src_reg(unsigned int ctr_idx)
+{
+	return csr_ind_read(CSR_SIREG, CTR_ENTRIES_FIRST, ctr_idx);
+}
+
+static inline void set_ctr_src_reg(unsigned int ctr_idx, u64 value)
+{
+	return csr_ind_write(CSR_SIREG, CTR_ENTRIES_FIRST, ctr_idx, value);
+}
+
+static inline u64 get_ctr_tgt_reg(unsigned int ctr_idx)
+{
+	return csr_ind_read(CSR_SIREG2, CTR_ENTRIES_FIRST, ctr_idx);
+}
+
+static inline void set_ctr_tgt_reg(unsigned int ctr_idx, u64 value)
+{
+	return csr_ind_write(CSR_SIREG2, CTR_ENTRIES_FIRST, ctr_idx, value);
+}
+
+static inline u64 get_ctr_data_reg(unsigned int ctr_idx)
+{
+	return csr_ind_read(CSR_SIREG3, CTR_ENTRIES_FIRST, ctr_idx);
+}
+
+static inline void set_ctr_data_reg(unsigned int ctr_idx, u64 value)
+{
+	return csr_ind_write(CSR_SIREG3, CTR_ENTRIES_FIRST, ctr_idx, value);
+}
+
+static inline bool ctr_record_valid(u64 ctr_src)
+{
+	return !!FIELD_GET(CTRSOURCE_VALID, ctr_src);
+}
+
+static inline int ctr_get_mispredict(u64 ctr_target)
+{
+	return FIELD_GET(CTRTARGET_MISP, ctr_target);
+}
+
+static inline unsigned int ctr_get_cycles(u64 ctr_data)
+{
+	const unsigned int cce = FIELD_GET(CTRDATA_CCE_MASK, ctr_data);
+	const unsigned int ccm = FIELD_GET(CTRDATA_CCM_MASK, ctr_data);
+
+	if (ctr_data & CTRDATA_CCV)
+		return 0;
+
+	/* Formula to calculate cycles from spec: (2^12 + CCM) << CCE-1 */
+	if (cce > 0)
+		return (4096 + ccm) << (cce - 1);
+
+	return FIELD_GET(CTRDATA_CCM_MASK, ctr_data);
+}
+
+static inline unsigned int ctr_get_type(u64 ctr_data)
+{
+	return FIELD_GET(CTRDATA_TYPE_MASK, ctr_data);
+}
+
+static inline unsigned int ctr_get_depth(u64 ctr_depth)
+{
+	/* Depth table from CTR Spec: 2.4 sctrdepth.
+	 *
+	 * sctrdepth.depth       Depth
+	 * 000			- 16
+	 * 001			- 32
+	 * 010			- 64
+	 * 011			- 128
+	 * 100			- 256
+	 *
+	 * Depth = 16 * 2 ^ (ctrdepth.depth)
+	 * or
+	 * Depth = 16 << ctrdepth.depth.
+	 */
+	return 16 << FIELD_GET(SCTRDEPTH_MASK, ctr_depth);
+}
+
+static inline struct riscv_perf_task_context *task_context(void *ctx)
+{
+	return (struct riscv_perf_task_context *)ctx;
+}
+
+/* Reads CTR entry at idx and stores it in entry struct. */
+static bool get_ctr_regset(struct ctr_regset *entry, unsigned int idx)
+{
+	entry->src = get_ctr_src_reg(idx);
+
+	if (!ctr_record_valid(entry->src))
+		return false;
+
+	entry->src = entry->src;
+	entry->target = get_ctr_tgt_reg(idx);
+	entry->ctr_data = get_ctr_data_reg(idx);
+
+	return true;
+}
+
+static void set_ctr_regset(struct ctr_regset *entry, unsigned int idx)
+{
+	set_ctr_src_reg(idx, entry->src);
+	set_ctr_tgt_reg(idx, entry->target);
+	set_ctr_data_reg(idx, entry->ctr_data);
+}
+
+static u64 branch_type_to_ctr(int branch_type)
+{
+	u64 config = CTR_BRANCH_FILTERS_INH | CTRCTL_LCOFIFRZ;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_USER)
+		config |= CTRCTL_U_ENABLE;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_KERNEL)
+		config |= CTRCTL_KERNEL_ENABLE;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_HV) {
+		if (riscv_isa_extension_available(NULL, h))
+			config |= CTRCTL_KERNEL_ENABLE;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
+		config &= ~CTR_BRANCH_FILTERS_INH;
+		return config;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
+		config &= ~CTRCTL_INDCALL_INH;
+		config &= ~CTRCTL_DIRCALL_INH;
+		config &= ~CTRCTL_EXCINH;
+		config &= ~CTRCTL_INTRINH;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		config &= ~(CTRCTL_RET_INH | CTRCTL_TRETINH);
+
+	if (branch_type & PERF_SAMPLE_BRANCH_IND_CALL)
+		config &= ~CTRCTL_INDCALL_INH;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_COND)
+		config &= ~CTRCTL_TKBRINH;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_CALL_STACK)
+		config |= CTRCTL_RASEMU;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_IND_JUMP) {
+		config &= ~CTRCTL_INDJUMP_INH;
+		config &= ~CTRCTL_INDOJUMP_INH;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_CALL)
+		config &= ~CTRCTL_DIRCALL_INH;
+
+	return config;
+}
+
+static const int ctr_perf_map[] = {
+	[CTRDATA_TYPE_NONE]			= PERF_BR_UNKNOWN,
+	[CTRDATA_TYPE_EXCEPTION]		= PERF_BR_SYSCALL,
+	[CTRDATA_TYPE_INTERRUPT]		= PERF_BR_IRQ,
+	[CTRDATA_TYPE_TRAP_RET]			= PERF_BR_ERET,
+	[CTRDATA_TYPE_NONTAKEN_BRANCH]		= PERF_BR_COND,
+	[CTRDATA_TYPE_TAKEN_BRANCH]		= PERF_BR_COND,
+	[CTRDATA_TYPE_RESERVED_6]		= PERF_BR_UNKNOWN,
+	[CTRDATA_TYPE_RESERVED_7]		= PERF_BR_UNKNOWN,
+	[CTRDATA_TYPE_INDIRECT_CALL]		= PERF_BR_IND_CALL,
+	[CTRDATA_TYPE_DIRECT_CALL]		= PERF_BR_CALL,
+	[CTRDATA_TYPE_INDIRECT_JUMP]		= PERF_BR_IND,
+	[CTRDATA_TYPE_DIRECT_JUMP]		= PERF_BR_UNCOND,
+	[CTRDATA_TYPE_CO_ROUTINE_SWAP]		= PERF_BR_UNKNOWN,
+	[CTRDATA_TYPE_RETURN]			= PERF_BR_RET,
+	[CTRDATA_TYPE_OTHER_INDIRECT_JUMP]	= PERF_BR_IND,
+	[CTRDATA_TYPE_OTHER_DIRECT_JUMP]	= PERF_BR_UNCOND,
+};
+
+static void ctr_set_perf_entry_type(struct perf_branch_entry *entry,
+				    u64 ctr_data)
+{
+	int ctr_type = ctr_get_type(ctr_data);
+
+	entry->type = ctr_perf_map[ctr_type];
+	if (entry->type == PERF_BR_UNKNOWN)
+		pr_warn("%d - unknown branch type captured\n", ctr_type);
+}
+
+static void capture_ctr_flags(struct perf_branch_entry *entry,
+			      struct perf_event *event, u64 ctr_data,
+			      u64 ctr_target)
+{
+	if (branch_sample_type(event))
+		ctr_set_perf_entry_type(entry, ctr_data);
+
+	if (!branch_sample_no_cycles(event))
+		entry->cycles = ctr_get_cycles(ctr_data);
+
+	if (!branch_sample_no_flags(event)) {
+		entry->abort = 0;
+		entry->mispred = ctr_get_mispredict(ctr_target);
+		entry->predicted = !entry->mispred;
+	}
+
+	if (branch_sample_priv(event))
+		entry->priv = PERF_BR_PRIV_UNKNOWN;
+}
+
+static void ctr_regset_to_branch_entry(struct cpu_hw_events *cpuc,
+				       struct perf_event *event,
+				       struct ctr_regset *regset,
+				       unsigned int idx)
+{
+	struct perf_branch_entry *entry = &cpuc->branches->branch_entries[idx];
+
+	perf_clear_branch_entry_bitfields(entry);
+	entry->from = regset->src & (~CTRSOURCE_VALID);
+	entry->to = regset->target & (~CTRTARGET_MISP);
+	capture_ctr_flags(entry, event, regset->ctr_data, regset->target);
+}
+
+static void ctr_read_entries(struct cpu_hw_events *cpuc,
+			     struct perf_event *event,
+			     unsigned int depth)
+{
+	struct ctr_regset entry = {};
+	u64 ctr_ctl;
+	int i;
+
+	ctr_ctl = csr_read_clear(CSR_CTRCTL, CTR_BRANCH_ENABLE_BITS);
+
+	for (i = 0; i < depth; i++) {
+		if (!get_ctr_regset(&entry, i))
+			break;
+
+		ctr_regset_to_branch_entry(cpuc, event, &entry, i);
+	}
+
+	csr_set(CSR_CTRCTL, ctr_ctl & CTR_BRANCH_ENABLE_BITS);
+
+	cpuc->branches->branch_stack.nr = i;
+	cpuc->branches->branch_stack.hw_idx = 0;
+}
+
+bool riscv_pmu_ctr_valid(struct perf_event *event)
+{
+	u64 branch_type = event->attr.branch_sample_type;
+
+	if (branch_type & ~allowed_filters) {
+		pr_debug_once("Requested branch filters not supported 0x%llx\n",
+				branch_type & ~allowed_filters);
+		return false;
+	}
+
+	return true;
+}
+
+void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc, struct perf_event *event)
+{
+	unsigned int depth = to_riscv_pmu(event->pmu)->ctr_depth;
+
+	ctr_read_entries(cpuc, event, depth);
+
+	/* Clear frozen bit. */
+	csr_clear(CSR_SCTRSTATUS, SCTRSTATUS_FROZEN);
+}
+
+static void riscv_pmu_ctr_reset(void)
+{
+	/* FIXME: Replace with sctrclr instruction once support is merged
+	 * into toolchain.
+	 */
+	asm volatile(".4byte 0x10400073\n" ::: "memory");
+	csr_write(CSR_SCTRSTATUS, 0);
+}
+
+static void __riscv_pmu_ctr_restore(void *ctx)
+{
+	struct riscv_perf_task_context *task_ctx = ctx;
+	unsigned int i;
+
+	csr_write(CSR_SCTRSTATUS, task_ctx->ctr_status);
+
+	for (i = 0; i < task_ctx->num_entries; i++)
+		set_ctr_regset(&task_ctx->store[i], i);
+}
+
+static void riscv_pmu_ctr_restore(void *ctx)
+{
+	if (task_context(ctx)->stack_state == CTR_STATE_NONE ||
+	    task_context(ctx)->callstack_users == 0) {
+		return;
+	}
+
+	riscv_pmu_ctr_reset();
+	__riscv_pmu_ctr_restore(ctx);
+
+	task_context(ctx)->stack_state = CTR_STATE_NONE;
+}
+
+static void __riscv_pmu_ctr_save(void *ctx, unsigned int depth)
+{
+	struct riscv_perf_task_context *task_ctx = ctx;
+	struct ctr_regset *dst;
+	unsigned int i;
+
+	for (i = 0; i < depth; i++) {
+		dst = &task_ctx->store[i];
+		if (!get_ctr_regset(dst, i))
+			break;
+	}
+
+	task_ctx->num_entries = i;
+
+	task_ctx->ctr_status = csr_read(CSR_SCTRSTATUS);
+}
+
+static void riscv_pmu_ctr_save(void *ctx, unsigned int depth)
+{
+	if (task_context(ctx)->stack_state == CTR_STATE_VALID)
+		return;
+
+	if (task_context(ctx)->callstack_users == 0) {
+		task_context(ctx)->stack_state = CTR_STATE_NONE;
+		return;
+	}
+
+	__riscv_pmu_ctr_save(ctx, depth);
+
+	task_context(ctx)->stack_state = CTR_STATE_VALID;
+}
+
+/*
+ * On context switch in, we need to make sure no samples from previous tasks
+ * are left in the CTR.
+ *
+ * On ctxswin, sched_in = true, called after the PMU has started
+ * On ctxswout, sched_in = false, called before the PMU is stopped
+ */
+void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			      bool sched_in)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(pmu_ctx->pmu);
+	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
+	void *task_ctx;
+
+	if (!cpuc->ctr_users)
+		return;
+
+	/* Save branch records in task_ctx on sched out */
+	task_ctx = pmu_ctx ? pmu_ctx->task_ctx_data : NULL;
+	if (task_ctx) {
+		if (sched_in)
+			riscv_pmu_ctr_restore(task_ctx);
+		else
+			riscv_pmu_ctr_save(task_ctx, rvpmu->ctr_depth);
+		return;
+	}
+
+	/* Reset branch records on sched in */
+	if (sched_in)
+		riscv_pmu_ctr_reset();
+}
+
+static inline bool branch_user_callstack(unsigned int br_type)
+{
+	return (br_type & PERF_SAMPLE_BRANCH_USER) &&
+		(br_type & PERF_SAMPLE_BRANCH_CALL_STACK);
+}
+
+void riscv_pmu_ctr_add(struct perf_event *event)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
+
+	if (branch_user_callstack(event->attr.branch_sample_type) &&
+			event->pmu_ctx->task_ctx_data)
+		task_context(event->pmu_ctx->task_ctx_data)->callstack_users++;
+
+	perf_sched_cb_inc(event->pmu);
+
+	if (!cpuc->ctr_users++)
+		riscv_pmu_ctr_reset();
+}
+
+void riscv_pmu_ctr_del(struct perf_event *event)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
+
+	if (branch_user_callstack(event->attr.branch_sample_type) &&
+			event->pmu_ctx->task_ctx_data)
+		task_context(event->pmu_ctx->task_ctx_data)->callstack_users--;
+
+	perf_sched_cb_dec(event->pmu);
+	cpuc->ctr_users--;
+	WARN_ON_ONCE(cpuc->ctr_users < 0);
+}
+
+void riscv_pmu_ctr_enable(struct perf_event *event)
+{
+	u64 branch_type = event->attr.branch_sample_type;
+	u64 ctr;
+
+	ctr = branch_type_to_ctr(branch_type);
+	csr_write(CSR_CTRCTL, ctr);
+}
+
+void riscv_pmu_ctr_disable(struct perf_event *event)
+{
+	/* Clear CTRCTL to disable the recording. */
+	csr_write(CSR_CTRCTL, 0);
+}
+
+/*
+ * Check for hardware supported perf filters here. To avoid missing
+ * any new added filter in perf, we do a BUILD_BUG_ON check, so make sure
+ * to update CTR_ALLOWED_BRANCH_FILTERS or CTR_EXCLUDE_BRANCH_FILTERS
+ * defines when adding support for it in below function.
+ */
+static void __init check_available_filters(void)
+{
+	u64 ctr_ctl;
+
+	/*
+	 * Ensure both perf branch filter allowed and exclude
+	 * masks are always in sync with the generic perf ABI.
+	 */
+	BUILD_BUG_ON(CTR_PERF_BRANCH_FILTERS != (PERF_SAMPLE_BRANCH_MAX - 1));
+
+	allowed_filters = PERF_SAMPLE_BRANCH_USER      |
+			  PERF_SAMPLE_BRANCH_KERNEL    |
+			  PERF_SAMPLE_BRANCH_ANY       |
+			  PERF_SAMPLE_BRANCH_HW_INDEX  |
+			  PERF_SAMPLE_BRANCH_NO_FLAGS  |
+			  PERF_SAMPLE_BRANCH_NO_CYCLES |
+			  PERF_SAMPLE_BRANCH_TYPE_SAVE;
+
+	csr_write(CSR_CTRCTL, ~0);
+	ctr_ctl = csr_read(CSR_CTRCTL);
+	csr_write(CSR_CTRCTL, 0);
+
+	if (riscv_isa_extension_available(NULL, h))
+		allowed_filters |= PERF_SAMPLE_BRANCH_HV;
+
+	if (ctr_ctl & (CTRCTL_INDCALL_INH | CTRCTL_DIRCALL_INH))
+		allowed_filters |= PERF_SAMPLE_BRANCH_ANY_CALL;
+
+	if (ctr_ctl & (CTRCTL_RET_INH | CTRCTL_TRETINH))
+		allowed_filters |= PERF_SAMPLE_BRANCH_ANY_RETURN;
+
+	if (ctr_ctl & CTRCTL_INDCALL_INH)
+		allowed_filters |= PERF_SAMPLE_BRANCH_IND_CALL;
+
+	if (ctr_ctl & CTRCTL_TKBRINH)
+		allowed_filters |= PERF_SAMPLE_BRANCH_COND;
+
+	if (ctr_ctl & CTRCTL_RASEMU)
+		allowed_filters |= PERF_SAMPLE_BRANCH_CALL_STACK;
+
+	if (ctr_ctl & (CTRCTL_INDOJUMP_INH | CTRCTL_INDJUMP_INH))
+		allowed_filters |= PERF_SAMPLE_BRANCH_IND_JUMP;
+
+	if (ctr_ctl & CTRCTL_DIRCALL_INH)
+		allowed_filters |= PERF_SAMPLE_BRANCH_CALL;
+}
+
+void riscv_pmu_ctr_starting_cpu(void)
+{
+	if (!riscv_isa_extension_available(NULL, SxCTR) ||
+	    !riscv_isa_extension_available(NULL, SSCOFPMF) ||
+	    !riscv_isa_extension_available(NULL, SxCSRIND))
+		return;
+
+	/* Set depth to maximum. */
+	csr_write(CSR_SCTRDEPTH, SCTRDEPTH_MASK);
+}
+
+void riscv_pmu_ctr_dying_cpu(void)
+{
+	if (!riscv_isa_extension_available(NULL, SxCTR) ||
+	    !riscv_isa_extension_available(NULL, SSCOFPMF) ||
+	    !riscv_isa_extension_available(NULL, SxCSRIND))
+		return;
+
+	/* Clear and reset CTR CSRs. */
+	csr_write(CSR_SCTRDEPTH, 0);
+	csr_write(CSR_CTRCTL, 0);
+	riscv_pmu_ctr_reset();
+}
+
+int riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu)
+{
+	size_t size = sizeof(struct riscv_perf_task_context);
+
+	if (!riscv_isa_extension_available(NULL, SxCTR) ||
+	    !riscv_isa_extension_available(NULL, SSCOFPMF) ||
+	    !riscv_isa_extension_available(NULL, SxCSRIND))
+		return 0;
+
+	riscv_pmu->pmu.task_ctx_cache =
+		kmem_cache_create("ctr_task_ctx", size, sizeof(u64), 0, NULL);
+	if (!riscv_pmu->pmu.task_ctx_cache)
+		return -ENOMEM;
+
+	check_available_filters();
+
+	/* Set depth to maximum. */
+	csr_write(CSR_SCTRDEPTH, SCTRDEPTH_MASK);
+	riscv_pmu->ctr_depth = ctr_get_depth(csr_read(CSR_SCTRDEPTH));
+
+	pr_info("Perf CTR available, with %d depth\n", riscv_pmu->ctr_depth);
+
+	return 0;
+}
+
+void riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu)
+{
+	if (!riscv_pmu_ctr_supported(riscv_pmu))
+		return;
+
+	riscv_pmu->ctr_depth = 0;
+	csr_write(CSR_SCTRDEPTH, 0);
+	csr_write(CSR_CTRCTL, 0);
+	riscv_pmu_ctr_reset();
+
+	kmem_cache_destroy(riscv_pmu->pmu.task_ctx_cache);
+}
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 883781f12ae0be93d8292ae1a7e7b03fea3ea955..f32b6dcc349109dc0aa74cbe152381c0b2c662d0 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -127,6 +127,43 @@ struct riscv_pmu *riscv_pmu_alloc(void);
 int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr);
 #endif
 
+static inline bool riscv_pmu_ctr_supported(struct riscv_pmu *pmu)
+{
+	return !!pmu->ctr_depth;
+}
+
 #endif /* CONFIG_RISCV_PMU_COMMON */
 
+#ifdef CONFIG_RISCV_CTR
+
+bool riscv_pmu_ctr_valid(struct perf_event *event);
+void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc, struct perf_event *event);
+void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+void riscv_pmu_ctr_add(struct perf_event *event);
+void riscv_pmu_ctr_del(struct perf_event *event);
+void riscv_pmu_ctr_enable(struct perf_event *event);
+void riscv_pmu_ctr_disable(struct perf_event *event);
+void riscv_pmu_ctr_dying_cpu(void);
+void riscv_pmu_ctr_starting_cpu(void);
+int riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu);
+void riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu);
+
+#else
+
+static inline bool riscv_pmu_ctr_valid(struct perf_event *event) { return false; }
+static inline void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc,
+				      struct perf_event *event) { }
+static inline void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *,
+					    bool sched_in) { }
+static void riscv_pmu_ctr_add(struct perf_event *event) { }
+static void riscv_pmu_ctr_del(struct perf_event *event) { }
+static inline void riscv_pmu_ctr_enable(struct perf_event *event) { }
+static inline void riscv_pmu_ctr_disable(struct perf_event *event) { }
+static inline void riscv_pmu_ctr_dying_cpu(void) { }
+static inline void riscv_pmu_ctr_starting_cpu(void) { }
+static inline int riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu) { return 0; }
+static inline void riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu) { }
+
+#endif /* CONFIG_RISCV_CTR */
+
 #endif /* _RISCV_PMU_H */

-- 
2.43.0

