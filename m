Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394B49CF45;
	Mon, 14 Sep 2026 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390234; cv=none; b=gw1FZBfCEnMNCLzdAPgfcK/LKOns2vuXP/1FPa8b5iiOK0Hjx27GTyNN/ZHdfEhuLAd3/uvCrC3fB26zJsKrkkCchHRMPcnFxTE4Mtom6bDazISVJb8/OwTTxS4omib+nc14lUmKJA0mxtzA8wlF2aNgomuCeA91obCr+Qvbdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390234; c=relaxed/simple;
	bh=PYl9tcxM6Cdu8hGPpv2Egs41pWacXKoL2X28FmuNlZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiOrImYveWqNlAliTegxGWOP36WZpoTPE6rwHFNn55e2cD1/3OcwmuA8RLKbfw+0+2Oemn9srF7OzlJx81Kd7WQ58NXLfGZxz6OxxTJ0v8sm+GNqes69BEKm+MzrlLkjYumMCbtvAbAnf6T1Rk2URBPgN+mRwnA7N9N5da0S+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+mdlLmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+mdlLmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE59E1F0089B;
	Mon, 14 Sep 2026 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390230;
	bh=qNK7HWtEwf7yYtEI+BW5sYT6RpN5ifh+1rzahdwRim4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i+mdlLmtunjzGffH0pIm4ljNJcZczRmG9ygNjA5aWYlknuQuYzvt0gmX+HGnEZptQ
	 yJ3D+mCRLWWhwpeRdnLKJ4hVcNC6TzBzDNpEpSktv8XCEwSOBjhPOxp+5duz4nXzod
	 I37kDpDZGkgsyTzig4+va3ZIoCGnMlHbV2iVEwiJ3hQq6oLqZ6+o67+saHyrvdtfrn
	 JjI0ei5irh2Lzp1FuBqM9gqTa1Ap3tWNM6vcz+TZveJ+BjilSvXJX1mL35tS7zXuT1
	 x5jA5oZ2X1utAz2hWNuRfvIi81kigGM4kUAEQ4bGBd7lMQiIJL+iRX96NozVkSAAnF
	 sACWfvh4MaDJQ==
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
Subject: [PATCH v16 04/13] x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
Date: Mon, 14 Sep 2026 21:50:23 +0900
Message-ID: <178939022358.94750.10843461787759740658.stgit@devnote2>
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

Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v16:
 - Clear breakpoint in shadow cpu_dr7 before setting hardware DR7 so
   an intervening NMI cannot re-enable the breakpoint via
   local_db_restore() while the address register is being updated,
   preventing spurious #DB exceptions.
 - Check cpu_dr_in_guest and return -EBUSY to reject modifying local
   breakpoints while executing a KVM guest.
Changes in v15:
 - Temporarily clear the breakpoint enable bit in DR7 before updating the
   debug address register, and re-enable it afterward, to comply with the
   x86 hardware specification and avoid spurious #DB exceptions.
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
 arch/x86/include/asm/hw_breakpoint.h |    2 +
 arch/x86/kernel/hw_breakpoint.c      |   61 ++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

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
index 866bbbb8918d..37896902da5c 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -135,6 +135,67 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
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
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct arch_hw_breakpoint hw;
+	struct perf_event_attr attr = bp->attr;
+	unsigned int seq;
+	int i, ret;
+
+	lockdep_assert_irqs_disabled();
+
+	if (this_cpu_read(cpu_dr_in_guest))
+		return -EBUSY;
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
+
+		/* Disable breakpoint in shadow DR7 and hardware DR7 */
+		this_cpu_and(cpu_dr7, ~__encode_dr7(i, info->len, info->type));
+		barrier();
+		set_debugreg(this_cpu_read(cpu_dr7) | DR7_FIXED_1, 7);
+		barrier();
+
+		this_cpu_write(cpu_debugreg[i], addr);
+		barrier();
+		set_debugreg(addr, i);
+		barrier();
+
+		/* Re-enable breakpoint in shadow DR7 and hardware DR7 */
+		this_cpu_or(cpu_dr7, encode_dr7(i, info->len, info->type));
+		barrier();
+		set_debugreg(this_cpu_read(cpu_dr7) | DR7_FIXED_1, 7);
+		barrier();
+	} while (seq != this_cpu_read(cpu_dr7_seq));
+
+	return 0;
+}
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *

