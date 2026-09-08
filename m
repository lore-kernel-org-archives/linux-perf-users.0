Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654AF559C9A;
	Tue,  8 Sep 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872759; cv=none; b=Dze3CAPC4g4sm/2jaJG3D0NTX0MV3szU7A+hk+S8mFvYp/6n8nenn5Uu6XJ/D+QBJmgNG/KUrAaUPSETM/Y/0rK4ynM4LQWOGZZmpVNr1+2f7ZAQ7OaapQtac7FVj7vv5OrR6xkIP8RApWQe7GyN8G46Ni0ST9GkaYd8O1Gyp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872759; c=relaxed/simple;
	bh=rfqXh9MfNv1Ncha+ZWYP7+fbRIrP2iU9ew6IiMSJWss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJgTLowA5Fa5bvJbgmH8mklCaE95eWnvH5TWWD5z5UkKT7VEKIH5/jN1sv11t50rZ3GcOb3OLRn/HMYtM1g1KeKN8VMZTD4P1zoPvWgbCvK8J6YeLZmLK0avawigYe+4shdVV/aOp3Tk0j+A87jqqpg3Phf4OSPRFoWex0zTaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPKw3t30zYQw9W;
	Tue,  8 Sep 2026 21:04:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0E0F540579;
	Tue,  8 Sep 2026 21:05:44 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S22;
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
Subject: [PATCH v5 20/26] perf annotate-x86: Delete stale stack state on store of untracked register
Date: Tue,  8 Sep 2026 13:05:23 +0000
Message-Id: <d8120878619b98f3956f8a63676dfbe2cee7a59f.1788872630.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S22
X-Coremail-Antispam: 1UD129KBjvJXoWxur4xGry8KFyxKrWUGF4xCrg_yoW5KrW7pr
	yDC343Ww17Gr4SqFnxAFW5XF95Crs7X3WrC3s0qwn2vF1xJr1fG3s7tFWYyF47Xr92kw12
	yw1DKr4DXa12gaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
	8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Wrv_ZF1lc7CjxVAKzI0E
	Y4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x0z
	CjgJUUUUUU=
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

