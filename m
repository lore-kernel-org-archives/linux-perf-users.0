Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E882D7D2E;
	Wed,  1 Jul 2026 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878092; cv=none; b=FfE7aWXTpLswmMvyQmzrwh15tHEdPuVa+rPzUwKf0Z65ZnIW5FCIannq8WCUJ+PRqhE01Ucp89B2E8gteZ2OhyXlQb9plXxjlaqW7tOo3aGBO7G+6JKeITisAOV1BRhRKxO1E1mMonbFso+DfUh9ECHawJuKVO82dgEtbv6UVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878092; c=relaxed/simple;
	bh=IWyQGAE/Ea5jkHiSWm8yrIn7AN2/9ebbWqpKKLd/YpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PkhpWSEheDjunY6EwCsYXJ6XZYw/rDMUteM7cDDgjPyG+4NGzpBX1u3KxO+XCGkKpYvP+LqHM1q6npnGetNfxfFpT4M54vJLU7hIg61XVWxv7wH8/EgAG0FbFITQVQf4J49HPmGRfDlJvwSbD1tG5TAtTW0VkE6t/rbHD26a/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmMz29BPzYQtGf;
	Wed,  1 Jul 2026 11:53:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 28D294056F;
	Wed,  1 Jul 2026 11:54:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S4;
	Wed, 01 Jul 2026 11:54:44 +0800 (CST)
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
Subject: [PATCH v3 02/21] perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
Date: Wed,  1 Jul 2026 03:53:36 +0000
Message-Id: <20260701035355.752944-3-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rKFyrWF1xJF48GF18Grg_yoWxArW7pa
	1DC345Jan5XF1fWw4fJa1kX34a93yfXF1Yk3yxK39akFnIkrn3XFWxKFya9Fn8Gry8Ww42
	vFs0yF15Wrn3JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRQL00DUUUU
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
 tools/perf/util/capstone.c | 131 +++++++++++++++++++++++++++++++++----
 tools/perf/util/disasm.c   |   5 ++
 tools/perf/util/disasm.h   |   1 +
 3 files changed, 125 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 9bba78ee0c5a..a9c0a1d2eb03 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -218,6 +218,12 @@ static int capstone_init(uint16_t e_machine, csh *cs_handle, bool is64, bool is_
 		 * on x86 by investigating instruction details.
 		 */
 		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
+	} else if (machine__normalized_is(machine, "arm64")) {
+		/*
+		 * Same as x86: arm64 needs instruction details to resolve
+		 * symbolic addresses
+		 */
+		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
 	}
 
 	return 0;
@@ -292,10 +298,6 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 	struct map *map = args->ms->map;
 	struct symbol *sym;
 
-	/* TODO: support more architectures */
-	if (!arch__is_x86(args->arch))
-		return;
-
 	if (insn->detail == NULL)
 		return;
 
@@ -347,6 +349,116 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
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
+				       size_t len, struct annotate_args *args,
+				       u64 addr)
+{
+	struct map *map = args->ms->map;
+	struct symbol *sym;
+	char *last_imm, *endptr;
+	u64 orig_addr;
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
+		/* Relocate map that contains the address */
+		if (dso__kernel(map__dso(map))) {
+			found_map = maps__find(map__kmaps(map), orig_addr);
+			if (found_map == NULL)
+				return;
+			map = found_map;
+		}
+
+		/* Convert it to map-relative address for search */
+		addr = map__map_ip(map, orig_addr);
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
+		format_capstone_insn_arm64(insn, buf, len, args, addr);
+	else {
+		print_default_format(insn, buf, len);
+	}
+}
+
 struct find_file_offset_data {
 	u64 ip;
 	u64 offset;
@@ -426,14 +538,9 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 
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
index 0a1a7e9cf3ef..bd28829cb00d 100644
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

