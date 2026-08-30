Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDED39E6FC;
	Sun, 30 Aug 2026 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100029; cv=none; b=XHMyItethwuP0b6dnzCkNGhf98f8x4I1OVu5rY/DxAQ4NzZtOVQh8ePn2UECrep46cwWrZAX9GUO7eMmGFlXdIiAuhb2/rVOPvvy6YDBcllTogfkY3f7wGvRnT/nIUSae601FeEJL8jhFyED0/C9uPBLaqZ0StSg/Y9Jl7ZSQJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100029; c=relaxed/simple;
	bh=EuZr4900QNyWKnewwzCV1UFmlkplj1FX3SUkVolMhXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrlxNn3spw8AqkkB5ARifh3/ZuhlFU7tICEuw0Afj0sn7vej8iXfrFCpbX0GTNLUwMHdi/niLNRSESgYaTuqyiTbXA8XvzXX2xSNbzDQzWPA5ZsCWgNEmOvjIsVL7JTliOl/+sPgq3XPWbY8uXKjOtO4zi9se4AJH31sZis3pJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAgHAKc/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAgHAKc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FC61F000E9;
	Sun, 30 Aug 2026 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100028;
	bh=dVvkbL12qdBeZy/TOlqvj4SbZaMgEXfYq3x5+rZOW2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cAgHAKc/FylDjuvsicvTt3Gbm9tt3n16xLE4m7xmY7EIZBFy3lsY+l1+y9P3+TLbG
	 19L+oJgtAAIpYHUqCMb70pP+Kh4PoTTReVsQ3iIqLPjBYpErFtkaxgRHHA6yTC4hpY
	 E+YJesCL5QjUjXUjKQn/yp25S8ZTQw99mck9y5VP8KzUbOJ6HSiyD8jPG9yApcxeE1
	 zqPKl6Tmn5RGXOIKhlB4Nm+MHC7NWEFp/oa5AsmRmNTaPDX7JI/e3WD6B9ubOH+m9C
	 75hE1yicoD5kbvX6LoSXoIKsrk1VTnNy8NTZHgTTc+8/NicWUCCR9I7lhIV6DC8ajo
	 UbNnotqRRlY4A==
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
Subject: [PATCH v14 01/14] x86/mce: Fix hardware debug register corruption on task migration
Date: Sun, 30 Aug 2026 23:27:03 +0900
Message-ID: <178810002334.64882.15357388305843450280.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178810001186.64882.2161016469449127450.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
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
exc_machine_check_user() and exc_machine_check_kernel() so that DR7
is saved and restored strictly around do_machine_check().

Fixes: cd840e424f27 ("x86/entry, mce: Disallow #DB during #MC")
Assisted-by: Antigravity:gemini-3.7-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v14:
 - Newly added.
---
 arch/x86/kernel/cpu/mce/core.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index cfb74be19994..61ade8b5c9d7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2108,6 +2108,7 @@ bool filter_mce(struct mce *m)
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
 	irqentry_state_t irq_state;
+	unsigned long dr7;
 
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -2118,18 +2119,24 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	if (mca_cfg.initialized && mce_check_crashing_cpu())
 		return;
 
+	dr7 = local_db_save();
 	irq_state = irqentry_nmi_enter(regs);
 
 	do_machine_check(regs);
 
 	irqentry_nmi_exit(regs, irq_state);
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
@@ -2138,21 +2145,13 @@ static __always_inline void exc_machine_check_user(struct pt_regs *regs)
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
@@ -2169,28 +2168,20 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
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
 

