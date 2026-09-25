Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DED48125E;
	Fri, 25 Sep 2026 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334676; cv=none; b=lT7nneRY+Dg9L1bP95Vd09Q0S1Gr4Zz5Tv8oOtdHoEIFljD3Mdwg95U3aIJy7FeNd4dF7NIBv4sU1sfEpxB/qj/uIoHfRooOzVUOgws+zYGDYApDh2HW08gWiCu7kzQI/yRhuKKVQ2tkgKru3jFMAi7sbYMnziZ+MahFmYLKjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334676; c=relaxed/simple;
	bh=p6yaYR+uK9F2D7mPrHOKHqt57NV1TKVPzRpBTj+TkDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ifu6a9v+Pqp3fxD32BuqbYsuQPHd261N36NAJqeKzUjBGvSVzGbP4RIk6n/c3qYqbpKD2ZCftU/g3iQ9qxRev5R1pSxu39jKoaBSyCQEBEEcUKK5ODDrpJ4qz1x6ifpfpisPBxo50FchQe7oeYo7kI8KPcDbKLUnCUuPj1vGTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px/HI3TS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px/HI3TS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD391F00893;
	Fri, 25 Sep 2026 11:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334674;
	bh=0mQqZMhAzrsoisnEL8pl7I0TBi/ANBYk5yFrQSp1oJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Px/HI3TSxhq+KLTHfQQAz6BPV77F8/DGyBzap7dmqVwITOXqrtWgg1jO0trNqgN3B
	 IaPrG0XNpf4KMtXWo6+xHXSmzXN0bWKfbmQX5ezs+e/WoIl80rnU9l9HAicpVDIrce
	 iWLf70Gs5Rm01a+X0G4NB1rp6Ja70P3jAOZFULYtNnvuzgTIKFOuJHr6wcBe1M0Tav
	 4MjF4LXY3o4tyP0qGIe0q26z72d/3QNvDdy1QrdSThsplyGfR5zkF8ODoYG+aQqmtZ
	 V392bI+FjfL/OQfWdm8kQJYc9tQu3cYoZSVmlYDX1Jc4Dlfnf9qqPu0Gq7eH2rJePC
	 6vx46e8st750w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
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
	x86@kernel.org
Subject: [PATCH v18 01/11] x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
Date: Fri, 25 Sep 2026 20:11:02 +0900
Message-ID: <179033466185.136630.10668757489676082035.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179033464327.136630.864883694296882051.stgit@devnote2>
References: <179033464327.136630.864883694296882051.stgit@devnote2>
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

Assisted-by: LLM
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v18:
 - Drop perf_guest_in_guest() check and cpu_dr7_seq sequence loop
   since wprobe does not support updating DR7 in NMI context.
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
 arch/x86/kernel/hw_breakpoint.c      |   51 ++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

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
index f846c15f21ca..3f63f7899f95 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -133,6 +133,57 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
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
+	unsigned long dr7;
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
+	/*
+	 * Temporarily clear the breakpoint enable bit in DR7 before updating the
+	 * debug address register, and re-enable it afterward, to comply with the
+	 * x86 hardware specification and avoid spurious #DB exceptions.
+	 */
+	dr7 = this_cpu_read(cpu_dr7);
+	set_debugreg(dr7 & ~__encode_dr7(i, info->len, info->type), 7);
+
+	this_cpu_write(cpu_debugreg[i], addr);
+	barrier();
+	set_debugreg(addr, i);
+
+	set_debugreg(dr7, 7);
+
+	return 0;
+}
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *

