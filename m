Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B662BEC2A;
	Tue, 23 Jun 2026 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219770; cv=none; b=Z0T+n7WN13RVdmiEhEUKYYtJScuyA5pDzNEXFGrfEWJVa1QC3c1jpAzDBMdliFKmHTre4EGfwlmr1XKKbFhLM1bLc2660rGOfDRck60A56YzPVTQmsVVGShyPa6F0ndtIEZfDPJDenvuFDQV0kWwJnC3RZ6SP0QpoQcgxjUunbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219770; c=relaxed/simple;
	bh=umVj2ORw1phCxDDZ8wUxNSRSV+I6hPul80WxYGswG5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRQriP1vVgDqIRzjzrIt4ZsjswlbXvf1j7V+unoOCqSFbVOQkUTrQitCb7CJX7XSniKRfzWlTyJCDEaLmyGEjlBK6TrIQqM8hPP6L5Mn4KQ9z53v6n5OesXj3ZbkMBmXvGpTv15IZPD5h9IYxZbDXt0E33JKnMEThprpGlIQnv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xqlDbmQw; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xqlDbmQw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782219764; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=myZQdNFKoJDQgZTeIs7E/e5gDli66UFS3bIMOJ3e2Qw=;
	b=xqlDbmQww+xN8BNMMrEeO3brGRxzADc71t7aSmKlrLhD2H6SIH491QlbK/6PbRg6rVH/M9MYnk7MgHtMB1qE9AQwOcI/ZBB1AKEbMTfDBu6SWRI8jD0iFaY67eGf84q5mfiSeVQ09LxAJtn4ygCmCl/Bc7RqX1Q8ATJLcxQsTr4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X5UKImf_1782219761;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X5UKImf_1782219761 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 21:02:41 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/5] perf annotate: Wire up ARM64 data type profiling infrastructure
Date: Tue, 23 Jun 2026 21:02:33 +0800
Message-Id: <20260623130234.8709-5-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
References: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ARM64 support to the core dispatch and initialization points:

1. annotate_get_insn_location(): Add an arm64 branch alongside the
   existing powerpc branch to call get_arm64_regs() for extracting
   register numbers and memory offsets from raw instructions.

2. arch_supports_insn_tracking(): Include arm64 so that
   find_data_type_block() can perform instruction-level type state
   tracking on ARM64.

3. init_type_state(): Add arm64 branch to set caller-saved registers
   (x0-x18 per AAPCS64) and stack register (SP, DWARF reg 31).
   Without this, stack_reg defaults to 0 (x0) after memset, causing
   x0-based memory accesses to be misidentified as stack accesses.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 tools/perf/util/annotate-data.c | 18 +++++++++++++++++-
 tools/perf/util/annotate.c      | 12 ++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1eff0a27237d..c04ad66ff077 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -29,6 +29,11 @@
 /* register number of the stack pointer */
 #define X86_REG_SP 7
 
+/* ARM64 DWARF register numbers: x0-x30=0-30, SP=31 */
+#define ARM64_REG_SP 31
+#define ARM64_REG_LR 30
+#define ARM64_REG_FP 29
+
 static void delete_var_types(struct die_var_type *var_types);
 
 #define pr_debug_dtp(fmt, ...)					\
@@ -178,6 +183,16 @@ static void init_type_state(struct type_state *state, const struct arch *arch)
 		state->ret_reg = 0;
 		state->stack_reg = X86_REG_SP;
 	}
+
+	if (arch__is_arm64(arch)) {
+		int i;
+
+		/* ARM64 ABI: x0-x18 are caller-saved */
+		for (i = 0; i <= 18; i++)
+			state->regs[i].caller_saved = true;
+		state->ret_reg = 0;
+		state->stack_reg = ARM64_REG_SP;
+	}
 }
 
 static void exit_type_state(struct type_state *state)
@@ -1421,7 +1436,8 @@ static enum type_match_result find_data_type_insn(struct data_loc_info *dloc,
 
 static int arch_supports_insn_tracking(struct data_loc_info *dloc)
 {
-	if ((arch__is_x86(dloc->arch)) || (arch__is_powerpc(dloc->arch)))
+	if ((arch__is_x86(dloc->arch)) || (arch__is_powerpc(dloc->arch)) ||
+	    (arch__is_arm64(dloc->arch)))
 		return 1;
 	return 0;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e745f3034a0e..bd734826538d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2574,19 +2574,23 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 		op_loc->reg2 = -1;
 
 		if (insn_str == NULL) {
-			if (!arch__is_powerpc(arch))
+			if (!arch__is_powerpc(arch) && !arch__is_arm64(arch))
 				continue;
 		}
 
 		/*
-		 * For powerpc, call get_powerpc_regs function which extracts the
-		 * required fields for op_loc, ie reg1, reg2, offset from the
-		 * raw instruction.
+		 * For powerpc and arm64, call arch-specific functions to
+		 * extract the required fields for op_loc (reg1, reg2, offset)
+		 * from the raw instruction.
 		 */
 		if (arch__is_powerpc(arch)) {
 			op_loc->mem_ref = mem_ref;
 			op_loc->multi_regs = multi_regs;
 			get_powerpc_regs(dl->raw.raw_insn, !i, op_loc);
+		} else if (arch__is_arm64(arch)) {
+			op_loc->mem_ref = mem_ref;
+			op_loc->multi_regs = multi_regs;
+			get_arm64_regs(dl->raw.raw_insn, !i, op_loc);
 		} else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
 			op_loc->mem_ref = true;
 			op_loc->multi_regs = multi_regs;
-- 
2.51.2.612.gdc70283dfc

