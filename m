Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D93FBEBC
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293489; cv=none; b=jwfgsTpkd0qdljJznJRp8TN+VHsDHwB35NbOhlmoLH6FBKQEZczYay552HtyiYff4Cp3yQErUUsBowV7+qu90wOHUQBKY7hAg6VnRjejkT2re2lIWBDJQSDAWQnvY5VhXW2M5Om+GTYE6T0PEokjMew3E5f5dMWytUFi7d9azFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293489; c=relaxed/simple;
	bh=EtJoFWpzZWBdawFoDueuFU6iEwMn2zfmcjtMLM64xIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojvFemzP/ytp3nZ7vtEsz3VN6wzWRkJ7GyOoo7GJqtYPjFeLF1ELZtcbN4c9QzRURyHD8L4KzqbFRK3gicpu/ExlfpAdBxNWRyifPPugFLZPIlJEty8uACbcDPoUhJaBLRoFJ7oAinQaO7xiByo/iXlYcuP6xgw8ULa78NYLPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQBPPhBU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQBPPhBU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so77460325ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293487; x=1784898287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4DcODrlK3jRROVEKQp+XA+e79BwmfTHaetARzpTbTQI=;
        b=HQBPPhBUqwGuBpyqLiWxUXiGJvihqyWKxg6MunhyX4Bg96StAMvwhCahapEjSE/DKO
         zaN6/yuYruwN23I49T5/cyA89FHiba/mfAJ899negpZZZzwmg8ZR+5ldWa3jH1G23Cvh
         7N5ayIxfHwlZmcq3YRqh2Wi/awuqXZMUPXa+y0+5/YzqGxe/LprpxCM5MuVFazlMBFPm
         5Hz8PWKa1NkaXwsEA7AW/M+g3Jin2+gPx+Om7vswC4kKGOoq1zjqzKQEVtVn5QrOmwXx
         aVTqXi8GuT20G46uYtrqgV9owAENAnDWL3sEU6VBBq5BAhRxMz2Wg+XLx1STNAHUjOVi
         8AIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293487; x=1784898287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4DcODrlK3jRROVEKQp+XA+e79BwmfTHaetARzpTbTQI=;
        b=cGYczpcyRdFddcNMPOt0fjgPG+GJHZuRnEe6zh53V7239HnjMPfTNLPDzo3ffyVAHr
         rm+i1A82NJdttBnl5wbPV3UVmVSvzsmjBjd6ytBPBfgF0NbuaMtb2C3LU9yPH5m81VBZ
         bqVkY62q9eLaZv1Xs+kc5jWeggdCBpFjGLSCROfo7oatH7c3M4kB+XOWMPqCjo/mQr0w
         WujbqQfc073RxN9QVBfgGHJxtRg+ZKsVnpN2byjKL/d8uURkUxZ8bmOjrEdssW42WVHq
         gsx1bDW2HXP2Bl5YO/ieili1TNVcAqDVLtWFRCaVuJpxNwW1oxXMeXCYotigoOB6DOTw
         Wglw==
X-Forwarded-Encrypted: i=1; AHgh+RriKgiorUVsnyAuo5IYvuik5MwAjOzfGImKLVtwJrTsbuirE96ej7cU4j6Qg+BKZB4KGrysQL/QoUYOhPXivzt9@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+SO+oRxtz1mmSH9wi8yeT+FurHK623jMTna74DdYvmp25nmf
	0GjCq5FJsgDygG4EYzy6awPImWcZT5EAkv7IOcCFLA4HA8g5QecK/nmU
X-Gm-Gg: AfdE7cme1hPVNnjJo6j7yLYbrLkASpbpNIcoNdSvd+SRMUgmX2mGD/E2SlzuQH+iMLn
	ql6PK4+Ob+azYR3Kzk94irN/O8+w8/wf/UzvLyH73jtubiUs2yBmVYalE3eIpV/DZdi/gM3xSsJ
	bmQ/+xiL9WJd/aiNtvY4m2b8D0y06sZZtEH3DfDykrGgERx0YZsyD6FY5uIv8cA8sUZYtnXOIgS
	l1X+NzgoK6gZ8bIGn4ScMore6jjWKfSnDLoH33JMvTE5dUNPraXZKQtT9J+3VFlkZ8dqPQqiLz0
	Eh5Rc0FAFWFMWhQv0e7zf4N8hoPmUxD14/cIxqIP5ZjYAOv2UX9E9QHlZPiA47/SzdPNVmHgngw
	KEL/akP7HlQlZisFTj8CMsV5SJzKjhn3wV4xnodpS+emGuN1q5wPY601aaKzhdad2957GZU1NFg
	QJYg==
X-Received: by 2002:a17:903:32c3:b0:2cc:670d:9b2f with SMTP id d9443c01a7336-2cf349f4041mr28069715ad.33.1784293487195;
        Fri, 17 Jul 2026 06:04:47 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb7c5sm5234901c88.10.2026.07.17.06.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:04:45 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/13] mm/kwatch: add lockless per-task context pool
Date: Fri, 17 Jul 2026 09:04:30 -0400
Message-ID: <20260717130430.1902527-1-wangjinchao600@gmail.com>
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

A task that enters the watched function needs somewhere to keep its
window state (nesting depth, owned watchpoint, config epoch). The
lookup runs in kprobe and NMI-like contexts, so it must not allocate
or take locks.

Use a preallocated open-addressing array hashed by task_struct
pointer. Slots are claimed with cmpxchg() and released with
smp_store_release(); lookup is a read-only probe sequence. The pool
size (max_concurrency) bounds how many tasks can be inside watch
windows concurrently; excess tasks are simply not tracked.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kwatch/Makefile   |   2 +-
 mm/kwatch/task_ctx.c | 125 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 mm/kwatch/task_ctx.c

diff --git a/mm/kwatch/Makefile b/mm/kwatch/Makefile
index 69c21ae62123..cc6574df0d68 100644
--- a/mm/kwatch/Makefile
+++ b/mm/kwatch/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_KWATCH) += kwatch.o
 
-kwatch-y := deref.o
+kwatch-y := deref.o task_ctx.o
diff --git a/mm/kwatch/task_ctx.c b/mm/kwatch/task_ctx.c
new file mode 100644
index 000000000000..64383a4429e7
--- /dev/null
+++ b/mm/kwatch/task_ctx.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/slab.h>
+#include <linux/hash.h>
+#include <linux/sched.h>
+#include <linux/log2.h>
+#include "kwatch.h"
+
+static u16 kwatch_ctx_pool_size;
+static u16 kwatch_ctx_pool_mask;
+
+static struct kwatch_tsk_ctx *kwatch_ctx_pool;
+
+/* Pool size is a u16 and indexes a power-of-two hash table, so bound the
+ * request away from both the roundup_pow_of_two() u16 overflow (>32768 wraps
+ * to 0) and the degenerate size-1 case (ilog2(1) == 0 breaks hash_ptr()).
+ */
+#define KWATCH_CTX_POOL_MIN	256
+#define KWATCH_CTX_POOL_MAX	32768
+
+int kwatch_tsk_ctx_prealloc(u16 max_concurrency)
+{
+	if (max_concurrency < KWATCH_CTX_POOL_MIN)
+		max_concurrency = KWATCH_CTX_POOL_MIN;
+	else if (max_concurrency > KWATCH_CTX_POOL_MAX)
+		max_concurrency = KWATCH_CTX_POOL_MAX;
+
+	/*
+	 * Set the size/mask only when actually allocating, so they can never
+	 * drift out of sync with the live pool if prealloc is ever called
+	 * again without a matching free.
+	 */
+	if (unlikely(!kwatch_ctx_pool)) {
+		kwatch_ctx_pool_size = roundup_pow_of_two(max_concurrency);
+		kwatch_ctx_pool_mask = kwatch_ctx_pool_size - 1;
+
+		kwatch_ctx_pool = kcalloc(kwatch_ctx_pool_size,
+					  sizeof(struct kwatch_tsk_ctx),
+					  GFP_KERNEL);
+		if (!kwatch_ctx_pool)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+struct kwatch_tsk_ctx *kwatch_tsk_ctx_get(bool can_alloc)
+{
+	int start_idx, i, idx;
+	struct task_struct *t;
+
+	if (unlikely(!kwatch_ctx_pool))
+		return NULL;
+
+	start_idx = hash_ptr(current, ilog2(kwatch_ctx_pool_size));
+
+	for (i = 0; i < kwatch_ctx_pool_size; i++) {
+		idx = (start_idx + i) & kwatch_ctx_pool_mask;
+		t = READ_ONCE(kwatch_ctx_pool[idx].task);
+		if (t == current)
+			return &kwatch_ctx_pool[idx];
+	}
+
+	if (!can_alloc)
+		return NULL;
+
+	for (i = 0; i < kwatch_ctx_pool_size; i++) {
+		idx = (start_idx + i) & kwatch_ctx_pool_mask;
+		t = READ_ONCE(kwatch_ctx_pool[idx].task);
+		if (!t) {
+			if (!cmpxchg(&kwatch_ctx_pool[idx].task, NULL, current))
+				return &kwatch_ctx_pool[idx];
+		}
+	}
+
+	return NULL;
+}
+
+void kwatch_tsk_ctx_reset(struct kwatch_tsk_ctx *ctx, u32 new_epoch)
+{
+	struct kwatch_watchpoint *wp = xchg(&ctx->wp, NULL);
+
+	if (wp)
+		kwatch_hwbp_put(wp);
+	ctx->depth = 0;
+	ctx->epoch = new_epoch;
+}
+
+/* Release a slot we hold a pointer to: disarm its wp and free the slot. */
+void kwatch_tsk_ctx_release(struct kwatch_tsk_ctx *ctx)
+{
+	kwatch_tsk_ctx_reset(ctx, 0);
+
+	/* Pairs with READ_ONCE() in kwatch_tsk_ctx_get() */
+	smp_store_release(&ctx->task, NULL);
+}
+
+void kwatch_tsk_ctx_put(void)
+{
+	struct kwatch_tsk_ctx *ctx = kwatch_tsk_ctx_get(false);
+
+	if (unlikely(!ctx))
+		return;
+
+	kwatch_tsk_ctx_release(ctx);
+}
+
+void kwatch_tsk_ctx_release_wps(void)
+{
+	int i;
+
+	if (!kwatch_ctx_pool)
+		return;
+
+	for (i = 0; i < kwatch_ctx_pool_size; i++) {
+		struct kwatch_watchpoint *wp = xchg(&kwatch_ctx_pool[i].wp,
+						    NULL);
+		if (wp)
+			kwatch_hwbp_put(wp);
+	}
+}
+
+void kwatch_tsk_ctx_free(void)
+{
+	kfree(kwatch_ctx_pool);
+	kwatch_ctx_pool = NULL;
+}
-- 
2.53.0

