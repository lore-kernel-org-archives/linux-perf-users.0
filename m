Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145E43CECA
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053967; cv=none; b=OE4worwl3AfZCRLA1sXFVOV2ebVgjzRmHxR5l+sBKYN8R/Ex3BcY+rId1QAn2ESmjRClNAWFpMNr7PlryVzhfNErzcHOHtJeb0GbbXx+iqVId8f02ZZWJocCtVxmUeujK9U1ooVO+ahnGPenHXvbasKlwFVGyv1e7sKF2jey+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053967; c=relaxed/simple;
	bh=U8Z0nvRnaFFrw3lPHvPCl/wITya9sSFlUIbcZxe00bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/oEgSah6EdKtFTBHI6BPWiIYgJKoTtAV8sPeLK+NHHfelIJon5LNLlBO3XSx70rSOU9lukN6K2LTNDM6SmIn0/olU/amP3MqLVNxfdo9+zXn5WsegIyaBXfIUcWCND4BKNzowTpxzNR8Hw6yPFpSHCj3p0UqdUtI9e/JB57KpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6FYtvg9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6FYtvg9"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-920f33347f5so317191585a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053965; x=1784658765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JG+YXpLaf6eTeKDHjsfPWQsS8e418Ifa944UVLgQD7U=;
        b=l6FYtvg9K7qTr9PRUV9BLwvHtUGDx48DgF7q5vOQqGr0YH7Q14H5Kodm8HCyVugJl3
         4e+LaK37kdjGNqYiLjxI8ECiu+ZUIFV0y0OP+KCadlKsdUD40QRV1F6EeGK71rxxB5HE
         BUizXm9wvsLq+Wa50677s7e+fg3UlcEWyk8iJndeZjadc296WmkqBbR67JvWsrZXiGbb
         gmzwKwE3hFBVJkXwLD1XCai9/+ias7Ge1D/ANkcEDMOqA5uF8Z1gDpqwcFrRU9E8HVnc
         hRWSXYsBdAxnn0YTl1OxnKe7zoWHg5nc/piaWsjXS0dROWE2pruHRC+VwUdqGRfxA9gs
         qokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053965; x=1784658765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JG+YXpLaf6eTeKDHjsfPWQsS8e418Ifa944UVLgQD7U=;
        b=Cr5S4Nli+iN6fGnmePMumBM8aXA6YCsdHlUQ6m1GihnLhBn53T6ZSU9Zd+/O61gHL6
         kR5ylVleLWEVIr3DZJUnCxLvrnXpgUnWmnNrojKBoTindBPGv6VfwbOrk6PJ5hjBqrTN
         XV2Z+UBxB+O0rksS1SRaeNCmQf/4zkB8tODThyYWPDIUqloQ1Kv09OBls08DrUmpYjPu
         jo6H+zA2t7eb96XtSeYc2+vYaps0Ib06YZxfCHEf3BsYKEOJjsfuRsr+NkpUMe0br6TG
         l9xLjc/jCP+REhfIL7F0pLQNz0dAoz9DMFETuboaSLbu0tiCId+VuxvfbFtLUSZ5Yrs6
         NeoA==
X-Forwarded-Encrypted: i=1; AHgh+Rpu73yhqm/+q1c2hN/hJZjxnyO2K89yo59Z6G82D79Dk5z5Oxq4+RefwDin/z5L51WRgo1rPxrquiKzOvzOynAH@vger.kernel.org
X-Gm-Message-State: AOJu0YxMyjrK8Slh53sNzn2W14Z0tN8nkND+WUKEktZDBQTkfkMZXBoz
	oWFYlYSX4NQ0Zw9H4SG4S/CF86QLg1P+hgMfgyMGH5p7tfH2VUq3BCMd
X-Gm-Gg: AfdE7cnVJFyUkL1otIef87v2SWgGjgqFjdRp0unnGJP9zDEkIV9Wvtw0Jo8OEfegexn
	mihvNnxCAeWmYHO2nQuU3nuD2Mrz2X7ctwSoVSmeHVMQr38C+Y+8KGhRIt8lcbUBRyvq0rBY+4S
	pUfWUVdShGATEN67Fey4Wo8p29v8TdSMWC6GgCEANA0CfMmzSXOFeNJFfHdpNgihudh6jivwptO
	uvGRidGYDtJHB67s+Yzhm5PC6+xa7A0ZNISstNNHZM5xQbUR7yg/HM8x/ReneUOTBbtAV7RGLNn
	GNL0Rw2woHK0gkdpuOH6U6Fmsq/AVLBeReJbJvs0mvPGDfcVYxbRucEhsSltgxutxww8rUket9g
	4aD/nejQulkSXOpydPwkCjxg7GFEcmci3KJrI6f6a54+K4SSsdCfOqJnGvKAAEG+k1MhxmHDzJ3
	UB4+qC/HtJ97upvr3Ih11Urav92i4VZxYjsK3i+us7Ohxr1NG5HCM=
X-Received: by 2002:a05:620a:4012:b0:92e:d63b:455b with SMTP id af79cd13be357-92ef2b12452mr1436818585a.6.1784053964792;
        Tue, 14 Jul 2026 11:32:44 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b88a38sm1484900685a.12.2026.07.14.11.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:32:44 -0700 (PDT)
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
Subject: [RFC PATCH 09/13] mm/kwatch: add probe lifecycle runtime
Date: Wed, 15 Jul 2026 02:32:26 +0800
Message-ID: <20260714183226.12756-1-wangjinchao600@gmail.com>
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

Open and close the watch window with a kretprobe on the target
function: the entry handler tracks per-task nesting depth and, when
the configured depth is reached, resolves the watch expression and
arms a watchpoint; the exit handler disarms it. An optional kprobe
at func_offset arms mid-function instead of at entry.

Functions running in a real NMI(-like) context are rejected once, at
function entry, by comparing the NMI nesting count against the one
NMI-like layer that int3-based kprobe delivery itself adds; a
companion kprobe with a post_handler pins the probe point so jump
optimization cannot change the delivery mechanism after it is
sampled. Rejections are counted and exposed to the control plane.

A global epoch versioning scheme invalidates stale per-task state
across reconfigurations, and a per-CPU mute flag keeps window
management quiet while a CPU rewrites its own debug registers.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kwatch/Makefile |   2 +-
 mm/kwatch/probe.c  | 263 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 mm/kwatch/probe.c

diff --git a/mm/kwatch/Makefile b/mm/kwatch/Makefile
index b2bc3003c89b..f04673cc5b1c 100644
--- a/mm/kwatch/Makefile
+++ b/mm/kwatch/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_KWATCH) += kwatch.o
 
-kwatch-y := deref.o task_ctx.o hwbp.o
+kwatch-y := deref.o task_ctx.o hwbp.o probe.o
diff --git a/mm/kwatch/probe.c b/mm/kwatch/probe.c
new file mode 100644
index 000000000000..af6e0af45c10
--- /dev/null
+++ b/mm/kwatch/probe.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/atomic.h>
+#include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
+#include <linux/sched.h>
+
+#include "kwatch.h"
+#define TRAMPOLINE_CHECK_DEPTH 16
+static DEFINE_PER_CPU(bool, kwatch_probe_cpu_muted);
+
+struct kwatch_probe_ctx {
+	struct kprobe kp;
+	struct kretprobe rp;
+	struct kprobe pin_kp;
+	const struct kwatch_config *cfg;
+	bool rp_via_int3;
+
+	u32 epoch;
+};
+
+static struct kwatch_probe_ctx kwatch_probe_ctx;
+static atomic_long_t kwatch_nmi_rejected;
+
+unsigned long kwatch_probe_nmi_rejected(void)
+{
+	return atomic_long_read(&kwatch_nmi_rejected);
+}
+
+/*
+ * True if the probed function itself runs in an NMI-like context.
+ * int3-based kprobe delivery adds one NMI-like layer of its own;
+ * delivery is pinned at registration so the subtraction stays exact.
+ */
+static bool kwatch_probed_ctx_in_nmi(bool via_int3)
+{
+	return (preempt_count() & NMI_MASK) > (via_int3 ? NMI_OFFSET : 0);
+}
+
+static void kwatch_pin_post_handler(struct kprobe *p, struct pt_regs *regs,
+				    unsigned long flags)
+{
+	/* a post_handler pins the probepoint: no jump optimization */
+}
+
+bool kwatch_probe_validate_hit(struct pt_regs *regs,
+			       struct task_struct *arm_tsk)
+{
+	struct kwatch_tsk_ctx *ctx = kwatch_tsk_ctx_get(false);
+
+	if (unlikely(!ctx))
+		return true;
+
+	if (arm_tsk != current ||
+	    ctx->depth != kwatch_probe_ctx.cfg->depth + 1)
+		return true;
+
+	return false;
+}
+
+void kwatch_probe_mute(bool mute)
+{
+	__this_cpu_write(kwatch_probe_cpu_muted, mute);
+}
+
+static inline bool kwatch_probe_is_muted(void)
+{
+	return __this_cpu_read(kwatch_probe_cpu_muted);
+}
+
+enum kwatch_probe_position {
+	KWATCH_PROBE_POSITION_ENTRY,
+	KWATCH_PROBE_POSITION_ACTIVE,
+	KWATCH_PROBE_POSITION_EXIT
+};
+
+static bool kwatch_tsk_ctx_check(enum kwatch_probe_position pos)
+{
+	struct kwatch_tsk_ctx *ctx = kwatch_tsk_ctx_get(true);
+	u32 epoch;
+
+	if (unlikely(!ctx))
+		return false;
+
+	/* Pairs with smp_store_release() in kwatch_probe_start/stop() */
+	epoch = smp_load_acquire(&kwatch_probe_ctx.epoch);
+
+	if (unlikely(ctx->epoch != epoch))
+		kwatch_tsk_ctx_reset(ctx, epoch);
+
+	if (unlikely(!epoch))
+		return false;
+
+	switch (pos) {
+	case KWATCH_PROBE_POSITION_ENTRY:
+		ctx->depth++;
+		return true;
+	case KWATCH_PROBE_POSITION_ACTIVE:
+		return true;
+	case KWATCH_PROBE_POSITION_EXIT:
+		if (unlikely(ctx->depth == 0)) {
+			kwatch_tsk_ctx_put();
+			return false;
+		}
+
+		ctx->depth--;
+		if (ctx->depth == 0) {
+			kwatch_tsk_ctx_put();
+			return false;
+		}
+		return true;
+	}
+	return false;
+}
+
+static int kwatch_activate_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kwatch_tsk_ctx *ctx = kwatch_tsk_ctx_get(false);
+	unsigned long watch_addr;
+	u16 watch_len;
+
+	if (unlikely(!ctx))
+		return 0;
+
+	if (unlikely(kwatch_probe_is_muted()))
+		return 0;
+
+	if (unlikely(!kwatch_tsk_ctx_check(KWATCH_PROBE_POSITION_ACTIVE)))
+		return 0;
+
+	if (ctx->depth != kwatch_probe_ctx.cfg->depth + 1 || ctx->wp)
+		return 0;
+
+	if (kwatch_deref_resolve(kwatch_probe_ctx.cfg, regs, &watch_addr,
+				 &watch_len))
+		return 0;
+
+	if (kwatch_hwbp_get(&ctx->wp))
+		return 0;
+
+	kwatch_hwbp_arm(ctx->wp, watch_addr, watch_len);
+	return 0;
+}
+
+static int kwatch_lifecycle_entry(struct kretprobe_instance *ri,
+				  struct pt_regs *regs)
+{
+	/*
+	 * Single policy point: the target function's context is judged once
+	 * here. A rejected invocation never increments depth, so the offset
+	 * kprobe path inherits the verdict through the depth check.
+	 */
+	if (unlikely(kwatch_probed_ctx_in_nmi(kwatch_probe_ctx.rp_via_int3))) {
+		atomic_long_inc(&kwatch_nmi_rejected);
+		return 1; /* NMI context is unsupported: no window, no return hook */
+	}
+
+	if (!kwatch_tsk_ctx_check(KWATCH_PROBE_POSITION_ENTRY))
+		return 0;
+
+	if (kwatch_probe_ctx.cfg->func_offset == 0)
+		kwatch_activate_handler(NULL, regs);
+
+	return 0;
+}
+
+static int kwatch_lifecycle_exit(struct kretprobe_instance *ri,
+				 struct pt_regs *regs)
+{
+	struct kwatch_tsk_ctx *ctx = kwatch_tsk_ctx_get(false);
+
+	if (unlikely(!ctx))
+		return 0;
+
+	if (!kwatch_tsk_ctx_check(KWATCH_PROBE_POSITION_EXIT))
+		return 0;
+
+	if (ctx->depth == kwatch_probe_ctx.cfg->depth) {
+		struct kwatch_watchpoint *wp = xchg(&ctx->wp, NULL);
+
+		if (wp)
+			kwatch_hwbp_put(wp);
+	}
+
+	return 0;
+}
+
+int kwatch_probe_start(struct kwatch_config *cfg)
+{
+	static u32 next_epoch;
+	u32 current_epoch;
+	int ret;
+
+	/*
+	 * Lockless check to prevent concurrent starts. Strictly serialized
+	 * by the control plane mutex, but serves as a sanity check.
+	 */
+	if (smp_load_acquire(&kwatch_probe_ctx.epoch) != 0)
+		return -EBUSY;
+
+	memset(&kwatch_probe_ctx, 0, sizeof(kwatch_probe_ctx));
+	kwatch_probe_ctx.cfg = cfg;
+
+	/*
+	 * Pin the entry probepoint before the kretprobe registers, so its
+	 * delivery (int3 vs ftrace) can never change under jump optimization.
+	 * register_kretprobe() clears kp.post_handler, hence the companion.
+	 */
+	kwatch_probe_ctx.pin_kp.symbol_name = cfg->func_name;
+	kwatch_probe_ctx.pin_kp.post_handler = kwatch_pin_post_handler;
+	ret = register_kprobe(&kwatch_probe_ctx.pin_kp);
+	if (ret < 0)
+		return ret;
+
+	kwatch_probe_ctx.rp.entry_handler = kwatch_lifecycle_entry;
+	kwatch_probe_ctx.rp.handler = kwatch_lifecycle_exit;
+	kwatch_probe_ctx.rp.kp.symbol_name = cfg->func_name;
+
+	ret = register_kretprobe(&kwatch_probe_ctx.rp);
+	if (ret < 0) {
+		unregister_kprobe(&kwatch_probe_ctx.pin_kp);
+		return ret;
+	}
+	kwatch_probe_ctx.rp_via_int3 = !kprobe_ftrace(&kwatch_probe_ctx.rp.kp);
+
+	if (cfg->func_offset) {
+		kwatch_probe_ctx.kp.symbol_name = cfg->func_name;
+		kwatch_probe_ctx.kp.offset = cfg->func_offset;
+		kwatch_probe_ctx.kp.pre_handler = kwatch_activate_handler;
+
+		ret = register_kprobe(&kwatch_probe_ctx.kp);
+		if (ret) {
+			unregister_kretprobe(&kwatch_probe_ctx.rp);
+			unregister_kprobe(&kwatch_probe_ctx.pin_kp);
+			return ret;
+		}
+	}
+
+	current_epoch = ++next_epoch;
+	if (unlikely(!current_epoch))
+		current_epoch = ++next_epoch;
+
+	/* Pairs with smp_load_acquire() in kwatch_tsk_ctx_check() */
+	smp_store_release(&kwatch_probe_ctx.epoch, current_epoch);
+
+	return 0;
+}
+
+void kwatch_probe_stop(void)
+{
+	if (!kwatch_probe_ctx.epoch)
+		return;
+
+	/* Pairs with smp_load_acquire() in kwatch_tsk_ctx_check() */
+	smp_store_release(&kwatch_probe_ctx.epoch, 0);
+
+	if (kwatch_probe_ctx.cfg->func_offset > 0)
+		unregister_kprobe(&kwatch_probe_ctx.kp);
+
+	unregister_kretprobe(&kwatch_probe_ctx.rp);
+	unregister_kprobe(&kwatch_probe_ctx.pin_kp);
+}
-- 
2.53.0

