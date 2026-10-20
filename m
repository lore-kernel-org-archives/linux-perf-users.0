Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503969;
	b=B6eCNR8gtqDoh6KlCHDn6PorDENxqbYPpEc6QNyRDFm2UMMo5JIonMoJWO25sGQ4lF3E
	 NTxqoVMrtGV87Ezb8GVe73Ho+yVrtGFTbRqov+8hzsTkFUTC1OmY6+zSbog0V9z+3giPA
	 NcOJZ9dI/wOUXUvgVr+IbdnJWdbODxNd0nfaxZ+oaRxKCKvvfrGRHTHXd267D/PefgQBG
	 cOYavYYQ4V3sNtI9hjKbUxGsn+uTzrXKg4sSJm+jLnLE813zYAVrkGOBYjUZ5dh+a4yaL
	 ZfwZreEAOOP7KJG+ZAxPkpxJDH+NjHyi0qEdIb+t4fJq3ExIZWlWtljkRXcA7HjI29g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503969;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=0sc0q8GgFatN/24mN0QsD2TQgG/fuf2RuxJLWJWQGPI=;
	b=1XZxj/NFPzotICHfHEzc3ZAsEH+3mwAlqvFc0Z46WfYhWNTFtp4JSfoxUDx6U0I2OCXU
	 6BU1gkY8SoTSNJfspgIso3hNVgcXEjk6t+GW0CSaJ4qbcc54wd5ib27KNh3OM/5LU5fK3
	 +EL86piq5A+nyBZVTw8UF3jdeH1yBnA3w3XozsMSpdZAZG3vNfM6ZVv9nHruhsCPLfo0b
	 zBV4Ga57AJsHbJ7Tg0kzEkTQERdeaERtkwPy7eTB828wEfH+0ytobbpXGo3oslHlFDQAi
	 6R2GOhp51/UB+ZEwRvkgLzbPvw1xerEy4H5xQHciR/sZQ5sFyOvzFEA+RB+RMeB8izQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB7606F467;
	Tue, 20 Oct 2026 13:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0BB7606F467
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DFv5pQQzYQtvl;
	Tue, 20 Oct 2026 21:45:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C9269408C2;
	Tue, 20 Oct 2026 21:45:57 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB3QOaGcNdq8xegBA--.22174S4;
	Tue, 20 Oct 2026 21:45:57 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v8 02/15] perf annotate-arm64: Enable instruction tracking support
Date: Tue, 20 Oct 2026 13:44:58 +0000
Message-Id: <b216cc26455f9ee39222fd9d5efc4dd53ec83e24.1792411435.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3QOaGcNdq8xegBA--.22174S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WFy7Wr1DZFy5WryrAF4rAFb_yoWxCFWfpa
	yDC34rKFWUJr4IgwnxJF4UXry3Cw4fW3s0kr95XwsIyFnFyr95ta1kKFWayFW5Jr93Cr42
	q3WqvFWUX3yUCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x
	02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRNHq23UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Enable basic instruction tracking for arm64 by implementing three
essential functions in the find_data_type_block() call path:

  find_data_type_block
    -> arch_supports_insn_tracking  (1)
    -> find_data_type_insn
         -> init_type_state         (2)
         -> update_var_state
         -> update_insn_state       (3)

Changes:

* arch_supports_insn_tracking(): add arm64 to the list of supported
  architectures, allowing find_data_type_block() to proceed with data
  type analysis.

* init_type_state(): correctly identify ret_reg, stack_reg, and
  caller-saved registers for arm64 during type state initialization.

* update_insn_state(): add the update_insn_state_arm64() callback with
  conservative register invalidation for call instructions and those with
  destination register(s), preventing stale type propagation.

  For now the invalidation path does not treat special instructions
  individually; doing so for every such instruction up front would be
  costly. A TODO is therefore left in invalidate_unhandled_insn_regs()
  marking where per-instruction invalidation handling is to be extended
  in future patches.

With these changes, arm64 gains support for basic variable type
inference during instruction tracking.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 87 +++++++++++++++++++
 tools/perf/util/annotate-data.c               | 15 +++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 6549535961a9..d591d556ad40 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -9,6 +9,10 @@
 #include <regex.h>
 #include "../annotate.h"
 #include "../disasm.h"
+#include "../annotate-data.h"
+#include "../debug.h"
+#include "../map.h"
+#include "../symbol.h"
 
 struct arch_arm64 {
 	struct arch arch;
@@ -448,6 +452,86 @@ static void extract_op_location_arm64(const struct arch *arch,
 	}
 }
 
+#ifdef HAVE_LIBDW_SUPPORT
+/* Check if the instruction is read-only (does not modify register state). */
+static bool is_readonly_insn(const char *name)
+{
+	return !strncmp(name, "cb", 2) || !strncmp(name, "tb", 2) ||
+	       !strcmp(name, "tst") || !strcmp(name, "teq") ||
+	       !strcmp(name, "cmp") || !strcmp(name, "cmn") ||
+	       !strcmp(name, "ccmp") || !strcmp(name, "ccmn");
+}
+
+static void update_call_insn_state(struct type_state *state,
+				   struct data_loc_info *dloc,
+				   struct disasm_line *dl)
+{
+	struct symbol *func = dl->ops.target.sym;
+	const char *call_name;
+	u64 call_addr;
+	u32 insn_offset = dl->al.offset;
+
+	call_name = func ? func->name : dl->ops.target.name;
+	pr_debug_dtp("call [%x] %s\n", insn_offset, call_name ?: "<unknown>");
+
+	/* Invalidate caller-saved registers after call */
+	call_addr = map__rip_2objdump(dloc->ms->map,
+				      dloc->ms->sym->start + dl->al.offset);
+	for (unsigned int i = 0; i < ARRAY_SIZE(state->regs); i++) {
+		struct type_state_reg *reg = &state->regs[i];
+
+		if (!reg->caller_saved)
+			continue;
+		/* Keep register valid within DWARF location lifetime */
+		if (reg->lifetime_active && call_addr < reg->lifetime_end)
+			continue;
+		invalidate_reg_state(reg);
+	}
+}
+
+/* Invalidate registers explicitly written by an unhandled instruction. */
+static void invalidate_unhandled_insn_regs(struct type_state *state,
+					   struct disasm_line *dl,
+					   struct annotated_op_loc *dst)
+{
+	u32 insn_offset = dl->al.offset;
+
+	/* Invalidate destination registers */
+	if (has_reg_type(state, dst->reg1) && !dst->mem_ref) {
+		pr_debug_dtp("%s [%x] invalidate reg%d",
+			     dl->ins.name, insn_offset, dst->reg1);
+		invalidate_reg_state(&state->regs[dst->reg1]);
+
+		if (dst->multi_regs && has_reg_type(state, dst->reg2)) {
+			pr_debug_dtp(" and reg%d", dst->reg2);
+			invalidate_reg_state(&state->regs[dst->reg2]);
+		}
+		pr_debug_dtp("\n");
+	}
+
+	/* TODO: Extend invalidation support to more special instructions. */
+}
+
+static void update_insn_state_arm64(struct type_state *state,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
+				    struct disasm_line *dl)
+{
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
+
+	if (is_readonly_insn(dl->ins.name))
+		return;
+
+	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
+		return;
+
+	if (ins__is_call(&dl->ins))
+		update_call_insn_state(state, dloc, dl);
+	else
+		invalidate_unhandled_insn_regs(state, dl, dst);
+}
+#endif
+
 const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 				   const char *cpuid __maybe_unused)
 {
@@ -467,6 +551,9 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 	arch->extract_op_location	  = extract_op_location_arm64;
+#ifdef HAVE_LIBDW_SUPPORT
+	arch->update_insn_state		  = update_insn_state_arm64;
+#endif
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 32af1be4e451..398795ba3694 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -29,6 +29,7 @@
 
 /* register number of the stack pointer */
 #define X86_REG_SP 7
+#define ARM64_REG_SP 31
 
 static void delete_var_types(struct die_var_type *var_types);
 
@@ -179,6 +180,17 @@ static void init_type_state(struct type_state *state, const struct arch *arch)
 		state->regs[11].caller_saved = true;
 		state->ret_reg = 0;
 		state->stack_reg = X86_REG_SP;
+	} else if (arch__is_arm64(arch)) {
+		/*
+		 * Mark x0..x18 as caller-saved. x30 (LR) is intentionally
+		 * omitted from the caller_saved set: it is clobbered by
+		 * calls, but holds only the return address and is not used
+		 * to carry data type information.
+		 */
+		for (int i = 0; i < 19; i++)
+			state->regs[i].caller_saved = true;
+		state->ret_reg = 0;
+		state->stack_reg = ARM64_REG_SP;
 	}
 }
 
@@ -1543,7 +1555,8 @@ static enum type_match_result find_data_type_insn(struct data_loc_info *dloc,
 
 static int arch_supports_insn_tracking(struct data_loc_info *dloc)
 {
-	if ((arch__is_x86(dloc->arch)) || (arch__is_powerpc(dloc->arch)))
+	if (arch__is_x86(dloc->arch) || arch__is_powerpc(dloc->arch) ||
+	    arch__is_arm64(dloc->arch))
 		return 1;
 	return 0;
 }
-- 
2.34.1

