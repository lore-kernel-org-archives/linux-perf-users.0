Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96181238159;
	Sat,  4 Jul 2026 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783132897; cv=none; b=mDFbqePXQCtIf96vJuuJrbt38okD0aj4H5qrSkF+rNMAkhFq+lbry/T25PnRsRUHURf0Pw5J37rzU0dwvveClnEnsadqyuKUn9S0shQs4OrXg2NceASvFRCC+a8glvVI/EOl6eTQ2ikaZyrSu2tTNWEa35P3uxydWaRxV+INuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783132897; c=relaxed/simple;
	bh=Xs3tM7qfQm3lT25YtQSsbtO3kUabxeu3sLJHPS1uVVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T8qvVm4UAtJ4sWhFpeV6CXeAfulyqS9bbw0Sz+1md4SPkC4Pa9KEVj4oSF5zFJZS9kDFADdTjFuRhbEjnyRkTq7x6ymrv74C2s6gQHSA4pOjf8eE+5q2E+xYKNGnL6M18DfoGQE18bICOEGJUeGQ8HfESG8X4fums26p9hUfxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GjZtioYM; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GjZtioYM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783132892; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uXcSSBqyEs6AmgiGt4HIlYfUa4BF9HhKnMFy5oK8LMg=;
	b=GjZtioYM9Q4FUct+HfC0TPBFlapJP/EsoRiIbkjqIHN0ucVfysBxf06FMnAg/zBOOd5m+R1ztY6s7rkGDDeuanrvvilR2qGfuclCmcU2oWtTiFHX/IhIe3aWh16a4hu/sgYTOmCQOQH80wBvywH6pG3O1WUnvr7x/HoQCrMowwA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X6KaS.7_1783132569;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X6KaS.7_1783132569 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 04 Jul 2026 10:36:11 +0800
From: fangyu.yu@linux.alibaba.com
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
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Anup Patel <anup@brainfault.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	guoren@kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH] perf kvm/riscv: Fix event key collision between interrupts and exceptions
Date: Sat,  4 Jul 2026 10:36:08 +0800
Message-Id: <20260704023608.24971-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

RISC-V scause encodes interrupts and exceptions in the same
cause field, with bit 63 on RV64 and bit 31 on RV32 used to
distinguish interrupts from exceptions. The lower cause bits
overlap between the two namespaces, so masking off the interrupt
bit makes distinct IRQ and exception events map to the same key.

This affects perf kvm stat exit-reason decoding. For example,
IRQ_S_TIMER and EXC_LOAD_ACCESS both use cause code 5, and can be
misreported as the wrong exit reason.

Fix this by using the full scause value as the lookup key in
event_get_key(). Also split TRAP() into TRAP_EXC() and
TRAP_IRQ() so interrupt entries are encoded with the
architecture-specific IRQ bit set, matching the value reported by
hardware.

Fixes: ceea279f9376 ("perf kvm stat: Remove use of the arch directory")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  4 +--
 .../util/kvm-stat-arch/riscv_trap_types.h     | 27 ++++++++++---------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
index 967bba261a47..829096a41a3b 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
@@ -23,10 +23,8 @@ static const char * const __kvm_events_tp[] = {
 static void event_get_key(struct perf_sample *sample,
 			  struct event_key *key)
 {
-	int xlen = 64; // TODO: 32-bit support.
-
 	key->info = 0;
-	key->key = perf_sample__intval(sample, kvm_exit_reason(EM_RISCV)) & ~CAUSE_IRQ_FLAG(xlen);
+	key->key = perf_sample__intval(sample, kvm_exit_reason(EM_RISCV));
 	key->exit_reasons = riscv_exit_reasons;
 }
 
diff --git a/tools/perf/util/kvm-stat-arch/riscv_trap_types.h b/tools/perf/util/kvm-stat-arch/riscv_trap_types.h
index aa5d24fab4ee..da1f1ce55326 100644
--- a/tools/perf/util/kvm-stat-arch/riscv_trap_types.h
+++ b/tools/perf/util/kvm-stat-arch/riscv_trap_types.h
@@ -38,20 +38,21 @@
 #define EXC_VIRTUAL_INST_FAULT 22
 #define EXC_STORE_GUEST_PAGE_FAULT 23
 
-#define TRAP(x) { x, #x }
+#define TRAP_EXC(x) { x, #x }
+#define TRAP_IRQ(x) { (x) | CAUSE_IRQ_FLAG(__riscv_xlen), #x }
 
 #define kvm_riscv_trap_class \
-	TRAP(IRQ_S_SOFT), TRAP(IRQ_VS_SOFT), TRAP(IRQ_M_SOFT), \
-	TRAP(IRQ_S_TIMER), TRAP(IRQ_VS_TIMER), TRAP(IRQ_M_TIMER), \
-	TRAP(IRQ_S_EXT), TRAP(IRQ_VS_EXT), TRAP(IRQ_M_EXT), \
-	TRAP(IRQ_S_GEXT), TRAP(IRQ_PMU_OVF), \
-	TRAP(EXC_INST_MISALIGNED), TRAP(EXC_INST_ACCESS), TRAP(EXC_INST_ILLEGAL), \
-	TRAP(EXC_BREAKPOINT), TRAP(EXC_LOAD_MISALIGNED), TRAP(EXC_LOAD_ACCESS), \
-	TRAP(EXC_STORE_MISALIGNED), TRAP(EXC_STORE_ACCESS), TRAP(EXC_SYSCALL), \
-	TRAP(EXC_HYPERVISOR_SYSCALL), TRAP(EXC_SUPERVISOR_SYSCALL), \
-	TRAP(EXC_INST_PAGE_FAULT), TRAP(EXC_LOAD_PAGE_FAULT), \
-	TRAP(EXC_STORE_PAGE_FAULT), TRAP(EXC_INST_GUEST_PAGE_FAULT), \
-	TRAP(EXC_LOAD_GUEST_PAGE_FAULT), TRAP(EXC_VIRTUAL_INST_FAULT), \
-	TRAP(EXC_STORE_GUEST_PAGE_FAULT)
+	TRAP_IRQ(IRQ_S_SOFT), TRAP_IRQ(IRQ_VS_SOFT), TRAP_IRQ(IRQ_M_SOFT), \
+	TRAP_IRQ(IRQ_S_TIMER), TRAP_IRQ(IRQ_VS_TIMER), TRAP_IRQ(IRQ_M_TIMER), \
+	TRAP_IRQ(IRQ_S_EXT), TRAP_IRQ(IRQ_VS_EXT), TRAP_IRQ(IRQ_M_EXT), \
+	TRAP_IRQ(IRQ_S_GEXT), TRAP_IRQ(IRQ_PMU_OVF), \
+	TRAP_EXC(EXC_INST_MISALIGNED), TRAP_EXC(EXC_INST_ACCESS), TRAP_EXC(EXC_INST_ILLEGAL), \
+	TRAP_EXC(EXC_BREAKPOINT), TRAP_EXC(EXC_LOAD_MISALIGNED), TRAP_EXC(EXC_LOAD_ACCESS), \
+	TRAP_EXC(EXC_STORE_MISALIGNED), TRAP_EXC(EXC_STORE_ACCESS), TRAP_EXC(EXC_SYSCALL), \
+	TRAP_EXC(EXC_HYPERVISOR_SYSCALL), TRAP_EXC(EXC_SUPERVISOR_SYSCALL), \
+	TRAP_EXC(EXC_INST_PAGE_FAULT), TRAP_EXC(EXC_LOAD_PAGE_FAULT), \
+	TRAP_EXC(EXC_STORE_PAGE_FAULT), TRAP_EXC(EXC_INST_GUEST_PAGE_FAULT), \
+	TRAP_EXC(EXC_LOAD_GUEST_PAGE_FAULT), TRAP_EXC(EXC_VIRTUAL_INST_FAULT), \
+	TRAP_EXC(EXC_STORE_GUEST_PAGE_FAULT)
 
 #endif /* ARCH_PERF_RISCV_TRAP_TYPES_H */
-- 
2.50.1

