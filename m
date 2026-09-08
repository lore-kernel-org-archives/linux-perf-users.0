Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832B548540;
	Tue,  8 Sep 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872523; cv=none; b=Jg+DLSCVXMU/YirYASZtQifCSC9THzhlFIoa8UWFd3TRnsSuDAggLE+w62UFhML/lbXJKqpt4tFAb2o67OcGlrjOdoU9N03IDBB0jtxA9Wmr3ZvW0ZSlLbAR9pn+s9lGiLta25R8MKkIA6Zdz6OiUGexSBPsYBSGiSpkBlsRqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872523; c=relaxed/simple;
	bh=hFcovPbpIMEDyB5q02fyXL/9S359lyav1KWVv5tT4/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5WIo7yJXJ5VLdVUh3NYLJVlxVwr1SPxJWTWxamXvajOKQI1lOwdKC9FgFKt9q5EgXzs7fV+gfVse8QV5aQZeW/eT8aTh318+hWmuMlbF3V55Hz93hUMeEGa4JKaNr4K2rsBlRy8NMFpyxcdRATCVSdab+Z9PDfwnW+34Pr1864=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPGS0cDbzKHN43;
	Tue,  8 Sep 2026 21:01:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6900C4056B;
	Tue,  8 Sep 2026 21:01:53 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S5;
	Tue, 08 Sep 2026 21:01:53 +0800 (CST)
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
Date: Tue,  8 Sep 2026 13:00:59 +0000
Message-Id: <20260908130122.633500-4-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908130122.633500-1-wutengda@huaweicloud.com>
References: <20260908130122.633500-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1xurWfZFyfCw1kXw48Crg_yoWxJryDpa
	n2kw1rtr48Wr1Fgws3Jrs2vrn3Ww4fK34a9a48tas3Awsa9ryrKan3KF1akF4rGryxurWU
	tFnYvryrJr4DJaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRO_-kUUUUU=
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

