Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE437A845
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068586; cv=none; b=CKdKZraHEfDzyK3gW0oGWAPhUc436JUgynqmqftpfJsFzJZR4IHSnIYedNcy74tgrUeZh+6FVcWNSaNcQTsM2IPy5Bn4b9fmAhgP3jHjy9CBjrGQwbjLFeAbCI0q/z3NwhqeI7ZSQc/PL9bH3+hn9e1HWcrcglfUitsff7ecnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068586; c=relaxed/simple;
	bh=ZZFt29IE3883O0eR5o3Md7/GdZ+oxgKlmt3B2rD7ROA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIqlqFUzCcGd59Z4OpB7QZtB50JfLKbDO/YvTEopV1DVYDqIGTjK1lA7ceF1xwsIQfQAop6bNvQvygXxp1ayQRce85JgmAE6XBTopMDGj0iusZGDkH4mVWuK+mmL+2H6ynYvJmsWpmlNMCyvjT8cH7hGsEMzwadvi8uuWU6jUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHtjXdna; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHtjXdna"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6aae36ea5c4so986935eaf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785068583; x=1785673383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EevIvMuJNH40ZtgktJ190FILDXzowHUG1QR1Hxbsxss=;
        b=GHtjXdnaqR+hpQAU2t9ooAkWp8jiFFMbchqMNhCZVdlNirOELfOLzzZndcIWcrpmB+
         R2DgwliyZEuOauSaZ3Ny67CUXwa67BJGz6dENAAS5QrTXBPoaGjyaTRsCeBtGSj5f2cm
         DBB4GmjvmDJuhIlLPNo020kWDkd+NinvnYO+bEcwBMEONpEOAxzdN9zOJrwJ7UB7p4zc
         3SFsHYT+TZbSnv0oE26K3tt+09FeKuqQWswxTSXW3KkfAOLBQMvRiiGhMMenvSDK6awc
         HWchdFCdVlO5BxzChvcBlpDlE9uwRc7jARUMywU/uwChdWfL2trC/LMDRPj5Zb4P2n4J
         lFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785068583; x=1785673383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EevIvMuJNH40ZtgktJ190FILDXzowHUG1QR1Hxbsxss=;
        b=GisX3hEiQNAaur7Nr/xsTXFrLo3yc9csONTYj7yUpggg2mPjwhgTiSULiJOqpAKhfS
         LbwKsqQSnm18LZTn6bUbwTjgSznxrurAnN0StiXuhBYdBdmMhdmC0P0TpwnXC93NiREw
         Ij809ajy5Tq+BR2Clc/FAM5nOgQN2TDI91QVAAC8/b30hDctAo7Ev9PEAZWVfYFvvjPe
         zgQ0jZFWDD8G6ItXC79z70qgMlimJJklILwTAXtXjzui4kte3t8FpZ695osRtYqlN+QZ
         cIVEI0m42ejqt//fBfA+leKIGnqDMuW7lITJYwJHW+c13zUTFzFJZ2nrqtoGKpJLFYN0
         BnMA==
X-Forwarded-Encrypted: i=1; AHgh+RoamlDhPkXH44AzVM0OMxqya0FPPCZUcLEKZqJAyk1yDq/OX5WX93Kj8jwcufKE373/geSNF+HJiaE+gJ3yElyR@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMh4dq34qejqwGUneDBg2Bn4RyBiIUICPF7FnRuY7lQxeqotp
	QAofjUcZsT6WisXzEgDNUYTIWcs6YxUuskYX76ET6y67U7lyai5cIM/g
X-Gm-Gg: AR+sD10UzBhP/qg5sm4EFyssHRMipzQcadM3SNJL09hPDBIP+p7HNWl5559ga/LFgHI
	R3uD8UMyFPt1vvi/GDBk2MO+2Qf8nXWFLGoNnpxXWXk6xs9yNAO/yK/Zy1nudEzFfsNza/soSiS
	gfge4oHqpfcwfyjtZAzNdFZuAuA67P+17QLorYsv8cwabhVe8R1Ut4gfuz2qeQAzCBAayk7O7zh
	KyICaepBjbm4FDDL6oiUquB53ETrl8UvHWJvlG2DozpxxTzVMzve6fkuf2y6s2WP9HmFY2OEdlV
	YNdPCicTN4pazp6BRScaUBcF1gueQPIPDTxoe5Fs8KyiSHUrskxsZwrTuJnIiGCiBf797NQL1m8
	LQ+f3Yc2S4INAGr/6IL0VvanoK7eXYXxn3jEWuwUI0hHzP+fFeJ06aazYw9vEGtVRr5XLnKmNez
	x6hrtTFWvMgJ/Z
X-Received: by 2002:a05:6820:290f:b0:6a1:7fa0:1151 with SMTP id 006d021491bc7-6aaffa71504mr3925185eaf.66.1785068582701;
        Sun, 26 Jul 2026 05:23:02 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766e66674sm11145377fac.3.2026.07.26.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 05:23:02 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 1/3] x86/hw_breakpoints: Make DR7 updates NMI safe
Date: Sun, 26 Jul 2026 20:22:30 +0800
Message-ID: <4ee0a2efc9e8387af83286b8495b7d490247e165.1785067572.git.wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785067572.git.wangjinchao600@gmail.com>
References: <178476143000.26117.9810509272687580410.stgit@devnote2> <cover.1785067572.git.wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware breakpoint installation and removal run with IRQs disabled, but
an NMI can still enter the same code through KGDB. The interrupted
operation and the NMI can consequently claim the same slot or overwrite
each other's DR7 state.

Claim and release per-CPU slots with cmpxchg. Update cpu_dr7 with
single-instruction per-CPU operations, and preserve hardware-first
disable and hardware-last enable ordering. Add a per-CPU sequence number
so interrupted DR7 writers and restore paths detect an NMI update and
retry from the latest shadow state.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/debugreg.h | 36 ++++++++----
 arch/x86/kernel/cpu/mce/core.c  | 20 ++++---
 arch/x86/kernel/hw_breakpoint.c | 98 ++++++++++++++++-----------------
 arch/x86/kernel/nmi.c           | 10 +++-
 arch/x86/kernel/traps.c         | 10 +++-
 5 files changed, 101 insertions(+), 73 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index a2c1f2d24b64..b1fe1c47978d 100644
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
@@ -145,20 +148,33 @@ static __always_inline unsigned long local_db_save(void)
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
+	} while (unlikely(seq != this_cpu_read(cpu_dr7_seq)));
 }
 
 #ifdef CONFIG_CPU_SUP_AMD
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9bba1e2f03af..8dba9cd04bfa 100644
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
index f846c15f21ca..9ef24b55737f 100644
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
 
@@ -97,38 +100,30 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
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
+	} while (seq != this_cpu_read(cpu_dr7_seq));
 
 	return 0;
 }
@@ -146,36 +141,33 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
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
+	} while (seq != this_cpu_read(cpu_dr7_seq));
+
+	WARN_ONCE(this_cpu_cmpxchg(bp_per_reg[i], bp, NULL) != bp,
+		  "Can't release breakpoint slot");
 }
 
 static int arch_bp_generic_len(int x86_len)
@@ -309,13 +301,14 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
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
@@ -483,12 +476,17 @@ void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
 
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
+	} while (seq != this_cpu_read(cpu_dr7_seq));
 }
 EXPORT_SYMBOL_FOR_KVM(hw_breakpoint_restore);
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 3c9f60d6ca5a..f55a0cbd5927 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -532,10 +532,13 @@ enum nmi_states {
 static DEFINE_PER_CPU(enum nmi_states, nmi_state);
 static DEFINE_PER_CPU(unsigned long, nmi_cr2);
 static DEFINE_PER_CPU(unsigned long, nmi_dr7);
+static DEFINE_PER_CPU(unsigned int, nmi_dr7_seq);
 
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
 	irqentry_state_t irq_state;
+	unsigned long dr7;
+	unsigned int dr7_seq;
 	struct nmi_stats *nsp = this_cpu_ptr(&nmi_stats);
 
 	/*
@@ -572,7 +575,9 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	 */
 	sev_es_ist_enter(regs);
 
-	this_cpu_write(nmi_dr7, local_db_save());
+	local_db_save(&dr7, &dr7_seq);
+	this_cpu_write(nmi_dr7, dr7);
+	this_cpu_write(nmi_dr7_seq, dr7_seq);
 
 	irq_state = irqentry_nmi_enter(regs);
 
@@ -594,7 +599,8 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	irqentry_nmi_exit(regs, irq_state);
 
-	local_db_restore(this_cpu_read(nmi_dr7));
+	local_db_restore(this_cpu_read(nmi_dr7),
+			 this_cpu_read(nmi_dr7_seq));
 
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
-- 
2.53.0

