Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1B2415F1E;
	Sat,  8 Aug 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193076; cv=none; b=OO9EcJjqXa65Bc37ZGyyxExu68hL/fSW8LYWIUT9/StnmbGasnKT4ajkGTrHC2+j4Qn+fQ0xHVj8LamXX59W3UFgMGiCopL+T9kZdqy8oY2tf9oSJsnMAnHbRWSkRqVW7svoccrQ61G7M1lbIwrCubJMBQacCEv8szZkd3Uw7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193076; c=relaxed/simple;
	bh=LAyGolb0cHspUqjIQr3siyEE9NWXtxPLUKsXa7w4Als=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBsmJ9dllt+HWDzzfQyg6r07t7x0/fUy3S888BZjZg/OVqrYn9pHjqg/zrHqnGuCistdlqAf0LsCk3sryrCgnvhJu44AC3DtS/Xajl0ixs/1lIx6PSqLNJ3Hozw0X/dW+rdX7pCry59mam4KrNYY325lGryz3eAS7YRbiwtVni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hHKvB2GHpzKHNC1;
	Sat,  8 Aug 2026 20:24:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6A73F4070E;
	Sat,  8 Aug 2026 20:24:17 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S3;
	Sat, 08 Aug 2026 20:24:17 +0800 (CST)
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
Subject: [PATCH v4 01/23] perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
Date: Sat,  8 Aug 2026 12:23:38 +0000
Message-Id: <20260808122400.2961238-2-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808122400.2961238-1-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rKFyrWF17Kw4kJF4xWFg_yoWxur1rpa
	1DC345Jan5XF1fWw1fJa1kXw1ak3yfJr1Yk3y7K39akFnIkrn3XFWxKFya9Fn8GrykWw42
	qFs0kr15Wrs3JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxV
	A2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRNNVy3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The jump and adrp instructions parsed by libcapstone currently lack
symbolic representation and use a '#' prefix for addresses. This
format is inconsistent with objdump's output, which causes subsequent
parsing in jump__parse() and arm64_mov__parse() to fail.

Example mismatch:
  Current: b #0xffff8000800114c8
  Fix:     b ffff8000800114c8 <el0t_64_sync+0x108>

  Current: adrp x18, #0xffff800081f5f000
  Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>

Fix this by implementing extended formatting for these arm64
instructions during symbol__disassemble_capstone(). This ensures
the output matches objdump's expected style, including the raw
address and the associated <symbol+offset> suffix.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/capstone.c | 136 +++++++++++++++++++++++++++++++++----
 tools/perf/util/disasm.c   |   5 ++
 tools/perf/util/disasm.h   |   1 +
 3 files changed, 130 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 74213daf8786..fb8a2bc5558f 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -3,6 +3,7 @@
 
 #include <errno.h>
 #include <inttypes.h>
+#include <stdlib.h>
 #include <string.h>
 
 #include <dlfcn.h>
@@ -31,6 +32,10 @@
 #define CS_MODE_RISCVC   4
 #endif
 
+#if CS_VERSION_MAJOR < 4
+#define ARM64_GRP_BRANCH_RELATIVE  7
+#endif
+
 #ifdef LIBCAPSTONE_DLOPEN
 static void *perf_cs_dll_handle(void)
 {
@@ -225,6 +230,12 @@ static int capstone_init(uint16_t e_machine, csh *cs_handle, bool is64, bool is_
 		 * on x86 by investigating instruction details.
 		 */
 		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
+	} else if (arch == CS_ARCH_ARM64) {
+		/*
+		 * Same as x86: arm64 needs instruction details to resolve
+		 * symbolic addresses.
+		 */
+		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
 	}
 
 	return 0;
@@ -299,10 +310,6 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 	struct map *map = args->ms->map;
 	struct symbol *sym;
 
-	/* TODO: support more architectures */
-	if (!arch__is_x86(args->arch))
-		return;
-
 	if (insn->detail == NULL)
 		return;
 
@@ -354,6 +361,116 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 	}
 }
 
+static int print_default_format(struct cs_insn *insn, char *buf, size_t len)
+{
+	return scnprintf(buf, len, "       %-7s %s",
+			 insn->mnemonic, insn->op_str);
+}
+
+static void format_capstone_insn_x86(struct cs_insn *insn, char *buf,
+				     size_t len, struct annotate_args *args,
+				     u64 addr)
+{
+	int printed;
+
+	printed = print_default_format(insn, buf, len);
+	buf += printed;
+	len -= printed;
+
+	print_capstone_detail(insn, buf, len, args, addr);
+}
+
+static bool is_pc_relative_insn(struct cs_insn *insn)
+{
+	int i;
+
+	if (insn->id == ARM64_INS_ADR || insn->id == ARM64_INS_ADRP)
+		return true;
+
+	if (insn->detail == NULL)
+		return false;
+
+	for (i = 0; i < insn->detail->groups_count; i++) {
+		if (insn->detail->groups[i] == ARM64_GRP_JUMP ||
+		    insn->detail->groups[i] == ARM64_GRP_CALL ||
+		    insn->detail->groups[i] == ARM64_GRP_BRANCH_RELATIVE)
+			return true;
+	}
+
+	return false;
+}
+
+static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
+				       size_t len, struct annotate_args *args)
+{
+	struct map *map = args->ms->map;
+	struct symbol *sym;
+	char *last_imm, *endptr;
+	u64 orig_addr, addr;
+	struct map *found_map = NULL;
+
+	print_default_format(insn, buf, len);
+	/*
+	 * Adjust instructions to keep the existing behavior with objdump.
+	 *
+	 * Example conversion:
+	 * From: b #0xffff8000800114c8
+	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
+	 */
+	if (is_pc_relative_insn(insn)) {
+		/* Extract last immediate value as address */
+		last_imm = strrchr(buf, '#');
+		if (!last_imm)
+			return;
+
+		orig_addr = strtoull(last_imm + 1, &endptr, 16);
+		if (endptr == last_imm + 1)
+			return;
+
+		addr = map__objdump_2mem(map, orig_addr);
+
+		/* Relocate map that contains the address */
+		if (dso__kernel(map__dso(map))) {
+			found_map = maps__find(map__kmaps(map), addr);
+			if (found_map == NULL)
+				return;
+			map = found_map;
+		}
+
+		/* Convert it to map-relative address for search */
+		addr = map__map_ip(map, addr);
+
+		sym = map__find_symbol(map, addr);
+		if (sym == NULL) {
+			map__put(found_map);
+			return;
+		}
+
+		/* Symbolize the resolved address */
+		len = len - (last_imm - buf);
+		if (addr == sym->start) {
+			scnprintf(last_imm, len, "%"PRIx64" <%s>",
+				  orig_addr, sym->name);
+		} else {
+			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
+				  orig_addr, sym->name, addr - sym->start);
+		}
+		map__put(found_map);
+	}
+}
+
+static void format_capstone_insn(struct cs_insn *insn, char *buf, size_t len,
+				 struct annotate_args *args, u64 addr)
+{
+	/* TODO: support more architectures */
+	if (arch__is_x86(args->arch))
+		format_capstone_insn_x86(insn, buf, len, args, addr);
+	else if (arch__is_arm64(args->arch))
+		format_capstone_insn_arm64(insn, buf, len, args);
+	else
+		print_default_format(insn, buf, len);
+}
+
 struct find_file_offset_data {
 	u64 ip;
 	u64 offset;
@@ -446,14 +563,9 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 
 	free_count = count = perf_cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
-		int printed;
-
-		printed = scnprintf(disasm_buf, sizeof(disasm_buf),
-				    "       %-7s %s",
-				    insn[i].mnemonic, insn[i].op_str);
-		print_capstone_detail(&insn[i], disasm_buf + printed,
-				      sizeof(disasm_buf) - printed, args,
-				      start + offset);
+		format_capstone_insn(&insn[i], disasm_buf,
+				     sizeof(disasm_buf), args,
+				     start + offset);
 
 		args->offset = offset;
 		args->line = disasm_buf;
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 6cfdbabbb8c7..0ba38f70fe1a 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -203,6 +203,11 @@ bool arch__is_powerpc(const struct arch *arch)
 	return arch->id.e_machine == EM_PPC || arch->id.e_machine == EM_PPC64;
 }
 
+bool arch__is_arm64(const struct arch *arch)
+{
+	return arch->id.e_machine == EM_AARCH64;
+}
+
 static void ins_ops__delete(struct ins_operands *ops)
 {
 	if (ops == NULL)
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 25756e3f47e4..06c664fd4fc2 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -111,6 +111,7 @@ struct annotate_args {
 const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *cpuid);
 bool arch__is_x86(const struct arch *arch);
 bool arch__is_powerpc(const struct arch *arch);
+bool arch__is_arm64(const struct arch *arch);
 
 extern const struct ins_ops call_ops;
 extern const struct ins_ops dec_ops;
-- 
2.34.1

