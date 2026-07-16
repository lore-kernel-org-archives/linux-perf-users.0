Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F52AE8D;
	Thu, 16 Jul 2026 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170397; cv=none; b=d+6UI5DniCrFUjG0DeHVz0Z0uANquanaExwtbFoifQ2X2xOQaF+r9Txt2y3+sO4h825wzWRQTis4NW73VPpnueVV3Gfv4XjfhZ+JTnWubsMnxmUfZGJToJG9PbrQApFG0IPmPShPflbIRK5kaWMIeoRr6NucWqbOPJzp7MHcdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170397; c=relaxed/simple;
	bh=7Lui3c5VHc1beQVFUe6rLhhjmRvSzPZNoHLyDBa33xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTAeb+QqPABMELhqiCthkYHGxDOVDdRcRT4lf02YvzxAZiDVuY8ZKiywOD+vcf0xYMkWsETNbny+eBFYWniFQnc6mFjsuHGDTjhX+2gRjtJeI2he0riI8d+VQnwZYElfbjRq5tRCI2J4Zm6fkApN9aMcSDxzOVKtQzb6c67CIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5unNI1f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5unNI1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5C31F000E9;
	Thu, 16 Jul 2026 02:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170395;
	bh=dY7pLs1Bo/vMQ6i+d/kMZaytc+61ZrDx/sPx/QUmJCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e5unNI1fgnGg+xNbJllNxwWsuKupAMqZmdL7VhMvCg6FwfdFnTkphOB8qJM+HUm4p
	 Nx29trH9g5BUwXVKItitwlhr6/iFwQ22rJqJr8r8kRj5ei6pLsgLULb5S5semEKXyW
	 ubjavZB6VFEK36KECYVRwWX1/qp6B3sOVZqABPB0oeu5XZjWFoethp8fUlyI9T20gw
	 Y6EBefwwzG2mi0zGUL7utph9jyRgBihT9iFcjsYEiOgAmVDUv3urRl8FSPFZnm/6jX
	 PkHlx6BQmZM6Bj9wHs4wtMfaXysCrksKbLzVZJ4Ag3Pk/CKGE2v1tZ7O3BLAsHiGn1
	 MMI61UZM7jU3w==
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
Subject: [PATCH v8 5/9] x86/hw_breakpoint: Unify breakpoint install/uninstall
Date: Thu, 16 Jul 2026 11:53:09 +0900
Message-ID: <178417038908.209165.8682948217723063037.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178417033089.209165.16717079876036408877.stgit@devnote2>
References: <178417033089.209165.16717079876036408877.stgit@devnote2>
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

Consolidate breakpoint management to reduce code duplication.
The diffstat was misleading, so the stripped code size is compared instead.
After refactoring, it is reduced from 11976 bytes to 11448 bytes on my
x86_64 system built with clang.

This also makes it easier to introduce arch_reinstall_hw_breakpoint().

In addition, including linux/types.h to fix a missing build dependency.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v8:
  - Add missing barrier() on the disable path of setup_hwbp() to prevent
    the compiler from reordering this_cpu_write(cpu_dr7, ...) before
    set_debugreg(dr7, 7).
  - Clear existing slot control and enable bits in cpu_dr7 inside
    setup_hwbp() using __encode_dr7() before setting new ones to prevent
    register state corruption on update/reinstall.
---
 arch/x86/include/asm/hw_breakpoint.h |    6 +
 arch/x86/kernel/hw_breakpoint.c      |  144 +++++++++++++++++++---------------
 2 files changed, 86 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..aa6adac6c3a2 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -5,6 +5,7 @@
 #include <uapi/asm/hw_breakpoint.h>
 
 #define	__ARCH_HW_BREAKPOINT_H
+#include <linux/types.h>
 
 /*
  * The name should probably be something dealt in
@@ -18,6 +19,11 @@ struct arch_hw_breakpoint {
 	u8		type;
 };
 
+enum bp_slot_action {
+	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_UNINSTALL,
+};
+
 #include <linux/kdebug.h>
 #include <linux/percpu.h>
 #include <linux/list.h>
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index f846c15f21ca..c323c2aab2af 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -49,7 +49,6 @@ static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
  */
 static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
 
-
 static inline unsigned long
 __encode_dr7(int drnum, unsigned int len, unsigned int type)
 {
@@ -86,96 +85,113 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
 }
 
 /*
- * Install a perf counter breakpoint.
- *
- * We seek a free debug address register and use it for this
- * breakpoint. Eventually we enable it in the debug control register.
- *
- * Atomic: we hold the counter->ctx->lock and we only handle variables
- * and registers local to this cpu.
+ * We seek a slot and change it or keep it based on the action.
+ * Returns slot number on success, negative error on failure.
+ * Must be called with IRQs disabled.
  */
-int arch_install_hw_breakpoint(struct perf_event *bp)
+static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
-	int i;
-
-	lockdep_assert_irqs_disabled();
+	struct perf_event *old_bp;
+	struct perf_event *new_bp;
+	int slot;
+
+	switch (action) {
+	case BP_SLOT_ACTION_INSTALL:
+		old_bp = NULL;
+		new_bp = bp;
+		break;
+	case BP_SLOT_ACTION_UNINSTALL:
+		old_bp = bp;
+		new_bp = NULL;
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	for (i = 0; i < HBP_NUM; i++) {
-		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+	for (slot = 0; slot < HBP_NUM; slot++) {
+		struct perf_event **curr = this_cpu_ptr(&bp_per_reg[slot]);
 
-		if (!*slot) {
-			*slot = bp;
-			break;
+		if (*curr == old_bp) {
+			*curr = new_bp;
+			return slot;
 		}
 	}
 
-	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
-		return -EBUSY;
+	if (old_bp) {
+		WARN_ONCE(1, "Can't find matching breakpoint slot");
+		return -EINVAL;
+	}
 
-	set_debugreg(info->address, i);
-	__this_cpu_write(cpu_debugreg[i], info->address);
+	WARN_ONCE(1, "No free breakpoint slots");
+	return -EBUSY;
+}
 
-	dr7 = this_cpu_ptr(&cpu_dr7);
-	*dr7 |= encode_dr7(i, info->len, info->type);
+static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
+{
+	unsigned long dr7;
+
+	set_debugreg(info->address, slot);
+	__this_cpu_write(cpu_debugreg[slot], info->address);
+
+	dr7 = this_cpu_read(cpu_dr7);
+	dr7 &= ~(__encode_dr7(slot, 0xc, 0x3) |
+		 (DR_LOCAL_ENABLE << (slot * DR_ENABLE_SIZE)));
+	if (enable)
+		dr7 |= encode_dr7(slot, info->len, info->type);
 
 	/*
-	 * Ensure we first write cpu_dr7 before we set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 * Enabling:
+	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
+	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
 	 */
+	if (enable)
+		this_cpu_write(cpu_dr7, dr7);
+
 	barrier();
 
-	set_debugreg(*dr7, 7);
-	if (info->mask)
-		amd_set_dr_addr_mask(info->mask, i);
+	set_debugreg(dr7, 7);
+
+	amd_set_dr_addr_mask(enable ? info->mask : 0, slot);
 
-	return 0;
+	barrier();
+
+	/*
+	 * Disabling:
+	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
+	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	if (!enable)
+		this_cpu_write(cpu_dr7, dr7);
 }
 
 /*
- * Uninstall the breakpoint contained in the given counter.
- *
- * First we search the debug address register it uses and then we disable
- * it.
- *
- * Atomic: we hold the counter->ctx->lock and we only handle variables
- * and registers local to this cpu.
+ * find suitable breakpoint slot and set it up based on the action
  */
-void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+static int arch_manage_bp(struct perf_event *bp, enum bp_slot_action action)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long dr7;
-	int i;
+	struct arch_hw_breakpoint *info;
+	int slot;
 
 	lockdep_assert_irqs_disabled();
 
-	for (i = 0; i < HBP_NUM; i++) {
-		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
-
-		if (*slot == bp) {
-			*slot = NULL;
-			break;
-		}
-	}
+	slot = manage_bp_slot(bp, action);
+	if (slot < 0)
+		return slot;
 
-	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
-		return;
+	info = counter_arch_bp(bp);
+	setup_hwbp(info, slot, action != BP_SLOT_ACTION_UNINSTALL);
 
-	dr7 = this_cpu_read(cpu_dr7);
-	dr7 &= ~__encode_dr7(i, info->len, info->type);
-
-	set_debugreg(dr7, 7);
-	if (info->mask)
-		amd_set_dr_addr_mask(0, i);
+	return 0;
+}
 
-	/*
-	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
-	 */
-	barrier();
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
+}
 
-	this_cpu_write(cpu_dr7, dr7);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
 }
 
 static int arch_bp_generic_len(int x86_len)

