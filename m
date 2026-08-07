Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394A397958;
	Fri,  7 Aug 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116827; cv=none; b=k39ZlcZ3wI3K3IZUzp4f7sdg4iO7Go7oBbvecwLJKAlgRhdEZBohJGpMIwaejLxr9UipaN2JeuDeQKAAoYe8PWHdujtoll0HamRVygaT0Y3i/uL5LdQmu5Fb/4f2hp+dP3q7nNK4Ew5loCf4MFif7U4Dfft4TwpmIuD3Z8pH1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116827; c=relaxed/simple;
	bh=jdVNS7I1bb509M6k14U2tNrt1dP7h6wl7s1Q4QVj4YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjmnxeD3HS+u72VyGbU7sXDlBrV6E+vpldVxHDOwnZ6P8/Ow0xDksurqy/BQOVGTvsURqqKf/GKxuhEYj4QXy8WsiB0sl0rqt4bnEEt+oJ9dBMh9eMj/I/xK6neGrYke+CswVjJjFpf4e0lET1bpITwApSqkeT+2hix7yC6wZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBhlb2eu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBhlb2eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705A91F00A3A;
	Fri,  7 Aug 2026 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116825;
	bh=ZzhdsFUmY1PAP7mnpYfjuHIRqOYywJnS409/fS0ZObw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CBhlb2eu8tXGXLqnoyccoPu99JwpsPxATfsHrGYbRSYM0vV0KHJl56ytXNnQlGHS0
	 zj9uogI1C1Ut+Y3meuWLrdGqmJIsAufg6GlHYEwegwLLAKdMyk+i16UZm+kgAeiRDk
	 XqmJRyE/jCwBrEMV2b7xubRfMPcmloznwQqOAOQa0BLuiSsHag88yKO/Qq+N6aR0yr
	 2OJKzpbh3bX7/w7nfSX2eLp7oaHkXlJRhoyFsu1O87Cy/EIg2iFRChpLmVLf1hsST6
	 wu3PLHO/CjSIsD7oQCrLxECf235GQiFRx1fGL/kdGOraKUNWyozAuOArlRsemV+zgt
	 DdrqMrLJ2HW6w==
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
Subject: [PATCH v12 02/11] x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
Date: Sat,  8 Aug 2026 00:33:40 +0900
Message-ID: <178611682030.237811.16459191503595231339.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178611679753.237811.10190793347982785419.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
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

