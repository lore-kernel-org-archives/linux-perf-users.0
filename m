Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BDF396B7F;
	Fri,  3 Apr 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209735; cv=none; b=a6RizqvYHKZYNA+z2wxUmfh13bE7qLOlzeiqrkeFfHYJwbQLu5RwQHB2+jc6DCLyiQtfz+3rlWZmGN3TbxV6i/02ubRWXxrmbb+PU3GQb/PryCz72KgGIIfR9nQ9oCKHm/lzpkYjjwsVsLjsLhyY/9Yv7i7NZl0WRac6zdch6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209735; c=relaxed/simple;
	bh=sYdJ4JgRb9FfIMhXQOwR/uePWEnfu+fttCVSfbZNBe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVWH96BZoSNO7gKpUuWqLjBrYnppYN0PFjUjteoe8xYg0FdwKf9HCYVsGu78TrAKCGUeKNu5vKTyTxhlAhBg6HS+RUuomxoAuyYmelX5163rSXC8E32Et3mewSJnuFLQ+NmBxkWSyOU8G92yhRy+0KnX76pLmrbLvnTR+UKhNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnDS806GgzYQttW;
	Fri,  3 Apr 2026 17:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6DE2740573;
	Fri,  3 Apr 2026 17:48:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S6;
	Fri, 03 Apr 2026 17:48:49 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v2 04/16] perf annotate-arm64: Handle load and store instructions
Date: Fri,  3 Apr 2026 09:47:48 +0000
Message-Id: <20260403094800.1418825-5-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403094800.1418825-1-wutengda@huaweicloud.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4ftrWUGr4ruFWfZr1xGrg_yoWrZr1kpa
	nFk345Jr4UWr4Fg3WfXFsru34fKw4UJw1a9ry8J3s3Ca4Ivr97tF4kKr1akF4rGrWkCw4U
	XFn0vry8Wry5ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Add ldst_ops to handle load and store instructions in order to parse
the data types and offsets associated with PMU events for memory access
instructions. There are many variants of load and store instructions in
ARM64, making it difficult to match all of these instruction names
completely. Therefore, only the instruction prefixes are matched. The
prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
matches atomic instructions, and 'prf' matches memory prefetch
instructions.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 4c42323b0c18..8209faaa6086 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -3,7 +3,9 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
 #include <linux/zalloc.h>
+#include <linux/string.h>
 #include <regex.h>
 #include "../annotate.h"
 #include "../disasm.h"
@@ -12,6 +14,7 @@ struct arch_arm64 {
 	struct arch arch;
 	regex_t call_insn;
 	regex_t jump_insn;
+	regex_t ldst_insn; /* load and store instruction */
 };
 
 static bool arm64__check_multi_regs(const char *op)
@@ -114,6 +117,59 @@ static const struct ins_ops arm64_mov_ops = {
 	.scnprintf = mov__scnprintf,
 };
 
+static int arm64_ldst__parse(const struct arch *arch __maybe_unused,
+			     struct ins_operands *ops,
+			     struct map_symbol *ms __maybe_unused,
+			     struct disasm_line *dl __maybe_unused)
+{
+	char *s, *target;
+
+	/*
+	 * The part starting from the memory access annotation '[' is parsed
+	 * as 'target', while the part before it is parsed as 'source'.
+	 */
+	target = s = strchr(ops->raw, arch->objdump.memory_ref_char);
+	if (!s)
+		return -1;
+
+	while (s > ops->raw && *s != ',')
+		--s;
+
+	if (s == ops->raw)
+		return -1;
+
+	*s = '\0';
+	ops->source.raw = strdup(ops->raw);
+
+	*s = ',';
+	if (!ops->source.raw)
+		return -1;
+
+	ops->source.multi_regs = arm64__check_multi_regs(ops->source.raw);
+
+	ops->target.raw = strdup(target);
+	if (!ops->target.raw) {
+		zfree(&ops->source.raw);
+		return -1;
+	}
+	ops->target.mem_ref = true;
+	ops->target.multi_regs = arm64__check_multi_regs(ops->target.raw);
+
+	return 0;
+}
+
+static int arm64_ldst__scnprintf(const struct ins *ins, char *bf, size_t size,
+				 struct ins_operands *ops, int max_ins_name)
+{
+	return scnprintf(bf, size, "%-*s %s,%s", max_ins_name, ins->name,
+			 ops->source.raw, ops->target.raw);
+}
+
+static struct ins_ops arm64_ldst_ops = {
+	.parse	   = arm64_ldst__parse,
+	.scnprintf = arm64_ldst__scnprintf,
+};
+
 static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	struct arch_arm64 *arm = container_of(arch, struct arch_arm64, arch);
@@ -124,6 +180,8 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
 		ops = &jump_ops;
 	else if (!regexec(&arm->call_insn, name, 2, match, 0))
 		ops = &call_ops;
+	else if (!regexec(&arm->ldst_insn, name, 2, match, 0))
+		ops = &arm64_ldst_ops;
 	else if (!strcmp(name, "ret"))
 		ops = &ret_ops;
 	else
@@ -148,6 +206,8 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->id = *id;
 	arch->objdump.comment_char	  = '/';
 	arch->objdump.skip_functions_char = '+';
+	arch->objdump.memory_ref_char	  = '[';
+	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 
 	/* bl, blr */
@@ -161,8 +221,20 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	if (err)
 		goto out_free_call;
 
+	/*
+	 * The ARM64 architecture has many variants of load/store instructions.
+	 * It is quite challenging to match all of them completely. Here, we
+	 * only match the prefixes of these instructions.
+	 */
+	err = regcomp(&arm->ldst_insn, "^(ld|st|cas|prf|swp)",
+		      REG_EXTENDED);
+	if (err)
+		goto out_free_jump;
+
 	return arch;
 
+out_free_jump:
+	regfree(&arm->jump_insn);
 out_free_call:
 	regfree(&arm->call_insn);
 out_free_arm:
-- 
2.34.1

