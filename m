Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8154A7C4;
	Tue,  8 Sep 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872541; cv=none; b=HrbUv3FvMNkygaFlIQxNH7cLlG158RgLm4Zh1BECqQRq8Ng2PcwUTJ4Z6/FFZkm/CEwPpX4wRKeWNri0CokNkX35nAuc7QfLeVfKs1XsDsECATFNbFhhwrNhVM933ZbpIycZ0FrktEO+3CxvujoBe6+2pVu9U+ydIchbgrJYZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872541; c=relaxed/simple;
	bh=69h5joZRtjJP3TPqNFzEkBuJj5ZRLW8mie1rHJG84h8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gxay6pRIxCzLzMiFki6+nGtv6RQQvOzDaTgxH9ro6kZbF5aQAE/qzLoy3Shiu7XDInCVW6vwgO7bwOjm0M6nw0efT9+idFQmEWln9xyJ/2pB0DzEY0VfOXVf5HcXkI48KnX0mX9sGt0fJ08lQGLIWMfLvzkwNBY06I+RLVDi0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPFW2bxbzYQvVq;
	Tue,  8 Sep 2026 21:01:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D576D4057A;
	Tue,  8 Sep 2026 21:01:54 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S19;
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
Subject: [PATCH v5 17/26] perf annotate-arm64: Support store instruction tracking
Date: Tue,  8 Sep 2026 13:01:13 +0000
Message-Id: <20260908130122.633500-18-wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S19
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7XFykZw45uw1fAFy8Grg_yoW5JF48pF
	Z8Cw1YgF1Utr4I9an3JF4I9r9xua1fGw45Kr9rt397AFW2yrn3trZ3Ka13tFWrJrZ3uw1j
	qF4vkr4DWayjyaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0pRepBfUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to handle standard store instructions
(str, stur, stlr, stp). Exclusive stores (e.g., stxr, stxp) are omitted
as they exhibit different operand semantics.

Unlike load instructions, a store instruction sets a value in the struct
within the memory where the destination register resides, and does not
alter its type. Therefore, no processing is required for the transfer.

The only point to note is that store instructions support pre-index and
post-index addressing modes, so calling adjust_reg_index_state() is still
necessary to handle their addressing.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index c239ad9473dc..9d43e2c2041c 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -649,6 +649,20 @@ static void update_load_insn_state(struct type_state *state,
 	goto out_adjust;
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
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -730,6 +744,17 @@ static void update_insn_state_arm64(struct type_state *state,
 	/* Memory to register transfers */
 	if (is_standard_load_insn(dl->ins.name))
 		update_load_insn_state(state, dloc, dl, src, dst);
+	/* Register to memory transfers */
+	else if (is_standard_store_insn(dl->ins.name)) {
+		/*
+		 * Ignore transfers since it'd set a value in a struct
+		 * and won't change the type.
+		 *
+		 * Needs to update the pre-index and post-index addressing
+		 * modes for the destination register.
+		 */
+		adjust_reg_index_state(state, dloc, dl, dst);
+	}
 }
 #endif
 
-- 
2.34.1

