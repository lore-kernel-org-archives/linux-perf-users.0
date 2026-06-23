Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90612BE621;
	Tue, 23 Jun 2026 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219766; cv=none; b=gANd9vFh+o3ghQYEOA9O2dF2ZEtfK709ORUDEuVrL3eoyWqvtIwmtdZ9J1KYNGfXsoAKMQ9rDbXa1SA97d1/Rnu/n5ggzflDPY7V6XyVvTTOF6ZY1DYhk7kAtmGry46tp2bX+NfN2a5LxNe7ibbCzdKLUclorHpB7dZvd+NpatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219766; c=relaxed/simple;
	bh=BjY78BM00n/pJaHi9xvKmPqX5EWfAqV7rH4FBPpQ7zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ft93dpvtKc/8x536yH0mIcOVKwSIZ+peOSf/My8nqO1DcOmWPZHiXQgS9lZtTmZzx9sh2rTpda9aESTK59wN0pRPFjGBZI3TnAnbiRoqTVr8B8fk2O1QSEcMXFWqdCRnVOOBk3+URs/2/YC1keSOsoFSR9Ppco12PiIwJdkRDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m+qo2BLH; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m+qo2BLH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782219762; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tx9Ne21uZNy+GWMuJdeXidlQMBRpymzFnOMylWu+eps=;
	b=m+qo2BLHef/Vz3zjQA2Ev6OlYAEtCgf7NGeSVV1a4piaxbTdj8/E4XtKs7bKmxeC8E8Gv4BIJ+mvdOFZV3O9F0F7z3lH0dPwOK8MxbeFyosWydvs0M5+igxqpYh471pYsIw1u0hGACvXcJpWJKNmvrgJ9MpnHHlZsFir/EUEyjE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X5UKImC_1782219760;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X5UKImC_1782219760 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 21:02:40 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/5] perf dwarf-regs: Add ARM64 register and offset extraction from raw instructions
Date: Tue, 23 Jun 2026 21:02:32 +0800
Message-Id: <20260623130234.8709-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
References: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add get_arm64_regs() to extract register numbers (Rn, Rt, Rm) and
memory offsets from raw ARM64 load/store instruction encodings. This
follows the same pattern as get_powerpc_regs() for PowerPC.

ARM64 DWARF register numbers map trivially: x0-x30 = 0-30, sp = 31,
so the hardware register fields can be used directly as DWARF regnums.

Four addressing modes are handled:
  - Unsigned offset: imm12 scaled by access size
  - Pre/Post-indexed: sign-extended 9-bit immediate
  - Register offset: offset from Rm (set to 0, handled via multi_regs)
  - Load/Store Pair: sign-extended 7-bit immediate scaled by element size

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 .../util/dwarf-regs-arch/dwarf-regs-arm64.c   | 125 ++++++++++++++++++
 tools/perf/util/include/dwarf-regs.h          |   7 +
 2 files changed, 132 insertions(+)

diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
index 593ca7d4fccc..26f296624966 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
@@ -1,8 +1,133 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <dwarf-regs.h>
+#include "../annotate.h"
 #include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
 
+/*
+ * ARM64 instruction field extraction.
+ * Mirrors definitions in annotate-arm64.c.
+ */
+#define A64_RT(insn)	((insn) & 0x1f)
+#define A64_RN(insn)	(((insn) >> 5) & 0x1f)
+#define A64_RT2(insn)	(((insn) >> 10) & 0x1f)
+#define A64_RM(insn)	(((insn) >> 16) & 0x1f)
+
+/*
+ * Load/Store encoding sub-class detection.
+ * Derived from ARM Architecture Reference Manual, C4.1.
+ *
+ * Load/Store Pair (offset/pre/post): bits[29:27]=101, bit[26]=0
+ * Load/Store Register:              bits[29:27]=111, bit[26]=0
+ *   - Unsigned offset:              bits[25:24]=01
+ *   - Pre/Post-indexed:             bits[25:24]=00, bit[21]=0
+ *   - Register offset:              bits[25:24]=00, bit[21]=1, bits[11:10]=10
+ */
+#define A64_INSN_LS_PAIR_MASK		0x3c000000
+#define A64_INSN_LS_PAIR_VAL		0x28000000
+
+#define A64_INSN_LS_REG_MASK		0x3c000000
+#define A64_INSN_LS_REG_VAL		0x38000000
+
+#define A64_INSN_LS_UNSIGNED_MASK	0x3b000000
+#define A64_INSN_LS_UNSIGNED_VAL	0x39000000
+
+#define A64_INSN_LS_PREPOST_MASK	0x3b200000
+#define A64_INSN_LS_PREPOST_VAL		0x38000000
+
+#define A64_INSN_LS_REG_OFF_MASK	0x3b200c00
+#define A64_INSN_LS_REG_OFF_VAL	0x38200800
+
+static int arm64_get_immoff_unsigned(u32 insn)
+{
+	int size = (insn >> 30) & 0x3;
+	int imm12 = (insn >> 10) & 0xfff;
+
+	return imm12 << size;
+}
+
+static int arm64_get_immoff_prepost(u32 insn)
+{
+	int imm9 = (insn >> 12) & 0x1ff;
+
+	/* sign-extend 9-bit immediate */
+	if (imm9 & 0x100)
+		imm9 |= ~0x1ff;
+
+	return imm9;
+}
+
+static int arm64_get_immoff_pair(u32 insn)
+{
+	int imm7 = (insn >> 15) & 0x7f;
+	int scale = 2 + ((insn >> 31) & 1);
+
+	/* sign-extend 7-bit immediate */
+	if (imm7 & 0x40)
+		imm7 |= ~0x7f;
+
+	return imm7 << scale;
+}
+
+/*
+ * Fills op_loc fields depending on whether it is a source or target operand.
+ *
+ * ARM64 load/store encoding forms:
+ *   Register (unsigned offset):  [Rn, #imm12 << scale]
+ *   Register (pre/post-indexed): [Rn, #imm9]  or  [Rn], #imm9
+ *   Register (register offset):  [Rn, Rm{, extend/shift}]
+ *   Pair:                        [Rn, #imm7 << scale]
+ *
+ * For source (memory) operand: reg1=Rn (base), offset=immediate
+ * For target (register) operand: reg1=Rt
+ */
+void get_arm64_regs(u32 raw_insn, int is_source,
+		    struct annotated_op_loc *op_loc)
+{
+	if (is_source)
+		op_loc->reg1 = A64_RN(raw_insn);
+	else
+		op_loc->reg1 = A64_RT(raw_insn);
+
+	if (op_loc->multi_regs) {
+		/* LDP/STP pair: second register is Rt2 (bits[14:10]) */
+		if ((raw_insn & A64_INSN_LS_PAIR_MASK) == A64_INSN_LS_PAIR_VAL)
+			op_loc->reg2 = A64_RT2(raw_insn);
+		else
+			op_loc->reg2 = A64_RM(raw_insn);
+	}
+
+	if (!op_loc->mem_ref || !is_source)
+		return;
+
+	/* Load/Store Pair */
+	if ((raw_insn & A64_INSN_LS_PAIR_MASK) == A64_INSN_LS_PAIR_VAL) {
+		op_loc->offset = arm64_get_immoff_pair(raw_insn);
+		return;
+	}
+
+	/* Load/Store Register */
+	if ((raw_insn & A64_INSN_LS_REG_MASK) == A64_INSN_LS_REG_VAL) {
+		/* Unsigned offset */
+		if ((raw_insn & A64_INSN_LS_UNSIGNED_MASK) == A64_INSN_LS_UNSIGNED_VAL) {
+			op_loc->offset = arm64_get_immoff_unsigned(raw_insn);
+			return;
+		}
+
+		/* Register offset */
+		if ((raw_insn & A64_INSN_LS_REG_OFF_MASK) == A64_INSN_LS_REG_OFF_VAL) {
+			op_loc->offset = 0;
+			return;
+		}
+
+		/* Pre/Post-indexed */
+		if ((raw_insn & A64_INSN_LS_PREPOST_MASK) == A64_INSN_LS_PREPOST_VAL) {
+			op_loc->offset = arm64_get_immoff_prepost(raw_insn);
+			return;
+		}
+	}
+}
+
 int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum)
 {
 	if (perf_regnum < 0 || perf_regnum >= PERF_REG_ARM64_MAX)
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 46a764cf322f..c3f730d2fd88 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -129,6 +129,7 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machine, unsi
 				     bool only_libdw_supported);
 
 void get_powerpc_regs(u32 raw_insn, int is_source, struct annotated_op_loc *op_loc);
+void get_arm64_regs(u32 raw_insn, int is_source, struct annotated_op_loc *op_loc);
 
 #else /* HAVE_LIBDW_SUPPORT */
 
@@ -144,6 +145,12 @@ static inline void get_powerpc_regs(u32 raw_insn __maybe_unused, int is_source _
 {
 	return;
 }
+
+static inline void get_arm64_regs(u32 raw_insn __maybe_unused, int is_source __maybe_unused,
+		struct annotated_op_loc *op_loc __maybe_unused)
+{
+	return;
+}
 #endif
 
 #endif
-- 
2.51.2.612.gdc70283dfc

