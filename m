Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053763E8C75;
	Wed, 20 May 2026 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284434; cv=none; b=C+ebFXlzizMECia69yS9ZCv07yNzjn4Ps+qOpXyHXnHHmBiIw1KnKtYWGG5+sqDYRxsCwZkymbdrfJLVhFM5SxY3ZU4QClRmRYc0i0kGiqnPCXICW5/SIvqXnmqlm+UwAkTy+Kj8l7wEKWhsT/Qd9HLaZyvmuVzIP7uMIh9IiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284434; c=relaxed/simple;
	bh=ysieHJgULLrDz40Hw9B33+kWYMHRAEGf4bYsWCZnjGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJ7rPl9KkijY6U8qFgI1iEQ+lBVXOLaJDbTNPMgFroT5cvz+c0csVwbcYtAPN+pl/Wf8JuZTnLelk33NpqHdsapob4x6WztV4CNgOA1yxaUa+vF32jxyUrfRVjWXdeTVSLjTrb5rxZHln7iElFax64fCp6DGoUyXPwQpYfWksHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CrWZT/Wa; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CrWZT/Wa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779284415; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zz6r7l/Raw9+q6fJMv+zgPcO9HIwuiNFYsMU6mgqg9I=;
	b=CrWZT/WaKJc51o6idrEfzC55+I0eHFDcnCW87XeRTCpzbxJz/9loPntf3yYTjavNjeiwZvDDzzwv94gH/uOE1TLZSMjezLF8iUBZ77BvdguiBQ7M40JbIOdB/Q8/1BgE+EAIbY21+KahsPI/DCIHTr8CFNy85Ews9ME5uyBLVTY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X3J2wot_1779284410;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X3J2wot_1779284410 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 May 2026 21:40:14 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	dapeng1.mi@linux.intel.com,
	pjw@kernel.org,
	alex@ghiti.fr,
	guoren@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH v3] perf riscv: Add SDT argument parsing for RISC-V
Date: Wed, 20 May 2026 21:40:04 +0800
Message-ID: <20260520134004.30573-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement __perf_sdt_arg_parse_op_riscv() to convert RISC-V GCC-generated
SDT probe operands into uprobe-compatible format, and register it in the
perf_sdt_arg_parse_op() dispatcher for EM_RISCV.

RISC-V GCC uses the 'nor' constraint for SDT arguments, producing operands
in the following formats:

  Format       Example      Uprobe format
  -----------  -----------  -------------
  register     a0           %a0
  memory (+)   8(a0)        +8(%a0)
  memory (-)   -20(s0)      -20(%s0)
  constant     99           (skip, not supported by uprobe)

Key differences from other architectures:
 - Register names use ABI aliases (a0-a7, t0-t6, s0-s11, sp, ra, etc.)
   without any '%' prefix, unlike x86 (%rax) or arm64 (x0).
 - Memory operands use OFFSET(REG) syntax where OFFSET may be negative,
   unlike arm64's [sp, NUM] or powerpc's NUM(%rREG).

Two regexes are used:
 - SDT_OP_REGEX1: matches RISC-V ABI register names saved in pt_regs
 - SDT_OP_REGEX2: matches [-]NUM(REG) memory operands

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---

Tested on RISC-V QEMU(rv64gc) with GCC-generated SDT probes.
Requires systemtap-sdt-dev (provides <sys/sdt.h>) on the target system.

  # cat sdt_test.c
  #include <sys/sdt.h>
  #include <stdio.h>
  void my_func(int a, long b) {
      DTRACE_PROBE2(myapp, my_probe, a, b);
      printf("a=%d b=%ld\n", a, b);
  }
  int main() { my_func(42, -100); return 0; }

  # gcc -O0 -Wl,--build-id -o sdt_test_O0 sdt_test.c  # stack args: -20(s0)
  # gcc -O2 -Wl,--build-id -o sdt_test_O2 sdt_test.c  # reg args:   a0
  # perf buildid-cache --add sdt_test_O0
  # perf buildid-cache --add sdt_test_O2
  # find ~/.debug -name "probes" | xargs cat
  p:sdt_myapp/my_probe .../sdt_test_O0:0x530 arg1=-20(%s0):s32 arg2=-32(%s0):s64
  p:sdt_myapp/my_probe .../sdt_test_O2:0x538 arg1=%a0:s32 arg2=%a1:s64

Changes in v3:
 - Add two Reviewed-by tags.
 - No actual update, just to re-trigger sashiko's review.

Changes in v2:
 - Remove 'zero' (x0) from register regexes.
 - Fix sdt_init_op_regex() to return -ret on error.

 .../util/perf-regs-arch/perf_regs_riscv.c     | 128 ++++++++++++++++++
 tools/perf/util/perf_regs.c                   |   3 +
 tools/perf/util/perf_regs.h                   |   1 +
 3 files changed, 132 insertions(+)

diff --git a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
index 5b5f21fcba8c..bf769304c97c 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
@@ -1,8 +1,136 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <errno.h>
+#include <regex.h>
+#include <string.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+
+#include "../debug.h"
 #include "../perf_regs.h"
 #include "../../arch/riscv/include/perf_regs.h"
 
+/*
+ * RISC-V SDT argument formats (GCC 'nor' constraint):
+ *
+ * Register:  REG        e.g. a0, t1, s0, sp
+ * Memory:    NUM(REG)   e.g. 8(a0), -20(s0)
+ * Constant:  NUM        e.g. 99  (not supported by uprobe, skip)
+ *
+ * Note: 'zero' (x0) is hardwired to 0 and not in pt_regs; skip it.
+ *
+ * Uprobe target format:
+ *   Register: %REG       e.g. %a0
+ *   Memory:   +NUM(%REG) or -NUM(%REG)
+ */
+
+/* RISC-V register ABI names: ra, sp, gp, tp, t0-t6, s0-s11, a0-a7 */
+#define SDT_OP_REGEX1  "^(ra|sp|gp|tp|t[0-6]|s[0-9]|s1[01]|a[0-7])$"
+
+/* RISC-V memory operand: [-]NUM(REG) */
+#define SDT_OP_REGEX2  "^(\\-)?([0-9]+)\\((ra|sp|gp|tp|t[0-6]|s[0-9]|s1[01]|a[0-7])\\)$"
+
+static regex_t sdt_op_regex1, sdt_op_regex2;
+
+static int sdt_init_op_regex(void)
+{
+	static int initialized;
+	int ret = 0;
+
+	if (initialized)
+		return 0;
+
+	ret = regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
+	if (ret)
+		goto error;
+
+	ret = regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
+	if (ret)
+		goto free_regex1;
+
+	initialized = 1;
+	return 0;
+
+free_regex1:
+	regfree(&sdt_op_regex1);
+error:
+	pr_debug4("Regex compilation error.\n");
+	return -ret;
+}
+
+/*
+ * Parse OP and convert it into uprobe format.
+ * Possible variants of OP (RISC-V, GCC 'nor' constraint):
+ *
+ *   Format         Example       Uprobe
+ *   ----------------------------------------
+ *   REG            a0            %a0
+ *   NUM(REG)       8(a0)         +8(%a0)
+ *   -NUM(REG)      -20(s0)       -20(%s0)
+ *   NUM            99            (skip, constant not supported)
+ */
+int __perf_sdt_arg_parse_op_riscv(char *old_op, char **new_op)
+{
+	int ret, new_len;
+	regmatch_t rm[4];
+	char prefix;
+
+	/*
+	 * Constant argument: pure integer with no trailing '(' (e.g. "99", "-1").
+	 * uprobe does not support immediate values, so skip them.
+	 * Memory operands like "8(a0)" or "-20(s0)" contain '(' so are NOT
+	 * treated as constants here; they will be matched by REGEX2 below.
+	 */
+	if (strchr(old_op, '(') == NULL &&
+	    ((*old_op >= '0' && *old_op <= '9') ||
+	     (*old_op == '-' && old_op[1] >= '0' && old_op[1] <= '9'))) {
+		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
+		return SDT_ARG_SKIP;
+	}
+
+	ret = sdt_init_op_regex();
+	if (ret < 0)
+		return ret;
+
+	if (!regexec(&sdt_op_regex1, old_op, 2, rm, 0)) {
+		/* REG --> %REG */
+		new_len = 2;	/* % NULL */
+		new_len += (int)(rm[1].rm_eo - rm[1].rm_so);
+
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		scnprintf(*new_op, new_len, "%%%.*s",
+			(int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so);
+	} else if (!regexec(&sdt_op_regex2, old_op, 4, rm, 0)) {
+		/*
+		 * NUM(REG) or -NUM(REG) --> +NUM(%REG) or -NUM(%REG)
+		 * rm[1]: optional '-'
+		 * rm[2]: decimal offset
+		 * rm[3]: register name
+		 */
+		prefix = (rm[1].rm_so == -1) ? '+' : '-';
+
+		new_len = 5;	/* sign ( % ) NULL */
+		new_len += (int)(rm[2].rm_eo - rm[2].rm_so);
+		new_len += (int)(rm[3].rm_eo - rm[3].rm_so);
+
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		scnprintf(*new_op, new_len, "%c%.*s(%%%.*s)", prefix,
+			(int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so,
+			(int)(rm[3].rm_eo - rm[3].rm_so), old_op + rm[3].rm_so);
+	} else {
+		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
+		return SDT_ARG_SKIP;
+	}
+
+	return SDT_ARG_VALID;
+}
+
 uint64_t __perf_reg_mask_riscv(bool intr __maybe_unused)
 {
 	return PERF_REGS_MASK;
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 5b8f34beb24e..57a1d227d1b2 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -19,6 +19,9 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op)
 	case EM_PPC64:
 		ret = __perf_sdt_arg_parse_op_powerpc(old_op, new_op);
 		break;
+	case EM_RISCV:
+		ret = __perf_sdt_arg_parse_op_riscv(old_op, new_op);
+		break;
 	case EM_386:
 	case EM_X86_64:
 		ret = __perf_sdt_arg_parse_op_x86(old_op, new_op);
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 7c04700bf837..e0b51b514ee0 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -53,6 +53,7 @@ const char *__perf_reg_name_powerpc(int id);
 uint64_t __perf_reg_ip_powerpc(void);
 uint64_t __perf_reg_sp_powerpc(void);
 
+int __perf_sdt_arg_parse_op_riscv(char *old_op, char **new_op);
 uint64_t __perf_reg_mask_riscv(bool intr);
 const char *__perf_reg_name_riscv(int id);
 uint64_t __perf_reg_ip_riscv(void);
-- 
2.50.1

