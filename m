Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C863264FB
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053884; cv=none; b=J6nDtCqdN90jA4D7n6DhfMnzWDbivTqS7TBjk/g2qrjkwkjsQsjYFPNInu75cZUwE07oNBQYeJRLY+UXq9SjO0PF94qsUMNXiQN1YQSndEwIT8/84zQV97d7YSGCIHuyTvRgCCqDRnYMEX1w7gg/FHvMlZn8dQ9nHZBCHQFGkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053884; c=relaxed/simple;
	bh=fDbK7c6+B4xWjTfmF+IPyJhunYFzAjMQ8Y6rqVfMvII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZY8ONC12hY+/gF7PgB/xullCnHxk5ofQlB0Hp8PwTeJQiZl0Lv7vJoCwj7YD0rNGavhOtD5h5KDP24MIzmGyDApCGrnBjttA9/9zwCJiBeg+yFFad/F5nMpWsgGqt9xcdw7hctQKHZKehiFMD/rZuFY+jOFgkSgIY6tDcMx9lCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg5MGjBl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg5MGjBl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c0cea8883so11717381cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053881; x=1784658681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0sIaGf5EzkbjI19/agb6agMi3UfIlX+gCu5QJjKxqwU=;
        b=Dg5MGjBl2B7ggqi+x72dw/x92mZHUvAd33U8llzS12W3vblEwMVN0ER95oXPaaN2nP
         LO/lGOyJLj43ohBYRLYt4EskZ8szGdO4Eui56ZxlV6+WE72mvuW939aLk4mi7vX+HaPz
         5fTp5c4FJSG9LmlikMSRStEEWDykJkF7l38/36Pdc4gwiRMpPjaHL1YwJ7fWTRsIPOIp
         S51RhZimapd/ESUDDU949OUIGBIqsiUrMYkExp/A8FWm0IPicEAtRqMrHsVW5wSiLP72
         L31tOFwz8+8SnIrSBOKlbx/n/99bJwgieFOfO7dqV/jAyvf1++MFLeqd14dGK1XdRyKC
         5w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053881; x=1784658681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0sIaGf5EzkbjI19/agb6agMi3UfIlX+gCu5QJjKxqwU=;
        b=ln6KwbuJykyQELTth9lnJ6tfrBWh0hIqZEfGNxxNGTqMIeQp9esImBDZeMlBCoSubE
         EYVfUY20+HF45BPEcpMFBsDgLmkedP3ECp1Ls6vjXOP6bFFKKlz3iatHSR/AoQYXKeG8
         ZaLPCmtSGQeJLQK4AGbQ05OibLLGw3mhr38dJ5xALp+vto5GMVmjbOGrph4+pgorKJPI
         8z5kpbqGkv7YHvzVsyjw9OyMuxYEl7u8moMrcCnsFo6WcYyB1Js4n1YjNNXZ8CQ2Ei7f
         mYDas2A1B+hoBmfucaV8BpZ8bgITVJzzUq2qvT0WLQ3JitPXtAXCLYnAc2GtIGUzJVx5
         fM4w==
X-Forwarded-Encrypted: i=1; AHgh+Rrpqh+iyGtMq+ihSclG9FZTrX4ElJzm7GR9SAVHTa1ec9a8KWxRsvKf83AcL3hq5Of517N2PFbn1oC16NWn6zUd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt10XaFhAE2s4xE14K9PxRJ7XIV9swhA/HAaGiMAkNOcQVdnUG
	Mv2S5uXYPVSBb2iSqYXUABfXx0NJ+s8MImv6Ul9MPj5PPnGVZrlkhDIk
X-Gm-Gg: AfdE7cn68DO4Qtbve2zhQ7QEE5wmROK5cdQjHT/kLgNKai6/WoPoLX7cmWNx45q+cvs
	Eudlsn9/yI+8+jLryqS8knYXGmi+DUBe2fLKlTqxVOWqtkjN2hkoUOYdO4p3IPZK+b+jp6O+8LM
	hrcRjg/dfNlK1K8HwUHgrTZB0KjSEwx++sKnOYNCc++fNkn2R3MG8bO8319KLCRowHEEgfYVIcR
	tw3VeKshBNLroVXM2qdnA4XcwnM6o1JHfeNtZVgDuDThETuDSeR7ZLtCcZi46Fd0Biuy/Bep68N
	WNaV72VUfctSq5GPXh4sErpdDxRnqSXNKbkEaY1THWPDlRu3kQWCyGIrrmfyXWVVhMmmRpUaVZq
	1dEGwsl9i1uY6W/6pMBrMWWrdYnCxsmpGuPw94J2D358Qic0DnDqY+78zOU2+rOsvy2gPMjMuv8
	a4DOE72hROmUyGANQGeGpzb5lsJLV77kazUrW9loeGuj6TBcupOKY=
X-Received: by 2002:a05:622a:306:b0:51c:f64:bc39 with SMTP id d75a77b69052e-51cbf741118mr134331951cf.3.1784053880463;
        Tue, 14 Jul 2026 11:31:20 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae24d04sm117196081cf.18.2026.07.14.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:31:19 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 05/13] mm/kwatch: add watch expression parser and dereference engine
Date: Wed, 15 Jul 2026 02:31:07 +0800
Message-ID: <20260714183107.12463-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KWatch watches a memory address that is only known once the target
function runs, e.g. "argument 1, plus 8, dereferenced once". Add the
two halves of that mechanism:

- kwatch_deref_parse() turns a textual watch expression
  {base}[+-off][->[+-]off]... into a kwatch_config: a base anchor
  (arg1..arg6, stack, an absolute address or - for built-in KWatch -
  a symbol name) plus a static offset chain.

- kwatch_deref_resolve() replays the chain at probe time against
  pt_regs. Every pointer load goes through get_kernel_nofault() and
  the final address must be a kernel address.

Also add the internal kwatch.h header shared by the rest of the
series. Nothing is built yet; the Kconfig entry comes with the
control plane.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kwatch/Makefile |   3 +
 mm/kwatch/deref.c  | 174 +++++++++++++++++++++++++++++++++++++++++++++
 mm/kwatch/kwatch.h | 107 ++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 mm/kwatch/Makefile
 create mode 100644 mm/kwatch/deref.c
 create mode 100644 mm/kwatch/kwatch.h

diff --git a/mm/kwatch/Makefile b/mm/kwatch/Makefile
new file mode 100644
index 000000000000..69c21ae62123
--- /dev/null
+++ b/mm/kwatch/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_KWATCH) += kwatch.o
+
+kwatch-y := deref.o
diff --git a/mm/kwatch/deref.c b/mm/kwatch/deref.c
new file mode 100644
index 000000000000..a93c76139e7c
--- /dev/null
+++ b/mm/kwatch/deref.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/ptrace.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <linux/kallsyms.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
+#include "kwatch.h"
+
+int kwatch_deref_resolve(const struct kwatch_config *cfg, struct pt_regs *regs,
+			 unsigned long *out_addr, u16 *out_len)
+{
+	unsigned long addr = 0;
+	int i;
+
+	/* 1. Resolve the Base Anchor */
+	if (cfg->base == KWATCH_BASE_STACK) {
+		addr = kernel_stack_pointer(regs);
+		if (unlikely(!addr))
+			return -EINVAL;
+	} else if (cfg->base >= KWATCH_BASE_ARG1 &&
+		   cfg->base <= KWATCH_BASE_ARG6) {
+		int arg_idx = cfg->base - KWATCH_BASE_ARG1;
+
+		addr = regs_get_kernel_argument(regs, arg_idx);
+	} else if (cfg->base == KWATCH_BASE_ABS_ADDR ||
+		   cfg->base == KWATCH_BASE_GLOBAL_SYM) {
+		/* Zero-latency load of the static symbol location */
+		addr = cfg->sym_addr;
+	} else {
+		return -EINVAL;
+	}
+
+	/* 2. The Pointer-Chasing FSM */
+	for (i = 0; i < cfg->offset_count; i++) {
+		addr += cfg->offsets[i];
+
+		if (i < cfg->offset_count - 1) {
+			unsigned long next_addr;
+
+			/* Dynamically read the pointer contents at runtime */
+			if (get_kernel_nofault(next_addr, (unsigned long *)addr))
+				return -EFAULT;
+
+			addr = next_addr;
+		}
+	}
+
+	/* Enforce strict Kernel-Space boundary */
+	if (unlikely(addr < TASK_SIZE_MAX))
+		return -EINVAL;
+
+	*out_addr = addr;
+	*out_len = cfg->watch_len;
+	return 0;
+}
+
+int kwatch_deref_parse(struct kwatch_config *cfg, const char *watch_expr)
+{
+	char *p, *sep, *dup_expr;
+	char type = '\0';
+	bool is_deref = false;
+	int ret = 0;
+
+	dup_expr = kstrdup(watch_expr, GFP_KERNEL);
+	if (!dup_expr)
+		return -ENOMEM;
+
+	cfg->offset_count = 1;
+	cfg->offsets[0] = 0;
+
+	/* 1. Isolate and Resolve Base Anchor */
+	p = dup_expr;
+	sep = NULL;
+	while (*p) {
+		if (*p == '+') {
+			sep = p;
+			type = '+';
+			break;
+		}
+		if (*p == '-') {
+			sep = p;
+			type = '-';
+			if (p[1] == '>')
+				is_deref = true;
+			break;
+		}
+		p++;
+	}
+
+	if (type)
+		*sep = '\0';
+
+	if (!strcmp(dup_expr, "stack")) {
+		cfg->base = KWATCH_BASE_STACK;
+	} else if (!strncmp(dup_expr, "arg", 3) && strlen(dup_expr) == 4) {
+		int arg_num;
+
+		if (kstrtoint(dup_expr + 3, 10, &arg_num) || arg_num < 1 ||
+		    arg_num > 6) {
+			ret = -EINVAL;
+			goto out;
+		}
+		cfg->base = KWATCH_BASE_ARG1 + (arg_num - 1);
+	} else if (kstrtoul(dup_expr, 0, &cfg->sym_addr) == 0) {
+		cfg->base = KWATCH_BASE_ABS_ADDR;
+	} else {
+#if IS_BUILTIN(CONFIG_KWATCH)
+		cfg->sym_addr = kallsyms_lookup_name(dup_expr);
+		if (!cfg->sym_addr) {
+			pr_err("Failed to resolve symbol name: %s\n", dup_expr);
+			ret = -EINVAL;
+			goto out;
+		}
+		cfg->base = KWATCH_BASE_GLOBAL_SYM;
+#else
+		pr_err("cannot resolve symbol %s when built as a module, use a hex address\n",
+		       dup_expr);
+		ret = -EINVAL;
+		goto out;
+#endif
+	}
+
+	if (!type)
+		goto out;
+
+	/* 2. Resolve Base Offset (if + or - exists) */
+	if (!is_deref) {
+		char *next;
+
+		*sep = type; /* Restore the '+' or '-' for kstrtol */
+		next = strstr(sep, "->");
+		if (next)
+			*next = '\0';
+
+		if (kstrtol(sep, 0, &cfg->offsets[0])) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		p = next ? next + 2 : NULL;
+	} else {
+		/* Jump directly to the first dereference after '->' */
+		p = sep + 2;
+	}
+
+	/* 3. Resolve Dereference Chain */
+	while (p) {
+		char *next;
+
+		if (cfg->offset_count >= MAX_DEREF_CHAIN) {
+			ret = -E2BIG;
+			goto out;
+		}
+
+		next = strstr(p, "->");
+		if (next)
+			*next = '\0';
+
+		if (kstrtol(p, 0, &cfg->offsets[cfg->offset_count++])) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		p = next ? next + 2 : NULL;
+	}
+
+out:
+	kfree(dup_expr);
+	return ret;
+}
diff --git a/mm/kwatch/kwatch.h b/mm/kwatch/kwatch.h
new file mode 100644
index 000000000000..e1ac8ae312f6
--- /dev/null
+++ b/mm/kwatch/kwatch.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _MM_KWATCH_H
+#define _MM_KWATCH_H
+
+#include <linux/fprobe.h>
+#include <linux/kprobes.h>
+#include <linux/perf_event.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/atomic.h>
+
+#define MAX_CONFIG_STR_LEN 512
+#define MAX_DEREF_CHAIN 4
+
+struct kwatch_watchpoint;
+
+struct kwatch_tsk_ctx {
+	struct task_struct *task;
+	struct kwatch_watchpoint *wp;
+	u16 depth;
+	u32 epoch;
+};
+
+struct kwatch_watchpoint {
+	struct perf_event *__percpu *event;
+	call_single_data_t __percpu *csd_arm;
+	call_single_data_t __percpu *csd_disarm;
+	struct perf_event_attr attr;
+	atomic_t in_use; // multi-consumer safe get/put
+	struct list_head list; // for cpu online and offline
+
+	struct task_struct *arm_tsk;
+	atomic_t pending_ipis;
+	atomic_t refcount;
+	bool teardown;
+};
+
+enum kwatch_access_type {
+	KWATCH_ACCESS_W,
+	KWATCH_ACCESS_R,
+	KWATCH_ACCESS_RW,
+	KWATCH_ACCESS_X,
+};
+
+enum kwatch_base_type {
+	KWATCH_BASE_STACK,
+	KWATCH_BASE_ABS_ADDR,
+	KWATCH_BASE_GLOBAL_SYM,
+	KWATCH_BASE_ARG1,
+	KWATCH_BASE_ARG2,
+	KWATCH_BASE_ARG3,
+	KWATCH_BASE_ARG4,
+	KWATCH_BASE_ARG5,
+	KWATCH_BASE_ARG6,
+};
+
+struct kwatch_config {
+	u16 max_watch;
+	char func_name[KSYM_NAME_LEN];
+	u16 func_offset;
+	u16 depth;
+	u16 duration;
+	enum kwatch_access_type access_type;
+	u16 watch_len;
+
+	/* Unified Deref Engine State */
+	enum kwatch_base_type base;
+	char watch_expr[MAX_CONFIG_STR_LEN];
+	unsigned long sym_addr;
+	long offsets[MAX_DEREF_CHAIN];
+	u8 offset_count;
+	u16 max_concurrency;
+};
+
+int kwatch_hwbp_prealloc(u16 max_watch, enum kwatch_access_type access_type);
+void kwatch_hwbp_free(void);
+int kwatch_hwbp_get(struct kwatch_watchpoint **out_wp);
+void kwatch_hwbp_arm(struct kwatch_watchpoint *wp, unsigned long addr, u16 len);
+int kwatch_hwbp_put(struct kwatch_watchpoint *wp);
+
+int kwatch_probe_start(struct kwatch_config *cfg);
+void kwatch_probe_stop(void);
+void kwatch_probe_mute(bool mute);
+bool kwatch_probe_validate_hit(struct pt_regs *regs, struct task_struct *arm_tsk);
+unsigned long kwatch_probe_nmi_rejected(void);
+
+int kwatch_tsk_ctx_prealloc(u16 max_concurrency);
+struct kwatch_tsk_ctx *kwatch_tsk_ctx_get(bool can_alloc);
+void kwatch_tsk_ctx_put(void);
+void kwatch_tsk_ctx_reset(struct kwatch_tsk_ctx *ctx, u32 new_epoch);
+void kwatch_tsk_ctx_release_wps(void);
+void kwatch_tsk_ctx_free(void);
+
+void kwatch_global_anchor(unsigned long duration_sec);
+int kwatch_anchor_start(u16 duration);
+void kwatch_anchor_stop(void);
+void kwatch_anchor_cancel_work(void);
+bool kwatch_anchor_has_expired(void);
+void kwatch_anchor_clear_expired(void);
+void kwatch_auto_stop(void);
+
+int kwatch_deref_resolve(const struct kwatch_config *cfg, struct pt_regs *regs,
+			 unsigned long *out_addr, u16 *out_len);
+int kwatch_deref_parse(struct kwatch_config *cfg, const char *watch_expr);
+
+#endif /* _MM_KWATCH_H */
-- 
2.53.0

