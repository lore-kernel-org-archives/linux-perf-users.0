Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C331ED83;
	Sat, 22 Aug 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390581; cv=none; b=TDuXeAPkkf+xdYV7c488HOFH4i3aLI8WvrAmu6Ip68T5AI0GcAIKmX2wdKOkD7oYAzAOnRn1wGptqpOZXxVI5Pi1IcRdM5ruMbBYc83wMyX6i0G1gsNjYqckzg6jueLEnh+sr1zuj8DJYWSNYEjOtyi7zNNkKHPJXofd/2WGpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390581; c=relaxed/simple;
	bh=JaTR38Pf+wJocHC2jzs3lJ/Kxag7X9MH1lmO2DreohU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPHONHZPWtWKenb8zBoQjfZ1KQmfdhvYzoO8OCRhgVyFqxyw98a7aCqshotK0ZcHt6HLHtzAefWyo08Ec3Z0gBDKWkblvcMOf4CIBwYOAFldplQltjPWyCF+PdZXiW4O8cDP2ZybIa1Gilu5i+u0vN2PuRw7jzFWPLCw7nBqY4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV5+GG7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV5+GG7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB931F000E9;
	Sat, 22 Aug 2026 09:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787390579;
	bh=Z3Exe3Ypa2BFK9A+bKQrvhT6r2k5lqXMXqvUAaYQ/NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nV5+GG7ugFrUzUBmpCj9btnY96oSYssEXb/ILa6EEDHfJ+kUJUwJsCwsV4pzYE1Rd
	 tCngo0DrIT1T+u4wzurpJb52eITjSXQ8UXc6vuagsOA9E+Ezf65cC25Rwkj+by4odT
	 HHOn2Qde8FiJ8AR6xp/LcQBWZLRy908nhcsKy1rjFHFg117gNSv0LHhA2dIvC6dF7C
	 6RFe9IAobSTPGPUGaOzhBquo1wxnAF7+fxfUg381Owl2twIe2bjDgsacUkousSLYYx
	 QZ6gHOSTtGVDlV+z77ekuwQhAXKZFtaTAiLWsyoi5HP2X1lS6e1fNwJ+BgGKASzBwD
	 pXQXQdL26ltVQ==
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
Subject: [PATCH v13 03/12] x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
Date: Sat, 22 Aug 2026 18:22:53 +0900
Message-ID: <178739057338.1520941.9166530552338317000.stgit@devnote2>
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

Wprobe needs to move an active per-CPU watchpoint without releasing and
reserving its hardware slot.

Add arch_modify_local_hw_breakpoint_addr() as the architecture backend for
modify_local_hw_breakpoint_addr(). It validates the new address, finds the
installed local slot, and updates the hardware debug register and per-CPU
shadow register. The core layer (modify_local_hw_breakpoint_addr()) handles
updating bp->attr.bp_addr and counter_arch_bp(bp)->address.

The caller must provide an installed local event and a valid address.
Slot ownership, breakpoint type, length, mask and DR7 remain unchanged.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v13:
 - Add compiler barrier (barrier()) before checking cpu_dr7_seq to
   prevent hoisting the sequence check before set_debugreg().
 - Clarify in commit log and code comment that the core layer manages
   updating bp->attr.bp_addr and counter_arch_bp(bp)->address.
Changes in v11:
 - Return int error code instead of void.
 - Validate the new address using hw_breakpoint_arch_parse() before
   updating registers.
 - Increment cpu_dr7_seq in a sequence loop for NMI protection.
 - Return -ENOENT if the breakpoint slot is not found on the local CPU.
---
 arch/x86/include/asm/hw_breakpoint.h |    2 ++
 arch/x86/kernel/hw_breakpoint.c      |   44 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..f35ec491f6dd 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -59,6 +59,8 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
+					 unsigned long addr);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 3204e75dc454..2227918b0163 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -129,6 +129,50 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return 0;
 }
 
+/*
+ * Modify the address of an installed perf counter breakpoint on local CPU.
+ *
+ * This updates the debug address register and per-CPU shadow state without
+ * changing slot allocation or DR7. The core layer (modify_local_hw_breakpoint_addr())
+ * manages updating bp->attr.bp_addr and counter_arch_bp(bp)->address.
+ *
+ * Atomic: called with IRQs disabled and handles variables and registers
+ * local to this CPU.
+ */
+int arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
+					 unsigned long addr)
+{
+	struct arch_hw_breakpoint hw;
+	struct perf_event_attr attr = bp->attr;
+	unsigned int seq;
+	int i, ret;
+
+	lockdep_assert_irqs_disabled();
+
+	attr.bp_addr = addr;
+	ret = hw_breakpoint_arch_parse(bp, &attr, &hw);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < HBP_NUM; i++) {
+		if (this_cpu_read(bp_per_reg[i]) == bp)
+			break;
+	}
+
+	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
+		return -ENOENT;
+
+	do {
+		seq = this_cpu_inc_return(cpu_dr7_seq);
+		this_cpu_write(cpu_debugreg[i], addr);
+		barrier();
+		set_debugreg(addr, i);
+		barrier();
+	} while (seq != this_cpu_read(cpu_dr7_seq));
+
+	return 0;
+}
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *

