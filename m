Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44278345EAC;
	Mon,  7 Sep 2026 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788752819; cv=none; b=ZW6I0Va3haEN7Deu+HNYXi3lT7kHZPv1m8UhAUWPZmOoEyyHUarPXvnJGpGz4MwMi54fDHJy0iEtpUkb5NYFthp9BPuSHK/BzxtvVD/DbiREiOTvUcfCxa5KdWle++QnWqX2GbHPdqlNDsaKwO66mMk1nSPn8NGi2qas+U07H/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788752819; c=relaxed/simple;
	bh=N0ZreQGclss/XlCp36inxsdcAfEl7QDQRsoQ/lmAo5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL2hPTS8ypID68jQsKn+ByhZN0OxoLBMPOO7tpT2PBgVFM5RYUJyaA8AYEElw1fC0mDQhetR4lcQm9C/GOkc/an0b0xG6uUjla+IJsMG13Cu3mXmXgHT9Z3K3PqHbskEReTOP6H1qMfUtVRoq2fKOYrjUMP2pCAEtJ7wjRoU7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFYCpI2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFYCpI2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EB01F00A3A;
	Mon,  7 Sep 2026 03:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788752818;
	bh=dntm4Dmaxt6c0we5Lair/2EK77dGj1VLD5czr613kwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PFYCpI2HXe9bQyxDbarRNynnun5ILuG/lpKi2dePIlRg/n2C1i+F4nwA4R8wnNn1i
	 VOONOt+EdlA2GHnEvdaO1Ohln3Tt583MYWNxo4mnsYAJlRK6aWFzkpnU4cj41lnkje
	 kUuKcgv+XXt0LVKm1pDAD89a1MJq3uRHNv/jrbPTXii7G72UbKPBON3B7Ot3HjkyIv
	 sVhTf/b8gxhGoWdSNARXUq+64/w3ZAovgTuhDTDcOv0gJnzQfFv/aMuq6IhyEO5+lb
	 5w0VxoG8BHQKq3k9iTNzwYfpy48LDaoHgSWxJWKM5lFeNj9pj8uFk874evw3Laczgx
	 jEgyRkiBGD7eA==
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
Subject: [PATCH v15 03/12] x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
Date: Mon,  7 Sep 2026 12:46:52 +0900
Message-ID: <178875281237.93794.4844650709915505895.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178875277830.93794.14247844688761142429.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
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
 arch/x86/kernel/hw_breakpoint.c      |   56 ++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

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
index 312550be3ad2..99f0926298a8 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -129,6 +129,62 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
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
+
+		/* Disable breakpoint in DR7 before updating address register */
+		dr7 = this_cpu_read(cpu_dr7);
+		set_debugreg((dr7 & ~__encode_dr7(i, info->len, info->type)) | DR7_FIXED_1, 7);
+		barrier();
+
+		this_cpu_write(cpu_debugreg[i], addr);
+		barrier();
+		set_debugreg(addr, i);
+		barrier();
+
+		/* Re-enable breakpoint in DR7 */
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

