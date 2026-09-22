Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27A3B19BA;
	Tue, 22 Sep 2026 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051115; cv=none; b=TT6bR866dEPx2SoxhvLYuQY10d30TTplSQe/KyX6l+HUNjtnGbwB8em/34/ipocMDMLq3si+j4Lz7A2L9Ei20K7DAgPAUEJFii5nyINVuFxzwnHKeaxlkAI81FUolMHCooZtqz/qOfbw46L7LHSrRHJp6JdXd9sxaNx2X1GEHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051115; c=relaxed/simple;
	bh=ea9qxXx9kg89UWY0dCkt4q7OHjwdGM8gcXLohsiMyBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDos36bG5QlQ/i+8xoPyGCp28Ccujzu0yCqs1c28MyelxmoO65oEbe6KjpeP1Y7oEVmOR60D8x5188c0iJnujv8+0oHoXz1oQT2V9RWTx6AZGa6nCjw6XeXovXHLU/0szkP3pVKrbygYqCRhaeyLs5RAsRsjMfCdHAAtl4I2sag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkV2NN5i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkV2NN5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4251F000FF;
	Tue, 22 Sep 2026 04:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051114;
	bh=dsQx+QviCP8DSIGNuzmfZuXg5PLuR8qG1Ne4KObCFng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TkV2NN5ivtgtiw5IZBPl4swOC1Jc4gMRkcQZEuBmjd5PK+DdEnRdfudQi8DPMzj52
	 YfE2eScGGtJMD/z580IaumAmyBR0ElA1BxkALJ8k95F1GW+Vw5V0mZblJWdPQzcddA
	 3iUVkGy7klIoLWslBgUC228Vuhny6P/Tj0E+7ULgOb2/yHJQYOWpg8j33cArW12qIb
	 FYnrHml9SwXjWGo7+eS8hnsy3WUd3fvi/Ua/KRaIsOZh0u3RKjehqkY7HKCIdw1IfN
	 uudUKELd46HHwn4VTthZiJ3tNVvDo6SEOcu/ifEQDwcxBnSA0yXwhwT7RWfjN6oS+1
	 8K4IRudzRPTUA==
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
Subject: [PATCH v17 02/13] perf/x86, KVM: Prevent host debug register leak into guest OS on NMI
Date: Tue, 22 Sep 2026 13:25:07 +0900
Message-ID: <179005110742.388919.1509641807739909065.stgit@devnote2>
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

When KVM enters a guest OS, host hardware breakpoints are disabled
before running the guest. However, an NMI can occur while executing
in guest mode or during guest transition, where
arch_install_hw_breakpoint() can be invoked from NMI context.

If arch_install_hw_breakpoint() is executed while the CPU is in guest
mode or during the VM entry transition window, hardware debug registers
can be modified with host breakpoint settings, leaking host breakpoints
into the guest OS or clobbering the guest's debug registers.

To prevent this without introducing ad-hoc per-CPU flags, introduce an
.in_guest callback to struct perf_guest_info_callbacks and an inline
helper perf_guest_in_guest(). In KVM, implement .in_guest by checking
whether the current vCPU is in IN_GUEST_MODE or EXITING_GUEST_MODE.
In arch_install_hw_breakpoint(), check perf_guest_in_guest() and return
-EBUSY if the CPU is running or transitioning to/from a guest.

Fixes: f85d40160691 ("KVM: X86: Disable hardware breakpoints unconditionally before kvm_x86->run()")
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v17:
 - Drop changes to local_db_save() and local_db_restore().
 - Drop cpu_dr_in_guest per-CPU flag.
 - Introduce .in_guest callback in perf_guest_info_callbacks and
   perf_guest_in_guest() helper to query vcpu->mode.
   (avoid breaking perf_guest_state() users)
 - In arch_install_hw_breakpoint(), check perf_guest_in_guest()
Changes in v16:
 - Newly added.
---
 arch/x86/kernel/hw_breakpoint.c |    3 +++
 include/linux/perf_event.h      |    9 ++++++++-
 kernel/events/core.c            |    5 +++++
 virt/kvm/kvm_main.c             |   12 ++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index f846c15f21ca..0473a5c95856 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -102,6 +102,9 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 
 	lockdep_assert_irqs_disabled();
 
+	if (perf_guest_in_guest())
+		return -EBUSY;
+
 	for (i = 0; i < HBP_NUM; i++) {
 		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5842552294c1..194e69270460 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1677,8 +1677,8 @@ struct perf_guest_info_callbacks {
 	unsigned int			(*state)(void);
 	unsigned long			(*get_ip)(void);
 	unsigned int			(*handle_intel_pt_intr)(void);
-
 	void				(*handle_mediated_pmi)(void);
+	bool				(*in_guest)(void);
 };
 
 #ifdef CONFIG_GUEST_PERF_EVENTS
@@ -1689,6 +1689,7 @@ DECLARE_STATIC_CALL(__perf_guest_state, *perf_guest_cbs->state);
 DECLARE_STATIC_CALL(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
 DECLARE_STATIC_CALL(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
 DECLARE_STATIC_CALL(__perf_guest_handle_mediated_pmi, *perf_guest_cbs->handle_mediated_pmi);
+DECLARE_STATIC_CALL(__perf_guest_in_guest, *perf_guest_cbs->in_guest);
 
 static inline unsigned int perf_guest_state(void)
 {
@@ -1710,6 +1711,11 @@ static inline void perf_guest_handle_mediated_pmi(void)
 	static_call(__perf_guest_handle_mediated_pmi)();
 }
 
+static inline bool perf_guest_in_guest(void)
+{
+	return static_call(__perf_guest_in_guest)();
+}
+
 extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
 extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
 
@@ -1718,6 +1724,7 @@ extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callback
 static inline unsigned int perf_guest_state(void)		 { return 0; }
 static inline unsigned long perf_guest_get_ip(void)		 { return 0; }
 static inline unsigned int perf_guest_handle_intel_pt_intr(void) { return 0; }
+static inline bool perf_guest_in_guest(void)			 { return false; }
 
 #endif /* !CONFIG_GUEST_PERF_EVENTS */
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a3110..c5dead7c5f71 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7749,6 +7749,7 @@ DEFINE_STATIC_CALL_RET0(__perf_guest_state, *perf_guest_cbs->state);
 DEFINE_STATIC_CALL_RET0(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
 DEFINE_STATIC_CALL_RET0(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
 DEFINE_STATIC_CALL_RET0(__perf_guest_handle_mediated_pmi, *perf_guest_cbs->handle_mediated_pmi);
+DEFINE_STATIC_CALL_RET0(__perf_guest_in_guest, *perf_guest_cbs->in_guest);
 
 void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
@@ -7767,6 +7768,9 @@ void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 	if (cbs->handle_mediated_pmi)
 		static_call_update(__perf_guest_handle_mediated_pmi,
 				   cbs->handle_mediated_pmi);
+
+	if (cbs->in_guest)
+		static_call_update(__perf_guest_in_guest, cbs->in_guest);
 }
 EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
 
@@ -7780,6 +7784,7 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 	static_call_update(__perf_guest_get_ip, (void *)&__static_call_return0);
 	static_call_update(__perf_guest_handle_intel_pt_intr, (void *)&__static_call_return0);
 	static_call_update(__perf_guest_handle_mediated_pmi, (void *)&__static_call_return0);
+	static_call_update(__perf_guest_in_guest, (void *)&__static_call_return0);
 	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..7779d500fe77 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6476,11 +6476,23 @@ static unsigned long kvm_guest_get_ip(void)
 	return kvm_arch_vcpu_get_ip(vcpu);
 }
 
+static bool kvm_guest_in_guest(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	if (!vcpu)
+		return false;
+
+	return READ_ONCE(vcpu->mode) == IN_GUEST_MODE ||
+	       READ_ONCE(vcpu->mode) == EXITING_GUEST_MODE;
+}
+
 static struct perf_guest_info_callbacks kvm_guest_cbs = {
 	.state			= kvm_guest_state,
 	.get_ip			= kvm_guest_get_ip,
 	.handle_intel_pt_intr	= NULL,
 	.handle_mediated_pmi	= NULL,
+	.in_guest		= kvm_guest_in_guest,
 };
 
 void __kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void),

