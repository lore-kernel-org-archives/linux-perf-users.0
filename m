Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BF3FD94C
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293465; cv=none; b=gU0gqN9IPfHGbCpDwTs9nFoQuU72pZJJTaHtvWGgrb9pait2pT73GuwF7eumlvU/3TVwc56xV/uqrleKYEaGb2erM6pykcalr7mecFdD5ynxkpryMTSSJYakcTnAcNNf5I+Px34FgiKCqFulU4JUS3TjhzuluxLb/pQ/hV6sNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293465; c=relaxed/simple;
	bh=TqoEQEUr0dwFy5/OGLtnT5TOw/H5doFE4/2j9BgHBdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9nYwmYfHy3aKTAsdeLpsmFz83+4/txzJUuEAxRqA/kYZLAj63Tg+q8KKX6N2V421IpHx/ErybRHesq4uHb5tQp4ZL+rwwx+P447qOVoTV/acwoBgejTPB4cqs4MTsb3JuSBXgiicVgUOYNWRFuw9W8kLKSnkd3wX/C/tvAh7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWgrqcA2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWgrqcA2"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381216921aaso7760288a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293463; x=1784898263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oZ4T7oI/5myCntWJFqGEBzYfa7to/x/3/pee5fO6Ps8=;
        b=pWgrqcA2wTQzbEPMa1h+DlJpc/N9UfNaT8DhObK9T7GjXkj5lwrwMwMBEGIbSuM1EG
         nXciGCWfTyOLHxNJ9vks2qTsJf1/kf1swXCzsKzUBSfmGv495OMGlIIu89JEnCRxcN8c
         1QsA7jl1C90uva1rPvfK6HE9DC004bIExN/mI/+H6j3WlkwJGQ0UolAoycsQ0B3fejLU
         fqqHCW1yiwETu07/nxqZrvTd7LKwX19ojdPY2mzhgIpS+4s7wmTvk+XA9pF7mFZIncEE
         EpPIVNHFcMgUzUYdeUTsImkv/XiJaVlmV7neIeAi+S+DSNnR42+TWLllcijZ956o+kEz
         EAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293463; x=1784898263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oZ4T7oI/5myCntWJFqGEBzYfa7to/x/3/pee5fO6Ps8=;
        b=JUb1rrnHC32qME3oLb3nRFB8ALh4HanMdgMsIM79u7AzEENbYSWwhaeheh8bcYht0Q
         DYvUyl6ekhb1oTSDCoqeBrI7RSJvfBGcEBX4taTKwInqv/Ak/NnfFElzg4hx7trhhT87
         1iP+Zi4oXpSGtWckg+tpEw/3BS7EVzCyRIIMGWTBpRFbrwsWqekq+WBXA4+mV0yR+8y5
         d77rdc8I8F+L45Q3urEeqOOOmE4eHuBRy/6aWwp3dZCSo9rDaorle3f8hewnYeb5uqfX
         uFhbfS/nJtXKf5JqIa0YzKXUO0IdM5aDxyf2VPhxnqoUkSGDq8B/eIEq9zrMzqvQkDXk
         P34A==
X-Forwarded-Encrypted: i=1; AHgh+RoPOkEydNoEvFL4xxTXSnEbgNC/ufvbnAbS1Xc84l90FJHVfZVIweosNbdopFU95LDVmnUHPa93uh9RvZ7tdAo2@vger.kernel.org
X-Gm-Message-State: AOJu0YygzgcqUCduDScKBgS19Ps49Zfoc0iBO+2G3OMMgb3NGHmJhR3c
	OokqiI0WrnipgPbAodlqR+QS2yvbe5lwgbC5p/7NVz//l/KxH/vCttRP
X-Gm-Gg: AfdE7ckbFcDo/JC736EHe+nhjEfFi4JEMd9CBepxi4JKIZHrNCykUJ/SevZkHUiJBr/
	P1sfZAUCnqZy6qMl/Kp8NMqa9N0Wqqe0g2tp6skdSIECHCCSLW0ntF4ydIRbEo0hw97GHFLtjFW
	eUsKxFYcLMY6Qf+TPZ6DQKejmOhWMOBokOX/pFfKZfYZJg3c6QPf3M3ZCR3lyiOJxyeiVLTsflh
	7QOr7TvmfpUG2hVED9kiA0Yj9Cbj1uVS+cjVwSlr4NuABjnUkIJ/TD2b2hIXdL1Upbs5wfdlccI
	LcbFTSxjq+QIcQzfe2vaHEKjnHRQAvfmJkoK41sPdLNPEHA8tsJf99cnxKIJZSwjAp34XPSwhVH
	KwdUlb8iwrFpvVBYvULawv8ERmO1gAqo/r52STOp45aMZThcT6dSCPwMVai0BAuxFgssAf33kTR
	930Q==
X-Received: by 2002:a17:90b:5784:b0:38d:ecfe:41aa with SMTP id 98e67ed59e1d1-38e4b5a08aemr2660937a91.43.1784293463088;
        Fri, 17 Jul 2026 06:04:23 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429ff04absm6782635eec.8.2026.07.17.06.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:04:21 -0700 (PDT)
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
Subject: [RFC PATCH v2 05/13] mm/kwatch: add watch expression parser and dereference engine
Date: Fri, 17 Jul 2026 09:04:05 -0400
Message-ID: <20260717130405.1902323-1-wangjinchao600@gmail.com>
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
 mm/kwatch/kwatch.h | 101 ++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)
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
index 000000000000..dbe0fd0e6a0d
--- /dev/null
+++ b/mm/kwatch/kwatch.h
@@ -0,0 +1,101 @@
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
+int kwatch_hwbp_prealloc(u16 max_watch);
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
+unsigned long kwatch_hwbp_arm_ipi_suppressed(void);
+
+int kwatch_tsk_ctx_prealloc(u16 max_concurrency);
+struct kwatch_tsk_ctx *kwatch_tsk_ctx_get(bool can_alloc);
+void kwatch_tsk_ctx_put(void);
+void kwatch_tsk_ctx_release(struct kwatch_tsk_ctx *ctx);
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

