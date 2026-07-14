Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC74156E8
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053900; cv=none; b=MrTi72CFxNIRl3ncwhHIZci52pWxNZV1V7UEuJSEdycNrEpnXt29e3pnUPHab5zCvsozfmLWMlSELNjH+y4bwf4Vjp/G8XVyfL6MxagfVmDm9+bJ/ONXQyY1Pz5qw0qjnPafDuHZ2g5W2Sb0s7rfLJcZHXFkHh6bw8OKtwRP2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053900; c=relaxed/simple;
	bh=OAAD1xnXyhFbGaKlMDMrY7iHeLmxhSqKZFy2RD64VyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLnhjDSG7VTbzfZJd2zy+wYCkyLwfzhNMgX242tFAavNUx+tCxxTscg2vN5Ni29bE0TxOPyy6Hn8qOtuIjV5stubOvzbQLOBv6z/wKsOdjKtg25U0ADXiwON/zi6G4LfgHMdxHWHe+WyTsb4zrG9scKTLobAaVQ/2DKXvY1FDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqL6QUJM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqL6QUJM"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92f03daaa97so252848385a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053898; x=1784658698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gexNtD7XQMYc5ZpBXX88c2pnTg9Mi5LE1qEYRrtsHvs=;
        b=SqL6QUJMJKTccqNHgRN9cLBKaFiqXeB0EegkLpkwwn9vAplf9GLFJSaxKR2YR1hHzj
         oZSdhR4F4hCCPrUhUcSi4gj5VUcj1+RQK47VXVCvUtJycZCfMHqcI9rLoHMA1fKunS4E
         RF+aAibmDQpVRwCSHN4VBzqVMBmm0E9s/Z+5NkPC7q+cZcAvBQ6A2AArW4e3lelA6O0m
         SFzTIi/VIgqB6GuE/DX8S+KyARCnH0IooSluBovU//iS/ixot0A9sbXcgEQm/OyUuTEB
         SaFt7bPBGIi3EycNJtYTpwsFZmG6NngWZ4eBg+K8B0Yqupse/wx/nU2tFuzoswAE30Q7
         mgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053898; x=1784658698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gexNtD7XQMYc5ZpBXX88c2pnTg9Mi5LE1qEYRrtsHvs=;
        b=Q/7QB1EGaUHIw+dAIFz7lBpKoHbkoI5gOXb++X8E1v21qDzZiV6YTEHboK0D4qxbdP
         r/bivz7oqksItZ9SnRI4n2CEgKU+lSnCb9OP5gTOcmFHy3CCSY8Rc43WKYcAur9slunk
         IGBbo37qpAj9tAZM2rGZJWmvZaVca2j4ekHjPMXP1vu8TRFB5om6WB8+BXbT9L+lmi2P
         nVWs72sv+pf46TMlBNC/k88BAoEL+MF7ox8sK8b6ljmh+4qkHNMYx5X/uTjrDaWwK0To
         FiCz4XCx8wxQH2xUkBRZjP+zbWwmurZPrGg1c0mhdmVkJV4OLYf5qMHFwobNUuvp0WNg
         JXEg==
X-Forwarded-Encrypted: i=1; AHgh+Rpvn1CySgRXtKvlyo4RG/ZKrkydDqRVFANFoZkFHr6bTA02e0Nn6gHZvQspKaoG9UCUnxMLWn2ElAHMpu8VLMHb@vger.kernel.org
X-Gm-Message-State: AOJu0YxzTopF7hSYj83a2UB7wwBF6buLkKL3unbhiq3dEjWRfml2h51x
	KaS0iP/EVzUWV4c2h8yeGEtTmLbmdavJ2ynznkdqyh33LZqIQ7DHfbxx
X-Gm-Gg: AfdE7cnYn3yyaTdc9yrxEmQ/PJixLA17p6iZqk1q7eLiR66d8QI6vvWReOONtSJkUzc
	jGEY/JNA6f4OfeMpxQD5n8nGX6LWxA/HRNcyXrraeUkLBQW6Lvu51ZbW/i3mmxrETWKmTAiw84u
	z1hgPYn6PpgMLDbCPncFHqD/iWLMpcEY74MuQz2sb3L4+GZ1nbmDdHy2ok0oC4Elgf4rUVK+YsX
	PI6ipcXJcGoU6Oh/yzzVFDJals8F2nySQwW4YV5O1ZpHmLRL3GPpV4y3GMWrgjJnsVfHz2dh2Qe
	yVryMammDU0DlfIfK7kSUpwWexf4/MgvWB4P7zvpzYytax9U907AuZl7AUNkppAjjKiLupE6xzM
	IzMfswQDP90Aw/Gh8sNzoRVjKL/fPmMbuv8Qw3Rq3vO8siDmFqbPBJ8maX7Gi2xGo7EBq+DgKr1
	BoeK14sOHehiYJP0i10KA7oNoFlCeFsI+MW4iDqhZI42Ll/a3SVp72qRnOzwxMXg==
X-Received: by 2002:a05:620a:40d6:b0:930:927f:f81f with SMTP id af79cd13be357-930927ff9b4mr130636785a.91.1784053897781;
        Tue, 14 Jul 2026 11:31:37 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5bb3542sm1473718285a.20.2026.07.14.11.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:31:37 -0700 (PDT)
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
Subject: [RFC PATCH 06/13] mm/kwatch: add lockless per-task context pool
Date: Wed, 15 Jul 2026 02:31:29 +0800
Message-ID: <20260714183129.12542-1-wangjinchao600@gmail.com>
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
 mm/kwatch/task_ctx.c | 105 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 1 deletion(-)
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
index 000000000000..f8e582f0dcfe
--- /dev/null
+++ b/mm/kwatch/task_ctx.c
@@ -0,0 +1,105 @@
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
+int kwatch_tsk_ctx_prealloc(u16 max_concurrency)
+{
+	if (!max_concurrency)
+		max_concurrency = 256;
+
+	kwatch_ctx_pool_size = roundup_pow_of_two(max_concurrency);
+	kwatch_ctx_pool_mask = kwatch_ctx_pool_size - 1;
+
+	if (unlikely(!kwatch_ctx_pool)) {
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
+void kwatch_tsk_ctx_put(void)
+{
+	struct kwatch_tsk_ctx *ctx = kwatch_tsk_ctx_get(false);
+
+	if (unlikely(!ctx))
+		return;
+
+	kwatch_tsk_ctx_reset(ctx, 0);
+
+	/* Pairs with READ_ONCE() in kwatch_tsk_ctx_get() */
+	smp_store_release(&ctx->task, NULL);
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

