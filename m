Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B644A3859;
	Tue,  8 Sep 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872748; cv=none; b=Zfd1mVO8SLKnEw9xneMoRHuCfLrc9JRQHMGhMcFfusA3yixbw3v/bE33E/0+RL9JfbxB428Us62Le1mCsdLQw2zorPxBJRd7xfOw2ylBcm6Rin/lviBDavklX8a11DyGiriQ8pnIZWuvxIgM4ApsYYdA3T8J7wm72ziF6rXRgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872748; c=relaxed/simple;
	bh=hFcovPbpIMEDyB5q02fyXL/9S359lyav1KWVv5tT4/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=coXCNEozqhioQleJc9HfgG3g3cs26pMrXB+QweB7/nxQ1uFF0+SfTVfyqvSXdnYfQgLN+4pc3Y/JSJz1Jnf4+CaUGS7CzaMz7R8nfRX4XULRXLX2j5MWfeMPywNx5TB5Pg7QmpMO2fsXgFnALEciEXq6lC1MMB6clLYDxCF7sKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPKt70d5zYQw16;
	Tue,  8 Sep 2026 21:04:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7B74640577;
	Tue,  8 Sep 2026 21:05:42 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S5;
	Tue, 08 Sep 2026 21:05:42 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v5 03/26] perf annotate-arm64: Generalize arm64_mov__parse to support more instructions
Date: Tue,  8 Sep 2026 13:05:06 +0000
Message-Id: <872f51108191d20f65fc12f17c796863a36166da.1788872630.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1xurWfZFyfCw1kXw48Crg_yoWxJryDpa
	n2kw1rtr48Wr1Fgws3Jrs2vrn3Ww4fK34a9a48tas3Awsa9ryrKan3KF1akF4rGryxurWU
	tFnYvryrJr4DJaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxkF7I0Ew4C26cxK
	6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
	JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7sRQ
	2-bUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

As the default parser for arm64 instructions, arm64_mov__parse()
currently only supports parsing instructions with the 'addr <symbol>'
suffix. Other instructions are not supported, causing a lack of
source and target information for most regular instructions.

Generalize arm64_mov__parse to extend its parsing capabilities:
1. Parse 'ops->target.raw' and 'ops->source.raw' by default.
2. Utilize arm64__check_multi_regs() to identify if source and
   target contain multiple registers.
3. Maintain backward compatibility for instructions containing the
   'addr <symbol>' suffix.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 166 ++++++++++++++----
 1 file changed, 134 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 33080fdca125..151184210691 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -3,6 +3,8 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <linux/ctype.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <regex.h>
 #include "../annotate.h"
@@ -14,59 +16,158 @@ struct arch_arm64 {
 	regex_t jump_insn;
 };
 
-static int arm64_mov__parse(const struct arch *arch __maybe_unused,
+static bool arm64__is_reg(const char *op)
+{
+	if (!op || !*op)
+		return false;
+
+	/*
+	 * General-purpose registers: x0-x30, w0-w30.
+	 * Check for 'x' or 'w' prefix followed by a numeric index.
+	 */
+	if ((op[0] == 'x' || op[0] == 'w') && isdigit(op[1]))
+		return true;
+
+	/* Special-purpose registers: sp, wzr, xzr. */
+	if (!strncmp(op, "sp", 2) || !strncmp(op, "xzr", 3) ||
+	    !strncmp(op, "wzr", 3))
+		return true;
+
+	/* TODO: Support more registers. */
+	return false;
+}
+
+static bool arm64__check_multi_regs(const struct arch *arch, const char *op)
+{
+	const char *p = op;
+	int reg_count = 0;
+
+	while (p && *p) {
+		p = skip_spaces(p);
+		if (*p == arch->objdump.memory_ref_char)
+			p++;
+
+		if (arm64__is_reg(p))
+			reg_count++;
+
+		if (reg_count >= 2)
+			return true;
+
+		/* Move to next operand after comma */
+		p = strchr(p, ',');
+		if (p)
+			p++;
+	}
+
+	return false;
+}
+
+/*
+ * Duplicate @insn, stripping the comment and trailing whitespace.
+ * Returns a newly allocated string which the caller must free(),
+ * or NULL on allocation failure or if @insn is NULL.
+ */
+static char *rstrip_space_and_comment(const char *insn, char comment_char)
+{
+	const char *end, *comment;
+	size_t len;
+	char *result;
+
+	if (insn == NULL)
+		return NULL;
+
+	comment = strchr(insn, comment_char);
+	if (comment != NULL)
+		end = comment;
+	else
+		end = insn + strlen(insn);
+
+	while (end > insn && isspace(end[-1]))
+		--end;
+
+	len = end - insn;
+	result = malloc(len + 1);
+	if (result == NULL)
+		return NULL;
+
+	memcpy(result, insn, len);
+	result[len] = '\0';
+
+	return result;
+}
+
+static int arm64_mov__parse(const struct arch *arch,
 			    struct ins_operands *ops,
 			    struct map_symbol *ms __maybe_unused,
 			    struct disasm_line *dl __maybe_unused)
 {
-	char *s = strchr(ops->raw, ','), *target, *endptr;
+	char *s = strchr(ops->raw, ','), *source, *endptr;
 
 	if (s == NULL)
 		return -1;
 
+	/* Parse target */
 	*s = '\0';
-	ops->source.raw = strdup(ops->raw);
+	ops->target.raw = strdup(ops->raw);
 	*s = ',';
 
-	if (ops->source.raw == NULL)
-		return -1;
-
-	target = ++s;
-	ops->target.raw = strdup(target);
 	if (ops->target.raw == NULL)
-		goto out_free_source;
+		return -1;
 
-	ops->target.addr = strtoull(target, &endptr, 16);
-	if (endptr == target)
-		goto out_free_target;
+	ops->target.multi_regs = arm64__check_multi_regs(arch, ops->target.raw);
 
-	s = strchr(endptr, '<');
-	if (s == NULL)
-		goto out_free_target;
-	endptr = strchr(s + 1, '>');
-	if (endptr == NULL)
-		goto out_free_target;
-
-	*endptr = '\0';
-	*s = ' ';
-	ops->target.name = strdup(s);
-	*s = '<';
-	*endptr = '>';
-	if (ops->target.name == NULL)
-		goto out_free_target;
+	/* Parse source, stripping comment if present */
+	source = skip_spaces(++s);
+	ops->source.raw = rstrip_space_and_comment(source, arch->objdump.comment_char);
+	if (ops->source.raw == NULL) {
+		zfree(&ops->target.raw);
+		return -1;
+	}
+
+	ops->source.multi_regs = arm64__check_multi_regs(arch, ops->source.raw);
+
+	/*
+	 * Parse 'addr <symbol>' from source (if any).
+	 *
+	 * A raw hex string may be a scalar immediate, not an address.
+	 * Only validate 'source.addr' if accompanied by a '<symbol>' tag,
+	 * otherwise reset it to 0 to avoid false positive address tracking.
+	 */
+	ops->source.addr = strtoull(ops->source.raw, &endptr, 16);
+	if (endptr != ops->source.raw) {
+		s = strchr(endptr, '<');
+		if (s == NULL) {
+			ops->source.addr = 0;
+			return 0;
+		}
+		endptr = strrchr(s + 1, '>');
+		if (endptr == NULL) {
+			ops->source.addr = 0;
+			return 0;
+		}
+
+		*endptr = '\0';
+		ops->source.name = strdup(s + 1);
+		*endptr = '>';
+		if (ops->source.name == NULL) {
+			ops->source.addr = 0;
+			return 0;
+		}
+	}
 
 	return 0;
+}
 
-out_free_target:
-	zfree(&ops->target.raw);
-out_free_source:
-	zfree(&ops->source.raw);
-	return -1;
+static int arm64_mov__scnprintf(const struct ins *ins, char *bf, size_t size,
+				struct ins_operands *ops, int max_ins_name)
+{
+	return scnprintf(bf, size, "%-*s %s, %s", max_ins_name, ins->name,
+			 ops->target.raw, ops->source.name ?: ops->source.raw);
 }
 
 static const struct ins_ops arm64_mov_ops = {
 	.parse	   = arm64_mov__parse,
-	.scnprintf = mov__scnprintf,
+	.scnprintf = arm64_mov__scnprintf,
 };
 
 static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
@@ -103,6 +204,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->id = *id;
 	arch->objdump.comment_char	  = '/';
 	arch->objdump.skip_functions_char = '+';
+	arch->objdump.memory_ref_char	  = '[';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 
 	/* bl, blr */
-- 
2.34.1

