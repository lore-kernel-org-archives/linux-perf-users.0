Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A7399368
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269928; cv=none; b=k3J4ObLvCQghcKWs0XKh0q5r0RHq7inpxN/zQZUXuwJ6I8K5JkP9+qeEmoA20c17qBKx7gP6M+8BOu3W4q1+lHbJNMXsfP9zmxB8W+rFVSHKKeDrit+RdrEF0MCOK8TDzde33cNsb9u5ff3ikKZj3jSOIGC0c/6q2YTxCHVtU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269928; c=relaxed/simple;
	bh=d0L2vSa3oCUAcXPpREBEiBvUnZa1w0w8sODn8jCxIuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2t5Bj7TPuWTrAmvB3R+BAHNk4/i5nSpkbFJ1JmAHvdPcFL/+S1kK6SMRJx0ZHGnuy+bMAqXaTecBTyEvWisAGGZYGhCcPfpzaPQsbOr0IKKpW3KaxQe9Jz2Hdu96blr9kfTwzI5xKhvAPcbbt5cbLRtgiGE4qOY++iX5u8LlJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rI+ze9Ag; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rI+ze9Ag"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12721cd1a2aso13862596c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773269925; x=1773874725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmXJ8K/BpnLUJNna/3dVzpZzaD71lE2VNfovAjbqI3Y=;
        b=rI+ze9Ag932yeOBt2RIgxsThaYv9zVNI3EFhin1tEyK3OM7DIhmUNZj3/UNpJ8+K7X
         afo7tZCL2dChBCW9Y5wrmTfYjXd0Jq9l/va6TTHtn3ygKjL8QPPcLiGQnAFIKbWlfsKw
         cpXHrijcAZtfVKsm/cdw3pUvQy/GRj0uD7ZkjCaRHcDfD9bRvtXYVxXNGGQIj12Pp2VJ
         fFLGukRmK/a0F21e4FBBG9HPFzVgyJzxN+g0URucbBmseAYZbBFsn4/FFlCqzPeZiZSS
         loTG70IMOtSg073PbdGsHOlNTvXs8gQYHCY9JNE9EaeIPOPu69H50mOGMvFu97WGK/kz
         skTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773269925; x=1773874725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmXJ8K/BpnLUJNna/3dVzpZzaD71lE2VNfovAjbqI3Y=;
        b=pPe6bK9WRuu2seezpHkq3mdUpTCMbURZ0jk8h+xmWOpgp3UnY7aGhb9iEwNyhM0Vel
         1n5TqvEkbuWfdMucHnCj7d+s0WqgAYDC79uSTWQInkPkc5WuyzYAk1mo8xbmt6uc1VEH
         zpo/F8LEY1rVJ2f/2nyuH3vWIGwRNLiNH8cR3lcK1wG6iha7TGJ+Z+GxuxBqSew8dSPj
         s4pRamNvOknDyS7XyOmkmytcSsXho9RZJHr8XTSfBdWFNN91pAsho/vtjLBhyBaPXHnm
         XLRQ+GQO6anoMTVFyVnHbRGI+63nFUIyvSh3ZUAtQhhl357CfZJwyreWM15h5haJyzI4
         yvuA==
X-Forwarded-Encrypted: i=1; AJvYcCUx6IatehYogusLCXPOoozo15KyWZvrAHvFkjYrZvsf6r6djboNn6/NbSCTH6WKv3E763hCwGEYi5VS9gddd/9N@vger.kernel.org
X-Gm-Message-State: AOJu0YxGu3IJwzgHqyZLqbHvgDkOBdShcmpDncHpiXofQ2GAZy0HEUE9
	FPgWmksgzjLteOB0YPbrTr1vkZfhIrlJa8kpIeLYMxoKtm5hcMM+uRjFQmTkJzkFoa+otJ8ZSRn
	z3CpRrC8l9UI3SA==
X-Received: from dlbpt3.prod.google.com ([2002:a05:7022:e803:b0:128:cc09:3c31])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:497:b0:119:e56b:c75c with SMTP id a92af1059eb24-128e783cab1mr2269369c88.33.1773269924866;
 Wed, 11 Mar 2026 15:58:44 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:57:40 +0000
In-Reply-To: <20260309223156.GA73501@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309223156.GA73501@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311225822.1565895-1-cmllamas@google.com>
Subject: [PATCH] static_call: use CFI-compliant return0 stubs
From: Carlos Llamas <cmllamas@google.com>
To: Sami Tolvanen <samitolvanen@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Nathan Chancellor <nathan@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
	Jens Remus <jremus@linux.ibm.com>, Juergen Gross <jgross@suse.com>, 
	Carlos Llamas <cmllamas@google.com>, Conor Dooley <conor.dooley@microchip.com>, 
	David Kaplan <david.kaplan@amd.com>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, James Morse <james.morse@arm.com>, 
	Thomas Huth <thuth@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Will McVicker <willmcvicker@google.com>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Architectures with !HAVE_STATIC_CALL (such as arm64) rely on the generic
static_call implementation via indirect calls. In particular, users of
DEFINE_STATIC_CALL_RET0, default to the generic __static_call_return0
stub to optimize the unset path.

However, __static_call_return0 has a fixed signature of "long (*)(void)"
which may not match the expected prototype at callsites. This triggers
CFI failures when CONFIG_CFI is enabled. A trivial linux-perf command
does it:

  $ perf record -a sleep 1
  CFI failure at perf_prepare_sample+0x98/0x7f8 (target: __static_call_return0+0x0/0x10; expected type: 0x837de525)
  Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
  Modules linked in:
  CPU: 0 UID: 0 PID: 638 Comm: perf Not tainted 7.0.0-rc3 #25 PREEMPT
  Hardware name: linux,dummy-virt (DT)
  pstate: 900000c5 (NzcV daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : perf_prepare_sample+0x98/0x7f8
  lr : perf_prepare_sample+0x70/0x7f8
  sp : ffff80008289bc20
  x29: ffff80008289bc30 x28: 000000000000001f x27: 0000000000000018
  x26: 0000000000000100 x25: ffffffffffffffff x24: 0000000000000000
  x23: 0000000000010187 x22: ffff8000851eba40 x21: 0000000000010087
  x20: ffff0000098c9ea0 x19: ffff80008289bdc0 x18: 0000000000000000
  x17: 00000000837de525 x16: 0000000072923c8f x15: 7fffffffffffffff
  x14: 00007fffffffffff x13: 00000000ffffffea x12: 0000000000000000
  x11: 0000000000000015 x10: 0000000000000000 x9 : ffff8000822f2240
  x8 : ffff800080276e4c x7 : 0000000000000000 x6 : 0000000000000000
  x5 : 0000000000000000 x4 : ffff8000851eba10 x3 : ffff8000851eba40
  x2 : ffff8000822f2240 x1 : 0000000000000000 x0 : 00000009d377c3a0
  Call trace:
   perf_prepare_sample+0x98/0x7f8 (P)
   perf_event_output_forward+0x5c/0x17c
   __perf_event_overflow+0x2fc/0x460
   perf_event_overflow+0x1c/0x28
   armv8pmu_handle_irq+0x134/0x210
  [...]

To fix this, let architectures provide an ARCH_DEFINE_TYPED_STUB_RET0
implementation that generates individual signature-matching stubs for
users of DEFINE_STATIC_CALL_RET0. This ensures the CFI hash of the
target call matches that of the callsite.

Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will McVicker <willmcvicker@google.com>
Fixes: 87b940a0675e ("perf/core: Use static_call to optimize perf_guest_info_callbacks")
Closes: https://lore.kernel.org/all/YfrQzoIWyv9lNljh@google.com/
Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 arch/Kconfig                         |  4 ++++
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/linkage.h     |  3 ++-
 arch/arm64/include/asm/static_call.h | 23 +++++++++++++++++++++++
 include/linux/static_call.h          | 19 ++++++++++++++++++-
 kernel/events/core.c                 | 11 +++++++----
 kernel/sched/core.c                  |  4 ++--
 7 files changed, 57 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/static_call.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 102ddbd4298e..7735d548f02e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1678,6 +1678,10 @@ config HAVE_STATIC_CALL_INLINE
 	depends on HAVE_STATIC_CALL
 	select OBJTOOL
 
+config HAVE_STATIC_CALL_TYPED_STUBS
+	bool
+	depends on !HAVE_STATIC_CALL
+
 config HAVE_PREEMPT_DYNAMIC
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 38dba5f7e4d2..b370c31a23cf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -252,6 +252,7 @@ config ARM64
 	select HAVE_RSEQ
 	select HAVE_RUST if RUSTC_SUPPORTS_ARM64
 	select HAVE_STACKPROTECTOR
+	select HAVE_STATIC_CALL_TYPED_STUBS if CFI
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
index 40bd17add539..5625ea365d27 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -4,9 +4,10 @@
 #ifdef __ASSEMBLER__
 #include <asm/assembler.h>
 #endif
+#include <linux/stringify.h>
 
 #define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT
-#define __ALIGN_STR	".balign " #CONFIG_FUNCTION_ALIGNMENT
+#define __ALIGN_STR	__stringify(__ALIGN)
 
 /*
  * When using in-kernel BTI we need to ensure that PCS-conformant
diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/asm/static_call.h
new file mode 100644
index 000000000000..ef754b58b1c9
--- /dev/null
+++ b/arch/arm64/include/asm/static_call.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_STATIC_CALL_H
+#define _ASM_ARM64_STATIC_CALL_H
+
+#include <linux/compiler.h>
+#include <asm/linkage.h>
+
+/* Generates a CFI-compliant "return 0" stub matching @reffunc signature */
+#define __ARCH_DEFINE_TYPED_STUB_RET0(name, reffunc)	\
+	typeof(reffunc) name;				\
+	__ADDRESSABLE(name);				\
+	asm(						\
+	"	" __ALIGN_STR "                \n"	\
+	"	.4byte	__kcfi_typeid_" #name "\n"	\
+	#name ":                               \n"	\
+	"	bti c                          \n"	\
+	"	mov x0, xzr                    \n"	\
+	"	ret"					\
+	);
+#define ARCH_DEFINE_TYPED_STUB_RET0(name, reffunc)	\
+	__ARCH_DEFINE_TYPED_STUB_RET0(name, reffunc)
+
+#endif /* _ASM_ARM64_STATIC_CALL_H */
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 78a77a4ae0ea..6cb44441dfe0 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -184,6 +184,8 @@ extern int static_call_text_reserved(void *start, void *end);
 
 extern long __static_call_return0(void);
 
+#define STATIC_CALL_STUB_RET0(...)	((void *)&__static_call_return0)
+
 #define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
@@ -270,6 +272,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 extern long __static_call_return0(void);
 
+#define STATIC_CALL_STUB_RET0(...)	((void *)&__static_call_return0)
+
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
@@ -294,6 +298,18 @@ static inline long __static_call_return0(void)
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_STATIC_CALL_TYPED_STUBS
+#include <asm/static_call.h>
+
+#define STATIC_CALL_STUB_RET0(name)	__static_call_##name
+#define DEFINE_STATIC_CALL_STUB_RET0(name, _func)			\
+	ARCH_DEFINE_TYPED_STUB_RET0(STATIC_CALL_STUB_RET0(name), _func)
+#else
+/* Fall back to the generic __static_call_return0 stub */
+#define STATIC_CALL_STUB_RET0(...)	((void *)&__static_call_return0)
+#define DEFINE_STATIC_CALL_STUB_RET0(...)
+#endif
+
 #define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
@@ -307,7 +323,8 @@ static inline long __static_call_return0(void)
 	__DEFINE_STATIC_CALL(name, _func, NULL)
 
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
-	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
+	DEFINE_STATIC_CALL_STUB_RET0(name, _func)			\
+	__DEFINE_STATIC_CALL(name, _func, STATIC_CALL_STUB_RET0(name))
 
 static inline void __static_call_nop(void) { }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f5699b339ec..6ac00e89d320 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7695,16 +7695,19 @@ void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 }
 EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
 
+#define static_call_disable(name) \
+	static_call_update(name, STATIC_CALL_STUB_RET0(name))
+
 void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
 	if (WARN_ON_ONCE(rcu_access_pointer(perf_guest_cbs) != cbs))
 		return;
 
 	rcu_assign_pointer(perf_guest_cbs, NULL);
-	static_call_update(__perf_guest_state, (void *)&__static_call_return0);
-	static_call_update(__perf_guest_get_ip, (void *)&__static_call_return0);
-	static_call_update(__perf_guest_handle_intel_pt_intr, (void *)&__static_call_return0);
-	static_call_update(__perf_guest_handle_mediated_pmi, (void *)&__static_call_return0);
+	static_call_disable(__perf_guest_state);
+	static_call_disable(__perf_guest_get_ip);
+	static_call_disable(__perf_guest_handle_intel_pt_intr);
+	static_call_disable(__perf_guest_handle_mediated_pmi);
 	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b7f77c165a6e..57c441d01564 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7443,12 +7443,12 @@ EXPORT_SYMBOL(__cond_resched);
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
 #  define cond_resched_dynamic_enabled	__cond_resched
-#  define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
+#  define cond_resched_dynamic_disabled	STATIC_CALL_STUB_RET0(cond_resched)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
 #  define might_resched_dynamic_enabled	__cond_resched
-#  define might_resched_dynamic_disabled ((void *)&__static_call_return0)
+#  define might_resched_dynamic_disabled STATIC_CALL_STUB_RET0(might_resched)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
 # elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-- 
2.53.0.473.g4a7958ca14-goog

