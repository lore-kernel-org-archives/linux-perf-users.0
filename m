Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9493FC5AB
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293391; cv=none; b=TsbFlkxPcMDXnbm4jDXBUcJeNNRxEvjpR3frLMu89BptLwm0pHxaqm5/UH1Qf2m5bE5Bv7rkPuGT+NQyazXKrAIoMww7DOYK0AN1d47yHCEaXgJQa9YtCS289j6Ksrduotz72sEMW6qZa+qwQFKP6AB4cA9YtJULd3cd5sCwIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293391; c=relaxed/simple;
	bh=McJvpjFtHEtr6No4XI/yr1DXNKrvDdPTiwn+hIU5wl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJcMh8HOAVshveDkmhrMdh25UYpqEwcyd2zkPAMW4nHst6z1LQvq/K18LoCcldBuCpYFVLbQIFHoI/f5vRjgK/SNSuxyYIUx7cZFPHO7CghLAk/iMagWeM+zNxC6HuUtRgrZUzp3N5JQBRSKsKGlUUeuuT69awHEVkJ5Qk6COT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSC/ksbv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSC/ksbv"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e041ea211so5403863a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293389; x=1784898189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4gbLfd0R20qfhPC42TsD6whBibdrC59ZB/Kgr873YXk=;
        b=WSC/ksbvHku704vyMHWjcIfIVjUhKDmkKXrSJI9qL/MUYArt116JWMfYJWLKtCBhZ6
         oVRChodDrO3+ZPv7nPX6j1rbRey/qFCUQJG8YUqfmOs8Kmwn8o+dwIvlhyazoIY5bAPC
         cZjc4VwL+A6ZS40bWj4L9nxzVcH0h9RQXUgD13SMW4/+T88+jVKPyHzeXVIzu5agk2xI
         v9YIaVZLXeghlphyLFw3ncpY8Xi1fvY3uM+UYMuOxIaSLhPLtaIzArz+QNa8WCEfQXNv
         uKzezAJZFQwBLxmeJcyiwNiX/Z9wMDm+BKl4JRbQ40HFWnCJulSyOcmMbWESmi1xDk2F
         rWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293389; x=1784898189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4gbLfd0R20qfhPC42TsD6whBibdrC59ZB/Kgr873YXk=;
        b=Nrhw+9z5me4sCzVMNRJh2o4MtqeEw5mxstfw80NjbxU/sY4N3fNDnRZQs4SG9W/LGz
         nGXcieccj5fVbIDayMNTo9dbvffM014KqDGNB4XXn8xDb1Dmk64U9n642xBBCUSu9nVY
         y7o98P1ag/7G9t8NVopbzM8EMIBTFzxKcYPsEGP9Z/4ZGUMY0Wuk9QwEbg+crx3azgxV
         cWV3GQx71lr7/FNHbBbKxUsfgv9DpU8JnmLlbzcikjm4Gk1DSPEDWzK9yQZ0dn7Gb8qg
         wpx/kH+VsSAZWLFEFFfSA9fLnFpt3LlK42o/S+Hc7VoSVrp7NHnjn8CIrDpiNDxNdk+U
         myIA==
X-Forwarded-Encrypted: i=1; AHgh+RphccJ1+15vnyFQosvXDH+N9sfbpIJf+TZNPd6NXwL8HBag8l/IJtt2l0JdXfO+unrk/Wtm+US1pRgX/xMa6ehM@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWnVUQ7tC81Du0O6mw1z90lbl7XQ5T+L12w5d/qeW9uQhlpMQ
	YF/xwGxI/o2HL00WkvxmwBluvuohV/UhgFtH8zJ5uyfaq0N6Iuva0SCh
X-Gm-Gg: AfdE7ckPSDvg3E1ZiGLxPNlD+rEIwB1yUOZYiLWpeSezQPbc+GzEFnDzEuUBt4nhew2
	9hRAijgGM0KanN5WgbER946EJR/NGKyqoWnZMzLSW02RGsHp4BHL+XgQycTmHBO0nnLY9IJshyM
	zwW1kJU+ZZGMASSTYsPkijcoRL0oGJ+4881K/114Vx0ySEDm/uEUeqRc6ieRSxiNKm25CiHlWJ9
	YnvF9rk8EevDUXfwMGawvjHoBs8qiiQz4hb0WOQ4xMdD6/9DAIdG7kUNIWr1IMSgxeotyVwKvBQ
	mzT+9WJ9ixC+RbYcVhDIO8KxmASVWuD/ikvG4cCA8WFoh323Ux8Vd/yroWrrN2ugKMdZZZ4E8K4
	K8onwC6uNVkU3PFe5VHUlNfeU2ufSG15V92jD1bJiCFBUFA9bhiLQGVrs0KUFjPDthm/Da6zszI
	G6bQ==
X-Received: by 2002:a17:90b:1c81:b0:387:e0bb:57f1 with SMTP id 98e67ed59e1d1-38e4b56bd45mr2610926a91.34.1784293388471;
        Fri, 17 Jul 2026 06:03:08 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429ff04absm6773202eec.8.2026.07.17.06.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:03:07 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH v2 02/13] x86/hw_breakpoint: Unify breakpoint install/uninstall
Date: Fri, 17 Jul 2026 09:02:51 -0400
Message-ID: <20260717130251.1901695-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate breakpoint management to reduce code duplication.
The diffstat was misleading, so the stripped code size is compared instead.
After refactoring, it is reduced from 11976 bytes to 11448 bytes on my
x86_64 system built with clang.

This also makes it easier to introduce arch_reinstall_hw_breakpoint().

In addition, including linux/types.h to fix a missing build dependency.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/include/asm/hw_breakpoint.h |   6 ++
 arch/x86/kernel/hw_breakpoint.c      | 153 ++++++++++++++++-----------
 2 files changed, 95 insertions(+), 64 deletions(-)

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
index f846c15f21ca..76886467708b 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -49,7 +49,6 @@ static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
  */
 static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
 
-
 static inline unsigned long
 __encode_dr7(int drnum, unsigned int len, unsigned int type)
 {
@@ -86,96 +85,122 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
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
+	if (enable)
+		dr7 |= encode_dr7(slot, info->len, info->type);
+	else
+		dr7 &= ~__encode_dr7(slot, info->len, info->type);
 
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
 
-	return 0;
+	/*
+	 * Always push the address mask, even when clearing it (info->mask == 0):
+	 * a REINSTALL from a masked range breakpoint to an exact one must drop
+	 * the stale mask, or the CPU keeps matching the wider range.
+	 * amd_set_dr_addr_mask() is a no-op without X86_FEATURE_BPEXT and skips
+	 * redundant MSR writes, so the unconditional call is cheap.
+	 */
+	amd_set_dr_addr_mask(enable ? info->mask : 0, slot);
+
+	/*
+	 * Disabling:
+	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
+	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 *   The barrier keeps the compiler from reordering the two: native
+	 *   set_debugreg() has no memory clobber of its own.
+	 */
+	if (!enable) {
+		barrier();
+		this_cpu_write(cpu_dr7, dr7);
+	}
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
-
-	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
-		return;
+	slot = manage_bp_slot(bp, action);
+	if (slot < 0)
+		return slot;
 
-	dr7 = this_cpu_read(cpu_dr7);
-	dr7 &= ~__encode_dr7(i, info->len, info->type);
+	info = counter_arch_bp(bp);
+	setup_hwbp(info, slot, action != BP_SLOT_ACTION_UNINSTALL);
 
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
-- 
2.53.0

