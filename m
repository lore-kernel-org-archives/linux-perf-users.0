Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8D370AE9;
	Wed,  1 Jul 2026 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878101; cv=none; b=goE/acWMpXNnT73YGwuyep208uWat9p5Qju0seaPt+qzun5WDxUldiUru+Nb0l6Fz3RGAoGCZ9CCYTfAqEkw3sZQN9L76RK6MVwpAdbMEE/5x7+YmwRr3yW2rn6di92xGE+CEuvk9DvnWO5x1lzo2UhVd4lW5EgZ7I+dXrhAGng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878101; c=relaxed/simple;
	bh=GLKJajIofyOl1aHrvfXzb2NpNKve2Cc/K2d+Zc9jF/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOzUQRsQst4FLPPWXFbL2hbb0rpHeSkeO09hvCkdxAgtILqmxH7p6ATURrksUMUCW21VWK9uoCX/tjgE0UpWM8zMwXf1OjkS57iZ/yau8fH3144psxTaQTZuwiGPvzLWWugk1dnCQCdX7yGnHm3J0hCP/BL/RJ3OzWF5mW1nwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqmNs3kb6zKHMWG;
	Wed,  1 Jul 2026 11:54:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 902EA40590;
	Wed,  1 Jul 2026 11:54:46 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S19;
	Wed, 01 Jul 2026 11:54:46 +0800 (CST)
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
Subject: [PATCH v3 17/21] perf annotate-arm64: Support 'mov' instruction tracking
Date: Wed,  1 Jul 2026 03:53:51 +0000
Message-Id: <20260701035355.752944-18-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S19
X-Coremail-Antispam: 1UD129KBjvJXoWxXryDZw1DKw48WF47Kw1fCrg_yoWrAw1fpa
	4DC345G39rtr42gFsIqrWxXr9a9ws7Kr129r90vwnIvFW3Kr1rKa97Kay3ZF45Xry8Cr17
	Jw4DKrZxWw42kF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0piPkusUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state() for arm64 to support register-to-register and
immediate-to-register 'mov' instructions.

For register-to-register 'mov' (e.g., mov dreg, sreg), propagate data type
information from the source register to the destination register.

For immediate-to-register 'mov' (e.g., mov dreg, #imm), store the immediate
value in the destination register's imm_value field and set its kind to
TSR_KIND_CONST, allowing subsequent instructions to resolve it as a
constant.

A real-world example is shown below:

  ffff8000803eebf8 <get_vma_policy>:
  ffff8000803eec20:  mov  x21, x0          // x0 (struct vm_area_struct*) -> x21
  ffff8000803eec28:  ldr  x2, [x0, #112]
  ffff8000803eec2c:  cbz  x2, ffff8000803eec94 <get_vma_policy+0x9c>
* ffff8000803eec94:  ldr  x0, [x21, #152]

Before this commit, the type of x21 was unknown, causing the subsequent
inference to fail:

  var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
  chk [9c] reg21 offset=0x98 ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the type of x21 is correctly inferred as 'vm_area_struct':

  var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
  mov [28] reg0 -> reg21 type='struct vm_area_struct*' size=0x8
  chk [9c] reg21 offset=0x98 ok=1 kind=1 (struct vm_area_struct*) : Good!
  found by insn track: 0x98(reg21) type-offset=0x98
  final result:  type='struct vm_area_struct' size=0xb0

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 255ccaf33130..be07a85057c8 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -527,6 +527,51 @@ static void update_store_insn_state(struct type_state *state,
 	adjust_reg_index_state(state, dst, "str", insn_offset);
 }
 
+static void update_mov_insn_state(struct type_state *state,
+				  struct disasm_line *dl,
+				  struct annotated_op_loc *src,
+				  struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	u32 insn_offset = dl->al.offset;
+	int sreg = src->reg1;
+	int dreg = dst->reg1;
+
+	if (!has_reg_type(state, dreg))
+		return;
+
+	tsr = &state->regs[dreg];
+	tsr->copied_from = -1;
+
+	if (src->imm) {
+		tsr->kind = TSR_KIND_CONST;
+		tsr->imm_value = src->offset;
+		tsr->offset = 0;
+		tsr->ok = true;
+
+		pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
+			     insn_offset, tsr->imm_value, dreg);
+		return;
+	}
+
+	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	tsr->type = state->regs[sreg].type;
+	tsr->kind = state->regs[sreg].kind;
+	tsr->imm_value = state->regs[sreg].imm_value;
+	tsr->offset = state->regs[sreg].offset;
+	tsr->ok = state->regs[sreg].ok;
+
+	if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
+		tsr->copied_from = sreg;
+
+	pr_debug_dtp("mov [%x] reg%d -> reg%d", insn_offset, sreg, dreg);
+	pr_debug_type_name(&tsr->type, tsr->kind);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
 				    struct disasm_line *dl)
@@ -544,6 +589,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * the destination register itself to prevent incorrect type propagation.
 	 */
 	if (has_reg_type(state, dst->reg1) &&
+	    strcmp(dl->ins.name, "mov") &&
 	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d\n",
 			     dl->ins.name, insn_offset, dst->reg1);
@@ -551,6 +597,12 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
+	/* Register to register or imm value to register transfers */
+	if (!strcmp(dl->ins.name, "mov")) {
+		update_mov_insn_state(state, dl, src, dst);
+		return;
+	}
+
 	/* Memory to register transfers */
 	if (!strncmp(dl->ins.name, "ld", 2)) {
 		update_load_insn_state(state, dloc, dl, src, dst);
-- 
2.34.1

