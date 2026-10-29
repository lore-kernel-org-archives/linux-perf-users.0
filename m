Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260178;
	b=wPVppIf7J+NIpbyP6NIZK6xYgRQ+3mNze6WuBtp9jSZiSqcS6wD3c7SkL/j2Nd1eWcw5
	 j/UXKnSx/DnriQBKcHu87+v65meQuG3uP6Fr1Obcxfl12QNzgrQkwYLe4uwmFdPat4Gpg
	 +hC84slEZOgRcoMFIfWRx16MGBn+jo5tSnsqifjlvCllJNJe6pbifaBU4B3ion+NU9HVI
	 viakPSjxrFfmQ3IOKMd4D8dATm0k1q2A2v3MSxXyfU3n/4IdQlyT3UtcQdG0XxagIUV2F
	 //O1cGWNUOuNEiz2KUlrTQyOz1IHQLg7yuPcPd2UdrNR4qJx8WLBvOlmEypqEGYOLHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bRtGaCJxjX8ogBtdZOyw7RbTSk766OYJSNOnNnXJBC0=;
	b=MUXwInyzlXAPMallK8+gFP1dyHK18igiVHmW75Zy8Xp4acxrKbtVNt45jBPRaQXNmIUy
	 ntPiXyOJI4lh36dMpZUwVT6TTOtb+1nUMtk9xHzAm53fUo01/tvMXRoZcuZ8PS3PgCPV6
	 258+yPCHRA9amtj9D3ogCYGxwtU93hPX6MkDDwvW9qwrWkHceXKFqU2k/g5TQp5XpX2wd
	 i5FO8jeoTP9gVpjlNsQ75nYNTpAifIse55bEpwX7x917+AHD9uFYDDOs3n8hoE3NN/ANP
	 z6xIpiZZ8o7u6zSk5wGGSFjGIvSzkQ2m1PIsHAcqgP6EVvApoxjtlmu/dnLPZwdR1lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hCd62gD6;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A09606A31D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 07:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A09606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hCd62gD6
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e97ddaf3c4so6580865ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 00:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793260177; x=1793864977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bRtGaCJxjX8ogBtdZOyw7RbTSk766OYJSNOnNnXJBC0=;
        b=hCd62gD6QSa+uSODdP0s2LqLkgY2y68v3jIwenh8BB2qvtnM0wrylQNtjeyls7QyvC
         BvFg0nnBviJq5LI0FBHNLpZauAEj3r5sUoA7Alb+B7BMp97aMM++UPkDiuRlur3cq4Ar
         PmsGz478QYHD7ihSBLC6renq5/OhITutFW/kF4vp5RLFzfxRauudtfgtFDO0HVQu+FUM
         o5nIuy4Boew37ICusmUuMIHv6xNgUUG674YyUNJ+5v/qY7MlFrzvYx4fkAoQ+xIpqkof
         T7i6vbbLshipwQSogedHyMG6ARyS4Yabsuwd9r8/IWcnu/cIMwVqSAJWBLY8atPzYmt8
         dTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793260177; x=1793864977;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bRtGaCJxjX8ogBtdZOyw7RbTSk766OYJSNOnNnXJBC0=;
        b=hQNQKA1/T9QVzOXUNHjI40cYwQzP65eUqbedHlGg+S/B2mIXTjSrX9nRmIec5J2NkL
         bI9vaWhAViv/HpUeZ/ngdAs6OprpaDAaC9M4a5ljxnM8jfvBuhenyVqdS29v524OCqqS
         4TUtSSKA96cuM0lXH9TlVboD3egwQaSq3SzJhtIZwjIsR4QqmGWhpoJh85ZYs5C0frAe
         DfcPOWIQQ/Vt4uCk9FFo5+1W7lcfvXU+kTo6c8dygqMTvXXjf1+Vy19aoRGEZ7gnJjXm
         gKNMf2ZZlisJ8kwnlNqG2ygWN0yIcjjdiGUpgMsuSDluuEnuWLXLydAdELwRPW3t/MNz
         LSkA==
X-Forwarded-Encrypted: i=1; AKwUvBx+MOD+6i0iZY5oF/ArjA1Lop5qP9qOzexehNOYhqNuF8YzbWeh9rzqnl3Bv5ck76aT07FVk+CFremBFiaNPWwl@vger.kernel.org
X-Gm-Message-State: AFq9FYIGj7YhTwdEpdtIP8Oo1FXLidfRFfMqshaHpmkRSrmGYgYcmKC9
	g1c98jEW1IpD0BXs8Ugjp2Dk9dK8TmhMwg+qyfqxVewAK3OYfmNXKOlcJSHmXyv4mA0=
X-Gm-Gg: AYBFou1FjZOxmstUY8CPkrT0hAHRdSyBdUPWvUt0I7mqx6scwiiDkUQNkzIWr3+dds0
	otq4NhebIovGjQoYWloBvQBwaJogeeSPNjEsUdBC+N1W7C6lKa8IbQ/L75KTdhwnVYb9iRegW8Y
	81DS8zkev5+pV4vh+Vfmx0FKpxj3y6OzfoXuL3YIA5wzhhhKD21yqMKgqMQ6Q9b5Xcb5jQmse7q
	dZGiAnEmlyYi6oRADQFu0jOsokrCvOeT0sh8YBbRSLHOFafQskBDyxWR5qg06N5OZtc7dhv0g5c
	iIc0SMjfrurB7txWKvq7sKa2v2kKUEdl3rFoBXsr06/QOv0zHPDFCIyKhe8/zslOe0+ikxCv+sH
	99QThKe3i7VT4Vtqvny43INAjvohOhGiPupG0UvDjZi12HIzi2IcBHmV6+MxKj/90AjZvNQe41E
	d4P48J8ridaFc8A4OLmyOVzZnV7Zq3biM7vqPFwsmMRYtK374jIJogY8ckeFiAWDmKHtYaiqTcb
	brB7JmG5CyMFne6r8dMhZl83AAU+ewvP5HTqQOAqmuoZm3zdSfrNRaTI98uoDs+5PRFzw4Z7aS/
	vrZnF+ygsWThkBORhAHlrow0PL2IBxar3+vqTWdezdg2ls3NrXkXRyFb0dddcCFVwv6MuXcQXYr
	BPYS3nys=
X-Received: by 2002:a17:902:e74f:b0:2e5:6af9:a745 with SMTP id d9443c01a7336-2eb003b63d5mr41189465ad.23.1793260176984;
        Thu, 29 Oct 2026 00:49:36 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bd60desm30598915ad.29.2026.10.29.00.49.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 00:49:36 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	Conor Dooley <conor@kernel.org>,
	Anup Patel <anup.patel@oss.qualcomm.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Atish Patra <atish.patra@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	yuanzhu@bytedance.com,
	yang.yicong@picoheart.com,
	yang.susheng@zte.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v12 02/11] riscv: add support for SBI Supervisor Software Events extension
Date: Thu, 29 Oct 2026 15:48:44 +0800
Message-ID: <20261029074853.35467-3-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Clément Léger <cleger@rivosinc.com>

The SBI SSE extension allows firmware to notify supervisor software of
events that must be delivered independently of normal S-mode interrupts.
Firmware saves the minimal state required to enter the supervisor handler,
and Linux builds the synthetic handler context around it.

SSE can arrive while Linux is already in an exception entry path. At that
point sscratch and tp may be in the middle of the normal trap-entry
exchange, so they cannot always identify current. Store current in a
per-CPU slot and use the hart ID passed by firmware to recover it.

Give each event, including each CPU instance of a local event, a dedicated
stack and shadow call stack. Synchronize vmapped stack ranges before
unmasking events so that the handler cannot take a vmalloc fault while
running in an NMI-like context.

The handler is a synthetic supervisor episode, but completion must resume
the context interrupted by the SSE. Preserve stvec and, when the hypervisor
extension is present, hstatus across the handler. Read the interrupted a6
and a7 values from the SSE attributes, construct pt_regs for the
interrupted context, and write back any changes made by the handler.

Nested exceptions on the SSE event stack temporarily replace both
TASK_TI_KERNEL_SP and TASK_TI_USER_SP. Preserve their original values
across the handler and restore them before completing the event, so a
nested exception cannot leave the interrupted task referring to the event
stack.

On RV64 with an MMU, early trap entry also uses thread_info.a0/a1/a2
as scratch slots before saving the full register frame. An SSE handler
can interrupt that window and take a nested fault which overwrites the
same slots. Preserve them in already-saved callee-saved registers and
restore them before resuming the interrupted entry path.

Disable preemption while initializing the per-CPU entry-task slot.
CPU hotplug callbacks run in a preemptible thread, and this write
happens before the guards around the local SBI operations.

Compile the stack TLB helper only for VMAP_STACK or SHADOW_CALL_STACK,
its only users, to avoid an unused-function warning in other builds.

Keep an explicit EVENT_REGISTER not-supported result distinct from other
firmware failures. This lets clients select another delivery mechanism
only when firmware has positively rejected the requested event.

Link: https://lore.kernel.org/r/as79MHtNYd-VbUug@hu-himchau-blr.qualcomm.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610020009.P3ILnDi1-lkp@intel.com/
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 arch/riscv/include/asm/asm.h         |  14 +-
 arch/riscv/include/asm/scs.h         |   7 +
 arch/riscv/include/asm/sse.h         |  82 +++++++++
 arch/riscv/include/asm/thread_info.h |   1 +
 arch/riscv/kernel/Makefile           |   1 +
 arch/riscv/kernel/asm-offsets.c      |  14 ++
 arch/riscv/kernel/entry.S            |  14 ++
 arch/riscv/kernel/sbi_sse.c          | 251 +++++++++++++++++++++++++++
 arch/riscv/kernel/sbi_sse_entry.S    | 237 +++++++++++++++++++++++++
 9 files changed, 618 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/include/asm/sse.h
 create mode 100644 arch/riscv/kernel/sbi_sse.c
 create mode 100644 arch/riscv/kernel/sbi_sse_entry.S

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index b8bf842d4c1..e1196caea02 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,16 +91,24 @@
 .endm
 
 #ifdef CONFIG_SMP
-.macro asm_per_cpu dst sym tmp
-	lw    \tmp, TASK_TI_CPU_NUM(tp)
-	slli  \tmp, \tmp, RISCV_LGPTR
+.macro asm_per_cpu_with_cpu dst sym tmp cpu
+	slli  \tmp, \cpu, RISCV_LGPTR
 	la    \dst, __per_cpu_offset
 	add   \dst, \dst, \tmp
 	REG_L \tmp, 0(\dst)
 	la    \dst, \sym
 	add   \dst, \dst, \tmp
 .endm
+
+.macro asm_per_cpu dst sym tmp
+	lw \tmp, TASK_TI_CPU_NUM(tp)
+	asm_per_cpu_with_cpu \dst \sym \tmp \tmp
+.endm
 #else /* CONFIG_SMP */
+.macro asm_per_cpu_with_cpu dst sym tmp cpu
+	la    \dst, \sym
+.endm
+
 .macro asm_per_cpu dst sym tmp
 	la    \dst, \sym
 .endm
diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
index 023a412fe38..0d70a35bc01 100644
--- a/arch/riscv/include/asm/scs.h
+++ b/arch/riscv/include/asm/scs.h
@@ -17,6 +17,11 @@
 	load_per_cpu gp, irq_shadow_call_stack_ptr, \tmp
 .endm
 
+/* Load the per-CPU IRQ shadow call stack to gp. */
+.macro scs_load_sse_stack reg_evt
+	REG_L gp, SSE_REG_EVT_SHADOW_STACK(\reg_evt)
+.endm
+
 /* Load task_scs_sp(current) to gp. */
 .macro scs_load_current
 	REG_L	gp, TASK_TI_SCS_SP(tp)
@@ -40,6 +45,8 @@
 .endm
 .macro scs_load_irq_stack tmp
 .endm
+.macro scs_load_sse_stack reg_evt
+.endm
 .macro scs_load_current
 .endm
 .macro scs_load_current_if_task_changed prev
diff --git a/arch/riscv/include/asm/sse.h b/arch/riscv/include/asm/sse.h
new file mode 100644
index 00000000000..cbd8618c6e0
--- /dev/null
+++ b/arch/riscv/include/asm/sse.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+#ifndef __ASM_SSE_H
+#define __ASM_SSE_H
+
+#include <linux/printk.h>
+#include <linux/types.h>
+
+#include <asm/sbi.h>
+
+static inline bool riscv_sse_available(void)
+{
+#ifdef CONFIG_RISCV_SBI
+	return sbi_probe_extension(SBI_EXT_SSE) > 0;
+#else
+	return false;
+#endif
+}
+
+static inline void riscv_sse_mask_current_hart(void)
+{
+#ifdef CONFIG_RISCV_SBI
+	struct sbiret ret;
+
+	if (!riscv_sse_available())
+		return;
+
+	ret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_MASK, 0, 0, 0, 0, 0, 0);
+	if (ret.error && ret.error != SBI_ERR_ALREADY_STOPPED)
+		pr_emerg("SSE hart mask failed: %ld\n", ret.error);
+#endif
+}
+
+#ifdef CONFIG_RISCV_SBI_SSE
+
+struct sse_event_interrupted_state {
+	unsigned long a6;
+	unsigned long a7;
+};
+
+struct sse_event_arch_data {
+	void *stack;
+	void *shadow_stack;
+	unsigned long tmp;
+	struct sse_event_interrupted_state *interrupted;
+	phys_addr_t interrupted_phys;
+	u32 evt_id;
+	unsigned long hart_id;
+	unsigned int cpu_id;
+};
+
+struct riscv_sse_interrupted_context {
+	struct pt_regs *regs;
+	unsigned long hstatus;
+};
+
+static inline bool sse_event_is_global(u32 evt)
+{
+	return !!(evt & SBI_SSE_EVENT_GLOBAL);
+}
+
+void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt, int cpu);
+int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id,
+			int cpu);
+void arch_sse_free_event(struct sse_event_arch_data *arch_evt);
+int arch_sse_register_event(struct sse_event_arch_data *arch_evt);
+void arch_sse_init_cpu(void);
+
+void sse_handle_event(struct sse_event_arch_data *arch_evt,
+		      struct pt_regs *regs);
+asmlinkage void handle_sse(void);
+asmlinkage void noinstr do_sse(struct sse_event_arch_data *arch_evt,
+			       struct pt_regs *regs, unsigned long hstatus);
+
+const struct riscv_sse_interrupted_context *
+riscv_sse_get_interrupted_context(void);
+
+#endif
+
+#endif
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 55019fdfa9e..d14b45610c7 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -36,6 +36,7 @@
 #define OVERFLOW_STACK_SIZE     SZ_4K
 
 #define IRQ_STACK_SIZE		THREAD_SIZE
+#define SSE_STACK_SIZE		THREAD_SIZE
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f54c336bf54..0728362ba0a 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o sbi_ecall.o
+obj-$(CONFIG_RISCV_SBI_SSE)	+= sbi_sse.o sbi_sse_entry.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP)		+= sbi-ipi.o
 obj-$(CONFIG_SMP) += cpu_ops_sbi.o
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index a75f0cfea1e..15363703cdd 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -15,6 +15,8 @@
 #include <asm/ptrace.h>
 #include <asm/cpu_ops_sbi.h>
 #include <asm/stacktrace.h>
+#include <asm/sbi.h>
+#include <asm/sse.h>
 #include <asm/suspend.h>
 
 void asm_offsets(void);
@@ -533,6 +535,18 @@ void asm_offsets(void)
 	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
 	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
 #endif
+
+#ifdef CONFIG_RISCV_SBI_SSE
+	OFFSET(SSE_REG_EVT_STACK, sse_event_arch_data, stack);
+	OFFSET(SSE_REG_EVT_SHADOW_STACK, sse_event_arch_data, shadow_stack);
+	OFFSET(SSE_REG_EVT_TMP, sse_event_arch_data, tmp);
+	OFFSET(SSE_REG_HART_ID, sse_event_arch_data, hart_id);
+	OFFSET(SSE_REG_CPU_ID, sse_event_arch_data, cpu_id);
+
+	DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
+	DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
+	DEFINE(ASM_NR_CPUS, CONFIG_NR_CPUS);
+#endif
 #ifdef CONFIG_RISCV_SBI
 	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
 	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index d799c4e56f8..0b79fa7241e 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -424,6 +424,15 @@ SYM_FUNC_END(call_on_irq_stack)
  * arguments are passed to schedule_tail.
  */
 SYM_FUNC_START(__switch_to)
+#ifdef CONFIG_RISCV_SBI_SSE
+	/*
+	 * Mark the interval where tp changes from prev to next. SSE entry uses
+	 * the interrupted tp while this per-CPU pointer is NULL.
+	 */
+	asm_per_cpu t0, __sbi_sse_entry_task, t1
+	REG_S zero, 0(t0)
+#endif
+
 	/* Save context into prev->thread */
 	li    a4,  TASK_THREAD_RA
 	add   a3, a0, a4
@@ -470,6 +479,11 @@ SYM_FUNC_START(__switch_to)
 	REG_L s11, TASK_THREAD_S11_RA(a4)
 	/* The offset of thread_info in task_struct is zero. */
 	move tp, a1
+#ifdef CONFIG_RISCV_SBI_SSE
+	/* Publish next only after tp contains its task_struct pointer. */
+	asm_per_cpu t0, __sbi_sse_entry_task, t1
+	REG_S tp, 0(t0)
+#endif
 	/* Switch to the next shadow call stack */
 	scs_load_current
 	ret
diff --git a/arch/riscv/kernel/sbi_sse.c b/arch/riscv/kernel/sbi_sse.c
new file mode 100644
index 00000000000..032fcc07abc
--- /dev/null
+++ b/arch/riscv/kernel/sbi_sse.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Rivos Inc.
+ */
+#include <linux/nmi.h>
+#include <linux/sched.h>
+#include <linux/scs.h>
+#include <linux/bitfield.h>
+#include <linux/percpu-defs.h>
+#include <linux/preempt.h>
+#include <linux/string.h>
+
+#include <asm/asm-prototypes.h>
+#include <asm/switch_to.h>
+#include <asm/irq_stack.h>
+#include <asm/sbi.h>
+#include <asm/sse.h>
+#include <asm/tlbflush.h>
+
+DEFINE_PER_CPU(struct task_struct *, __sbi_sse_entry_task);
+static DEFINE_PER_CPU(struct riscv_sse_interrupted_context *,
+			      riscv_sse_interrupted_context);
+
+const struct riscv_sse_interrupted_context *
+riscv_sse_get_interrupted_context(void)
+{
+	return this_cpu_read(riscv_sse_interrupted_context);
+}
+
+void __weak sse_handle_event(struct sse_event_arch_data *arch_evt, struct pt_regs *regs)
+{
+}
+
+void noinstr do_sse(struct sse_event_arch_data *arch_evt,
+		    struct pt_regs *regs, unsigned long hstatus)
+{
+	struct riscv_sse_interrupted_context context = { regs, hstatus };
+	struct riscv_sse_interrupted_context *previous;
+	struct sbiret sret;
+
+	nmi_enter();
+	instrumentation_begin();
+
+	/* Retrieve missing GPRs from SBI */
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt_id,
+			 SBI_SSE_ATTR_INTERRUPTED_A6,
+			 (SBI_SSE_ATTR_INTERRUPTED_A7 -
+			  SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
+			 (unsigned long)arch_evt->interrupted_phys, 0, 0);
+	if (sret.error) {
+		pr_warn("Failed to read interrupted registers for event %x: %ld\n",
+			arch_evt->evt_id, sret.error);
+		/* Let the client quiesce its source without using incomplete regs. */
+		sse_handle_event(arch_evt, NULL);
+		goto out;
+	}
+
+	memcpy(&regs->a6, arch_evt->interrupted,
+	       sizeof(*arch_evt->interrupted));
+
+	/* Make the interrupted frame visible while clients handle this event. */
+	previous = this_cpu_read(riscv_sse_interrupted_context);
+	this_cpu_write(riscv_sse_interrupted_context, &context);
+	sse_handle_event(arch_evt, regs);
+	this_cpu_write(riscv_sse_interrupted_context, previous);
+
+	if (memcmp(&regs->a6, arch_evt->interrupted,
+		   sizeof(*arch_evt->interrupted))) {
+		memcpy(arch_evt->interrupted, &regs->a6,
+		       sizeof(*arch_evt->interrupted));
+		sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE,
+				 arch_evt->evt_id, SBI_SSE_ATTR_INTERRUPTED_A6,
+				 (SBI_SSE_ATTR_INTERRUPTED_A7 -
+				  SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
+				 (unsigned long)arch_evt->interrupted_phys, 0, 0);
+		/*
+		 * If writeback fails, COMPLETE resumes with firmware's original
+		 * a6/a7 rather than treating the shared buffer as committed.
+		 */
+		if (sret.error)
+			pr_warn("Failed to write interrupted registers for event %x: %ld\n",
+				arch_evt->evt_id, sret.error);
+	}
+
+out:
+	instrumentation_end();
+	nmi_exit();
+}
+
+static void *alloc_to_stack_pointer(void *alloc)
+{
+	return alloc ? alloc + SSE_STACK_SIZE : NULL;
+}
+
+static void *stack_pointer_to_alloc(void *stack)
+{
+	return stack ? stack - SSE_STACK_SIZE : NULL;
+}
+
+#if defined(CONFIG_VMAP_STACK) || defined(CONFIG_SHADOW_CALL_STACK)
+static void arch_sse_flush_tlb_range(struct sse_event_arch_data *arch_evt,
+				     unsigned long start, unsigned long size)
+{
+	unsigned long end = start + size;
+
+	if (sse_event_is_global(arch_evt->evt_id))
+		flush_tlb_kernel_range(start, end);
+	else
+		local_flush_tlb_kernel_range(start, end);
+}
+#endif
+
+static void arch_sse_shadow_stack_cpu_sync(struct sse_event_arch_data *arch_evt)
+{
+#ifdef CONFIG_SHADOW_CALL_STACK
+	if (arch_evt->shadow_stack)
+		arch_sse_flush_tlb_range(arch_evt,
+					 (unsigned long)arch_evt->shadow_stack,
+					 SCS_SIZE);
+#endif
+}
+
+#ifdef CONFIG_VMAP_STACK
+static void *sse_stack_alloc(unsigned int cpu)
+{
+	void *stack = arch_alloc_vmap_stack(SSE_STACK_SIZE, cpu_to_node(cpu));
+
+	return alloc_to_stack_pointer(stack);
+}
+
+static void sse_stack_free(void *stack)
+{
+	vfree(stack_pointer_to_alloc(stack));
+}
+
+static void arch_sse_stack_cpu_sync(struct sse_event_arch_data *arch_evt)
+{
+	void *p_stack = arch_evt->stack;
+	unsigned long stack = (unsigned long)stack_pointer_to_alloc(p_stack);
+
+	/*
+	 * Flush the tlb to avoid taking any exception when accessing the
+	 * vmapped stack inside the SSE handler
+	 */
+	arch_sse_flush_tlb_range(arch_evt, stack, SSE_STACK_SIZE);
+
+	arch_sse_shadow_stack_cpu_sync(arch_evt);
+}
+#else /* CONFIG_VMAP_STACK */
+static void *sse_stack_alloc(unsigned int cpu)
+{
+	void *stack = kmalloc(SSE_STACK_SIZE, GFP_KERNEL);
+
+	return alloc_to_stack_pointer(stack);
+}
+
+static void sse_stack_free(void *stack)
+{
+	kfree(stack_pointer_to_alloc(stack));
+}
+
+static void arch_sse_stack_cpu_sync(struct sse_event_arch_data *arch_evt)
+{
+	arch_sse_shadow_stack_cpu_sync(arch_evt);
+}
+#endif /* CONFIG_VMAP_STACK */
+
+static int sse_init_scs(int cpu, struct sse_event_arch_data *arch_evt)
+{
+	void *stack;
+
+	if (!scs_is_enabled())
+		return 0;
+
+	stack = scs_alloc(cpu_to_node(cpu));
+	if (!stack)
+		return -ENOMEM;
+
+	arch_evt->shadow_stack = stack;
+
+	return 0;
+}
+
+void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt, int cpu)
+{
+	arch_evt->cpu_id = cpu;
+	arch_evt->hart_id = cpuid_to_hartid_map(cpu);
+}
+
+void arch_sse_init_cpu(void)
+{
+	preempt_disable();
+	this_cpu_write(__sbi_sse_entry_task, current);
+	preempt_enable();
+}
+
+int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id,
+			int cpu)
+{
+	void *stack;
+
+	arch_evt->interrupted = kmalloc_obj(*arch_evt->interrupted, GFP_KERNEL);
+	if (!arch_evt->interrupted)
+		return -ENOMEM;
+
+	arch_evt->evt_id = evt_id;
+	stack = sse_stack_alloc(cpu);
+	if (!stack)
+		goto err_free_interrupted;
+
+	arch_evt->stack = stack;
+
+	if (sse_init_scs(cpu, arch_evt)) {
+		sse_stack_free(arch_evt->stack);
+		goto err_free_interrupted;
+	}
+
+	/* kmalloc keeps the two adjacent SBI attribute words contiguous. */
+	arch_evt->interrupted_phys = virt_to_phys(arch_evt->interrupted);
+
+	arch_sse_event_update_cpu(arch_evt, cpu);
+
+	return 0;
+
+err_free_interrupted:
+	kfree(arch_evt->interrupted);
+	arch_evt->interrupted = NULL;
+	return -ENOMEM;
+}
+
+void arch_sse_free_event(struct sse_event_arch_data *arch_evt)
+{
+	scs_free(arch_evt->shadow_stack);
+	sse_stack_free(arch_evt->stack);
+	kfree(arch_evt->interrupted);
+}
+
+int arch_sse_register_event(struct sse_event_arch_data *arch_evt)
+{
+	struct sbiret sret;
+
+	arch_sse_stack_cpu_sync(arch_evt);
+
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_REGISTER, arch_evt->evt_id,
+			 (unsigned long)handle_sse, (unsigned long)arch_evt, 0,
+			 0, 0);
+	if (sret.error == SBI_ERR_NOT_SUPPORTED)
+		return -EOPNOTSUPP;
+
+	return sbi_err_map_linux_errno(sret.error);
+}
diff --git a/arch/riscv/kernel/sbi_sse_entry.S b/arch/riscv/kernel/sbi_sse_entry.S
new file mode 100644
index 00000000000..1e38fbb1c2a
--- /dev/null
+++ b/arch/riscv/kernel/sbi_sse_entry.S
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Rivos Inc.
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+
+#include <asm/alternative-macros.h>
+#include <asm/asm.h>
+#include <asm/csr.h>
+#include <asm/hwcap.h>
+#include <asm/scs.h>
+
+/* When entering handle_sse, the following registers are set:
+ * a6: contains the hartid
+ * a7: contains a sse_event_arch_data struct pointer
+ */
+SYM_CODE_START(handle_sse)
+	/* Save stack temporarily */
+	REG_S sp, SSE_REG_EVT_TMP(a7)
+	/* Set entry stack */
+	REG_L sp, SSE_REG_EVT_STACK(a7)
+
+	addi sp, sp, -(PT_SIZE_ON_STACK)
+	REG_S ra, PT_RA(sp)
+	REG_S s0, PT_S0(sp)
+	REG_S s1, PT_S1(sp)
+	REG_S s2, PT_S2(sp)
+	REG_S s3, PT_S3(sp)
+	REG_S s4, PT_S4(sp)
+	REG_S s5, PT_S5(sp)
+	REG_S s6, PT_S6(sp)
+	REG_S s7, PT_S7(sp)
+	REG_S s8, PT_S8(sp)
+	REG_S s9, PT_S9(sp)
+	REG_S s10, PT_S10(sp)
+	REG_S s11, PT_S11(sp)
+	REG_S tp, PT_TP(sp)
+	REG_S t0, PT_T0(sp)
+	REG_S t1, PT_T1(sp)
+	REG_S t2, PT_T2(sp)
+	REG_S t3, PT_T3(sp)
+	REG_S t4, PT_T4(sp)
+	REG_S t5, PT_T5(sp)
+	REG_S t6, PT_T6(sp)
+	REG_S gp, PT_GP(sp)
+	REG_S a0, PT_A0(sp)
+	REG_S a1, PT_A1(sp)
+	REG_S a2, PT_A2(sp)
+	REG_S a3, PT_A3(sp)
+	REG_S a4, PT_A4(sp)
+	REG_S a5, PT_A5(sp)
+
+	/* Retrieve entry sp */
+	REG_L a4, SSE_REG_EVT_TMP(a7)
+	/* Save CSRs */
+	csrr a0, CSR_EPC
+	csrr a1, CSR_SSTATUS
+	csrr a2, CSR_STVAL
+	csrr a3, CSR_SCAUSE
+
+	REG_S a0, PT_EPC(sp)
+	REG_S a1, PT_STATUS(sp)
+	REG_S a2, PT_BADADDR(sp)
+	REG_S a3, PT_CAUSE(sp)
+	REG_S a4, PT_SP(sp)
+
+	/* Disable user memory access and floating/vector computing */
+	li t0, SR_SUM | SR_FS_VS
+	csrc CSR_STATUS, t0
+
+	load_global_pointer
+	scs_load_sse_stack a7
+
+#ifdef CONFIG_SMP
+	REG_L t4, SSE_REG_HART_ID(a7)
+	lw t3, SSE_REG_CPU_ID(a7)
+
+	bne t4, a6, .Lfind_hart_id_slowpath
+
+.Lcpu_id_found:
+#else
+	mv t3, zero
+#endif
+
+	asm_per_cpu_with_cpu t2 __sbi_sse_entry_task t1 t3
+	REG_L tp, 0(t2)
+	bnez tp, .Lcurrent_task_found
+
+	/* __switch_to() marks its transition window with a NULL entry task. */
+	REG_L tp, PT_TP(sp)
+
+.Lcurrent_task_found:
+	/* Nested exceptions temporarily replace these with the SSE stack. */
+	REG_L s6, TASK_TI_KERNEL_SP(tp)
+	REG_L s7, TASK_TI_USER_SP(tp)
+#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
+	/* A nested fault must not overwrite an interrupted trap's scratch slots. */
+	REG_L s8, TASK_TI_A0(tp)
+	REG_L s9, TASK_TI_A1(tp)
+	REG_L s10, TASK_TI_A2(tp)
+#endif
+
+	mv a1, sp /* pt_regs on stack */
+
+	/*
+	 * Run the SSE handler with the normal exception vector, but restore the
+	 * interrupted stvec before completing the event. SSE can arrive while
+	 * the kernel is using a temporary trap vector in a sensitive entry path.
+	 */
+	csrr s3, CSR_STVEC
+	la t0, handle_exception
+	csrw CSR_STVEC, t0
+
+	/*
+	 * Preserve the full HS-mode virtualization state across the handler.
+	 * hstatus is live supervisor state rather than an SSE interrupted
+	 * attribute, and OpenSBI consumes hstatus.SPV during event completion.
+	 * Saving the whole CSR keeps the handler episode transparent to KVM and
+	 * avoids having to infer which hstatus bits may matter to a guest resume.
+	 */
+	li s5, 0
+	ALTERNATIVE("nop", "csrr s5, hstatus", 0, RISCV_ISA_EXT_H, 1)
+
+	/*
+	 * Save sscratch for restoration since we might have interrupted the
+	 * kernel in early exception path and thus, we don't know the content of
+	 * sscratch.
+	 */
+	csrrw s4, CSR_SSCRATCH, x0
+
+	mv a0, a7
+	mv a2, s5
+
+	call do_sse
+
+	/* Leave no reference to the event stack in the interrupted task. */
+	REG_S s7, TASK_TI_USER_SP(tp)
+	REG_S s6, TASK_TI_KERNEL_SP(tp)
+#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
+	REG_S s8, TASK_TI_A0(tp)
+	REG_S s9, TASK_TI_A1(tp)
+	REG_S s10, TASK_TI_A2(tp)
+#endif
+
+	csrw CSR_SSCRATCH, s4
+	ALTERNATIVE("nop", "csrw hstatus, s5", 0, RISCV_ISA_EXT_H, 1)
+	csrw CSR_STVEC, s3
+
+	REG_L a0, PT_STATUS(sp)
+	REG_L a1, PT_EPC(sp)
+	REG_L a2, PT_BADADDR(sp)
+	REG_L a3, PT_CAUSE(sp)
+	csrw CSR_SSTATUS, a0
+	csrw CSR_EPC, a1
+	csrw CSR_STVAL, a2
+	csrw CSR_SCAUSE, a3
+
+	REG_L ra, PT_RA(sp)
+	REG_L s0, PT_S0(sp)
+	REG_L s1, PT_S1(sp)
+	REG_L s2, PT_S2(sp)
+	REG_L s3, PT_S3(sp)
+	REG_L s4, PT_S4(sp)
+	REG_L s5, PT_S5(sp)
+	REG_L s6, PT_S6(sp)
+	REG_L s7, PT_S7(sp)
+	REG_L s8, PT_S8(sp)
+	REG_L s9, PT_S9(sp)
+	REG_L s10, PT_S10(sp)
+	REG_L s11, PT_S11(sp)
+	REG_L tp, PT_TP(sp)
+	REG_L t0, PT_T0(sp)
+	REG_L t1, PT_T1(sp)
+	REG_L t2, PT_T2(sp)
+	REG_L t3, PT_T3(sp)
+	REG_L t4, PT_T4(sp)
+	REG_L t5, PT_T5(sp)
+	REG_L t6, PT_T6(sp)
+	REG_L gp, PT_GP(sp)
+	REG_L a0, PT_A0(sp)
+	REG_L a1, PT_A1(sp)
+	REG_L a2, PT_A2(sp)
+	REG_L a3, PT_A3(sp)
+	REG_L a4, PT_A4(sp)
+	REG_L a5, PT_A5(sp)
+
+	REG_L sp, PT_SP(sp)
+
+	li a7, SBI_EXT_SSE
+	li a6, SBI_SSE_EVENT_COMPLETE
+	ecall
+
+	/*
+	 * COMPLETE must resume the interrupted context and never return. Trap
+	 * through the normal vector instead of falling into adjacent assembly.
+	 */
+	la t0, handle_exception
+	csrw CSR_STVEC, t0
+	ebreak
+	/* The fatal trap must not return; execution should never reach here. */
+
+#ifdef CONFIG_SMP
+.Lfind_hart_id_slowpath:
+
+	/* Restore current task struct from __sbi_sse_entry_task */
+	li t1, ASM_NR_CPUS
+	/* Slowpath to find the CPU id associated to the hart id */
+	la t0, __cpuid_to_hartid_map
+	li t3, 0
+
+.Lhart_id_loop:
+	REG_L t2, 0(t0)
+	beq t2, a6, .Lcpu_id_found
+
+	/* Increment pointer and CPU number */
+	addi t3, t3, 1
+	addi t0, t0, RISCV_SZPTR
+	bltu t3, t1, .Lhart_id_loop
+
+	/*
+	 * This should never happen since we expect the hart_id to match one
+	 * of our CPU, but better be safe than sorry
+	 */
+	la tp, init_task
+	la a0, sse_hart_id_panic_string
+	la t0, panic
+	jalr t0
+#endif
+
+SYM_CODE_END(handle_sse)
+ASM_NOKPROBE(handle_sse)
+
+SYM_DATA_START_LOCAL(sse_hart_id_panic_string)
+    .ascii "Unable to match hart_id with cpu\0"
+SYM_DATA_END(sse_hart_id_panic_string)
-- 
2.50.1 (Apple Git-155)

