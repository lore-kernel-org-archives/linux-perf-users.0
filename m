Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B42E8B63
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007478; cv=none; b=nPQnpULOVTnzEfvITn5KWFU55AVnmL42k1c1o2GhvV2ukiWenCNrbAa4Awy+7sVk80fWnXqXyDSSLq2B0dh2VoLwXi7M7TqjmNO7XJMeYMR8tJxlZLFvI96rC6Id76Z3UdcY19Qw3a74n1fjMHIQpaIBT3Qr7/FEfpPlR9dK6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007478; c=relaxed/simple;
	bh=fgMlahiCQseGsOMwUDeQip37398eJhQex5YpJdEa4RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkS12sptJdFlymWLZgijx2d1Wp5iTnzbK5iJCPv+0s/XRZ+3pOqsmL+joa/ceGYZJ3xIf9LRntmaX4MBVa92AvlUJII8+eZupi8cwWOwmVihkWvcJAKEOOOXkB4KrENQRzPx/CHk4SpmNMSG7pKUdX8e00iQ2EhL0trQu/1hqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBaI82Mu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBaI82Mu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so944593a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 03:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007475; x=1760612275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zjvk/jwcgtCF9TRiT6Fv94jzQiYOsdOhmjAblUevyNs=;
        b=bBaI82Mu1Gm9EbsCGujOT3z5dNCSgA/zOK/B47EgLJLBiudpscHV4WhPiWoKR5Uc1Q
         ipfyop5GQ1b96oKKrRZWGTGx9lDsWMhEck8YY+PZXAwmlxzv9oCv38ew7+jJST6rcwQN
         o2PXUHQ+ubERxmLQLpbJ7JNRg+s4jWKTmFoHU2+M8eXZUzWGODwNziKOViu53LpXw9Cm
         oDkvt92GQt0NFArjfTAGvaJnIwz+iaw55K0F38Szmt++SR2Iju+lY6aj8Lf9AtnhjkFS
         DLvqEny9j/kemdAU3K2iTaqezOZ93mTxywCRNoVPKYBYl0dC0yl8E1lLDrORsAmdo+3T
         y44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007475; x=1760612275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjvk/jwcgtCF9TRiT6Fv94jzQiYOsdOhmjAblUevyNs=;
        b=vkSPFZ3wfovI87MWZjGYznSkqyqYiJ3dyXEf+wad8Gxczbym4vyIbscmbg9cCUAbY0
         ocltVi48sJjZQg4rJfpJUioBc4rmCdZMQiTP7QDk1xi3uUXHYvEw/6/llntbXgZVmRjs
         VlLL6yFl644430AMkoz0Sh22kxnc6SvGD2oCqMZZiwTdvj2wzhPxG+79PmhGQWgRWv3D
         NROZWbqrQolaGZS8gdnwkGyXGraMqZGecSWx2lPbrXIJwaQWD4IIYfoIFz5YEbMCawJG
         6WY2dAk7+4g/BYFPtTPnvqTm2yPdjAlPx3swjilmf8pFkvuQ5Q3QtZh35X2x1RA0wRCP
         02vg==
X-Forwarded-Encrypted: i=1; AJvYcCVt6dVcuayOW026B7QJx5EVgAhkTXaydmYR4CfC3NZRe4TLBRXSergEKbxmVVUoQunwjxxDMzmE6QtYUwAeisjT@vger.kernel.org
X-Gm-Message-State: AOJu0YxAks6da9pnHShwyknf8W0ESz+duwQn6Wjtl3GnxBPMmdaf3Vhw
	C6dmL7HR9463wpqlYdp5CRby9Ly8s1jeNccXug0SEn9VK8T90Jm1rYFE
X-Gm-Gg: ASbGncsMKWFxx4fxzd5AgxfN7cFvCPxndmKg2jOmuD/WRnlWQh0+RoHdI/XLM5cCcEk
	Ir6faDPCN2Tsig7lUz7+XwBMJpPJLK757oj/3wK5vVrg6vVzJE5HC6bQMSsu4woq7FCTDkok1CY
	w4vi35X7MCBsmkj1GrtknFx5JjxL0xp0d5iMo9sY720UCjvSeNvCeZKRLz1K0uFBsxLeIBX9g1f
	f5nmaCBmAj2Zo3HgMSstgNBXb+3owCoT2FYZWmlY8zwkc+BtWi4visfC4/WLUiP4f2XJLsQa2Bv
	jG5TUUSd/QnWqMIEpcNJZon/jCEKfvC7zAspKp/STIBbAGua5IrdKvk3ooWYS7Y63hL3JbexDo9
	09taPb224qvlnT3Bv2wvfmvupPmNH1U0DKY738OY2gHrSGQjeLXhJnGbNuwjE
X-Google-Smtp-Source: AGHT+IE9NnpcMWupwlw2d16VoEQWRKCqW2Bel2NYXvT1Gf2U7ZL3QTEBs97P3B1zPpdcUzC3SQMjYA==
X-Received: by 2002:a17:903:acb:b0:24b:270e:56cb with SMTP id d9443c01a7336-2902739b362mr90085425ad.27.1760007475016;
        Thu, 09 Oct 2025 03:57:55 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cc53sm25234015ad.46.2025.10.09.03.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:57:54 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v7 12/23] mm/ksw: add entry kprobe and exit fprobe management
Date: Thu,  9 Oct 2025 18:55:48 +0800
Message-ID: <20251009105650.168917-13-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009105650.168917-1-wangjinchao600@gmail.com>
References: <20251009105650.168917-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide ksw_stack_init() and ksw_stack_exit() to manage entry and exit
probes for the target function from ksw_get_config().

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |   4 ++
 mm/kstackwatch/stack.c       | 101 +++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 850fc2b18a9c..4045890e5652 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -35,6 +35,10 @@ struct ksw_config {
 // singleton, only modified in kernel.c
 const struct ksw_config *ksw_get_config(void);
 
+/* stack management */
+int ksw_stack_init(void);
+void ksw_stack_exit(void);
+
 /* watch management */
 struct ksw_watchpoint {
 	struct perf_event *__percpu *event;
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index cec594032515..9f59f41d954c 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1 +1,102 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/fprobe.h>
+#include <linux/kprobes.h>
+#include <linux/kstackwatch_types.h>
+#include <linux/printk.h>
+
+#include "kstackwatch.h"
+
+static struct kprobe entry_probe;
+static struct fprobe exit_probe;
+
+static int ksw_stack_prepare_watch(struct pt_regs *regs,
+				   const struct ksw_config *config,
+				   ulong *watch_addr, u16 *watch_len)
+{
+	/* implement logic will be added in following patches */
+	*watch_addr = 0;
+	*watch_len = 0;
+	return 0;
+}
+
+static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
+				    unsigned long flags)
+{
+	struct ksw_ctx *ctx = &current->ksw_ctx;
+	ulong watch_addr;
+	u16 watch_len;
+	int ret;
+
+	ret = ksw_watch_get(&ctx->wp);
+	if (ret)
+		return;
+
+	ret = ksw_stack_prepare_watch(regs, ksw_get_config(), &watch_addr,
+				      &watch_len);
+	if (ret) {
+		ksw_watch_off(ctx->wp);
+		ctx->wp = NULL;
+		pr_err("failed to prepare watch target: %d\n", ret);
+		return;
+	}
+
+	ret = ksw_watch_on(ctx->wp, watch_addr, watch_len);
+	if (ret) {
+		pr_err("failed to watch on depth:%d addr:0x%lx len:%u %d\n",
+		       ksw_get_config()->depth, watch_addr, watch_len, ret);
+		return;
+	}
+
+}
+
+static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
+				   unsigned long ret_ip,
+				   struct ftrace_regs *regs, void *data)
+{
+	struct ksw_ctx *ctx = &current->ksw_ctx;
+
+
+	if (ctx->wp) {
+		ksw_watch_off(ctx->wp);
+		ctx->wp = NULL;
+		ctx->sp = 0;
+	}
+}
+
+int ksw_stack_init(void)
+{
+	int ret;
+	char *symbuf = NULL;
+
+	memset(&entry_probe, 0, sizeof(entry_probe));
+	entry_probe.symbol_name = ksw_get_config()->func_name;
+	entry_probe.offset = ksw_get_config()->func_offset;
+	entry_probe.post_handler = ksw_stack_entry_handler;
+	ret = register_kprobe(&entry_probe);
+	if (ret) {
+		pr_err("failed to register kprobe ret %d\n", ret);
+		return ret;
+	}
+
+	memset(&exit_probe, 0, sizeof(exit_probe));
+	exit_probe.exit_handler = ksw_stack_exit_handler;
+	symbuf = (char *)ksw_get_config()->func_name;
+
+	ret = register_fprobe_syms(&exit_probe, (const char **)&symbuf, 1);
+	if (ret < 0) {
+		pr_err("failed to register fprobe ret %d\n", ret);
+		unregister_kprobe(&entry_probe);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ksw_stack_exit(void)
+{
+	unregister_fprobe(&exit_probe);
+	unregister_kprobe(&entry_probe);
+}
-- 
2.43.0

