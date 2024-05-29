Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24621C6885
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008879; cv=none; b=h/TPeGED7AxIgiQ3IlYDsdUvGKxNNwbakGTlDOAB3IxUnIvYx2PoDaoIdy/HfEiEeg/11QWH/zelseVzlwY/RmsEVFecPRRl5vqqPAljhCHDLU4zVMXuI0xg0GRrdl+sVlgtc5vsuMef51TqG/MS7m602o+aT3zJlR3qOISJchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008879; c=relaxed/simple;
	bh=acsH4CXflg8MWwftRGHOCAfjnNVksPUpC1VI99j84PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s2L+vliVUBMYgpWbA2Rf9ES0gbd7yTHT5Qr6Ecosw16nekhDKxNMgnkHprO5VF6yKxvKuPaQfDDSXOAMhkg34SsAaRqwSBB7tJhWzvI4RlHEiZQNUiSL9PH2XMckZl29tm2CuZ6sB10/ezjgxMHd5z9EloMJHKHkbvrIEZyMYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z33m9uzE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z33m9uzE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42121d27861so635305e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717008875; x=1717613675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o+B1b3b9otKzfoRya637jHIfmbAgjTIaV6zgoFCmBw=;
        b=z33m9uzEBrrPztugdjncliVvPsAxS0TbDE1qOsWerMogqKoEfTEF/iCSqEUoLpHFVs
         H6Oexj4ngz1X39VkgcSn2TmM4roKdLurkiseYNVRFEDoYkmMlj3Gwtwncb7SLigytkR7
         vxK+MCad4qJMcyJNWH4hk2TDULB8gDD9sPNTYQsPXxNJ6T1/ropOoDksJn4voLKAGVzr
         YUIescN6e2NedpST2v6IF8akoID2o00b+L5gZlVjOvyOyiHUrJ7MZ1HsI0bgN8hnhgBQ
         A3SnJYOlfbCTjM266aiR3eSEerZnFJUsV5wm9WCZCwvQ07Ral4/xDZdeEXyqo0m2n2/Z
         AUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717008875; x=1717613675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o+B1b3b9otKzfoRya637jHIfmbAgjTIaV6zgoFCmBw=;
        b=uKxxWzrZZjL1oFCQ3nrbSVGV5ruE19L3JRaIsBzMkYpjhtpk7DaWeNPya0B9qkGMpI
         FYOlnf2KQf2CcLGEEnz58nRRs306Q3aHdCyJ7fZ69sDwfeoFsP5b1+nWO30ejszmbWt1
         ZGHZ1utpq6UuFgKD6c2xkdi5Mo3AM1YqOjVtl9yr1OMWsEd5BL3iW4ucQX466FnwlHhB
         pmnMTmLQqFfs3nd8Vus6HEQBORgn3bvH7IPbXnlAbD8qaepllhOu0ezjGHY1DFS0DUaE
         2Hs18ai8HaLyeH5WLth3eaijirHzFsCiWhgjfKDumv9piHtR4WFdW26e444psNW7DCmA
         +pRw==
X-Gm-Message-State: AOJu0YwQ46NgS0c8hoRurQBi6/mkfNqcQR93Y73iNzp7P9wdbLRPtwpo
	V+5Z/4g5cybblwBVeGsRhUyWj+14SvtJvSHuiih7EXcN4aQ1A4FL/CWTyM0BjHc=
X-Google-Smtp-Source: AGHT+IErFHVKwDzA+pRnaE1cowj8Cur30CsYYW0yRqy5Cyv1C3pRbjxr/J2rzgCC4GvWtUmPlzLsaw==
X-Received: by 2002:a05:600c:a03:b0:416:2471:e102 with SMTP id 5b1f17b1804b1-4212792c381mr196775e9.37.1717008875165;
        Wed, 29 May 2024 11:54:35 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706a23csm2787885e9.27.2024.05.29.11.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:54:34 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	acme@kernel.org,
	atishp@rivosinc.com,
	beeman@rivosinc.com,
	brauner@kernel.org,
	conor@kernel.org,
	heiko@sntech.de,
	irogers@google.com,
	mingo@redhat.com,
	james.clark@arm.com,
	renyu.zj@linux.alibaba.com,
	jolsa@kernel.org,
	jisheng.teoh@starfivetech.com,
	palmer@dabbelt.com,
	tech-control-transfer-records@lists.riscv.org,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH RFC 5/6] riscv: perf: Add driver for Control Transfer Records Ext.
Date: Wed, 29 May 2024 19:53:36 +0100
Message-Id: <20240529185337.182722-6-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529185337.182722-1-rkanwal@rivosinc.com>
References: <20240529185337.182722-1-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for CTR Ext defined in [0]. The extension
allows to records a maximum for 256 last branch records.

CTR extension depends on s[m|s]csrind and Sscofpmf extensions.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 MAINTAINERS                    |   1 +
 drivers/perf/Kconfig           |  11 +
 drivers/perf/Makefile          |   1 +
 drivers/perf/riscv_ctr.c       | 469 +++++++++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h |  33 +++
 5 files changed, 515 insertions(+)
 create mode 100644 drivers/perf/riscv_ctr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d6b42d5f62da..868e4b0808ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19056,6 +19056,7 @@ M:	Atish Patra <atishp@atishpatra.org>
 R:	Anup Patel <anup@brainfault.org>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	drivers/perf/riscv_ctr.c
 F:	drivers/perf/riscv_pmu_common.c
 F:	drivers/perf/riscv_pmu_dev.c
 F:	drivers/perf/riscv_pmu_legacy.c
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 3c37577b25f7..cca6598be739 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -110,6 +110,17 @@ config ANDES_CUSTOM_PMU
 
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
index ba809cc069d5..364b1f66f410 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_RISCV_PMU_COMMON) += riscv_pmu_common.o
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu_dev.o
 obj-$(CONFIG_STARFIVE_STARLINK_PMU) += starfive_starlink_pmu.o
+obj-$(CONFIG_RISCV_CTR) += riscv_ctr.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/riscv_ctr.c b/drivers/perf/riscv_ctr.c
new file mode 100644
index 000000000000..95fda1edda4f
--- /dev/null
+++ b/drivers/perf/riscv_ctr.c
@@ -0,0 +1,469 @@
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
+static inline u64 get_ctr_src_reg(unsigned int ctr_idx)
+{
+	return csr_ind_read(CSR_IREG, CTR_ENTRIES_FIRST, ctr_idx);
+}
+
+static inline u64 get_ctr_tgt_reg(unsigned int ctr_idx)
+{
+	return csr_ind_read(CSR_IREG2, CTR_ENTRIES_FIRST, ctr_idx);
+}
+
+static inline u64 get_ctr_data_reg(unsigned int ctr_idx)
+{
+	return csr_ind_read(CSR_IREG3, CTR_ENTRIES_FIRST, ctr_idx);
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
+/* Reads CTR entry at idx and stores it in entry struct. */
+static bool capture_ctr_regset(struct ctr_regset *entry, unsigned int idx)
+{
+	entry->src = get_ctr_src_reg(idx);
+
+	if (!ctr_record_valid(entry->src))
+		return false;
+
+	entry->src = entry->src & (~CTRSOURCE_VALID);
+	entry->target = get_ctr_tgt_reg(idx);
+	entry->ctr_data = get_ctr_data_reg(idx);
+
+	return true;
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
+	if (branch_type & PERF_SAMPLE_BRANCH_CALL_STACK) {
+		config &= ~(CTRCTL_INDCALL_INH | CTRCTL_DIRCALL_INH |
+			    CTRCTL_RET_INH);
+		config |= CTRCTL_RASEMU;
+	}
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
+	[CTRDATA_TYPE_INDIRECT_JUMP]		= PERF_BR_UNCOND,
+	[CTRDATA_TYPE_DIRECT_JUMP]		= PERF_BR_UNKNOWN,
+	[CTRDATA_TYPE_CO_ROUTINE_SWAP]		= PERF_BR_UNKNOWN,
+	[CTRDATA_TYPE_RETURN]			= PERF_BR_RET,
+	[CTRDATA_TYPE_OTHER_INDIRECT_JUMP]	= PERF_BR_IND,
+	[CTRDATA_TYPE_OTHER_DIRECT_JUMP]	= PERF_BR_UNKNOWN,
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
+
+static void ctr_regset_to_branch_entry(struct cpu_hw_events *cpuc,
+				       struct perf_event *event,
+				       struct ctr_regset *regset,
+				       unsigned int idx)
+{
+	struct perf_branch_entry *entry = &cpuc->branches->branch_entries[idx];
+
+	perf_clear_branch_entry_bitfields(entry);
+	entry->from = regset->src;
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
+		if (!capture_ctr_regset(&entry, i))
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
+static void riscv_pmu_ctr_clear(void)
+{
+	/* FIXME: Replace with sctrclr instruction once support is merged
+	 * into toolchain.
+	 */
+	asm volatile(".4byte 0x10400073\n" ::: "memory");
+	csr_write(CSR_SCTRSTATUS, 0);
+}
+
+/*
+ * On context switch in, we need to make sure no samples from previous user
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
+
+	if (cpuc->ctr_users && sched_in)
+		riscv_pmu_ctr_clear();
+}
+
+void riscv_pmu_ctr_enable(struct perf_event *event)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
+	u64 branch_type = event->attr.branch_sample_type;
+	u64 ctr;
+
+	if (!cpuc->ctr_users++ && !event->total_time_running)
+		riscv_pmu_ctr_clear();
+
+	ctr = branch_type_to_ctr(branch_type);
+	csr_write(CSR_CTRCTL, ctr);
+
+	perf_sched_cb_inc(event->pmu);
+}
+
+void riscv_pmu_ctr_disable(struct perf_event *event)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
+
+	/* Clear CTRCTL to disable the recording. */
+	csr_write(CSR_CTRCTL, 0);
+
+	cpuc->ctr_users--;
+	WARN_ON_ONCE(cpuc->ctr_users < 0);
+
+	perf_sched_cb_dec(event->pmu);
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
+	riscv_pmu_ctr_clear();
+}
+
+void __init riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu)
+{
+	if (!riscv_isa_extension_available(NULL, SxCTR) ||
+	    !riscv_isa_extension_available(NULL, SSCOFPMF) ||
+	    !riscv_isa_extension_available(NULL, SxCSRIND))
+		return;
+
+	check_available_filters();
+
+	/* Set depth to maximum. */
+	csr_write(CSR_SCTRDEPTH, SCTRDEPTH_MASK);
+	riscv_pmu->ctr_depth = ctr_get_depth(csr_read(CSR_SCTRDEPTH));
+
+	pr_info("Perf CTR available, with %d depth\n", riscv_pmu->ctr_depth);
+}
+
+void __init riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu)
+{
+	if (!riscv_pmu_ctr_supported(riscv_pmu))
+		return;
+
+	csr_write(CSR_SCTRDEPTH, 0);
+	csr_write(CSR_CTRCTL, 0);
+	riscv_pmu_ctr_clear();
+	riscv_pmu->ctr_depth = 0;
+}
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 5a6b840018bd..455d2386936f 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -104,6 +104,39 @@ struct riscv_pmu *riscv_pmu_alloc(void);
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
+void riscv_pmu_ctr_enable(struct perf_event *event);
+void riscv_pmu_ctr_disable(struct perf_event *event);
+void riscv_pmu_ctr_dying_cpu(void);
+void riscv_pmu_ctr_starting_cpu(void);
+void riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu);
+void riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu);
+
+#else
+
+static inline bool riscv_pmu_ctr_valid(struct perf_event *event) { return false; }
+static inline void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc,
+				      struct perf_event *event) { }
+static inline void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *,
+					    bool sched_in) { }
+static inline void riscv_pmu_ctr_enable(struct perf_event *event) { }
+static inline void riscv_pmu_ctr_disable(struct perf_event *event) { }
+static inline void riscv_pmu_ctr_dying_cpu(void) { }
+static inline void riscv_pmu_ctr_starting_cpu(void) { }
+static inline void riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu) { }
+static inline void riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu) { }
+
+#endif /* CONFIG_RISCV_CTR */
+
 #endif /* _RISCV_PMU_H */
-- 
2.34.1

