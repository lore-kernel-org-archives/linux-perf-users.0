Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F9D23EAB4;
	Tue, 22 Sep 2026 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051139; cv=none; b=c62IGmeACx1VQw4LtJrNbMkNpyMAPnf7I4cRG/2kntw3WxN35C3jW0mAD63AMB8ehUJ2K7jLtCFE7kKf1kpcjrdhEBPHeq9sIbVomHn/B/yvVPxX4A3uuMngoEGT2RUQedeAQVp5yEW6pVpWkn5UuNT0cRBakDO8PktD4gPiNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051139; c=relaxed/simple;
	bh=FP1ZO8k6dm2mq9IXVy0kJFnWXyVvZf0o1cKIp7XICdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spViM5nuy/2V7sk7TAV27BPv6g8x94Oep+aCKsww/W7mTj2upsJc0nN/8/KRyow7E2I+Ce29Azc2AUkPnVWePI7I9AO1F3sfVaqqTh3uywdFresxDlKwxeci5T2xILcUuZdSAuUDErpD5WBBhZqTtuDCmXZWjIkKEBlgcCFrhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXrdoqC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXrdoqC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE731F000FF;
	Tue, 22 Sep 2026 04:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051137;
	bh=fqbG6vas082OHQpmqS/hQzgdwEej8KUz2Ruuf0Wo7c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OXrdoqC0MMT7oPXXdRi1yokdI4tdtcqALoC9SjolHKWBXe9P4EP3/vx0H4QydEca6
	 sJ8bAwnPBt4upWW6uENAGnGOEHOL6aFM8IbeA7e7Q5tPQzqJbegf2Sc0u1XSFjY1Ri
	 poigNhCS67wOYJT9N6NQ68unoWLON6aawvUdrU05ZqNOsnuW1OzUSoKE5eqSESW628
	 vhdMAtAlp9s3oUiu8Iq61M2BKSvr9rqTMwtguEhg3bCWU2l9Xnesl7E0lSbQd6EYTZ
	 aESgCzsl2v0Co1fFTZhSgYlYtLKz9qjk1KFhULqMcNVPnXuVNm+nAW1Lo2agKuDtqE
	 HYSsHq8+305Zw==
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
Subject: [PATCH v17 04/13] x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
Date: Tue, 22 Sep 2026 13:25:31 +0900
Message-ID: <179005113108.388919.2257490475086393913.stgit@devnote2>
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
Changes in v17:
 - In arch_modify_local_hw_breakpoint_addr(), check perf_guest_in_guest()
   instead of cpu_dr_in_guest.
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
index 901323ae7d6a..b413adc2bbbf 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -131,6 +131,67 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
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
+	if (perf_guest_in_guest())
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

