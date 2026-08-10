Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981742B736;
	Mon, 10 Aug 2026 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380417; cv=none; b=FYGMZJindK+T/sqZAsrAGZQKtDsWWrWa3MaFFcUI84qsvCiCu/3OvTjolqdMg/Tr9gYySrKTNpuditYpewJoDKH+hRhRz+LdzN4kpoZVtIHRMHeLmFLDb4mDKMAembfgjopt6dvU5058/RLmyGa8Z5hcd82j9bifyqcuX3nqmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380417; c=relaxed/simple;
	bh=rlVkEnZhSJm2h0cc27O1cWgfHaeRA7zb7QQnYshho+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpdUYEi+xrljntNcwV8FH//4FZ5O05pIsjwXTUMbVI+frJzHUAD0dTLnu80bGz76CUl4fFmOlguEghCL0lHwAOy4JvR/wvGwor8z8vzefs78C25poVYjcB2OMCYU95TOGQGS7k6gXsiZAAp6p0p5zo5TfZQWgbL9y/+Rtzap0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVBZJ4LB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVBZJ4LB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8BD1F00A3D;
	Mon, 10 Aug 2026 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786380415;
	bh=BJm1Z9xZ0d8T/x30s5rEX7Wpd/wxL/yzuR113JZ+N2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVBZJ4LBmAqMcuNy4QTwNkP9Hd82xX+auqNQuNoTeezY1tYQ6cfYnTUmI+Mq9wduN
	 ULOi3Gb6t0hTHlZduxRAdRJXwzAwAxiVDb4UzbzqzmU8FO9vD74lyTmK1iBcMhj0wB
	 p0aGX91KeSBMcGaS5PD8+Dq1cZmGdhvGqZUbZkF8eiL5Oz6O9whHrDsk9vZ5wkupMM
	 pl3Ug3FH+DhuWbHCDKfRIpIzkgbBN4oQKlyhf3fy58BFaj8FkY7r0vflR725lzkUdj
	 ja2d9QNXhC3KKLwZW1NNNtIfhQ2mUM/rTQPYMXDED8pQl62jMqmU4glbL8ivd/Lubr
	 u7FTv1WcGzxYw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v6 1/3] arm64: Add raw variants of local_daif_save() and local_daif_restore()
Date: Mon, 10 Aug 2026 09:46:18 -0700
Message-ID: <20260810164622.1829843-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810164622.1829843-1-puranjay@kernel.org>
References: <20260810164622.1829843-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

local_daif_save() unconditionally calls trace_hardirqs_off(), and
local_daif_restore() the matching trace_hardirqs_on(). A caller already
in a hardirqs-off context, or one that must not run tracing code between
masking exceptions and its next step, has no way to opt out.

cpu_suspend() is one such caller and already carries a comment asking for
this. Sampling the BRBE branch record buffer is another: the tracing
calls generate branches that evict the records about to be read.

Split the tracing out into raw_local_daif_save() and
raw_local_daif_restore(), and convert cpu_suspend() to the raw save with
a lockdep_assert_irqs_disabled() for the precondition it now relies on.
Its restore stays traced, to re-arm the irqsoff tracer for the resume
path. The PMR unmasking cpu_suspend() needs is in raw_local_daif_mask(),
so it is unaffected.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/include/asm/daifflags.h | 41 +++++++++++++++++++++++++-----
 arch/arm64/kernel/suspend.c        |  7 ++---
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 795b351284673..c3adba0985bda 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -18,8 +18,7 @@
 #define DAIF_MASK		(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
 
 
-/* mask/save/unmask/restore all exceptions, including interrupts. */
-static __always_inline void local_daif_mask(void)
+static __always_inline void raw_local_daif_mask(void)
 {
 	WARN_ON(system_has_prio_mask_debugging() &&
 		(read_sysreg_s(SYS_ICC_PMR_EL1) == (GIC_PRIO_IRQOFF |
@@ -34,6 +33,12 @@ static __always_inline void local_daif_mask(void)
 	/* Don't really care for a dsb here, we don't intend to enable IRQs */
 	if (system_uses_irq_prio_masking())
 		gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET);
+}
+
+/* mask/save/unmask/restore all exceptions, including interrupts. */
+static __always_inline void local_daif_mask(void)
+{
+	raw_local_daif_mask();
 
 	trace_hardirqs_off();
 }
@@ -53,18 +58,29 @@ static __always_inline unsigned long local_daif_save_flags(void)
 	return flags;
 }
 
-static __always_inline unsigned long local_daif_save(void)
+static __always_inline unsigned long raw_local_daif_save(void)
 {
 	unsigned long flags;
 
 	flags = local_daif_save_flags();
 
-	local_daif_mask();
+	raw_local_daif_mask();
 
 	return flags;
 }
 
-static __always_inline void local_daif_restore(unsigned long flags)
+static __always_inline unsigned long local_daif_save(void)
+{
+	unsigned long flags;
+
+	flags = raw_local_daif_save();
+
+	trace_hardirqs_off();
+
+	return flags;
+}
+
+static __always_inline void __local_daif_restore(unsigned long flags, bool trace)
 {
 	bool irq_disabled = flags & PSR_I_BIT;
 
@@ -72,7 +88,8 @@ static __always_inline void local_daif_restore(unsigned long flags)
 		(read_sysreg(daif) & (PSR_I_BIT | PSR_F_BIT)) != (PSR_I_BIT | PSR_F_BIT));
 
 	if (!irq_disabled) {
-		trace_hardirqs_on();
+		if (trace)
+			trace_hardirqs_on();
 
 		if (system_uses_irq_prio_masking()) {
 			gic_write_pmr(GIC_PRIO_IRQON);
@@ -116,10 +133,20 @@ static __always_inline void local_daif_restore(unsigned long flags)
 
 	write_sysreg(flags, daif);
 
-	if (irq_disabled)
+	if (irq_disabled && trace)
 		trace_hardirqs_off();
 }
 
+static __always_inline void local_daif_restore(unsigned long flags)
+{
+	__local_daif_restore(flags, true);
+}
+
+static __always_inline void raw_local_daif_restore(unsigned long flags)
+{
+	__local_daif_restore(flags, false);
+}
+
 /*
  * Called by synchronous exception handlers to restore the DAIF bits that were
  * modified by taking an exception.
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index c41724a40b756..461948ad15ec8 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -117,14 +117,11 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 * updates to mdscr register (saved and restored along with
 	 * general purpose registers) from kernel debuggers.
 	 *
-	 * Strictly speaking the trace_hardirqs_off() here is superfluous,
-	 * hardirqs should be firmly off by now. This really ought to use
-	 * something like raw_local_daif_save().
-	 *
 	 * This also unmasks interrupts in PMR in order to reliably
 	 * resume if we're using pseudo-NMIs.
 	 */
-	flags = local_daif_save();
+	lockdep_assert_irqs_disabled();
+	flags = raw_local_daif_save();
 
 	/*
 	 * Function graph tracer state gets inconsistent when the kernel
-- 
2.53.0-Meta

