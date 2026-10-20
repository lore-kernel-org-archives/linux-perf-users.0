Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503972;
	b=RNoXpve/RC2P/TuSFAfjREpxvM+sCbBMvux1CvVE+3Dwj+6EejMxAu1dzAOiyJyVVb8L
	 +MpibWjm+oIIVZ8CpAgIyb1OpBGq5hc2yOWm6YjusO6/DMuHB1U0oLPrNojYBA+Gf1OS1
	 TsbMgRB4ZdhWovPzPpVkN9BgEvbC26+WPyFf5JG9r2oGHHHXT07kA9A0DnXi9SyswVifp
	 bujoUKtgmTLKP97t/TDg+aOJMFbNCowSvZ9TE0V/lIYMnLrqG+gOSCrTDKdLU1HczDP/7
	 eYz26ji3gJPydCq792A/3nkc4kcq6PohKv5+nZzEe9/nFE732JhexAop4Bwy839RDLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503972;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=1+Rqf9oyraC0i4oMEEUD1ytYbF185f9XIVI8t5jeH/8=;
	b=rBqLcI0jrLL52AA8ximyXJBPzdBj4Yz7vr9Lb8Ykrs1JNmeNR25IkmOTbtdl8qG4gHMO
	 dExLhgiL/kURyVIybmLkPegQJNVScoj3IscrTvIFiBcOsdPTNjnY2nu7IrQukL+Wo3aA6
	 SmHdaLkmGD2C8Nso9QXgdFJvRwl7/bvqxkjAHOEpD3lVC9hb6KF+wTxPR9oq1BRbBPbdV
	 gLp4082FJ9/OOdQiZbvw7q3r6A141HRg3ulTg+TvDKWHAoBc1P2SV+i+i/rGNzo3EJFxI
	 yk23J/DbY0El5SOp4rGb8CcEWqVnqtwDsjvh+/00reFNR+rlFUMHHTa/WcDdRlwHCBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.56
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED91606A336;
	Tue, 20 Oct 2026 13:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ED91606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8DFm4xFjzKHMbN;
	Tue, 20 Oct 2026 21:45:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9D31740A5B;
	Tue, 20 Oct 2026 21:45:58 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB3QOaGcNdq8xegBA--.22174S10;
	Tue, 20 Oct 2026 21:45:58 +0800 (CST)
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
Subject: [PATCH v8 08/15] perf annotate-data: Track imm_value for stack variables
Date: Tue, 20 Oct 2026 13:45:04 +0000
Message-Id: <229d5b940a370daf47dfff23cc9e348093adc8eb.1792411435.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB3QOaGcNdq8xegBA--.22174S10
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW7ur45tw1UZF1UCw13XFb_yoW7GF15pr
	yDWFy7W3W7Wr4IqrsxJF4UXr93Gws2gr1Yk3s0qFn3tFyxtr1fG3s7tFW5tF47Cryvyw17
	Jwn0kr4DXw47KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Currently, imm_value is tracked in registers but dropped when values
are saved to or loaded from stack variables during type profiling.
If a register of type TSR_KIND_CONST is stored to the stack, its value
will be lost.

Add an imm_value field to struct type_state_stack and update
set_stack_state() and findnew_stack_state() to accept and preserve the
immediate value when updating stack state.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
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
index 24d82739b2ec..9ed0780d6244 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -704,7 +704,7 @@ struct type_state_stack *find_stack_state(struct type_state *state,
 }
 
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
-			    Dwarf_Die *type_die, int ptr_offset)
+			    Dwarf_Die *type_die, int ptr_offset, u64 imm_value)
 {
 	int tag;
 	Dwarf_Word size;
@@ -721,8 +721,9 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->offset = offset;
 	stack->ptr_offset = ptr_offset;
 	stack->kind = kind;
+	stack->imm_value = imm_value;
 
-	if (kind == TSR_KIND_POINTER) {
+	if (kind == TSR_KIND_POINTER || kind == TSR_KIND_CONST) {
 		stack->compound = false;
 		return;
 	}
@@ -743,18 +744,18 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
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
@@ -1058,7 +1059,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				continue;
 
 			findnew_stack_state(state, offset, TSR_KIND_TYPE,
-					    &mem_die, /*ptr_offset=*/0);
+					    &mem_die, /*ptr_offset=*/0, /*imm_value=*/0);
 
 			if (var->reg == state->stack_reg) {
 				pr_debug_dtp("var [%"PRIx64"] %#x(reg%d)",
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 12b5b6db5f57..dccd56759cea 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -208,6 +208,7 @@ struct type_state_stack {
 	int size;
 	bool compound;
 	u8 kind;
+	u64 imm_value;
 };
 
 /*
@@ -262,9 +263,9 @@ bool has_reg_type(struct type_state *state, int reg);
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

