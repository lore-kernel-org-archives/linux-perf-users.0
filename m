Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017E345722;
	Mon,  1 Sep 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737902; cv=none; b=kaeiCNCYoECa1r+jdUDdzSakGP2VYIKtb5OOshwK7sQ6SrOLLLnsAi4mbEt1og5IfJhmCfDHKgs/qEyMEoAF5fEQ92FfZlZRbWPFWEiaCGKZtryfHmHfTODZVADIrbEUNvtml5LwT1xmDCH5YRfqyyk3kxo+lFCvTdegtXP49mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737902; c=relaxed/simple;
	bh=u2SnMniYqIdTGMz3VmsvHD4YSv0VfLGBYGvO+y0pNYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRQAkumYMpA9zIh3K0VwHczMDesjskYn6cYC/OcUyxOK4iFI8RZDP84B3sKGxgM78p8AWTosEmKLooSqXvrhfvWE40fejihxIDgTF5UkbWfl7u9XDpKpisxNXxMDZ8PFWWX6xehe/eqAYD0q+4CmPWh/OgCvAP5abP6A2a94sY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIDu+KgS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIDu+KgS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62879C4CEF0;
	Mon,  1 Sep 2025 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737902;
	bh=u2SnMniYqIdTGMz3VmsvHD4YSv0VfLGBYGvO+y0pNYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIDu+KgSO3TM89vViYmPuGZMKp90ymDtpGDR4ijZRzgIUVE28FnJ1oUPDPUZfSZOg
	 KTgm92Uc9Xlhxwti8hGBlkNxVr+RbpylysmofS80544xp5u5slkMDdGzcg+R2Z9Szm
	 jN/UEdO7RQRnzc6QVbTWyDiCI1DYgm8YlxzO/9Yxqci1+DS0paK60NtR5kjkd5JXEC
	 BN1ka4ntIEWUSYrJGXUcIrLqeKRDWz7A6yTdHNSreLThDm/Pc/lwGBfNVf0jn1vbX+
	 4LS7K9JUvmbNFn0cLhNbH0N0gxD8BAs1jJE7hVHR/m8RGw5ZpsjgxkKAnN8MJuEPyP
	 jAcBSb1Sr2IDg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [RFC PATCH 2/6] x86/HWBP: introduce arch_reinstall_hw_breakpoint() for atomic context
Date: Mon,  1 Sep 2025 23:44:56 +0900
Message-ID: <175673789661.478080.5655284926337640078.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175673787502.478080.3342912952394010967.stgit@devnote2>
References: <175673787502.478080.3342912952394010967.stgit@devnote2>
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

Introduce arch_reinstall_hw_breakpoint() to update hardware breakpoint
parameters (address, length, type) without freeing and reallocating the
debug register slot.

This allows atomic updates in contexts where memory allocation is not
permitted, such as kprobe handlers.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h |    1 +
 arch/x86/kernel/hw_breakpoint.c      |   50 ++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..bb7c70ad22fe 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index b01644c949b2..89135229ed21 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return 0;
 }
 
+/*
+ * Reinstall a hardware breakpoint on the current CPU.
+ *
+ * This function is used to re-establish a perf counter hardware breakpoint.
+ * It finds the debug address register slot previously allocated for the
+ * breakpoint and re-enables it by writing the address to the debug register
+ * and setting the corresponding bits in the debug control register (DR7).
+ *
+ * It is expected that the breakpoint's event context lock is already held
+ * and interrupts are disabled, ensuring atomicity and safety from other
+ * event handlers.
+ */
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	unsigned long *dr7;
+	int i;
+
+	lockdep_assert_irqs_disabled();
+
+	for (i = 0; i < HBP_NUM; i++) {
+		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+
+		if (*slot == bp)
+			break;
+	}
+
+	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
+		return -EINVAL;
+
+	set_debugreg(info->address, i);
+	__this_cpu_write(cpu_debugreg[i], info->address);
+
+	dr7 = this_cpu_ptr(&cpu_dr7);
+	*dr7 |= encode_dr7(i, info->len, info->type);
+
+	/*
+	 * Ensure we first write cpu_dr7 before we set the DR7 register.
+	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	barrier();
+
+	set_debugreg(*dr7, 7);
+	if (info->mask)
+		amd_set_dr_addr_mask(info->mask, i);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *

