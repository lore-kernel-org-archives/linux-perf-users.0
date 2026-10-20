Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503974;
	b=oHjC6gvv5vso+cSiFJBnqmx5mQDUH1sR1WPBfT6H8Aru+9/wLwlyWvl9gIkdpXCwGuaQ
	 CgUwR4z4804xJjPgBzOY7h6wzUKl8NhaoSq6cSOjKixsLHWAohRWmkDA0FFyvAcsiUJvt
	 kkoSCucsgDfvue757+Thdjz9letoZh81WlLsZaTvEmuIHIIhc5KxM9e2iJsJFz8QZmS9o
	 MqOmdWBZ/OV0nV3eKgehVbOrHrP08J716qSvtxBrof7vN8UEtqInYaw2hv8qhOBY0oLwd
	 kU4ncV7FbYJpXxe0+RZ1XPwIWB6e78jVIqLIeHlFZWRRVLw1Par5BwT06HjpTYFhzlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503974;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=CZWy778o6XGQDQD29XDHWZl04pvNL0pti0ZIWrzvNv4=;
	b=iVIO9HcX+uEgMZDYVdSAnxkE9dN4M9pzVA3pf5fcpElHHlOi9KTaMxZaTZ4afvGl3iqh
	 cMjf0FsC2zQyri3KzQuHKIsNZqRGy7RsX7IVbybBVPLiWLAdXRIpsf4jwnaDfimIQJ0Up
	 b/3Tg6+vkGE4d8jf4ijbOxdpZfaHULutyE14ff8q5q6tnsyuCOpeP05wuRqsGR+tgwiuw
	 1K0t3yTUzcqCVlT1twsDk7f3TqathMhr5aWLiE3d8fgAKn7wP37DeNIOeRU+Jt9Xv22ax
	 q3xbVhzbfAzzdO7IcXYOHrtvsW/yjzpG6bC2X9m0BxT5/9nArMm0V/SPNG4XSDakgCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF060A260A;
	Tue, 20 Oct 2026 13:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3BF060A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DFx0xcYzYQtwl;
	Tue, 20 Oct 2026 21:45:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 210B24056B;
	Tue, 20 Oct 2026 21:45:59 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB3QOaGcNdq8xegBA--.22174S14;
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
Subject: [PATCH v8 12/15] perf annotate-arm64: Support 'add' instruction tracking
Date: Tue, 20 Oct 2026 13:45:08 +0000
Message-Id: <adbd0606147f0243bfe059002d97703a25e153a5.1792411435.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB3QOaGcNdq8xegBA--.22174S14
X-Coremail-Antispam: 1UD129KBjvJXoWxXw15Xw1fJw1UJrWkurWruFg_yoWrCryUpF
	WDu34UWw12vrs2gws3JrWfXr93Kws7GF1Ykr9IqwnayFWayrn5Kas3KrW2vFW5Gr9xCr13
	Jw4DKrs3Xw40kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to track 'add' instructions for
structure member address calculation.

Unlike x86, the arm64 'add' instruction has an extra base register among
its source operands. Therefore, in terms of propagating the data type,
it is essentially performing a 'mov', except that before the 'mov', it
first needs to be updated by adding the offset or reg2.

A real-world example is shown below:

  ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
  ffff80008001c9c4:  add  x19, x0, #0xeb8   // x0 (task_struct*) + 0xeb8 -> x19
* ffff80008001c9d0:  ldr  x0, [x19]

Before this commit, the type flow broke at the 'add' instruction,
leaving the subsequent load with no type information:

  chk [28] reg19 offset=0 ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the tracker correctly follows the member address
calculation:

  var [0] reg0 offset 0 type='struct task_struct*'
  add [1c] address of 0xeb8(reg0) -> reg19 type='struct task_struct*'
  chk [28] reg19 offset=0 ok=1 kind=1 (struct task_struct*) : Good!
  found by insn track: 0(reg19) type-offset=0xeb8
  final result: type='struct task_struct'

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 38a9cb37c952..61df9c4f4877 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -959,6 +959,74 @@ static void update_mov_insn_state(struct type_state *state,
 	pr_debug_type_name(&tsr->type, tsr->kind);
 }
 
+static void update_add_insn_state(struct type_state *state,
+				  struct data_loc_info *dloc,
+				  struct disasm_line *dl,
+				  struct annotated_op_loc *src,
+				  struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	struct type_state_reg src_tsr;
+	u32 insn_offset = dl->al.offset;
+	int sreg = src->reg1;
+	int dreg = dst->reg1;
+	int reg_offset;
+
+	if (!has_reg_type(state, dreg))
+		return;
+
+	tsr = &state->regs[dreg];
+	tsr->copied_from = -1;
+	tsr->lifetime_active = false;
+	tsr->lifetime_end = 0;
+
+retry:
+	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	src_tsr = state->regs[sreg];
+
+	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
+		goto add_non_regoff;
+
+	if (src_tsr.kind == TSR_KIND_CONST) {
+		tsr->kind = src_tsr.kind;
+		tsr->imm_value = src_tsr.imm_value + reg_offset;
+		tsr->offset = 0;
+		tsr->ok = src_tsr.ok;
+
+		pr_debug_dtp("add [%x] imm %#x(reg%d) -> reg%d\n",
+			     insn_offset, reg_offset, sreg, dreg);
+		return;
+	}
+
+	if (src_tsr.kind == TSR_KIND_POINTER ||
+	    (src_tsr.kind == TSR_KIND_TYPE &&
+	     dwarf_tag(&src_tsr.type) == DW_TAG_pointer_type)) {
+		tsr->type = src_tsr.type;
+		tsr->kind = src_tsr.kind;
+		tsr->imm_value = src_tsr.imm_value;
+		tsr->offset = src_tsr.offset + reg_offset;
+		tsr->ok = src_tsr.ok;
+
+		pr_debug_dtp("add [%x] address of %#x(reg%d) -> reg%d",
+			     insn_offset, reg_offset, sreg, dreg);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return;
+	}
+
+add_non_regoff:
+	/* Try another register if any */
+	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
+	    !(src->extend_type || src->shift_type)) {
+		sreg = src->reg2;
+		goto retry;
+	}
+	invalidate_reg_state(tsr);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -975,6 +1043,8 @@ static void update_insn_state_arm64(struct type_state *state,
 
 	if (ins__is_call(&dl->ins))
 		update_call_insn_state(state, dloc, cu_die, dl);
+	else if (!strcmp(dl->ins.name, "add"))
+		update_add_insn_state(state, dloc, dl, src, dst);
 	/* Register to register or imm value to register transfers */
 	else if (!strcmp(dl->ins.name, "mov"))
 		update_mov_insn_state(state, dl, src, dst);
-- 
2.34.1

