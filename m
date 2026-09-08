Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685DC3A2544;
	Tue,  8 Sep 2026 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872554; cv=none; b=T7/ZZ/VD3crD8r3KY1KQ++5o/JKzrUxDtyH9bGkw1KaYROjMPi1QLa6a+mZ9ksJrLwKFPtub1uKmWOL21maDG2ELe+fc02R0ed68tAtc0rLwN+mpFGQgQCAQ0RJswBTTggzqKlKIug6CEeqOu/60UKLOPnXteq8z1/urO0a/acM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872554; c=relaxed/simple;
	bh=rfqXh9MfNv1Ncha+ZWYP7+fbRIrP2iU9ew6IiMSJWss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g57ozOjk1Ixz0yDms/O135PTRZpEY/F6sxegitRnxMUAUes5k6ZFdlpV7adfzlZD1ai3wZODrIWcCCw+bLZ+mLz8hCnJtnrYhBR34iMsjvyDrZS4DysDxNBtig7cGiYtd59R8F3CfhMLeypb/Pf51kdTCQQ/DvYjoOFWy/THgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPGV11DBzKHN58;
	Tue,  8 Sep 2026 21:01:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 76C0A4057D;
	Tue,  8 Sep 2026 21:01:55 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S22;
	Tue, 08 Sep 2026 21:01:54 +0800 (CST)
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
Subject: [PATCH v5 20/26] perf annotate-x86: Delete stale stack state on store of untracked register
Date: Tue,  8 Sep 2026 13:01:16 +0000
Message-Id: <20260908130122.633500-21-wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S22
X-Coremail-Antispam: 1UD129KBjvJXoWxur4xGry8KFyxKrWUGF4xCrg_yoW5KrW7pr
	yDC343Ww17Gr4SqFnxAFW5XF95Crs7X3WrC3s0qwn2vF1xJr1fG3s7tFWYyF47Xr92kw12
	yw1DKr4DXa12gaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0pRepBfUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

When a register without a tracked type is stored to a stack slot that
previously held a valid type, the code currently performs an early return.
This leaves the old type information intact in the stack state.

As a result, a stale type bug occurs:
1. A tracked register is stored into a stack slot.
2. The register becomes untracked/invalid (e.g., across a function call).
3. The now-untracked register is stored into the same stack slot.
4. Subsequent loads from that slot erroneously pick up the old stale type
   because the stack entry was never invalidated.

Fix this by introducing delete_stack_state() to search and free a stack
entry for a given offset. When storing an untracked or invalid source
register into a stack location, call delete_stack_state() to delete the
stale entry before returning.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 17 +++++++++++++----
 tools/perf/util/annotate-data.c              | 10 ++++++++++
 tools/perf/util/annotate-data.h              |  1 +
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 21729e153fa0..3a6ea7e978e0 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -753,15 +753,24 @@ static void update_insn_state_x86(struct type_state *state,
 	}
 	/* Case 3. register to memory transfers */
 	if (!src->mem_ref && dst->mem_ref) {
-		if (!has_reg_type(state, src->reg1) ||
-		    !state->regs[src->reg1].ok)
-			return;
-
 		/* Check stack variables with offset */
 		if (dst->reg1 == fbreg || dst->reg1 == state->stack_reg) {
 			struct type_state_stack *stack;
 			int offset = dst->offset - fboff;
 
+			if (!has_reg_type(state, src->reg1) ||
+			    !state->regs[src->reg1].ok) {
+				stack = find_stack_state(state, offset);
+				/*
+				 * Preserve compound states when only a member
+				 * is overwritten.
+				 */
+				if (stack && !stack->compound)
+					delete_stack_state(state, offset);
+
+				return;
+			}
+
 			tsr = &state->regs[src->reg1];
 
 			stack = find_stack_state(state, offset);
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 2150af5599fb..1936822c73f2 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -647,6 +647,16 @@ struct type_state_stack *findnew_stack_state(struct type_state *state,
 	return stack;
 }
 
+void delete_stack_state(struct type_state *state, int offset)
+{
+	struct type_state_stack *stack = find_stack_state(state, offset);
+
+	if (stack) {
+		list_del(&stack->list);
+		free(stack);
+	}
+}
+
 void invalidate_reg_state(struct type_state_reg *reg)
 {
 	reg->kind = TSR_KIND_INVALID;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 36ca7819a6f0..02d5602c5e20 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -259,6 +259,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 				Dwarf_Die *type_die, int ptr_offset, u64 imm_value);
 struct type_state_stack *find_stack_state(struct type_state *state,
 						int offset);
+void delete_stack_state(struct type_state *state, int offset);
 void invalidate_reg_state(struct type_state_reg *reg);
 bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 				u64 ip, u64 var_addr, int *var_offset,
-- 
2.34.1

