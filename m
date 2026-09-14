Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749D468C12;
	Mon, 14 Sep 2026 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390209; cv=none; b=P/CfFwKRGXaIEj+FS2xahgdyuJep9R07/Na1rUudcYyYLfMjE9JOVAE+Cmc+Kb+J38EMXVrxiYFfr1oNNormyw+9cnGLky5JgI/gpLvLX28DYnLpkB8eKqyN2eZJOUZP/zbzkxj2xgT0SUHK8I0+fQR3aInkNuCVJFk2sOsVNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390209; c=relaxed/simple;
	bh=J5+LWQZ2Pw7GZdx7OrTUfZuKENGPDom0WJ29M3Y/A08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgGv7fm/ggQftjF0PwF48OGtMkpyy2xbDPW8rof6HvYfVQoiqCVJzFm+3s1NrovBXNf9R3zZhGk/cyB1XyqdnaHMPXanvGVaq0yP4MQBuyKYZxLXvnKvO+f/ZRYO5xODFVwLCiHnW7UgGFpt6guDJU/9XzfFakXJ4GKq5UCjycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kzv3MTv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kzv3MTv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D411F008A0;
	Mon, 14 Sep 2026 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390206;
	bh=M67P/7heE2Mo2dh13Rp/Xbz4pdwd47nfGB122TYaZO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kzv3MTv9G365yCOp7cZk3m1qFsw9IR5dpIVAnxfe4qVYWb14sEDkTI0ECSuAAWVQm
	 CU61ag/pNTMR0KU5S81okPgXIdzr1bygNHPMmiE47jbqBgQhlngXu4C5C+mQrV2oix
	 BWbfn2onei0y0BqdzrFo9hyQe/gx/L1EECESRD1wYB1mNkWZpAquM0OVmeqevF5d1F
	 OBng9K8VTMPr814/qM5ZM+nLn0rxNk8XXjaGNiajfjhklt24WvW9fPSJ9SD5UwqFCN
	 9sk4ZO1kMNy9EAYZjGMfAzxXOIAN9A4jfJZ+EUkpN7d4FfSdrb6TcrOXIO60uHMxnz
	 7OomvAb31F3Zw==
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
Subject: [PATCH v16 02/13] KVM: x86: Prevent host DR7 debug register leak into guest OS on NMI
Date: Mon, 14 Sep 2026 21:49:59 +0900
Message-ID: <178939019982.94750.4441254006258061798.stgit@devnote2>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

When KVM enters a guest OS, host hardware breakpoints are disabled
before running the guest. However, an NMI can occur during guest
execution, where local_db_save() or arch_install_hw_breakpoint()
can be invoked.

In particular, if local_db_save() or arch_install_hw_breakpoint()
is executed from NMI, hardware DR7 can be modified or restored with
host breakpoint settings, leaking host breakpoints into the guest OS
or clobbering the guest's debug registers.

Introduce a per-CPU flag, cpu_dr_in_guest, to indicate that the CPU
is executing in guest mode. Set this flag in vcpu_enter_guest()
during entering the guest with disabling host breakpoints.
If this flag is set, local_db_save() and local_db_restore() return
immediately, and arch_install_hw_breakpoint() returns an error.
In addition, protect cpu_dr_in_guest in within_cpu_entry() to
prevent recursive #DB exceptions.

Fixes: f85d40160691 ("KVM: X86: Disable hardware breakpoints unconditionally before kvm_x86->run()")
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v16:
 - Newly added.
---
 arch/x86/include/asm/debugreg.h |    6 ++++++
 arch/x86/kernel/hw_breakpoint.c |   10 ++++++++++
 arch/x86/kvm/x86.c              |    7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 854d82b88ff4..50f830972698 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -18,6 +18,7 @@
 #define DR7_FIXED_1	0x00000400
 
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
+DECLARE_PER_CPU(bool, cpu_dr_in_guest);
 
 #ifndef CONFIG_PARAVIRT_XXL
 /*
@@ -129,6 +130,9 @@ static __always_inline unsigned long local_db_save(void)
 {
 	unsigned long dr7;
 
+	if (this_cpu_read(cpu_dr_in_guest))
+		return 0;
+
 	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
 		return 0;
 
@@ -157,6 +161,8 @@ static __always_inline void local_db_restore(unsigned long dr7)
 	 * not be good.
 	 */
 	barrier();
+	if (this_cpu_read(cpu_dr_in_guest))
+		return;
 	if (dr7)
 		set_debugreg(dr7, 7);
 }
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index f846c15f21ca..68de7ed79d88 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -40,6 +40,9 @@
 DEFINE_PER_CPU(unsigned long, cpu_dr7);
 EXPORT_PER_CPU_SYMBOL(cpu_dr7);
 
+DEFINE_PER_CPU(bool, cpu_dr_in_guest);
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_dr_in_guest);
+
 /* Per cpu debug address registers values */
 static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
 
@@ -102,6 +105,9 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 
 	lockdep_assert_irqs_disabled();
 
+	if (this_cpu_read(cpu_dr_in_guest))
+		return -EBUSY;
+
 	for (i = 0; i < HBP_NUM; i++) {
 		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
 
@@ -316,6 +322,10 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 		if (within_area(addr, end, (unsigned long)&per_cpu(cpu_dr7, cpu),
 				sizeof(cpu_dr7)))
 			return true;
+		if (within_area(addr, end,
+				(unsigned long)&per_cpu(cpu_dr_in_guest, cpu),
+				sizeof(cpu_dr_in_guest)))
+			return true;
 	}
 
 	return false;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..5e046924ab76 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8318,6 +8318,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	kvm_load_xfeatures(vcpu, true);
 
+	this_cpu_write(cpu_dr_in_guest, true);
+	barrier();
+
 	if (unlikely(vcpu->arch.switch_db_regs &&
 		     !(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH))) {
 		set_debugreg(DR7_FIXED_1, 7);
@@ -8400,6 +8403,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		kvm_update_dr7(vcpu);
 	}
 
+	barrier();
+	this_cpu_write(cpu_dr_in_guest, false);
+	barrier();
+
 	/*
 	 * If the guest has used debug registers, at least dr7
 	 * will be disabled while returning to the host.

