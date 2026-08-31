Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9651E433;
	Mon, 31 Aug 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188834; cv=none; b=fDU3erfALt1WIDfZ2UqW4fnYbhgvqH7KIP3VgAb/s/JJFlidy50+YLoizLVdJ2v8/1XQLN7amzscX6Q8UW/BvOUfWu343g1ZrUE5JV4HbTkdmIxggzcsvbPUBSh8AcLu7gl8aJUt1YcrRRLopsojxrh33yJcJ06XuBKcbsLWj1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188834; c=relaxed/simple;
	bh=ZMeODOalDT3eg3nc2re+bSKlJQA5rmy71TfgPv/2jag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzp0qzqFCZv3IabLmSkSDDqCW7shri+n19nb4tG668BEFs4e8ZS3FzJp0Omlmcv6f7sc81ehG1C/lyXPWN/NiDzW1lP/QbmVdgtrUv5kyJ/uKoJbx0wTrqX8wL5dsQIQVmMMez/2DE7NFXNQftZLcUPIULx3ueW61wwO/hM4ZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id A7A0563F89;
	Mon, 31 Aug 2026 17:07:08 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 1199816227F; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC v1 08/19] ptwrite uprobes / x86: Add a user fault notifier chain
Date: Mon, 31 Aug 2026 08:04:44 -0700
Message-ID: <20260831150651.1134594-9-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831150651.1134594-1-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ptwrite uprobes need to catch faults in the user probes, otherwise a
bad probe could crash the program. For classic probes that is handled in
the kernel, but with these new kinds of probes the crash happens in ring 3
code.

The existing die chain cannot be used for this because it only handles
kernel level faults. Add a new user fault notifier chain that is supported
for #GP, #PF, #SS. It is only called before a signal would be delivered, so
it doesn't slow down any hot paths. The fault handler can then handle the
fault and prevent the signal.

Add register code and the hooks for the chain.

Some of the existing fault hardware workarounds could be converted to this
in the future (not done yet)

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/x86/include/asm/traps.h | 17 +++++++++++++++++
 arch/x86/kernel/traps.c      | 32 ++++++++++++++++++++++++++++++++
 arch/x86/mm/fault.c          |  6 ++++++
 3 files changed, 55 insertions(+)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 3f24cc472ce9..c3cdfde3c7b0 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -4,6 +4,7 @@
 
 #include <linux/context_tracking_state.h>
 #include <linux/kprobes.h>
+#include <linux/notifier.h>
 
 #include <asm/debugreg.h>
 #include <asm/idtentry.h>
@@ -59,4 +60,20 @@ static inline void cond_local_irq_disable(struct pt_regs *regs)
 		local_irq_disable();
 }
 
+/*
+ * User-mode fault notifier chain, called before a user exception is
+ * about to become a signal. NOTIFY_STOP consumes the fault.
+ */
+struct x86_user_fault_args {
+	struct pt_regs	*regs;
+	unsigned long	error_code;
+	unsigned long	address;	/* #PF: faulting address */
+	unsigned int	trap;
+};
+
+extern int register_x86_user_fault_notifier(struct notifier_block *nb);
+extern void unregister_x86_user_fault_notifier(struct notifier_block *nb);
+extern int notify_x86_user_fault(struct pt_regs *regs, unsigned long error_code,
+				 unsigned long address, unsigned int trap);
+
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 30aa8369957e..5259a205b837 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -517,6 +517,11 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
 
 DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
 {
+	if (user_mode(regs) &&
+	    notify_x86_user_fault(regs, error_code, 0, X86_TRAP_SS) ==
+			NOTIFY_STOP)
+		return;
+
 	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
 		      0, NULL);
 }
@@ -911,6 +916,30 @@ static void gp_user_force_sig_segv(struct pt_regs *regs, int trapnr,
 	force_sig(SIGSEGV);
 }
 
+static ATOMIC_NOTIFIER_HEAD(x86_user_fault_chain);
+
+int register_x86_user_fault_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&x86_user_fault_chain, nb);
+}
+void unregister_x86_user_fault_notifier(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&x86_user_fault_chain, nb);
+}
+
+int notify_x86_user_fault(struct pt_regs *regs, unsigned long error_code,
+			  unsigned long address, unsigned int trap)
+{
+	struct x86_user_fault_args args = {
+		.regs = regs,
+		.error_code = error_code,
+		.address = address,
+		.trap = trap,
+	};
+
+	return atomic_notifier_call_chain(&x86_user_fault_chain, 0, &args);
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
@@ -942,6 +971,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (emulate_vsyscall_gp(regs))
 			goto exit;
 
+		if (notify_x86_user_fault(regs, error_code, 0, X86_TRAP_GP) == NOTIFY_STOP)
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index aa88370ce739..897165f960b8 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -821,6 +821,9 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
 		return;
 
+	if (notify_x86_user_fault(regs, error_code, address, X86_TRAP_PF) == NOTIFY_STOP)
+		return;
+
 	if (likely(show_unhandled_signals))
 		show_signal_msg(regs, error_code, address, tsk);
 
@@ -950,6 +953,9 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 		return;
 	}
 #endif
+	if (notify_x86_user_fault(regs, error_code, address, X86_TRAP_PF) == NOTIFY_STOP)
+		return;
+
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
 
-- 
2.54.0

