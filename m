Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26649345EAC;
	Mon,  7 Sep 2026 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788752797; cv=none; b=JI2qVhptmtXtxz8qSpcnm4N64TaYeeYIT72pMIQ8jqHfi9z4CidNUs5ixW0VVZQLsMJn80jF2bpj2KhEyhPrUgfYv0ByWxMqp0FpBsuYiZsJIbE/qcsCtpbD+ouY3hjdV0ZWUCCGObHHxvoyrpycHvxmYdKQK86ym7SJg3mRhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788752797; c=relaxed/simple;
	bh=++emXcP9SPk1N6KlszECK+hTyKvu/kLTGVZdg7HV0Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgPB36CMOUcuIbDKBlLZOsybhPlWZIIxMn3X9f/BMpBW6lbcN2xzESTxCpTQYDhW6JcJULLBbhjnBV4W0i/cBFqdNnOLn1SHurSr5wEVLGZTvpXttOVjY+Jz+DH7qIIKTwPfIGsLcN7bWXI6rxrEQtRY+09052KwNMTgVGz5Hx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyH4N0UD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyH4N0UD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D291F00A3A;
	Mon,  7 Sep 2026 03:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788752795;
	bh=ECQ2YrO3c6fTy3LNvcZ/qkWRkP34JaQc5nHEXsbIZYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GyH4N0UDZVDoofssCO9BCQETKgJkXbuM/BBGZ99C4OaDrACL5z4GlsesMge794BV5
	 82kDqbXwzJIYq65lRbzF0a5BzxdGpBre4Hf2YBNkxZqZt7r20i6hFB///vWIPLD6Ml
	 +qZIf7N6MwhLKaQmRP0h6zF8ZOf8QhEmU1urfBhPEta7COD6DSFIABXd90RvHNLq8J
	 krIV+RZX8O82czbkDWmUVlYaZqPV8hyFdf47xt7/VyZzHdrJp0QJz7lVH+XEMs6iew
	 B0ykl5MnvLjlyZ82jzQlByY6qQwE0O2lV3Thl7J0IIKByDSCgDTdoRt33mSINzrR2B
	 lw6Cx0YDTIHIg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v15 01/12] x86/mce: Fix hardware debug register corruption on task migration
Date: Mon,  7 Sep 2026 12:46:30 +0900
Message-ID: <178875279006.93794.3424002631388906633.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178875277830.93794.14247844688761142429.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In exc_machine_check_user(), local_db_save() and local_db_restore() are
invoked in the outer entry stubs (DEFINE_IDTENTRY_MCE_USER,
DEFINE_FREDENTRY_MCE, and DEFINE_IDTENTRY_RAW), surrounding
exc_machine_check_user().

However, exc_machine_check_user() calls irqentry_exit_to_user_mode(),
which handles pending thread work and may schedule() if TIF_NEED_RESCHED
is set. If the task migrates to another CPU during schedule(),
local_db_restore() runs on the new CPU with the dr7 state saved from the
old CPU. This corrupts the new CPU's DR7 hardware debug register and
leaves the old CPU's DR7 disabled.
In short, local_db_save() and local_db_restore() pair must be run
on the same CPU.

To fix this, move local_db_save() and local_db_restore() inside
exc_machine_check_user() and exc_machine_check_kernel(). In
exc_machine_check_user(), DR7 is saved and restored strictly around
do_machine_check() to avoid schedule() during migration. In
exc_machine_check_kernel(), local_db_save() is called at the entry point
to prevent early memory accesses from triggering nested #DB exceptions,
and restored on all exits.

Fixes: cd840e424f27 ("x86/entry, mce: Disallow #DB during #MC")
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v15:
 - Move local_db_save() to the entry of exc_machine_check_kernel() and
   restore it on early return from mce_check_crashing_cpu() to prevent
   nested #DB on watched variables.
Changes in v14:
 - Newly added.
---
 arch/x86/kernel/cpu/mce/core.c |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ab469605fc89..39f238952e14 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2108,6 +2108,9 @@ bool filter_mce(struct mce *m)
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
 	irqentry_state_t irq_state;
+	unsigned long dr7;
+
+	dr7 = local_db_save();
 
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -2116,20 +2119,26 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	 * mce_check_crashing_cpu() for details.
 	 */
 	if (mca_cfg.initialized && mce_check_crashing_cpu())
-		return;
+		goto out;
 
 	irq_state = irqentry_nmi_enter(regs);
 
 	do_machine_check(regs);
 
 	irqentry_nmi_exit(regs, irq_state);
+out:
+	local_db_restore(dr7);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
+	unsigned long dr7;
+
 	irqentry_enter_from_user_mode(regs);
 
+	dr7 = local_db_save();
 	do_machine_check(regs);
+	local_db_restore(dr7);
 
 	irqentry_exit_to_user_mode(regs);
 }
@@ -2138,21 +2147,13 @@ static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 /* MCE hit kernel mode */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
-	unsigned long dr7;
-
-	dr7 = local_db_save();
 	exc_machine_check_kernel(regs);
-	local_db_restore(dr7);
 }
 
 /* The user mode variant. */
 DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 {
-	unsigned long dr7;
-
-	dr7 = local_db_save();
 	exc_machine_check_user(regs);
-	local_db_restore(dr7);
 }
 
 #ifdef CONFIG_X86_FRED
@@ -2169,28 +2170,20 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
  */
 DEFINE_FREDENTRY_MCE(exc_machine_check)
 {
-	unsigned long dr7;
-
-	dr7 = local_db_save();
 	if (user_mode(regs))
 		exc_machine_check_user(regs);
 	else
 		exc_machine_check_kernel(regs);
-	local_db_restore(dr7);
 }
 #endif
 #else
 /* 32bit unified entry point */
 DEFINE_IDTENTRY_RAW(exc_machine_check)
 {
-	unsigned long dr7;
-
-	dr7 = local_db_save();
 	if (user_mode(regs))
 		exc_machine_check_user(regs);
 	else
 		exc_machine_check_kernel(regs);
-	local_db_restore(dr7);
 }
 #endif
 

