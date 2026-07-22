Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D158437845;
	Wed, 22 Jul 2026 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761427; cv=none; b=Hb5CVENEiXbQDPTtdkPyt+WCmX6qLaM3DE4ZDs6UAmvPLr6ttBSZM5IShI58EmtHZP4K1T0sZEAbkX2SxjTq//fPqw5XhXS3vh5CFXgV4otFw1bSFVarOSNqvM6qphpeK1lsqcwFXN/mfzNrHAZHFdpljOvAvKywhYA7GC24Aj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761427; c=relaxed/simple;
	bh=/T5lEK8DJeQPkBZw1CJanRPUc6l9C5N4tGXaiQE6buc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrijkKQ531FlIQIXRxdKy8FQmtxtAfZgAser4N8u/lSbQy5cUE5RCdMl8D/8mNbXPV5LTRkfnZ0tdZupwrdnSGfqCC5J7jWblOvYesns7bc/l2xlpdYtL3SYexrbomuEIrGUHCFlIuzukFyCBV8fT0qRkE/KYvdGGoamIH9clvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEFhzjrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEFhzjrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D721F000E9;
	Wed, 22 Jul 2026 23:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761424;
	bh=rk2umw+DZv1nSqIyLtphMjlVQouL5ewpaGHrx+pr8O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dEFhzjrm/6udIKN0LLyCaw6dF4aHkaSYbwGTuu8+JdfAv5giYyUPYWpBft26L82lE
	 w3eywYLIHzhGnPEigEcgMXoG1UyNPNbGr+VY0HHNFic4beKmD5rldL20H5DLwJcQiB
	 sKHXtD7bJKSq1Wa29MAGzWrsubleOsz2Cc2jZpSbRhYP3jDJR8NJrVKcFbKmHF/N77
	 w340Pw8kjWosvmyBZQDrrKSKYFyayuxfI5N8aqsUjDrp0O+jEvijOyjRkZOSGk6Nfi
	 3R01vTYFvEExHQvfxCWp1epM5LEjbtnvDhiJYmVN78UwsK/gTFjj1D4goKg1nPmBgS
	 Q2GPeaWtgpBEQ==
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
Subject: [PATCH v10 06/11] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Thu, 23 Jul 2026 08:03:38 +0900
Message-ID: <178476141832.26117.3201454711538502687.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178476134787.26117.10094977293012760490.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
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

The new arch_reinstall_hw_breakpoint() function can be used in an
atomic context, unlike the more expensive free and re-allocation path.
This allows callers to efficiently re-establish an existing breakpoint.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v9:
  - Update commit message.
  - Temporarily disable the active slot in setup_hwbp() before updating
    the address register to avoid spurious debug exceptions.
---
 arch/x86/include/asm/hw_breakpoint.h |    2 ++
 arch/x86/kernel/hw_breakpoint.c      |   34 ++++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index aa6adac6c3a2..c22cc4e87fc5 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -21,6 +21,7 @@ struct arch_hw_breakpoint {
 
 enum bp_slot_action {
 	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_REINSTALL,
 	BP_SLOT_ACTION_UNINSTALL,
 };
 
@@ -65,6 +66,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index c323c2aab2af..0df3ff556f47 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -100,6 +100,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 		old_bp = NULL;
 		new_bp = bp;
 		break;
+	case BP_SLOT_ACTION_REINSTALL:
+		old_bp = bp;
+		new_bp = bp;
+		break;
 	case BP_SLOT_ACTION_UNINSTALL:
 		old_bp = bp;
 		new_bp = NULL;
@@ -129,23 +133,36 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
 {
 	unsigned long dr7;
-
-	set_debugreg(info->address, slot);
-	__this_cpu_write(cpu_debugreg[slot], info->address);
+	bool enabled;
 
 	dr7 = this_cpu_read(cpu_dr7);
+	enabled = dr7 & ((DR_LOCAL_ENABLE | DR_GLOBAL_ENABLE) << (slot * DR_ENABLE_SIZE));
 	dr7 &= ~(__encode_dr7(slot, 0xc, 0x3) |
 		 (DR_LOCAL_ENABLE << (slot * DR_ENABLE_SIZE)));
-	if (enable)
-		dr7 |= encode_dr7(slot, info->len, info->type);
+
+	/*
+	 * If the slot is currently enabled, disable it first before updating
+	 * the address register to prevent spurious debug exceptions.
+	 */
+	if (enable && enabled) {
+		barrier();
+		set_debugreg(dr7, 7);
+		barrier();
+		this_cpu_write(cpu_dr7, dr7);
+	}
+
+	set_debugreg(info->address, slot);
+	__this_cpu_write(cpu_debugreg[slot], info->address);
 
 	/*
 	 * Enabling:
 	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
 	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
 	 */
-	if (enable)
+	if (enable) {
+		dr7 |= encode_dr7(slot, info->len, info->type);
 		this_cpu_write(cpu_dr7, dr7);
+	}
 
 	barrier();
 
@@ -189,6 +206,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
 }
 
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
+}
+
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);

