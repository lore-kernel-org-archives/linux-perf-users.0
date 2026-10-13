Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1051991F;
	Tue, 13 Oct 2026 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898130; cv=none; b=KcbKJ9nmiieSD5QtHZmybugNcuSwufmbo9ym7/+Bdh9bQKbpHIMeoq7rFRBvlI9TR9MrnTyFD78RW3Z2OxnJqJhw9CD5j3x/lgfMh1fqzbyTfceQiAS72jvWTXNo3g0CVTlEGi5AKh2aGTwMeKC9OPJn8biFlZOUoPwuZVDp8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898130; c=relaxed/simple;
	bh=yR1dTvLS1XWrsVK+6JCO6KazEkGRS06qEQ+BctICr+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdXicfI9hlVbom5qFvy/UvsxkuUljhj88FZbCQCMsMT0T40bVp0c1pM2nDynBasvMwnR+vW19LVjxuXKbzuPx640R8fpwSvgs3X/kj1Y8Gqff8ysodthG/fJlhINxQzwhPE/PJRhg8ybbqM1BgkKSvGf4+XB4ahB/Fk4TvPOUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j3wB15zF9zKHN15;
	Tue, 13 Oct 2026 21:27:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8AF8E40A4C;
	Tue, 13 Oct 2026 21:28:36 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDnIvL3Mc5qfU4wAQ--.7133S8;
	Tue, 13 Oct 2026 21:28:36 +0800 (CST)
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
Subject: [PATCH v7 06/15] perf annotate-arm64: Support store instruction tracking
Date: Tue, 13 Oct 2026 13:28:04 +0000
Message-Id: <eb44bbf4b74555bc43f3659f4733faff403debbf.1791629326.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnIvL3Mc5qfU4wAQ--.7133S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXryUtF13Jr17XFykCFyxAFb_yoW5Gr4kpr
	Z8Cw1Ygr4Utr4Ig3Z3XF4I9r9I9a1fGw4Ykr9rt397AF47trn3trZ3Ka13tFW8JrZ3uw15
	tF4qkr4DWayjyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index fb48bf95b32f..54d9928b536f 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -661,6 +661,20 @@ static void update_load_insn_state(struct type_state *state,
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
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -742,6 +756,17 @@ static void update_insn_state_arm64(struct type_state *state,
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

