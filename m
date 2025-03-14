Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6D1A83F2;
	Fri, 14 Mar 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940446; cv=none; b=sK0hGIm7y9HUDodRApUDV5P25IakFEm/dbaDQdM1HWkzREZmI/Hoo/9tYQJil5Vo0yIPMU6U3qX3jRp3gNVklp+XKIkDb6n4grTBVQIoRw3z/hEL6i4gnd5wYLCJ+CRG66Jw+1COHmtcwd4PW/5g+wBZPmiUfhUP5OW8bvJ90dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940446; c=relaxed/simple;
	bh=RwJSjxLUsvplq8xwlFW3Kbg0W+jQSq8JDjAzsQS+PSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMNJYodu91RmAfMwwd+/04cHZw37hVpzlmQFAZ1kvxT6dX9dDl5p1M57trQjH18cA17mIrc7FiNV2qFXSLlQkZV7rNd8Gk52QAk2mBoqT6Ba0qn3g+h5rSBR7J1YvvqFaVLrLPmtyeTRPZnbM4gLW9qICC2JrubmLqD0yj+ONv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZDcfx0mk3zCtSP;
	Fri, 14 Mar 2025 16:17:29 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id EC7F2140156;
	Fri, 14 Mar 2025 16:20:40 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:20:39 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <namhyung@kernel.org>, <acme@kernel.org>, <leo.yan@linux.dev>,
	<james.clark@linaro.org>, <mark.rutland@arm.com>, <john.g.garry@oracle.com>,
	<will@kernel.org>, <irogers@google.com>
CC: <mike.leach@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<kjain@linux.ibm.com>, <mhiramat@kernel.org>, <atrajeev@linux.vnet.ibm.com>,
	<sesse@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 4/7] perf annotate: Support for the 'extract_reg_offset' callback function in arm64
Date: Sat, 15 Mar 2025 00:21:34 +0800
Message-ID: <20250314162137.528204-5-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314162137.528204-1-lihuafei1@huawei.com>
References: <20250314162137.528204-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)

At present, only the following two addressing modes are supported:

 1. Base register only (no offset): [base{, #0}]
 2. Base plus offset (immediate): [base{, #imm}]

For addressing modes where the offset needs to be calculated from the
register value, it is difficult to know the specific value of the offset
register, making it impossible to calculate the offset.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/arch/arm64/annotate/instructions.c | 62 +++++++++++++++++++
 tools/perf/util/Build                         |  1 +
 tools/perf/util/disasm.c                      |  1 +
 tools/perf/util/dwarf-regs-arm64.c            | 25 ++++++++
 tools/perf/util/include/dwarf-regs.h          |  7 +++
 5 files changed, 96 insertions(+)
 create mode 100644 tools/perf/util/dwarf-regs-arm64.c

diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index c212eb7341bd..54497b72a5c5 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -188,3 +188,65 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	free(arm);
 	return SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
 }
+
+
+/*
+ * Get the base register number and access offset in load/store instructions.
+ * At present, only the following two addressing modes are supported:
+ *
+ *  1. Base register only (no offset): [base{, #0}]
+ *  2. Base plus offset (immediate): [base{, #imm}]
+ *
+ * For addressing modes where the offset needs to be calculated from the
+ * register value, it is difficult to know the specific value of the offset
+ * register, making it impossible to calculate the offset.
+ *
+ * Fills @reg and @offset when return 0.
+ */
+static int
+extract_reg_offset_arm64(struct arch *arch __maybe_unused,
+			 struct disasm_line *dl __maybe_unused,
+			 const char *insn_str, int insn_ops __maybe_unused,
+			 struct annotated_op_loc *op_loc)
+{
+	char *str;
+	regmatch_t match[4];
+	static regex_t reg_off_regex;
+	static bool regex_compiled;
+
+	if (!regex_compiled) {
+		regcomp(&reg_off_regex, "^\\[(sp|[xw][0-9]{1,2})(, #(-?[0-9]+))?\\].*",
+			REG_EXTENDED);
+		regex_compiled = true;
+	}
+
+	if (!op_loc->mem_ref)
+		return 0;
+
+	if (regexec(&reg_off_regex, insn_str, 4, match, 0))
+		return -1;
+
+	str = strdup(insn_str);
+	if (!str)
+		return -1;
+
+	/* Get the base register number. */
+	str[match[1].rm_eo] = '\0';
+	op_loc->reg1 = get_arm64_regnum(str + match[1].rm_so);
+
+	/*
+	 * If there is an immediate offset, match[2] records the start and end
+	 * positions of "#imm".
+	 */
+	if (match[2].rm_so == -1) {
+		free(str);
+		return 0;
+	}
+
+	/* Get the immediate offset. */
+	str[match[3].rm_eo] = '\0';
+	op_loc->offset = strtol(str + match[3].rm_so, NULL, 0);
+
+	free(str);
+	return 0;
+}
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 5ec97e8d6b6d..d408cbe94fdd 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -210,6 +210,7 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-arm64.o
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 905eceb824a4..1035c60a8545 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -128,6 +128,7 @@ static struct arch architectures[] = {
 	{
 		.name = "arm64",
 		.init = arm64__annotate_init,
+		.extract_reg_offset = extract_reg_offset_arm64,
 	},
 	{
 		.name = "csky",
diff --git a/tools/perf/util/dwarf-regs-arm64.c b/tools/perf/util/dwarf-regs-arm64.c
new file mode 100644
index 000000000000..edf41c059967
--- /dev/null
+++ b/tools/perf/util/dwarf-regs-arm64.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mapping of DWARF debug register numbers into register names.
+ *
+ * Copyright (c) 2025  Huawei Inc, Li Huafei <lihuafei1@huawei.com>
+ */
+#include <errno.h>
+#include <string.h>
+#include <dwarf-regs.h>
+
+int get_arm64_regnum(const char *name)
+{
+	int reg;
+
+	if (!strcmp(name, "sp"))
+		return 31;
+
+	if (*name != 'x' && *name != 'w')
+		return -EINVAL;
+
+	name++;
+	reg = strtol(name, NULL, 0);
+
+	return reg >= 0 && reg <= 30 ? reg : -EINVAL;
+}
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 6f1b9f6b2466..81cc5f69a391 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -101,6 +101,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 
 int get_x86_regnum(const char *name);
 
+int get_arm64_regnum(const char *name);
+
 #if !defined(__x86_64__) && !defined(__i386__)
 int get_arch_regnum(const char *name);
 #endif
@@ -128,6 +130,11 @@ static inline void get_powerpc_regs(u32 raw_insn __maybe_unused, int is_source _
 {
 	return;
 }
+
+static inline int get_arm64_regnum(const char *name __maybe_unused)
+{
+	return -1;
+}
 #endif
 
 #endif
-- 
2.25.1

