Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468F475320;
	Mon, 14 Sep 2026 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390222; cv=none; b=OW6+mowapidX6LvxmkDiatMiFHCDiiKipCJuC8O4goQijXPnnHMRG7YiKomyVUt8coJyi6chtUb2kpnxK0Q/dudLfdenIffy29T+JMP64YlYIgjasq+OkZdGhPrUQfEOUdDh7zHMm7rQer+CGr9AYlu85/znDvT6NeHHZ9yZmrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390222; c=relaxed/simple;
	bh=4etfGZMWZ5ZJzFe+zPJx242UvP4vou7lstyycOADWc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uR3LL0X27GKB0b3zowVRHZkFDIGPnVtjHetoJlpMlNDFA0a5/wN6vs076MXqw3L4p2kZpbXw4rDRAEC02m9GClVnfqyjkCQY/oyUIou2GcqBUJr70UslnlGXqRDC0v62RuMFHDREX17RFs7x/Ezp/DRk+YYJKv/K1aXSIr/qrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZnWie55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZnWie55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DCE1F000FF;
	Mon, 14 Sep 2026 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390218;
	bh=v2ra3ieNUhR7B4MtTkkeUqkeFuJOFN8UJu5yaTqCtis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TZnWie55FA4qDB9t+xus0CtSeQ7DnHKn71yabYzzbwgSemvva5oiWbzGYeTiWygKv
	 KAKklNGWy7xPgwV13h4SQxotsckyVft5P1Vm1sLgcDXUXL/rvEeDbHrMFyejVCyLw8
	 FNDE+gJhYHIVoGR1SzwU9QjDF1G2CBtZSxo5FoGQWsT9u6otumzQqJH3SwbTHpl4GE
	 Qv8pU1XrfWUSRmNMF8OZVx3ePcmZSphcnfwLodrh9QUuWvhac1rbt/x1MMQxesB0RN
	 v+fX277tvuqp9PtHIDmuDa7uH+RRhVFsCSZp1dtJjIiMMIjOUBDd8Fp/O+XfsZY/hy
	 1akYjFNuCTWAQ==
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
	linux-perf-users@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v16 03/13] x86/hw_breakpoints: Make DR7 updates NMI safe
Date: Mon, 14 Sep 2026 21:50:11 +0900
Message-ID: <178939021170.94750.17115728735164122117.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178939017565.94750.9431053336761330458.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
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

Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v16:
 - In local_db_save(), remove the hypervisor check so all paths go
   through the sequence retry loop, preventing an intervening NMI from
   bypassing the sequence check on return.
 - In local_db_save(), check cpu_dr7_seq before clearing hardware DR7
   and load from shadow cpu_dr7 on sequence retry to prevent
   destructively clobbering hardware DR7 state installed by an NMI.
 - In local_db_restore(), restore from shadow cpu_dr7 whenever
   cpu_dr7_seq changed instead of evaluating dr7 ? cpu_dr7 : 0,
   ensuring breakpoints installed by an NMI are preserved when dr7
   was initially 0.
Changes in v15:
 - Always preserve DR7_FIXED_1 in arch_install_hw_breakpoint(),
   arch_uninstall_hw_breakpoint(), and hw_breakpoint_restore() to comply
   with the x86 architectural specification.
 - Wrap local_db_save() in a cpu_dr7_seq loop to detect NMI breakpoint
   updates and ensure DR7 is disabled before entry.
 - In local_db_restore(), if dr7 is 0 and an NMI modified breakpoints,
   restore DR7_FIXED_1 to undo the NMI's overwrite and preserve KVM
   guest isolation.
 - Always write "val | DR7_FIXED_1" to hardware DR7 in local_db_restore()
   to ensure architectural compliance.
 - Avoid modifying the saved dr7 argument in-place across retry loops.
Changes in v14:
 - In local_db_restore(), return immediately if saved dr7 is 0 to avoid
   overwriting intentionally cleared hardware DR7 state (e.g. KVM guest
   entry) with cpu_dr7 when an NMI increments cpu_dr7_seq.
Changes in v13:
 - Add compiler barriers (barrier()) before checking cpu_dr7_seq to
   prevent the compiler from hoisting the sequence check before debug
   register updates or shadow state modifications.
Changes in v12:
 - Use stack variables dr7 and dr7_seq directly in exc_nmi() and remove
   unnecessary per-CPU nmi_dr7 and nmi_dr7_seq variables.
---
 arch/x86/include/asm/debugreg.h |   77 ++++++++++++++++++++++--------
 arch/x86/kernel/cpu/mce/core.c  |   10 ++--
 arch/x86/kernel/hw_breakpoint.c |  101 ++++++++++++++++++++-------------------
 arch/x86/kernel/nmi.c           |    7 ++-
 arch/x86/kernel/traps.c         |   10 +++-
 5 files changed, 124 insertions(+), 81 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 50f830972698..ac1607eeefb7 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -19,6 +19,7 @@
 
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
 DECLARE_PER_CPU(bool, cpu_dr_in_guest);
+DECLARE_PER_CPU(unsigned int, cpu_dr7_seq);
 
 #ifndef CONFIG_PARAVIRT_XXL
 /*
@@ -126,45 +127,79 @@ static __always_inline bool hw_breakpoint_active(void)
 
 extern void hw_breakpoint_restore(void);
 
-static __always_inline unsigned long local_db_save(void)
+static __always_inline void local_db_save(unsigned long *dr7,
+					  unsigned int *dr7_seq)
 {
-	unsigned long dr7;
+	bool retrying = false;
 
-	if (this_cpu_read(cpu_dr_in_guest))
-		return 0;
+	if (this_cpu_read(cpu_dr_in_guest)) {
+		*dr7 = 0;
+		*dr7_seq = 0;
+		return;
+	}
 
-	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
-		return 0;
+	do {
+		/* Inner loop: get DR7 with checking cpu_dr7_seq. */
+		*dr7_seq = this_cpu_read(cpu_dr7_seq);
 
-	get_debugreg(dr7, 7);
+		if (unlikely(retrying)) {
+			*dr7 = this_cpu_read(cpu_dr7);
+		} else {
+			get_debugreg(*dr7, 7);
 
-	/* Architecturally set bit */
-	dr7 &= ~DR7_FIXED_1;
-	if (dr7)
-		set_debugreg(DR7_FIXED_1, 7);
+			/* Architecturally set bit */
+			*dr7 &= ~DR7_FIXED_1;
+		}
 
-	/*
-	 * Ensure the compiler doesn't lower the above statements into
-	 * the critical section; disabling breakpoints late would not
-	 * be good.
-	 */
-	barrier();
+		barrier();
+		if (unlikely(*dr7_seq != this_cpu_read(cpu_dr7_seq))) {
+			retrying = true;
+			continue;
+		}
 
-	return dr7;
+		/* Outer loop: clear DR7 and retry if sequence number is updated. */
+		if (*dr7)
+			set_debugreg(DR7_FIXED_1, 7);
+
+		/*
+		 * Ensure the compiler doesn't lower the above statements into
+		 * the critical section; disabling breakpoints late would not
+		 * be good.
+		 */
+		barrier();
+		retrying = true;
+	} while (unlikely(*dr7_seq != this_cpu_read(cpu_dr7_seq)));
 }
 
-static __always_inline void local_db_restore(unsigned long dr7)
+static __always_inline void local_db_restore(unsigned long dr7,
+					     unsigned int dr7_seq)
 {
+	unsigned long val;
+	unsigned int seq;
+
 	/*
 	 * Ensure the compiler doesn't raise this statement into
 	 * the critical section; enabling breakpoints early would
 	 * not be good.
 	 */
 	barrier();
+
 	if (this_cpu_read(cpu_dr_in_guest))
 		return;
-	if (dr7)
-		set_debugreg(dr7, 7);
+
+	do {
+		seq = this_cpu_read(cpu_dr7_seq);
+		if (seq == dr7_seq) {
+			if (!dr7)
+				return;
+			val = dr7;
+		} else {
+			val = this_cpu_read(cpu_dr7);
+		}
+
+		set_debugreg(val | DR7_FIXED_1, 7);
+		barrier();
+	} while (unlikely(seq != this_cpu_read(cpu_dr7_seq)));
 }
 
 #ifdef CONFIG_CPU_SUP_AMD
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 39f238952e14..b3669d6f88d4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2109,8 +2109,9 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
 	irqentry_state_t irq_state;
 	unsigned long dr7;
+	unsigned int dr7_seq;
 
-	dr7 = local_db_save();
+	local_db_save(&dr7, &dr7_seq);
 
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -2127,18 +2128,19 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 
 	irqentry_nmi_exit(regs, irq_state);
 out:
-	local_db_restore(dr7);
+	local_db_restore(dr7, dr7_seq);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
 	unsigned long dr7;
+	unsigned int dr7_seq;
 
 	irqentry_enter_from_user_mode(regs);
 
-	dr7 = local_db_save();
+	local_db_save(&dr7, &dr7_seq);
 	do_machine_check(regs);
-	local_db_restore(dr7);
+	local_db_restore(dr7, dr7_seq);
 
 	irqentry_exit_to_user_mode(regs);
 }
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 68de7ed79d88..866bbbb8918d 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -43,6 +43,9 @@ EXPORT_PER_CPU_SYMBOL(cpu_dr7);
 DEFINE_PER_CPU(bool, cpu_dr_in_guest);
 EXPORT_PER_CPU_SYMBOL_GPL(cpu_dr_in_guest);
 
+/* Sequence number of the per-CPU DR7 state. */
+DEFINE_PER_CPU(unsigned int, cpu_dr7_seq);
+
 /* Per cpu debug address registers values */
 static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
 
@@ -100,7 +103,7 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
 int arch_install_hw_breakpoint(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
+	unsigned int seq;
 	int i;
 
 	lockdep_assert_irqs_disabled();
@@ -109,32 +112,25 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 		return -EBUSY;
 
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
+		set_debugreg(this_cpu_read(cpu_dr7) | DR7_FIXED_1, 7);
+		barrier();
+	} while (seq != this_cpu_read(cpu_dr7_seq));
 
 	return 0;
 }
@@ -152,36 +148,34 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
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
+		set_debugreg(dr7 | DR7_FIXED_1, 7);
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
@@ -315,10 +309,7 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
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
@@ -326,6 +317,10 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 				(unsigned long)&per_cpu(cpu_dr_in_guest, cpu),
 				sizeof(cpu_dr_in_guest)))
 			return true;
+		if (within_area(addr, end,
+				(unsigned long)&per_cpu(cpu_dr7_seq, cpu),
+				sizeof(cpu_dr7_seq)))
+			return true;
 	}
 
 	return false;
@@ -493,12 +488,18 @@ void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
 
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
+		set_debugreg(this_cpu_read(cpu_dr7) | DR7_FIXED_1, 7);
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

