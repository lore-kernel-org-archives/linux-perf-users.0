Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986991;
	b=lnHB1i3iMAP/pb9/66gaK/bH6Uc+z4cV7UtfTMMGD6zdYobZfBW3LdDrwvAtDNyrx8/y
	 OhbHgHup0P7Hk6zn2cbHQuR71lJvpYYJmmK51SiDUlNs211KLWHcqH1okUstfcsDNH91f
	 9xo6gLX4V3vJ9ufaENdnluLBQXhdf2yU1sBSR4l/kyRR5cvu+6W9oQcpP1iRM0hMUbJxb
	 jmP7f+kK8o8Io+W8zRFqI16iPjt4cS7Vj9O1I8grDAtSD6wocjCJHhw5zlKY8yXwHO77M
	 GP1DeAIWBNqn0MKjA223FFaUkcvbXHwLuH0xwypEv5J0M2ckhxNBe/DnYoxTBgOjaEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986991;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KwnNF5QW93XzxF0ChR+AYU/i5t0ZILiF7vSr2St8AiE=;
	b=f6UE5oZqI3J0j6smJVmGsh7LgoJf/KUn8jYkPe2DbpYVutWk4F4vxqB7PJM3ChlJ3K6W
	 hIX7oqGNlNPb9MDYWuYlQEaOFvBvjBg+4WUfGmqbKyhcfDZZ7uhTnDFPXzOYDVsmbaZl/
	 JTvnlNPL1HQXSzd2iDx1aN8pdqf6DYwz5s8d3nII8TnZjGi8wzazE4Waty79AuelNSlAC
	 A7fItewzTYBBRAyrRMoTOqSHerSiw6R/wfKXa16Kmade5kf8d6MoR2E5MoKbm/+t0kLPN
	 xQnpZN8cFS8HHtBetXkOJs4YbYruPMTR/cKwzx+3Mg0nHFibNXJHj7ligyKZ2AN37Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=csa9cT6E;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C395606A339;
	Fri,  6 Nov 2026 17:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C395606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=csa9cT6E
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Exxi21121587;
	Fri, 6 Nov 2026 17:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KwnNF5QW93X
	zxF0ChR+AYU/i5t0ZILiF7vSr2St8AiE=; b=csa9cT6EQzEcPj0RPWi7iJnylHL
	C4yi3aR4t3lGeTO3+ugIkd51D9211pNtAziNrDJNN/tULZbZUAOXWdbbv8uBbVJA
	X15No/VF0jfbVotGQS7PRYGWGS3cl41tfp/hTkK81Ugah2eQtlCaXqF1zjvInfPn
	riDR5SLIldp7qYP9ka7QIwodS81Z1PEP2pxVb5WnL964Haqjd7yXXFEXgkRMi7DT
	aNXrrxHmyDENF7MOjwMF3WqdgEjU0cYzQ5W5pZRjEZ0TfxuYe5SojkhnqGRWjgJI
	1pNRg6BBLSP0gaSsOBVRptCKzIJgMIjgdqfafok/NKjxIwuZYqpliFakYJQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9uyjr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:42:46 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Hes3w1892164;
	Fri, 6 Nov 2026 17:40:54 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A6HesCY1892159
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:40:54 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id B521A248A1; Fri,  6 Nov 2026 23:10:53 +0530 (+0530)
From: Vikram Singh <vikram.singh3@oss.qualcomm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Anup Patel <anup.patel@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Beeman Strong <beeman@rivosinc.com>
Cc: Vikram Singh <vikram.singh3@oss.qualcomm.com>,
        Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 5/7] riscv: pmu: Add driver for Control Transfer Records Ext
Date: Fri,  6 Nov 2026 23:09:40 +0530
Message-ID: <20261106173942.3175069-6-vikram.singh3@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106173942.3175069-1-vikram.singh3@oss.qualcomm.com>
References: <20261106173942.3175069-1-vikram.singh3@oss.qualcomm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX+g3EjqPlTPFw
 GhiQkmBwf790Ogjjg88RVjwu3bBbiXIrQ/CLWC020AqP3eUi5bXL/w3nKW4Kv3WsddOT9LK/EeH
 +ljq+l43vMomGKDY5crV+1WZp/xmwsE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfXwZ9wpNws4usa
 ko/lmwn6zvuoa3zrSPunSb6to/5WdStFQH5FMg4LNnWi3PpiWktcIrk9hj9fc7dgmvoFGyd1TCa
 nTRmQwNvq3+Vc90mHSRqJZWkROcTV7F81J4uN1q24yVI03nNGbCIHdYHAkIItjwY0mkkJe2BW6u
 Mntw8p7EFVmiRaRtieGt0jhS7a+URIhgx/u/nIAPKr7iP4Ve8fEmKivKzr9/Jiqfu+H3SB6dzJC
 zBOLxyMZzlrWsccV6py6wT8pONrm4xA0R8rr8fquxTh0juAyksTLPTgQdjWOuODKBh2OlqPp9I7
 RWMViICtM9/7Ft8uKLPXJIqp8W8Ax6sNYiTMW/08EVzIrDf8wLE0Y8LnoHRWRlYjUvQMZvnjg6W
 NPsSAg3ABUedtW99FoWzHzk21T0SQRfKa/tlzUG48PclLJ8uMVhO+SEj+1Ghf3YPG++Ca1CEl0F
 aLzvxUF13nXkTYkNthQ==
X-Proofpoint-ORIG-GUID: -BYh-dLIc0SPsixX8RgsHRBPW5MNl6UI
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aee1196 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=W-_n0kkjAAAA:8
 a=JfrnYn6hAAAA:8 a=h0uksLzaAAAA:8 a=p8uuPNNgm1G0NsEGCEIA:9
 a=qeNa2pbTr82C0GpJEZFS:22 a=1CNFftbPRP8L7MoqJWF3:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: -BYh-dLIc0SPsixX8RgsHRBPW5MNl6UI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060070

This adds support for CTR Ext defined in [0]. The extension
allows to records a maximum for 256 last branch records.

CTR extension depends on s[m|s]csrind and Sscofpmf extensions.

Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
---
 MAINTAINERS                           |   4 +
 arch/riscv/include/asm/csr_indirect.h |  50 +++
 drivers/perf/Kconfig                  |  16 +
 drivers/perf/Makefile                 |   1 +
 drivers/perf/riscv_ctr.c              | 609 ++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h        |  44 +-
 6 files changed, 720 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/include/asm/csr_indirect.h
 create mode 100644 drivers/perf/riscv_ctr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c31ca1f20de..5faf599440a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23295,8 +23295,12 @@ F:	arch/riscv/boot/dts/sifive/
 RISC-V PMU DRIVERS
 M:	Atish Patra <atish.patra@linux.dev>
 R:	Anup Patel <anup@brainfault.org>
+R:	Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
+R:	Vikram Singh <vikram.singh3@oss.qualcomm.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	arch/riscv/include/asm/csr_indirect.h
+F:	drivers/perf/risc_ctr.c
 F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
diff --git a/arch/riscv/include/asm/csr_indirect.h b/arch/riscv/include/asm/csr_indirect.h
new file mode 100644
index 000000000000..0f558fac8f5f
--- /dev/null
+++ b/arch/riscv/include/asm/csr_indirect.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_RISCV_CSR_INDIRECT_H
+#define _ASM_RISCV_CSR_INDIRECT_H
+
+#include <linux/irqflags.h>
+
+#include <asm/csr.h>
+
+/*
+ * These have to be macros rather than functions: csr_read()/csr_write()
+ * stringify their CSR argument into the inline asm template via __ASM_STR(),
+ * so the CSR number must be a literal token at preprocessing time. Passing it
+ * as a function parameter emits "csrr %0, iregcsr", which no assembler can
+ * resolve. RISC-V has no register-indirect form of csrr/csrw - the CSR is a
+ * 12-bit immediate - so the sireg CSR selecting the indirect window cannot
+ * itself be a variable.
+ */
+#define csr_indirect_read(iregcsr, iselbase, iseloff) ({		\
+	unsigned long __value = 0;				\
+	unsigned long __flags;					\
+	local_irq_save(__flags);				\
+	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
+	__value = csr_read(iregcsr);				\
+	local_irq_restore(__flags);				\
+	__value;						\
+})
+
+#define csr_indirect_write(iregcsr, iselbase, iseloff, value) ({	\
+	unsigned long __flags;					\
+	local_irq_save(__flags);				\
+	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
+	csr_write(iregcsr, (value));				\
+	local_irq_restore(__flags);				\
+})
+
+#define csr_indirect_warl(iregcsr, iselbase, iseloff, warl_val) ({	\
+	unsigned long __old_val = 0, __value = 0;		\
+	unsigned long __flags;					\
+	local_irq_save(__flags);				\
+	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
+	__old_val = csr_read(iregcsr);				\
+	csr_write(iregcsr, (warl_val));				\
+	__value = csr_read(iregcsr);				\
+	csr_write(iregcsr, __old_val);				\
+	local_irq_restore(__flags);				\
+	__value;						\
+})
+
+#endif
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index d60ab1e357f4..6d8cc3905340 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -139,6 +139,22 @@ config ANDES_CUSTOM_PMU
 
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
+config RISCV_M_MODE
+		bool "Enable M Mode"
+		depends on RISCV_CTR
+		default n
+
 config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index eb8a022dad9a..02cba90afb54 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
 obj-$(CONFIG_STARFIVE_STARLINK_PMU) += starfive_starlink_pmu.o
+obj-$(CONFIG_RISCV_CTR) += riscv_ctr.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/riscv_ctr.c b/drivers/perf/riscv_ctr.c
new file mode 100644
index 000000000000..2cb86ec5d2da
--- /dev/null
+++ b/drivers/perf/riscv_ctr.c
@@ -0,0 +1,609 @@
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
+#include <asm/csr_indirect.h>
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
+	u32 ctr_status;
+	u64 ctr_control;
+	struct ctr_regset store[MAX_BRANCH_RECORDS];
+};
+
+static inline u64 get_ctr_src_reg(unsigned int ctr_idx)
+{
+	return csr_indirect_read(CSR_SIREG, CTR_ENTRIES_FIRST, ctr_idx);
+}
+
+static inline void set_ctr_src_reg(unsigned int ctr_idx, u64 value)
+{
+	return csr_indirect_write(CSR_SIREG, CTR_ENTRIES_FIRST, ctr_idx, value);
+}
+
+static inline u64 get_ctr_tgt_reg(unsigned int ctr_idx)
+{
+	return csr_indirect_read(CSR_SIREG2, CTR_ENTRIES_FIRST, ctr_idx);
+}
+
+static inline void set_ctr_tgt_reg(unsigned int ctr_idx, u64 value)
+{
+	return csr_indirect_write(CSR_SIREG2, CTR_ENTRIES_FIRST, ctr_idx, value);
+}
+
+static inline u64 get_ctr_data_reg(unsigned int ctr_idx)
+{
+	return csr_indirect_read(CSR_SIREG3, CTR_ENTRIES_FIRST, ctr_idx);
+}
+
+static inline void set_ctr_data_reg(unsigned int ctr_idx, u64 value)
+{
+	return csr_indirect_write(CSR_SIREG3, CTR_ENTRIES_FIRST, ctr_idx, value);
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
+			      branch_type & ~allowed_filters);
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
+void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *pmu_ctx, struct task_struct *task,
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
+	task_ctx = pmu_ctx ? task->perf_ctx_data : NULL;
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
+	    event->ctx->task->perf_ctx_data)
+		task_context(event->ctx->task->perf_ctx_data)->callstack_users++;
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
+	    event->ctx->task->perf_ctx_data)
+		task_context(event->ctx->task->perf_ctx_data)->callstack_users--;
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
+	    !riscv_isa_extension_available(NULL, SSCOFPMF))
+		return;
+
+	/* Set depth to maximum. */
+	csr_write(CSR_SCTRDEPTH, SCTRDEPTH_MASK);
+}
+
+void riscv_pmu_ctr_dying_cpu(void)
+{
+	if (!riscv_isa_extension_available(NULL, SxCTR) ||
+	    !riscv_isa_extension_available(NULL, SSCOFPMF))
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
+	    !riscv_isa_extension_available(NULL, SSCOFPMF))
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
index 58bafa173868..7f40ff40ab01 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -56,9 +56,8 @@ struct cpu_hw_events {
 	bool snapshot_set_done;
 	/* A shadow copy of the counter values to avoid clobbering during multiple SBI calls */
 	u64 snapshot_cval_shcopy[RISCV_MAX_COUNTERS];
-	/* Saved branch records. */
+	/* Saved branch records */
 	struct branch_records *branches;
-
 	/* Active events requesting branch records */
 	int ctr_users;
 };
@@ -91,8 +90,7 @@ struct riscv_pmu {
 	struct cpu_hw_events	__percpu *hw_events;
 	struct hlist_node	node;
 	struct notifier_block   riscv_pm_nb;
-
-	unsigned int	ctr_depth;
+	unsigned int ctr_depth;
 };
 
 #define to_riscv_pmu(p) (container_of(p, struct riscv_pmu, pmu))
@@ -114,6 +112,44 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr);
 int riscv_pmu_get_event_info(u32 type, u64 config, u64 *econfig);
 #endif
 
+static inline bool riscv_pmu_ctr_supported(struct riscv_pmu *pmu)
+{
+	return !!pmu->ctr_depth;
+}
+
 #endif /* CONFIG_RISCV_PMU */
 
+#ifdef CONFIG_RISCV_CTR
+
+bool riscv_pmu_ctr_valid(struct perf_event *event);
+void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc, struct perf_event *event);
+void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *pmu_ctx, struct task_struct *task,
+			      bool sched_in);
+void riscv_pmu_ctr_add(struct perf_event *event);
+void riscv_pmu_ctr_del(struct perf_event *event);
+void riscv_pmu_ctr_enable(struct perf_event *event);
+void riscv_pmu_ctr_disable(struct perf_event *event);
+void riscv_pmu_ctr_dying_cpu(void);
+void riscv_pmu_ctr_starting_cpu(void);
+int  riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu);
+void riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu);
+
+#else
+
+static inline bool riscv_pmu_ctr_valid(struct perf_event *event) { return false; }
+static inline void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc,
+					 struct perf_event *event) { }
+static inline void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *,
+					    struct task_struct *task, bool sched_in) { }
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

