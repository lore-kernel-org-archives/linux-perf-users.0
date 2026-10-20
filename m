Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503973;
	b=IU1QfBubxZOnXCGvy8moMHs6tpM4mdEezdqhaCelezd8fHF3aki+vaunQUMAJKDYEoBf
	 cFaAEyf5lS4KAOtqTGOMW11ClWNb3/4MfUWivLrzwKZcjL3BLWwQxhqKt/2F/XoJiHL2o
	 QeBj4pI4ZEHI1hEnrUfbtybTwgEYBiWUZjXs3nK/GrbnACbSmmIuV5ghaPO2tPsnxRy2+
	 lVKG8hg7UgTnBR7bU3rvUsD4KKeNDgOSAUN8qzUhApnxlm2+zGexyPkJfIpEQNQxigGxk
	 4CO7lyqvP+xwLGRwLBBBsCsIBIumLIQempU/ePBZg4MU14LYRCG7FY2d74jty2uL5tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503973;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=k4WWuFNk4sAPPlyVkVk+NIdtMGKVW5YzTBh9tXIjVc0=;
	b=i5SynLYBSPNZtU4Q0BvftmMwtxdghWN/X3bUYiwIlx9DPq8PERE+qT2LpZFEdiupBEXI
	 mC5sSAzH1K8CQB6Y/R5kWGXcum90dLj5REvWhFfwhHZ9/jEqtMABHulAh/EEqc6zs3BCq
	 D4MOb4a2ThqXICYkXB8arJa+TyFjvQQrcB3N3iGvqLhjI3GnVeX2OnqoY7RJ7hcswEaoD
	 Oef/E6yKY62bDBS7R71IJXg7PYOtfzR7q0q0utjQfRu7udXN78i9XF81X7lmPf8bBS+vI
	 KESEyPwNiRilA0bdPK5Gqiiwrb82+Bon6wxdYs7wzwlRa05IF17QDHH5hilM62/T5jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.56
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E9606A334;
	Tue, 20 Oct 2026 13:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A0E9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8DFm2vPrzKHMWS;
	Tue, 20 Oct 2026 21:45:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5703F408C2;
	Tue, 20 Oct 2026 21:45:58 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB3QOaGcNdq8xegBA--.22174S8;
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
Subject: [PATCH v8 06/15] perf annotate-arm64: Support store instruction tracking
Date: Tue, 20 Oct 2026 13:45:02 +0000
Message-Id: <8d778f5ed416b0d385c27c601c32c224b545bf33.1792411435.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB3QOaGcNdq8xegBA--.22174S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4DKw47AF15Aw1kZrWDArb_yoWrZr1kpF
	WDCw4Fgr4Utr4IgFsxXF48urZxCa1fGw42kr9xJ392yF47trnYya98KayayF4rJr93Zw1U
	XanFkr4DWay2k3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Extend update_insn_state_arm64() to handle standard store instructions
(str, stur, stlr, stp). Exclusive stores (e.g., stxr, stxp) are excluded
from this path since their operand semantics differ.

Unlike load instructions, a store instruction writes a value into the
memory location addressed by the destination register, without changing
that register's type. As a result, no type transfer is needed here.

The only thing to keep in mind is that store instructions support
pre-index and post-index addressing modes, so adjust_reg_index_state()
still needs to be called to handle their addressing.

In addition, exclusive stores (stxr, stxp, stlxr, stlxp, etc.) write
their execution status (0 or 1) into the status register, which is
parsed into src->reg1. Invalidate this status register in
invalidate_unhandled_insn_regs() so that stale types are not propagated.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 0b5d1abbc575..e0bb37d8b353 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -507,6 +507,7 @@ static void update_call_insn_state(struct type_state *state,
 /* Invalidate registers explicitly written by an unhandled instruction. */
 static void invalidate_unhandled_insn_regs(struct type_state *state,
 					   struct disasm_line *dl,
+					   struct annotated_op_loc *src,
 					   struct annotated_op_loc *dst)
 {
 	u32 insn_offset = dl->al.offset;
@@ -524,6 +525,21 @@ static void invalidate_unhandled_insn_regs(struct type_state *state,
 		pr_debug_dtp("\n");
 	}
 
+	/*
+	 * Exclusive store instructions (stxr, stxp, stlxr, stlxp, etc.)
+	 * write their execution status (0 or 1) into the status register
+	 * (parsed into src->reg1). Invalidate this status register to prevent
+	 * stale type propagation.
+	 */
+	if (!strncmp(dl->ins.name, "stx", 3) ||  /* stxr, stxp, stxrb, stxrh */
+	    !strncmp(dl->ins.name, "stlx", 4)) { /* stlxr, stlxp, stlxrb, stlxrh */
+		if (has_reg_type(state, src->reg1)) {
+			pr_debug_dtp("%s [%x] invalidate reg%d\n",
+				     dl->ins.name, insn_offset, src->reg1);
+			invalidate_reg_state(&state->regs[src->reg1]);
+		}
+	}
+
 	/* TODO: Extend invalidation support to more special instructions. */
 }
 
@@ -727,6 +743,35 @@ static void update_load_insn_state(struct type_state *state,
 	adjust_reg_index_state(state, dloc, dl, src);
 }
 
+/*
+ * Match standard store variants (str, stur, stlr, stp) that follow
+ * straightforward store semantics: source registers on the left (read-only)
+ * and memory target on the right. Excludes exclusive stores (stxr, stxp, etc.)
+ * which have status/result register side effects.
+ */
+static bool is_standard_store_insn(const char *name)
+{
+	return !strncmp(name, "str", 3)  ||  /* str, strb, strh */
+	       !strncmp(name, "stur", 4) ||  /* stur, sturb, sturh */
+	       !strncmp(name, "stlr", 4) ||  /* stlr, stlrb, stlrh */
+	       !strncmp(name, "stp", 3);     /* stp */
+}
+
+static void update_store_insn_state(struct type_state *state,
+				    struct data_loc_info *dloc,
+				    struct disasm_line *dl,
+				    struct annotated_op_loc *dst)
+{
+	/*
+	 * Ignore transfers since it'd set a value in a struct
+	 * and won't change the type.
+	 *
+	 * Needs to update the pre-index and post-index addressing
+	 * modes for the destination register.
+	 */
+	adjust_reg_index_state(state, dloc, dl, dst);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -746,8 +791,11 @@ static void update_insn_state_arm64(struct type_state *state,
 	/* Memory to register transfers */
 	else if (is_standard_load_insn(dl->ins.name))
 		update_load_insn_state(state, dloc, dl, src, dst);
+	/* Register to memory transfers */
+	else if (is_standard_store_insn(dl->ins.name))
+		update_store_insn_state(state, dloc, dl, dst);
 	else
-		invalidate_unhandled_insn_regs(state, dl, dst);
+		invalidate_unhandled_insn_regs(state, dl, src, dst);
 }
 #endif
 
-- 
2.34.1

