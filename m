Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204955476E8;
	Tue,  8 Sep 2026 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872529; cv=none; b=Ko633YLkIR6G+UC1neFa7OojA7sw2o4/dRnamG0rVlXNk350RGfid+s+w9A/WDHFLOLI7FnhR/jl2qGuU5JwWUzucfs0bv5uSNYQKzjmOaLVsmNiLe5rdVZXgC/vuL25Wg9HCl+mEbgmDRWO5unL9agPpXyxrJ2MvP6adg2UZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872529; c=relaxed/simple;
	bh=jWCyyfZ9I3VCtLkKmk044coxRXktwvjMCKi5KK2n5aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2rOVQHeh511ca8nhjJSclo2iGhf1/u568S5NI8F05vkJ72FH88Bu1dpgkH0FTbYtkFOVx4QztPdiUBNpBpuSFxthuwNJP8GA5YhqDZ4MFdzj1CDj65OT32Ijj6iBYjm+CMF2kHDVhBFEsgI7PR/fapeEOFnGi6F2H7QOdC8HfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPGR6T1JzKHN34;
	Tue,  8 Sep 2026 21:01:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3A9D64058D;
	Tue,  8 Sep 2026 21:01:53 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S3;
	Tue, 08 Sep 2026 21:01:52 +0800 (CST)
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
Subject: [PATCH v5 01/26] perf capstone: Symbolize address operands to match objdump on arm64
Date: Tue,  8 Sep 2026 13:00:57 +0000
Message-Id: <20260908130122.633500-2-wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtw15AF13JFWDKFW5Gr1rZwb_yoWfWFW7pa
	1kC345Xrs5JF1fWws5Ja1kX343K393XF1Yk3y7C3ySkrnIgrn3JayxKFya9Fy5GrykGw47
	tFs0yr45Wrs3Jr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRXdb1UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Capstone currently outputs address-bearing instructions with a raw hex
value prefixed by '#', without symbolic resolution. This differs from
objdump output and leads to parse failures in jump__parse() and
arm64_mov__parse() on arm64.

Example of the mismatch:
  Current: b #0xffff8000800114c8
  Objdump: b ffff8000800114c8 <el0t_64_sync+0x108>

  Current: adrp x18, #0xffff800081f5f000
  Objdump: adrp x18, ffff800081f5f000 <this_cpu_vector>

Fix this by extending symbol__disassemble_capstone() to:
- Enable CS_OPT_DETAIL for arm64 to access instruction group info.
- Detect instructions with address operands requiring symbolization
  (jump/call/branch/adr/adrp) via opcode or Capstone group ID.
- Resolve target addresses to symbols via resolve_symbol_from_addr().
- Format output to match objdump's style (strip '#' prefix, add
  symbol and offset).

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/capstone.c | 185 +++++++++++++++++++++++++++++--------
 tools/perf/util/disasm.c   |   5 +
 tools/perf/util/disasm.h   |   1 +
 3 files changed, 153 insertions(+), 38 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 74213daf8786..7f82c33e3464 100644
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
+#define ARM64_GRP_BRANCH_RELATIVE  7  /* = CS_GRP_BRANCH_RELATIVE */
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
@@ -292,16 +303,44 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine, struct thread *threa
 	return printed;
 }
 
+static int resolve_symbol_from_addr(struct map *map, u64 addr,
+				    const char **sym_name, u64 *sym_offset)
+{
+	struct map *found_map = NULL;
+	struct symbol *sym;
+	u64 al_addr;
+	u64 ip = map__objdump_2mem(map, addr);
+
+	if (dso__kernel(map__dso(map))) {
+		/*
+		 * The kernel maps can be split into sections, let's
+		 * find the map first and then search the symbol.
+		 */
+		found_map = maps__find(map__kmaps(map), ip);
+		if (found_map == NULL)
+			return -1;
+		map = found_map;
+	}
+
+	/* convert it to map-relative address for search */
+	al_addr = map__map_ip(map, ip);
+
+	sym = map__find_symbol(map, al_addr);
+	map__put(found_map);
+
+	if (sym == NULL)
+		return -1;
+
+	*sym_name = sym->name;
+	*sym_offset = al_addr - sym->start;
+	return 0;
+}
+
 static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 				  struct annotate_args *args, u64 addr)
 {
 	int i;
 	struct map *map = args->ms->map;
-	struct symbol *sym;
-
-	/* TODO: support more architectures */
-	if (!arch__is_x86(args->arch))
-		return;
 
 	if (insn->detail == NULL)
 		return;
@@ -309,7 +348,8 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 	for (i = 0; i < insn->detail->x86.op_count; i++) {
 		struct cs_x86_op *op = &insn->detail->x86.operands[i];
 		u64 orig_addr;
-		struct map *found_map = NULL;
+		const char *sym_name = NULL;
+		u64 sym_offset;
 
 		if (op->type != X86_OP_MEM)
 			continue;
@@ -320,40 +360,114 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 
 		/* get the target address */
 		orig_addr = addr + insn->size + op->mem.disp;
-		addr = map__objdump_2mem(map, orig_addr);
-
-		if (dso__kernel(map__dso(map))) {
-			/*
-			 * The kernel maps can be split into sections, let's
-			 * find the map first and then search the symbol.
-			 */
-			found_map = maps__find(map__kmaps(map), addr);
-			if (found_map == NULL)
-				continue;
-			map = found_map;
-		}
-
-		/* convert it to map-relative address for search */
-		addr = map__map_ip(map, addr);
-
-		sym = map__find_symbol(map, addr);
-		if (sym == NULL) {
-			map__put(found_map);
+		if (resolve_symbol_from_addr(map, orig_addr, &sym_name, &sym_offset))
 			continue;
-		}
 
-		if (addr == sym->start) {
+		if (sym_offset == 0) {
 			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
-				  orig_addr, sym->name);
+				  orig_addr, sym_name);
 		} else {
 			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
-				  orig_addr, sym->name, addr - sym->start);
+				  orig_addr, sym_name, sym_offset);
 		}
-		map__put(found_map);
 		break;
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
+static bool needs_symbolic_address(struct cs_insn *insn)
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
+	char *last_imm, *endptr;
+	u64 addr;
+
+	print_default_format(insn, buf, len);
+	/*
+	 * Adjust instructions to keep the existing behavior with objdump.
+	 *
+	 * Example conversion:
+	 * From: b #0xffff8000800114c8
+	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
+	 */
+	if (needs_symbolic_address(insn)) {
+		const char *sym_name = NULL;
+		u64 sym_offset;
+
+		/* Extract last immediate value as address */
+		last_imm = strrchr(buf, '#');
+		if (!last_imm)
+			return;
+
+		addr = strtoull(last_imm + 1, &endptr, 16);
+		if (endptr == last_imm + 1)
+			return;
+
+		if (resolve_symbol_from_addr(map, addr, &sym_name, &sym_offset))
+			return;
+
+		/* Symbolize the resolved address */
+		len = len - (last_imm - buf);
+		if (sym_offset == 0) {
+			scnprintf(last_imm, len, "%"PRIx64" <%s>",
+				  addr, sym_name);
+		} else {
+			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
+				  addr, sym_name, sym_offset);
+		}
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
@@ -446,14 +560,9 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 
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

