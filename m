Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A813AE188;
	Wed, 16 Sep 2026 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522223; cv=none; b=tBniPnnXHtK61keuOKtbUQUWItFEHSkwaZq13DsSgQ9np0v9L6gbWe3K/VafQTUKBPAdfU5OVuBJKkYIfnSUidgDnO0caYEp5U+cSpiEajcgVRSt54TEK/lX/C1t/o2gb+WbTB2duA2N0QvWhk3/ammYKWEnH38BAQVvpg/44KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522223; c=relaxed/simple;
	bh=gu/irH4xHKyQrTYNpvzC0VdmiHz2BuMy+VGA/tohtYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C43wGIIYamPI1EEnlABVxnWSYqDO4FScH2R1Pmv5D/gAHQs+hJpnRqpuFCHgfI3YnKrYM6UWhLy/nnKLhQIFUNpX21m/P7OgGV20MHriZ1ntq41k9PRnMhNEUjw7S7BvsqugsOyTVU3Pjkj3lhGMl6wdW3g7pyPc+Nx0/c7XbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hl1XK0j86zKHMV4;
	Wed, 16 Sep 2026 09:29:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B42814056B;
	Wed, 16 Sep 2026 09:30:06 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAn+CoH8alqUcjbAQ--.36458S21;
	Wed, 16 Sep 2026 09:30:06 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
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
Subject: [PATCH v6 19/26] perf annotate-data: Track imm_value for stack variables
Date: Wed, 16 Sep 2026 01:29:33 +0000
Message-Id: <8b29a11ea56bdc9973e3ab65d6f5ebdea0927bfa.1789521520.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAn+CoH8alqUcjbAQ--.36458S21
X-Coremail-Antispam: 1UD129KBjvJXoWxGF18uw17Jw1DGFyUGFW8Crg_yoW7JF4xpr
	WDWFy7W3W7Wr4IqrsxJF4UXr93Gws2gF1Fk3s0qFnayFyxtr1fG3s7tFW5tF47Cryvyw17
	Jwn0kr4DXw47KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxc
	IEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr
	0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRNg4S3UUUU
	U==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Currently, imm_value is tracked in registers but dropped when values
are saved to or loaded from stack variables during type profiling.
If a register of type TSR_KIND_CONST is stored to the stack, its value
will be lost.

Add an imm_value field to struct type_state_stack and update
set_stack_state() and findnew_stack_state() to accept and preserve the
immediate value when updating stack state.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c |  8 ++++++--
 tools/perf/util/annotate-data.c              | 13 +++++++------
 tools/perf/util/annotate-data.h              |  5 +++--
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index f5e40cef08ab..21729e153fa0 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -591,6 +591,7 @@ static void update_insn_state_x86(struct type_state *state,
 				tsr->type = stack->type;
 				tsr->kind = stack->kind;
 				tsr->offset = stack->ptr_offset;
+				tsr->imm_value = stack->imm_value;
 				tsr->ok = true;
 			} else if (die_get_member_type(&stack->type,
 						       offset - stack->offset,
@@ -598,6 +599,7 @@ static void update_insn_state_x86(struct type_state *state,
 				tsr->type = type_die;
 				tsr->kind = TSR_KIND_TYPE;
 				tsr->offset = 0;
+				tsr->imm_value = 0;
 				tsr->ok = true;
 			} else {
 				invalidate_reg_state(tsr);
@@ -773,10 +775,12 @@ static void update_insn_state_x86(struct type_state *state,
 				 */
 				if (!stack->compound)
 					set_stack_state(stack, offset, tsr->kind,
-							&tsr->type, tsr->offset);
+							&tsr->type, tsr->offset,
+							tsr->imm_value);
 			} else {
 				findnew_stack_state(state, offset, tsr->kind,
-						    &tsr->type, tsr->offset);
+						    &tsr->type, tsr->offset,
+						    tsr->imm_value);
 			}
 
 			if (dst->reg1 == fbreg) {
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index d9f0bfd3f0a7..8bd9b6370277 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -594,7 +594,7 @@ struct type_state_stack *find_stack_state(struct type_state *state,
 }
 
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
-			    Dwarf_Die *type_die, int ptr_offset)
+			    Dwarf_Die *type_die, int ptr_offset, u64 imm_value)
 {
 	int tag;
 	Dwarf_Word size;
@@ -611,8 +611,9 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->offset = offset;
 	stack->ptr_offset = ptr_offset;
 	stack->kind = kind;
+	stack->imm_value = imm_value;
 
-	if (kind == TSR_KIND_POINTER) {
+	if (kind == TSR_KIND_POINTER || kind == TSR_KIND_CONST) {
 		stack->compound = false;
 		return;
 	}
@@ -633,18 +634,18 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 struct type_state_stack *findnew_stack_state(struct type_state *state,
 						    int offset, u8 kind,
 						    Dwarf_Die *type_die,
-						    int ptr_offset)
+						    int ptr_offset, u64 imm_value)
 {
 	struct type_state_stack *stack = find_stack_state(state, offset);
 
 	if (stack) {
-		set_stack_state(stack, offset, kind, type_die, ptr_offset);
+		set_stack_state(stack, offset, kind, type_die, ptr_offset, imm_value);
 		return stack;
 	}
 
 	stack = malloc(sizeof(*stack));
 	if (stack) {
-		set_stack_state(stack, offset, kind, type_die, ptr_offset);
+		set_stack_state(stack, offset, kind, type_die, ptr_offset, imm_value);
 		list_add(&stack->list, &state->stack_vars);
 	}
 	return stack;
@@ -939,7 +940,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				continue;
 
 			findnew_stack_state(state, offset, TSR_KIND_TYPE,
-					    &mem_die, /*ptr_offset=*/0);
+					    &mem_die, /*ptr_offset=*/0, /*imm_value=*/0);
 
 			if (var->reg == state->stack_reg) {
 				pr_debug_dtp("var [%"PRIx64"] %#x(reg%d)",
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 62efdcd8a79a..de92459e8502 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -199,6 +199,7 @@ struct type_state_stack {
 	int size;
 	bool compound;
 	u8 kind;
+	u64 imm_value;
 };
 
 /*
@@ -253,9 +254,9 @@ bool has_reg_type(struct type_state *state, int reg);
 struct type_state_stack *findnew_stack_state(struct type_state *state,
 						int offset, u8 kind,
 						Dwarf_Die *type_die,
-						int ptr_offset);
+						int ptr_offset, u64 imm_value);
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
-				Dwarf_Die *type_die, int ptr_offset);
+				Dwarf_Die *type_die, int ptr_offset, u64 imm_value);
 struct type_state_stack *find_stack_state(struct type_state *state,
 						int offset);
 void invalidate_reg_state(struct type_state_reg *reg);
-- 
2.34.1

