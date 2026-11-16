Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806770;
	b=f0UKYleQj5CsXvAGdK6gLFdJhJIT1/6d+8I5NCLCySl5YC3k1sJLIwTOthhJ2PbmqQfo
	 E5SPR2s9/npWPOFZh5J+QN+FjNEuapc2Z5rmEOGoLvVLqu0oWximZK1dDUaXoNdmMY4s4
	 V392GDfxNWpFW3f8uIsOEl6Js1Fz6n0XhEe3qijHKqrLM2svfSxLtlUUrjO5/id6RiRb6
	 cSDHKecEO8iU4320Xn/nUC0V6k+WIsZ10alO08AyhLfWSI6CldBO+pM4Ik4jiRvCGbzrX
	 RYRr6ZZbuwXnIuypy5GEGXSoNh6FxlcrhwP4W+NHRIPBHLHE4VbuUD1nKOuN3g5+dIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806770;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JXQ50En4WCwtWMvCMnnERx70BUlJEQpKgvy04B4rdYI=;
	b=dSL99Q+WFwWax8XSEBKifxTPq/vNlR/zfAtT68Jb8OGKC5oiFM8f/9ixmV0wsrSdVNGx
	 19UMR48H849zeRAzhDsJQXSLXpwoyGN1rZTNLDJUAYi6ALpWqlM+V4k6ozfIR8F3MADm2
	 T3HflfgygxiViMMsV36MXtRnt/78egmSx3PGcfxTUDfVgKXVEh5ru4WrIfkpRCwcQU1zF
	 LB7yOv8DPKYae4Jhi1guWkOpsUXItNrTgH+ApL+JVSU7f+2Lwh/EAIvVPtjxWa8XJ9zk8
	 JIh+uK7NzbTM4snslMsx/j2zsQ7iEsGmAEqh8OCO88RY0xtgIhDi4zVeES/Q1ECWevQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5Qrosnl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE3606A323;
	Mon, 16 Nov 2026 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5Qrosnl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5A41F000C4;
	Mon, 16 Nov 2026 05:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794806770;
	bh=JXQ50En4WCwtWMvCMnnERx70BUlJEQpKgvy04B4rdYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5QrosnlzvK+wEIsEVeUhU3Oe6LSSMEGTzR7ljJ9j1e9zHlH3KmfodwoTKnESwhQo
	 45/CBLvo3mH+91VysJjFovvJiPWtP2//KO1UhhmahdJH9XAEbED/p02FVQN9YPcKEd
	 gAmG+iGi99O4zIeuJUI5vSlINgo8K1GOJ0iQ6h4vkrchTIU9MKtCG1NewLIYxVarA1
	 RB80cXBJoDxXHoOzINcTPcNvg5OwJTr5HR1u+ZQ8X1Xtx663OOhnkJvUJ+E+L5wvLH
	 6aGzmtUGf+Cw+8pIFHFYiYd/0wzi4fDGf3GwvOAtItJdSWEMdssrShQkiuEXmnMn6Y
	 0DDgcxStmUIHg==
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
Subject: [PATCH v20 01/11] x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
Date: Mon, 16 Nov 2026 14:26:04 +0900
Message-ID: <179480676405.38065.17662254533654266956.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179480675130.38065.3086970856119381693.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
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

