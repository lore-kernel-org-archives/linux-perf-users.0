Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B738CFEF;
	Sat, 22 Aug 2026 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390570; cv=none; b=n1uOAzV3ZFblqA8QRS5/HbFjfAU3dnYNU/Ie39oy5Np1qDfFFLj3qBDDd2IufKZ91VX5Mza68dx1kDBtQMY2lNd9AEfPrpLvqD1wU5O0Ne4rjOTsRat0Xkdh7nB/+pR5JYQbafk3VCVd5rQVqJzvwM7/es9vvoDaXpGF8g31xOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390570; c=relaxed/simple;
	bh=rwoRf4Zs74vi/87xaArnZCay2+GKPdl9YMWZcOGr6KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiFsxxz6XsEkj/eZKQz9QKgIcLo8cHUX8306U9SRf6dKGaeAKRffIxeh67kZ4c2PVOXPaED8dMsLDcAG+zDpTTa9Gkz6CROng2C2dmUaWX9qZIwnLLJ5jRaBLtTG610a0vgDwR/6sT/6ZMNOe1pxoBrTcJnz40lW79ibCODTvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8Q1bta9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8Q1bta9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6664D1F000E9;
	Sat, 22 Aug 2026 09:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787390568;
	bh=cLZNE7Qt8sppOoO7bJsawycHshOiVZAa5NvF6lZin44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d8Q1bta9gURfjP5v1nJ2bsu62J1yNcyquQqcD+6de5+r5Z2T8XPBCcLq64GJg1WdP
	 dP92l9PwuQy763xHXBXzrgkOI7n4lxGEc9GoPOjoBSfEaEERdPVb0GsDsHKyIVTPOf
	 S7+CNlv/4ymkoZPCbAWoAukF6ELsv9puTF3SN4SJtWfbi9P4RXhiAvOV3NsdrUtTLv
	 EFnTdrd/tE9e8Qu/obDzVNWeuJC9MSG869X8IduJ94LgqvIykrxoatdaucv22Inl9v
	 Ix9LD6KWEMk7KCbJC79s0L249i0hOO9UCH4pVQX+SCRgqitpoOvLpjotpTCnC8ftGA
	 0jgAA2BO2D9UQ==
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
Subject: [PATCH v13 02/12] x86/hw_breakpoints: Make DR7 updates NMI safe
Date: Sat, 22 Aug 2026 18:22:42 +0900
Message-ID: <178739056219.1520941.16843776326995549779.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178739053919.1520941.17662338993878200834.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Jinchao Wang <wangjinchao600@gmail.com>

Hardware breakpoint installation and removal run with IRQs disabled, but
an NMI can still enter the same code through KGDB. The interrupted
operation and the NMI can consequently claim the same slot or overwrite
each other's DR7 state.

Claim and release per-CPU slots with cmpxchg. Update cpu_dr7 with
single-instruction per-CPU operations, and preserve hardware-first
disable and hardware-last enable ordering. Add a per-CPU sequence number
so interrupted DR7 writers and restore paths detect an NMI update and
retry from the latest shadow state.

Link: https://lore.kernel.org/all/4ee0a2efc9e8387af83286b8495b7d490247e165.1785067572.git.wangjinchao600@gmail.com/

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v13:
 - Add compiler barriers (barrier()) before checking cpu_dr7_seq to
   prevent the compiler from hoisting the sequence check before debug
   register updates or shadow state modifications.
Changes in v12:
 - Use stack variables dr7 and dr7_seq directly in exc_nmi() and remove
   unnecessary per-CPU nmi_dr7 and nmi_dr7_seq variables.
---
 arch/x86/include/asm/debugreg.h |   37 ++++++++++----
 arch/x86/kernel/cpu/mce/core.c  |   20 +++++---
 arch/x86/kernel/hw_breakpoint.c |  101 ++++++++++++++++++++-------------------
 arch/x86/kernel/nmi.c           |    7 ++-
 arch/x86/kernel/traps.c         |   10 +++-
 5 files changed, 101 insertions(+), 74 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index a2c1f2d24b64..c41ee981c230 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -18,6 +18,7 @@
 #define DR7_FIXED_1	0x00000400
 
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
+DECLARE_PER_CPU(unsigned int, cpu_dr7_seq);
 
 #ifndef CONFIG_PARAVIRT_XXL
 /*
@@ -125,18 +126,20 @@ static __always_inline bool hw_breakpoint_active(void)
 
 extern void hw_breakpoint_restore(void);
 
-static __always_inline unsigned long local_db_save(void)
+static __always_inline void local_db_save(unsigned long *dr7,
+					  unsigned int *dr7_seq)
 {
-	unsigned long dr7;
+	*dr7 = 0;
+	*dr7_seq = this_cpu_read(cpu_dr7_seq);
 
 	if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
-		return 0;
+		return;
 
-	get_debugreg(dr7, 7);
+	get_debugreg(*dr7, 7);
 
 	/* Architecturally set bit */
-	dr7 &= ~DR7_FIXED_1;
-	if (dr7)
+	*dr7 &= ~DR7_FIXED_1;
+	if (*dr7)
 		set_debugreg(DR7_FIXED_1, 7);
 
 	/*
@@ -145,20 +148,34 @@ static __always_inline unsigned long local_db_save(void)
 	 * be good.
 	 */
 	barrier();
-
-	return dr7;
 }
 
-static __always_inline void local_db_restore(unsigned long dr7)
+static __always_inline void local_db_restore(unsigned long dr7,
+					     unsigned int dr7_seq)
 {
+	unsigned int seq;
+
 	/*
 	 * Ensure the compiler doesn't raise this statement into
 	 * the critical section; enabling breakpoints early would
 	 * not be good.
 	 */
 	barrier();
-	if (dr7)
+
+	do {
+		seq = this_cpu_read(cpu_dr7_seq);
+		if (seq == dr7_seq) {
+			if (!dr7)
+				return;
+		} else {
+			dr7 = this_cpu_read(cpu_dr7);
+			if (!dr7)
+				dr7 = DR7_FIXED_1;
+		}
+
 		set_debugreg(dr7, 7);
+		barrier();
+	} while (unlikely(seq != this_cpu_read(cpu_dr7_seq)));
 }
 
 #ifdef CONFIG_CPU_SUP_AMD
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index cfb74be19994..9dffd45ad89e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2139,20 +2139,22 @@ static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
 	unsigned long dr7;
+	unsigned int dr7_seq;
 
-	dr7 = local_db_save();
+	local_db_save(&dr7, &dr7_seq);
 	exc_machine_check_kernel(regs);
-	local_db_restore(dr7);
+	local_db_restore(dr7, dr7_seq);
 }
 
 /* The user mode variant. */
 DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 {
 	unsigned long dr7;
+	unsigned int dr7_seq;
 
-	dr7 = local_db_save();
+	local_db_save(&dr7, &dr7_seq);
 	exc_machine_check_user(regs);
-	local_db_restore(dr7);
+	local_db_restore(dr7, dr7_seq);
 }
 
 #ifdef CONFIG_X86_FRED
@@ -2170,13 +2172,14 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 DEFINE_FREDENTRY_MCE(exc_machine_check)
 {
 	unsigned long dr7;
+	unsigned int dr7_seq;
 
-	dr7 = local_db_save();
+	local_db_save(&dr7, &dr7_seq);
 	if (user_mode(regs))
 		exc_machine_check_user(regs);
 	else
 		exc_machine_check_kernel(regs);
-	local_db_restore(dr7);
+	local_db_restore(dr7, dr7_seq);
 }
 #endif
 #else
@@ -2184,13 +2187,14 @@ DEFINE_FREDENTRY_MCE(exc_machine_check)
 DEFINE_IDTENTRY_RAW(exc_machine_check)
 {
 	unsigned long dr7;
+	unsigned int dr7_seq;
 
-	dr7 = local_db_save();
+	local_db_save(&dr7, &dr7_seq);
 	if (user_mode(regs))
 		exc_machine_check_user(regs);
 	else
 		exc_machine_check_kernel(regs);
-	local_db_restore(dr7);
+	local_db_restore(dr7, dr7_seq);
 }
 #endif
 
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index f846c15f21ca..3204e75dc454 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -40,6 +40,9 @@
 DEFINE_PER_CPU(unsigned long, cpu_dr7);
 EXPORT_PER_CPU_SYMBOL(cpu_dr7);
 
+/* Sequence number of the per-CPU DR7 state. */
+DEFINE_PER_CPU(unsigned int, cpu_dr7_seq);
+
 /* Per cpu debug address registers values */
 static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
 
@@ -97,38 +100,31 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
 int arch_install_hw_breakpoint(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
+	unsigned int seq;
 	int i;
 
 	lockdep_assert_irqs_disabled();
 
 	for (i = 0; i < HBP_NUM; i++) {
-		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
-
-		if (!*slot) {
-			*slot = bp;
+		if (!this_cpu_cmpxchg(bp_per_reg[i], NULL, bp))
 			break;
-		}
 	}
 
 	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
 		return -EBUSY;
 
-	set_debugreg(info->address, i);
-	__this_cpu_write(cpu_debugreg[i], info->address);
-
-	dr7 = this_cpu_ptr(&cpu_dr7);
-	*dr7 |= encode_dr7(i, info->len, info->type);
-
-	/*
-	 * Ensure we first write cpu_dr7 before we set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
-	 */
-	barrier();
-
-	set_debugreg(*dr7, 7);
-	if (info->mask)
-		amd_set_dr_addr_mask(info->mask, i);
+	do {
+		seq = this_cpu_inc_return(cpu_dr7_seq);
+		this_cpu_write(cpu_debugreg[i], info->address);
+		barrier();
+		set_debugreg(info->address, i);
+		if (info->mask)
+			amd_set_dr_addr_mask(info->mask, i);
+		this_cpu_or(cpu_dr7, encode_dr7(i, info->len, info->type));
+		barrier();
+		set_debugreg(this_cpu_read(cpu_dr7), 7);
+		barrier();
+	} while (seq != this_cpu_read(cpu_dr7_seq));
 
 	return 0;
 }
@@ -146,36 +142,34 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	unsigned long dr7;
+	unsigned int seq;
 	int i;
 
 	lockdep_assert_irqs_disabled();
 
 	for (i = 0; i < HBP_NUM; i++) {
-		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
-
-		if (*slot == bp) {
-			*slot = NULL;
+		if (this_cpu_read(bp_per_reg[i]) == bp)
 			break;
-		}
 	}
 
 	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
 		return;
 
-	dr7 = this_cpu_read(cpu_dr7);
-	dr7 &= ~__encode_dr7(i, info->len, info->type);
-
-	set_debugreg(dr7, 7);
-	if (info->mask)
-		amd_set_dr_addr_mask(0, i);
-
-	/*
-	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
-	 */
-	barrier();
-
-	this_cpu_write(cpu_dr7, dr7);
+	do {
+		seq = this_cpu_inc_return(cpu_dr7_seq);
+		dr7 = this_cpu_read(cpu_dr7);
+		dr7 &= ~__encode_dr7(i, info->len, info->type);
+		set_debugreg(dr7, 7);
+		if (info->mask)
+			amd_set_dr_addr_mask(0, i);
+		barrier();
+		this_cpu_and(cpu_dr7,
+			     ~__encode_dr7(i, info->len, info->type));
+		barrier();
+	} while (seq != this_cpu_read(cpu_dr7_seq));
+
+	WARN_ONCE(this_cpu_cmpxchg(bp_per_reg[i], bp, NULL) != bp,
+		  "Can't release breakpoint slot");
 }
 
 static int arch_bp_generic_len(int x86_len)
@@ -309,13 +303,14 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 				sizeof(struct tlb_state)))
 			return true;
 
-		/*
-		 * When in guest (X86_FEATURE_HYPERVISOR), local_db_save()
-		 * will read per-cpu cpu_dr7 before clear dr7 register.
-		 */
+		/* local_db_save() reads this state before clearing DR7. */
 		if (within_area(addr, end, (unsigned long)&per_cpu(cpu_dr7, cpu),
 				sizeof(cpu_dr7)))
 			return true;
+		if (within_area(addr, end,
+				(unsigned long)&per_cpu(cpu_dr7_seq, cpu),
+				sizeof(cpu_dr7_seq)))
+			return true;
 	}
 
 	return false;
@@ -483,12 +478,18 @@ void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
 
 void hw_breakpoint_restore(void)
 {
-	set_debugreg(__this_cpu_read(cpu_debugreg[0]), 0);
-	set_debugreg(__this_cpu_read(cpu_debugreg[1]), 1);
-	set_debugreg(__this_cpu_read(cpu_debugreg[2]), 2);
-	set_debugreg(__this_cpu_read(cpu_debugreg[3]), 3);
-	set_debugreg(DR6_RESERVED, 6);
-	set_debugreg(__this_cpu_read(cpu_dr7), 7);
+	unsigned int seq;
+
+	do {
+		seq = this_cpu_inc_return(cpu_dr7_seq);
+		set_debugreg(this_cpu_read(cpu_debugreg[0]), 0);
+		set_debugreg(this_cpu_read(cpu_debugreg[1]), 1);
+		set_debugreg(this_cpu_read(cpu_debugreg[2]), 2);
+		set_debugreg(this_cpu_read(cpu_debugreg[3]), 3);
+		set_debugreg(DR6_RESERVED, 6);
+		set_debugreg(this_cpu_read(cpu_dr7), 7);
+		barrier();
+	} while (seq != this_cpu_read(cpu_dr7_seq));
 }
 EXPORT_SYMBOL_FOR_KVM(hw_breakpoint_restore);
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 3c9f60d6ca5a..c3806f7bd3e8 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -531,11 +531,12 @@ enum nmi_states {
 };
 static DEFINE_PER_CPU(enum nmi_states, nmi_state);
 static DEFINE_PER_CPU(unsigned long, nmi_cr2);
-static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
 	irqentry_state_t irq_state;
+	unsigned long dr7;
+	unsigned int dr7_seq;
 	struct nmi_stats *nsp = this_cpu_ptr(&nmi_stats);
 
 	/*
@@ -572,7 +573,7 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	 */
 	sev_es_ist_enter(regs);
 
-	this_cpu_write(nmi_dr7, local_db_save());
+	local_db_save(&dr7, &dr7_seq);
 
 	irq_state = irqentry_nmi_enter(regs);
 
@@ -594,7 +595,7 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	irqentry_nmi_exit(regs, irq_state);
 
-	local_db_restore(this_cpu_read(nmi_dr7));
+	local_db_restore(dr7, dr7_seq);
 
 	sev_es_ist_exit();
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 30aa8369957e..018abe736285 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1231,8 +1231,12 @@ static noinstr void exc_debug_kernel(struct pt_regs *regs, unsigned long dr6)
 	 * it results in an endless recursion and stack overflow. Thus we stay
 	 * with the IDT approach, i.e., save DR7 and disable #DB.
 	 */
-	unsigned long dr7 = local_db_save();
-	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+	unsigned long dr7;
+	unsigned int dr7_seq;
+	irqentry_state_t irq_state;
+
+	local_db_save(&dr7, &dr7_seq);
+	irq_state = irqentry_nmi_enter(regs);
 	instrumentation_begin();
 
 	/*
@@ -1289,7 +1293,7 @@ static noinstr void exc_debug_kernel(struct pt_regs *regs, unsigned long dr6)
 	instrumentation_end();
 	irqentry_nmi_exit(regs, irq_state);
 
-	local_db_restore(dr7);
+	local_db_restore(dr7, dr7_seq);
 }
 
 static noinstr void exc_debug_user(struct pt_regs *regs, unsigned long dr6)

