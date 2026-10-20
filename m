Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503971;
	b=encOFI/hquHnP3Z7OTj8sdZHQ3vb9nFRxArqSif1Afp/xSu8T/m9lELnNowvK96OJ7Zu
	 iBSgRmbEEEcvh1k075eJckqWRD5BV7CrhipE/+ALmYMTfOachmJJprFhfpZ8a3MM4WU+M
	 TaMmDKUtXmG7emMcb8YiID8LAWrkAsxh8NdhLjJOHjJpGtJhDNS5OPcGh4X61VJKGhgRY
	 UsyItR6Ha/+dDNwRcSC2ckMhc8QPPhUZAfslSy8sl07ZfUxMfC8XWb3ca262HcKOGfeeD
	 nh42epJ8j+mIhYAH1cF2pa2FuQ6Kza9Bjcxoke9Wh6cjnnt2ShOC4M+5phehyX+ng8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503971;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=r7Jj+7iqzFb6IuBrZRgHoxVqen+BPmVI9Tm/CM9SebY=;
	b=HZreUEnyYdQCY0gC9n7FCqXrC1vFgtB1pSxTxVNp7MTVsR0D1ms2jbFZyYvcdBIPs2bx
	 zitKoEFaFVUjCvvBMK++T0feeY5Vwk6GJCbTGXoZt4IwMmNrvRVcvk5uj5ghzPDl0om98
	 UyDlttK3sylmPhu70OxmZ+2Iqo2ah39l1R6wQgx5rhdZuw4Bsdp5Iz72rEwpocmdUOQGb
	 8ZtB9dbstGjDwcxh+W3VuXR0ZGOrGFJ8kTIfHn8b4mcKRPwrk4KaGJWZzMYAOaJ9r7lE8
	 0Z7EvzOBabLuLdCiaR43VCWm2r1kaL0VisoeARYFOEyhxoq8qR7pUc0rC899Eh/CmDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=none smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.56
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CEB606F44F;
	Tue, 20 Oct 2026 13:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81CEB606F44F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8DFm0yXBzKHMVv;
	Tue, 20 Oct 2026 21:45:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1498E4056E;
	Tue, 20 Oct 2026 21:45:58 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB3QOaGcNdq8xegBA--.22174S6;
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
Subject: [PATCH v8 04/15] perf annotate-arm64: Track return type after call instructions
Date: Tue, 20 Oct 2026 13:45:00 +0000
Message-Id: <62622766adb2db49d32e51136c8a78050b133617.1792411435.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB3QOaGcNdq8xegBA--.22174S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3ZFykGryUKr18Jr15XFb_yoW5JFyDpa
	4Du34j9r1UGr4IgrnxJr4xZry3urWxW342kr98AanavFW2yrn3JaykKryaqF45Xr95Cw4U
	JwsFkF4UZa1IkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Enable data type profiling to track function return values in arm64
annotations by looking up the DWARF return type of called functions.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index d591d556ad40..c4cc8bca85cc 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -463,12 +463,14 @@ static bool is_readonly_insn(const char *name)
 }
 
 static void update_call_insn_state(struct type_state *state,
-				   struct data_loc_info *dloc,
+				   struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				   struct disasm_line *dl)
 {
 	struct symbol *func = dl->ops.target.sym;
 	const char *call_name;
 	u64 call_addr;
+	struct type_state_reg *tsr;
+	Dwarf_Die type_die;
 	u32 insn_offset = dl->al.offset;
 
 	call_name = func ? func->name : dl->ops.target.name;
@@ -487,6 +489,19 @@ static void update_call_insn_state(struct type_state *state,
 			continue;
 		invalidate_reg_state(reg);
 	}
+
+	/* Update register with the return type (if any) */
+	if (call_name && die_find_func_rettype(cu_die, call_name, &type_die)) {
+		tsr = &state->regs[state->ret_reg];
+		invalidate_reg_state(tsr);
+		tsr->type = type_die;
+		tsr->kind = TSR_KIND_TYPE;
+		tsr->offset = 0;
+		tsr->ok = true;
+
+		pr_debug_dtp("call [%x] return -> reg%d", insn_offset, state->ret_reg);
+		pr_debug_type_name(&type_die, tsr->kind);
+	}
 }
 
 /* Invalidate registers explicitly written by an unhandled instruction. */
@@ -513,7 +528,7 @@ static void invalidate_unhandled_insn_regs(struct type_state *state,
 }
 
 static void update_insn_state_arm64(struct type_state *state,
-				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
@@ -526,7 +541,7 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 
 	if (ins__is_call(&dl->ins))
-		update_call_insn_state(state, dloc, dl);
+		update_call_insn_state(state, dloc, cu_die, dl);
 	else
 		invalidate_unhandled_insn_regs(state, dl, dst);
 }
-- 
2.34.1

