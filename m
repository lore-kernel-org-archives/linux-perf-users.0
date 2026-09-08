Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C955C1A3;
	Tue,  8 Sep 2026 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872760; cv=none; b=eW/v5dJX3I9qsF8VfHOull0Abdjf/EzZSkPRGv9hKo2MMoE4osnS1lGN9tB1ibG2JAglXdBQ4bRHsXpl4T18s4w2asqGcmvgHFiWtvGMoxpvI4OQpjac5mX+uumnvFXUWKq6F7JcK2vP1fnmPaR9xfwnfbMekJS0BRMSzC7EgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872760; c=relaxed/simple;
	bh=0iGqBogiDsUD9IX6n18y1qeHWvrszSQw6b6wW562DRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epdLC8Z1kMhrZ7fVnJBScXzKK26wwtmWlcoISbehA7X/apPA3AsZ155Obm1kYaV45/xkgoFBeN94M+9bXc98ELCEfe0c0wjm08RQ1grKpBp9O0yZmRPgu9g5PUkHTvFyftStAZpl82jyXeOSsqwGQ30cD9ZvPYbn4zOTKiCYQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPLt0VNMzKHN7x;
	Tue,  8 Sep 2026 21:05:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 665864058D;
	Tue,  8 Sep 2026 21:05:43 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S15;
	Tue, 08 Sep 2026 21:05:43 +0800 (CST)
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
Subject: [PATCH v5 13/26] perf annotate-arm64: Enable instruction tracking support
Date: Tue,  8 Sep 2026 13:05:16 +0000
Message-Id: <8ff5cfde0aad3d585b34f177fd87e8ec57ba4fa1.1788872630.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S15
X-Coremail-Antispam: 1UD129KBjvJXoW3WFy7Wr48tF1UAF4rCry8Krg_yoW7Kw17pa
	yDC345KF4UJr42gwnxJF4UXry3G3yfW34Y9r9Ygw4SyFsFyryrtFs5KFWayF4rGrZ3Cw4Y
	q3WqyFWDXw4UCaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxkF7I0Ew4C2
	6cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa
	7xRxnoUUUUUUU==
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
  destination register(s), preventing stale type propagation. Full
  instruction-level analysis support will be added incrementally in
  later patches.

With these changes, arm64 gains support for basic variable type
inference during instruction tracking.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 78 +++++++++++++++++++
 tools/perf/util/annotate-data.c               | 11 ++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index d8a5904359b1..8fda4d4d6888 100644
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
@@ -442,6 +446,77 @@ static void extract_op_location_arm64(const struct arch *arch,
 	}
 }
 
+#ifdef HAVE_LIBDW_SUPPORT
+static bool is_readonly_branch_or_cmp(const char *name)
+{
+	return !strncmp(name, "cb", 2) || !strncmp(name, "tb", 2) ||
+	       !strcmp(name, "tst") || !strcmp(name, "teq") ||
+	       !strcmp(name, "cmp") || !strcmp(name, "cmn") ||
+	       !strcmp(name, "ccmp") || !strcmp(name, "ccmn");
+}
+
+static void update_insn_state_arm64(struct type_state *state,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
+				    struct disasm_line *dl)
+{
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
+	u32 insn_offset = dl->al.offset;
+
+	/* Skip read-only instructions that do not affect register type state */
+	if (is_readonly_branch_or_cmp(dl->ins.name))
+		return;
+
+	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
+		return;
+
+	/*
+	 * Invalidate caller-saved registers on function calls per ARM64 AAPCS64
+	 * ABI, unless DWARF location info indicates the register remains valid
+	 * beyond the call address.
+	 */
+	if (ins__is_call(&dl->ins)) {
+		struct symbol *func = dl->ops.target.sym;
+		const char *call_name;
+		u64 call_addr;
+
+		call_name = func ? func->name : dl->ops.target.name;
+		pr_debug_dtp("call [%x] %s\n", insn_offset, call_name ?: "<unknown>");
+
+		/* Invalidate caller-saved registers after call */
+		call_addr = map__rip_2objdump(dloc->ms->map,
+					      dloc->ms->sym->start + dl->al.offset);
+		for (unsigned int i = 0; i < ARRAY_SIZE(state->regs); i++) {
+			struct type_state_reg *reg = &state->regs[i];
+
+			if (!reg->caller_saved)
+				continue;
+			/* Keep register valid within DWARF location lifetime */
+			if (reg->lifetime_active && call_addr < reg->lifetime_end)
+				continue;
+			invalidate_reg_state(reg);
+		}
+		return;
+	}
+
+	/*
+	 * Invalidate destination register(s) for unsupported instructions to
+	 * prevent stale type info from propagating to subsequent instructions.
+	 */
+	if (has_reg_type(state, dst->reg1) && !dst->mem_ref) {
+		pr_debug_dtp("%s [%x] invalidate reg%d",
+			     dl->ins.name, insn_offset, dst->reg1);
+		invalidate_reg_state(&state->regs[dst->reg1]);
+		if (dst->multi_regs && has_reg_type(state, dst->reg2)) {
+			pr_debug_dtp(" and reg%d", dst->reg2);
+			invalidate_reg_state(&state->regs[dst->reg2]);
+		}
+		pr_debug_dtp("\n");
+		return;
+	}
+}
+#endif
+
 const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 				   const char *cpuid __maybe_unused)
 {
@@ -461,6 +536,9 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 	arch->extract_op_location	  = extract_op_location_arm64;
+#ifdef HAVE_LIBDW_SUPPORT
+	arch->update_insn_state		  = update_insn_state_arm64;
+#endif
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 104b80d471f1..c51b20a7af9b 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -28,6 +28,7 @@
 
 /* register number of the stack pointer */
 #define X86_REG_SP 7
+#define ARM64_REG_SP 31
 
 static void delete_var_types(struct die_var_type *var_types);
 
@@ -178,6 +179,13 @@ static void init_type_state(struct type_state *state, const struct arch *arch)
 		state->regs[11].caller_saved = true;
 		state->ret_reg = 0;
 		state->stack_reg = X86_REG_SP;
+	} else if (arch__is_arm64(arch)) {
+		int i;
+
+		for (i = 0; i < 18; i++)
+			state->regs[i].caller_saved = true;
+		state->ret_reg = 0;
+		state->stack_reg = ARM64_REG_SP;
 	}
 }
 
@@ -1437,7 +1445,8 @@ static enum type_match_result find_data_type_insn(struct data_loc_info *dloc,
 
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

