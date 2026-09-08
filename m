Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A2559CB8;
	Tue,  8 Sep 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872772; cv=none; b=qXTxvqIzyzNri3foc8zbEtzhTsKLMO8EpIvUq0wtHxzZUxaP5EeWE1hWLIEjRs8M4rIm4jorN0yB7a6I5bnC8GBGzni9szdcthlSHNHwzCQysivrIM5rdU2A9P0fRbu1DnuhPH+fAzB4r5xtQzxHijA7FHtAhbVpduTSF07EaLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872772; c=relaxed/simple;
	bh=69h5joZRtjJP3TPqNFzEkBuJj5ZRLW8mie1rHJG84h8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgLUQVFiTrPwugsMWVLj7xho7e6GStFooct6JGO9TxufmG+vYFhLPvgCTbvnWUVuZDPOM0EchrOLx4MkiL91oR0QyfzNPbKbwhKu5WvrKd8mRqU4Qg/NhtKZcWBqKoBSWqBvSO5V7jgokp+HNb3kzgJUmL4gDltcK6H9owlJqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPKw1zBZzYQw9q;
	Tue,  8 Sep 2026 21:04:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C14054057D;
	Tue,  8 Sep 2026 21:05:43 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S19;
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
Subject: [PATCH v5 17/26] perf annotate-arm64: Support store instruction tracking
Date: Tue,  8 Sep 2026 13:05:20 +0000
Message-Id: <1e6613616abcf852b54025176f70357f11507d25.1788872630.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S19
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7XFykZw45uw1fAFy8Grg_yoW5JF48pF
	Z8Cw1YgF1Utr4I9an3JF4I9r9xua1fGw45Kr9rt397AFW2yrn3trZ3Ka13tFWrJrZ3uw1j
	qF4vkr4DWayjyaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvj
	4E73dUUUUUU
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

