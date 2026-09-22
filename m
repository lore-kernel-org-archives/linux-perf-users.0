Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDF93B19BA;
	Tue, 22 Sep 2026 04:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051103; cv=none; b=t/ZdNzJIjEDo/Ll7x1Wfx3ae9BNfOcYAYmtduSYWx6T7f4cQEVhZWszrA2NFbkryLyGwtmbtWG8FIyy8pIqnJWGVtFwRu/6j0dUBDH7K/fExPgUqgeGE5MZ9lX2O4CmbXVQ8C+0ELNKBYS0fqsBAfVu0l+x0iXnC3FTnnB2C3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051103; c=relaxed/simple;
	bh=++emXcP9SPk1N6KlszECK+hTyKvu/kLTGVZdg7HV0Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHJH2Yxnr1PUpx+G/zTOUI18Us9FDFNW0IXEJJt+lmh1imqe2zpqzSm9WPOT7qKzmOV0XflXzq+/qcLDJLq0cAy5l5ytWyUmVoyIXfAr6B8E+wINUm9P6Dta2T8sFDMg3Y/Nn9aTJ80V6oB6D4rRi22OnYRAjbX1n3FZGi0qX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9vsazbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9vsazbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004BB1F000FF;
	Tue, 22 Sep 2026 04:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051102;
	bh=ECQ2YrO3c6fTy3LNvcZ/qkWRkP34JaQc5nHEXsbIZYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9vsazbSFWTo5U6CPnSMDUrbuQR2IpclOPrYwrj6DA1iF1EC4SEKlyc6aqW07l9pt
	 sxU2MKo2Qcm30AuaRSCdmGle9dG4uCUBqmr9nw8T+lFv3VKgpVnbHFt9ZlfKJYP2wJ
	 sVGa1NN/40op0Gcsk6z83+Yq8WLZCqwLcY87gW+vDxBcmMb8Kd8iZ4a3glIA4QoeJv
	 g5llcML+kVX/KEEgZI8kdrdfTX3CkH7vUv9VM5x9ifsK1P2QuLqcPu1AqtTgcWRdUN
	 ELykU/8lLuXyWRRzd0vRoQ0Y7XcOCmzuJa9r/HPWF8lnn+7v6dvjeUVfdvl/Axg6OG
	 NZcsLl1NFl9bQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>
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
	linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v17 01/13] x86/mce: Fix hardware debug register corruption on task migration
Date: Tue, 22 Sep 2026 13:24:55 +0900
Message-ID: <179005109564.388919.3937970081044095776.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179005108298.388919.4535333252892590932.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
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
 

