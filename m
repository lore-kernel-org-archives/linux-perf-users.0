Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2C6286D70;
	Wed,  1 Jul 2026 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878090; cv=none; b=SRcOR6DhCOwCuKiCfpj82YzszgmmCXbPTjRiKVEdXAjTfvDmz751YWfA3CODOPzlE9jCyPUPBSmi32iUCfL23AwWpF4d+infu721jE/DkJFgD1K5i50qpFX0VsidisBJjrnLHwWt+DGoc3crbPYIy2yalTyOSw97dMCqC2Mumnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878090; c=relaxed/simple;
	bh=fD/qtdM7o3zmVCYM4ViQc85cx31RTFVB78UPR7eXopE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kz4hAo3wj1r+oo9MPbiPtco/KzTAI/koPN8eSNGcaE+cmdJkUR574B8AtVAYNxjCEqSTPF0QRboGK4R7HhKPsSTuV4arApcCAms40Mkcrggno65oJbbat3JZKO4DiCEVI+avbV3XJ0Q3UuyYl8rFLvZtkDuLWjRQaI5ZAHiDNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmMz3N4DzYQtn9;
	Wed,  1 Jul 2026 11:53:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5501C40561;
	Wed,  1 Jul 2026 11:54:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S6;
	Wed, 01 Jul 2026 11:54:45 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v3 04/21] perf annotate-arm64: Generalize arm64_mov__parse to support more instructions
Date: Wed,  1 Jul 2026 03:53:38 +0000
Message-Id: <20260701035355.752944-5-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701035355.752944-1-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGryrXr1ktrWftrWDZw13urg_yoWrKrWkpa
	nFk345tr4FgrWrWanxJr4vvwn3Ww4I934Y9Fy8J3Z3Aw4SkrWrt3Z3KF1akF4rGF97ur4U
	tFsYyr1rGrWDJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0piPkusUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

As the default parser for arm64 instructions, arm64_mov__parse()
currently only supports parsing instructions with the 'addr <symbol>'
suffix. Other instructions are not supported, causing a lack of
source and target information for most regular instructions.

Generalize arm64_mov__parse to extend its parsing capabilities:
1. Parse 'ops->target.raw' and 'ops->source.raw' by default.
2. Utilize arm64__check_multi_regs() to identify if 'ops->source.raw'
   contains multiple registers.
3. Maintain backward compatibility for instructions containing the
   'addr <symbol>' suffix.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 118 ++++++++++++++----
 1 file changed, 95 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 33080fdca125..a1667237114a 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -4,6 +4,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/zalloc.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
 #include <regex.h>
 #include "../annotate.h"
 #include "../disasm.h"
@@ -14,59 +16,129 @@ struct arch_arm64 {
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
+	/*
+	 * Special-purpose registers:
+	 * sp: stack pointer
+	 * xzr/wzr: zero registers
+	 */
+	if (!strncmp(op, "sp", 2) || !strncmp(op, "xzr", 3) ||
+	    !strncmp(op, "wzr", 3))
+		return true;
+
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
+static int arm64_mov__parse(const struct arch *arch,
 			    struct ins_operands *ops,
 			    struct map_symbol *ms __maybe_unused,
 			    struct disasm_line *dl __maybe_unused)
 {
-	char *s = strchr(ops->raw, ','), *target, *endptr;
+	char *s = strchr(ops->raw, ','), *source, *endptr, *comment, prev;
 
 	if (s == NULL)
 		return -1;
 
 	*s = '\0';
-	ops->source.raw = strdup(ops->raw);
+	ops->target.raw = strdup(ops->raw);
 	*s = ',';
 
-	if (ops->source.raw == NULL)
+	if (ops->target.raw == NULL)
 		return -1;
 
-	target = ++s;
-	ops->target.raw = strdup(target);
-	if (ops->target.raw == NULL)
-		goto out_free_source;
+	/* Parse source, discarding comment if present */
+	source = skip_spaces(++s);
+	comment = strchr(s, arch->objdump.comment_char);
+
+	if (comment != NULL)
+		s = comment - 1;
+	else
+		s = strchr(s, '\0') - 1;
 
-	ops->target.addr = strtoull(target, &endptr, 16);
-	if (endptr == target)
-		goto out_free_target;
+	while (s > source && isspace(s[0]))
+		--s;
+	s++;
+	prev = *s;
+	*s = '\0';
+	ops->source.raw = strdup(source);
+	*s = prev;
 
+	if (ops->source.raw == NULL) {
+		zfree(&ops->target.raw);
+		return -1;
+	}
+
+	ops->source.multi_regs = arm64__check_multi_regs(arch, ops->source.raw);
+
+	/* Parse address from source (if any) */
+	ops->source.addr = strtoull(source, &endptr, 16);
+	if (endptr == source)
+		return 0;
+
+	/* Parse a symbol followed by an address, if present */
 	s = strchr(endptr, '<');
 	if (s == NULL)
-		goto out_free_target;
-	endptr = strchr(s + 1, '>');
+		return 0;
+	endptr = strrchr(s + 1, '>');
 	if (endptr == NULL)
-		goto out_free_target;
+		return 0;
 
 	*endptr = '\0';
 	*s = ' ';
-	ops->target.name = strdup(s);
+	s = skip_spaces(++s);
+	ops->source.name = strdup(s);
 	*s = '<';
 	*endptr = '>';
-	if (ops->target.name == NULL)
-		goto out_free_target;
 
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
-- 
2.34.1

