Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71DA23B632
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200326; cv=none; b=uAh9p2SIZkex3wdgjTWlJme0MCi8WJjjFsZEs18YLBOd3X734ok8La7Ipsqma9u6lNKi4boalTdUphgsqkVXYqqt8njSfa0UbMVwenJgTgJw9A6z+8RzXsiy7AMeTONahfxrCiexS4Pz98/ndfg8LMdgSC48SJKM6Dgt61pQ5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200326; c=relaxed/simple;
	bh=fgMlahiCQseGsOMwUDeQip37398eJhQex5YpJdEa4RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5j+hcNDirHvJVmjgdV/ujqWFTssuGfO7iJDWaPk4OvQk9IWVSSnbvtqkuJBEGVj30Vx/JO+FKCvevuO8O8GbtsCiLRBVO+V6taSaCWL/WSQqu7vrYSy+rTtKbiDets1V06RjUH6uEl4EI50VTSU4YBLqRfMQzZevl7PCjMtoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No9OfCZX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No9OfCZX"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4214213a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200324; x=1759805124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zjvk/jwcgtCF9TRiT6Fv94jzQiYOsdOhmjAblUevyNs=;
        b=No9OfCZX9owieXBcRX+B6gSVclHzBzJQOdWfoZW1dw/BKdM/Q0KQAv2vYG6qhtGT3Q
         UiJVzXVzY2mfNRCQoaG6UyHtAI393lh8+dW8+9xeMJ/Vka4UQVCsIE24O4q06u5zhIB/
         VIj6CvpUhfWZIkmqbsoAJ+tp5Hz3iF+Q3E722TWAiEEhUZd23IUBRHyTR/FhvioOgjHL
         YOOIJ6rZmPCltya7R4+Ze4T0vUJ+E/GxezdjyH1OUkysJewfOmNJ6QniD78dJmVe44Jr
         i2FL0Whnb4tJs/85PK1fO5guI59deBBBqW7dQeheMT4R3CFSlcmfV6df+ah7q5Eua5Uy
         wshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200324; x=1759805124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjvk/jwcgtCF9TRiT6Fv94jzQiYOsdOhmjAblUevyNs=;
        b=WMhf/wK+D3lM19iX3CqTCWfWvS0eB45ZhRuMuYlcWCC1pgymOV1tk1StuASJbApiVE
         1yFM3gtAfhaUGu0JWNNKE74cEtpgwyHg6N0rx20TQWC2JEO6vcxGVqNCzhqjgPEYiRci
         XgBvtSuuopNoDtJBZQs00SjanGEYr0YG4v2qbsStDgjKXV32l73REB6l5etfehEJiUaY
         XgcqPOsIfHAmTg0bjTFaIcqsc3SGOapR9PUEazawPY3jn6V/TfNbAGgOEJuFrcWAELCA
         P0lv1Sp2ly6Db3CQczmWTeRzu7gvtWfIA48o0nTwXktiduAvMJgnPhjdSKoTF5VJvEwu
         8Dpw==
X-Forwarded-Encrypted: i=1; AJvYcCVY3yyrQXDyN7ieyR/evo85EnG6bz//EHFFsnVfsu6KZGR6yAx4ksUtC++8Gm5CAQ6bro+m06028auN12Z0cG3f@vger.kernel.org
X-Gm-Message-State: AOJu0Yz58mXLppoXM+DGKObzcvJr+jF3Wc+zSlHLRWNG8KgukcO7UPkG
	LF/7BlEoiVySphxiOz4DWKlZAvz9bGINrnlv6VLjENcQLZHHPhQ0tZLQ
X-Gm-Gg: ASbGncsX+TeAfWzBVwO7bay3WwCny5lkYNyOZswl5FiFQZY9Z65RCVx4klFCX1z4vp4
	vo6w/2f0jinpCp5DU8NqULfQ3siQk7e0JabmZHYpmT42qz0sqSNay0nSlEBR48nDYe+HxWIXr2f
	h+V4XC1JmSgiVUx/pXrDTKCr4/iiWhR1H6Rd3y2Zkn/kVhB4cFzL49iwOglFQA+x8bTtX7Hf3Yj
	sqq6uirsULuQfYrbVpmtGGtKGBKI1bWYp/q9n+6H7BzkqF2xmFFViT+qTMlDu1rIslJ5NJbbd/O
	vMHzfstBY0bkjuMKlhI0Pm6cW/3UaczFhddTfcY2/ys3VNY6vEcUq6Jy8TiNgcaQ+EWqETbpFEX
	9tXPqlIEm2MR6BqHFTEPF+9KVsQ7LqVn5yONYFPN9VCd4g6eXhfUcZSNTpruyFHfV3Kg+ua4zHd
	j8
X-Google-Smtp-Source: AGHT+IFfp8YXgNuQukwwqsnxDRX708PqLBqQKd9UC8iSffGPe0+X00XIAI7NxbzgZKbYcTueKMe0YQ==
X-Received: by 2002:a17:903:3bc5:b0:27d:6777:2833 with SMTP id d9443c01a7336-27ed4a986c5mr179688865ad.47.1759200323854;
        Mon, 29 Sep 2025 19:45:23 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821d3sm145446045ad.83.2025.09.29.19.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:23 -0700 (PDT)
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
Subject: [PATCH v6 12/23] mm/ksw: add entry kprobe and exit fprobe management
Date: Tue, 30 Sep 2025 10:43:33 +0800
Message-ID: <20250930024402.1043776-13-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
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

