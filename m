Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A7E549386;
	Tue,  8 Sep 2026 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872544; cv=none; b=GmwpDOINzII5d4AqeG/XuEZC9hfL3FKaJoHcHke8icrEUIvTDFNQC0Yk1LSSq/yA/BI3G8zlcmHImemlGyOoxKHGNbOhJ35hEypFALs7DEWeWeYmaGFov6YcAAWjdsphUF24Nm554I+0XQ4fuz4a5Dqfr20+rhB5Niklsy0L9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872544; c=relaxed/simple;
	bh=F2ScKTi4VWGsltezkQfAVP9hhVJfM0RkL3vvmhkVas8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnXgmt8ynN0MrEuyvJbXcHqyIV2FMh6wOdUr1QAgMif7X9XVn2yvBvGiG34+8KPqrFTUpQHf1hRnVmcodmD897OAyuQDNYQIWtn7LUY78JDELKTZLVLxxMakv135yqX/0vnee8qZ/R4YbX5afAQymdH+eZZbymqrZlYX682Cruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPFW0qpQzYQvRq;
	Tue,  8 Sep 2026 21:01:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9B5274057C;
	Tue,  8 Sep 2026 21:01:54 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S17;
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
Subject: [PATCH v5 15/26] perf annotate-arm64: Track return type after call instructions
Date: Tue,  8 Sep 2026 13:01:11 +0000
Message-Id: <20260908130122.633500-16-wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S17
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3ZFykGF13Xw4kuFWDCFg_yoW8CFWrpa
	4Dury5Gr1UGr42grnxtrWxXryfCryxW34jkrnrtwn2vFW2yr4fJFZ7Kryaqa1rXr9xCw48
	AwsFkF45Cw4xCaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Enable data type profiling to track function return values in arm64
annotations by looking up the DWARF return type of called functions.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-arch/annotate-arm64.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 8fda4d4d6888..9a3226526522 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -456,7 +456,7 @@ static bool is_readonly_branch_or_cmp(const char *name)
 }
 
 static void update_insn_state_arm64(struct type_state *state,
-				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
@@ -479,6 +479,8 @@ static void update_insn_state_arm64(struct type_state *state,
 		struct symbol *func = dl->ops.target.sym;
 		const char *call_name;
 		u64 call_addr;
+		struct type_state_reg *tsr;
+		Dwarf_Die type_die;
 
 		call_name = func ? func->name : dl->ops.target.name;
 		pr_debug_dtp("call [%x] %s\n", insn_offset, call_name ?: "<unknown>");
@@ -496,6 +498,20 @@ static void update_insn_state_arm64(struct type_state *state,
 				continue;
 			invalidate_reg_state(reg);
 		}
+
+		/* Update register with the return type (if any) */
+		if (call_name && die_find_func_rettype(cu_die, call_name, &type_die)) {
+			tsr = &state->regs[state->ret_reg];
+			invalidate_reg_state(tsr);
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
+			tsr->ok = true;
+
+			pr_debug_dtp("call [%x] return -> reg%d",
+				     insn_offset, state->ret_reg);
+			pr_debug_type_name(&type_die, tsr->kind);
+		}
 		return;
 	}
 
-- 
2.34.1

