Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807FA37F8B3;
	Sun,  2 Aug 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658735; cv=none; b=LDRSvk+VeBtsMB8r+XPfqEyxrRZL2fJ8tYSv6/iKnyOsUb7YxqaKrmr8WA65IHAuwH2hLfm4ABpzrZKClYDV2jlpHLqA9/l8v4ZIyv2ebiUbAK70WsUZdErtFhUcHzU3F4pUpCOZ5UYWtazdTr7+ummYAvEdP00Pih/qmtXWryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658735; c=relaxed/simple;
	bh=jdVNS7I1bb509M6k14U2tNrt1dP7h6wl7s1Q4QVj4YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mg9xfmsMwnl5f8LeqEVqIKv8xPyiaq741FfkPZWgqbKbjnbryghiYqFoNtAavxvPrItemF/ORYv7DKr/pKOJPZ1dkMWDgPAoMLRnyUXLOg6mXiKt/TP8K3OQ5SWovir+gMmZJVH/pzSp8qxC4s280hc0eXLLBDo3j149UBMzsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPX9MXGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPX9MXGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A416B1F00AC4;
	Sun,  2 Aug 2026 08:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785658734;
	bh=ZzhdsFUmY1PAP7mnpYfjuHIRqOYywJnS409/fS0ZObw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OPX9MXGWUnEh5pQuixvCIT20YCSGYG9Yx2pE9SDhKGUL2PHF//bCcAr3+UfZPhw2Y
	 v7xu5hg+bcbD1rOofWCGlYJj76PD9Lf81YhkYE17l39NBmQZNnAibf1eVkkZbrnxmN
	 LfiJghPtkmdlhVSdh4AOPvJ7CGuoQnrISxGFUc48QrGFRfs9BZkwNjBYZEUCkjEK4h
	 EIkzS0pQL8p2ebbqdxn7cp5ivSvUyHVFCKuyrZ+W060Ro9EpPO2cbkrRAy79pifpgM
	 NAEDjGyMkPgF1OIPMziTL71hkV+sFW7rxLpYzVXzugsZrmRGuR55htWzbDuP99LRp4
	 u/AIRN6fVsc4w==
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
Subject: [PATCH v11 02/11] x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
Date: Sun,  2 Aug 2026 17:18:48 +0900
Message-ID: <178565872848.714490.5743606430062347908.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178565870538.714490.11309825813968306287.stgit@devnote2>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
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

Add arch_modify_local_hw_breakpoint_addr() to find the installed local
slot and update only its address shadow and hardware debug address
register. Publish the shadow first so hw_breakpoint_restore() observes
the new address if an NMI interrupts the update.

The caller must provide an installed local event and a valid address.
Slot ownership, breakpoint type, length, mask and DR7 remain unchanged.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v11:
 - Return int error code instead of void.
 - Validate the new address using hw_breakpoint_arch_parse() before
   updating registers.
 - Increment cpu_dr7_seq in a sequence loop for NMI protection.
 - Return -ENOENT if the breakpoint slot is not found on the local CPU.
---
 arch/x86/include/asm/hw_breakpoint.h |    2 ++
 arch/x86/kernel/hw_breakpoint.c      |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

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
index 9ef24b55737f..c89f6e71c3a9 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -128,6 +128,39 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return 0;
 }
 
+int arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
+					  unsigned long addr)
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
+	} while (seq != this_cpu_read(cpu_dr7_seq));
+
+	return 0;
+}
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *

