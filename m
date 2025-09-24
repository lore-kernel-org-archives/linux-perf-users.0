Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A733301039
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716706; cv=none; b=ldvUl5ViH7j/VProLoQHiuLJeyPgUuT5+9XCfBkEGiKHrIMJ5kkfzn2GyB0FJ8qLhPlq30d7EzPnzyHDTh0ywfqKwZf7DA5jZ9ARCV0lAZn1PJArAX/BTYviXvQ0e3xCi9D02yAZhxiV8SrpmvErPdmOkKWgzXAti1GvWQypHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716706; c=relaxed/simple;
	bh=nvDFxA5+kzzGy254IQd/07joD3bGnycuza2xxZ+JqIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQ59chwqmfLZaEIv3RdWJbELjT55Q3zmhSYpT+O/O5rZwkvHrpQR7umRsGA+RZIttl2lXXIeUPnFPMSwgzV+5kkUm+l5+aoOwmIPerEU6Ec+yN9SSW9Fep/Szdr2+U7XZC06MF/PfVq2A30mHMmi9ltB4bEMnEIFIG4NHlxWQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzUPhSKb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzUPhSKb"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so4350299a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758716704; x=1759321504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NW3rnfkFZjd7Zh69vJKiLybxjQ5f/0P49rVAWgM4UU=;
        b=GzUPhSKbQ1UzFo+PCOInTRZQCVj3Jes6eDa+o1f+NH8MCke+qDTkXS75LfQgcvz0H/
         rB0iQ0vXrQa3uR6/YGrZWtQijW3k1h0JHejITj4jDrTg0YkODhk5q+JV93EYFwpwHujt
         6w/H4CVtRCMJC7tBtjqx8y7XeUI1KVblS6GefW5DSiqVzN1NnpctF/8rtMtW2aqhGLNJ
         vC8XgTWRm9lvP1G8w7+oG8I1tvY4hb4GfmaBj+iCYPcvMAfHsBvZHnCvxM1bXc9bd1iM
         SLN5nvR7ECF4oblI5pABWTqYLaelDLgofZ0VXrZ80IxcNA/dLGYUHpB9iMBnn8mKsrAi
         3MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716704; x=1759321504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NW3rnfkFZjd7Zh69vJKiLybxjQ5f/0P49rVAWgM4UU=;
        b=YA2iITNsEz84hQf76nubWFvdrlLDdvTyDTQKhzU5ybDyCSW3pnAZ9L9sMl11Le+4eG
         5Nhxt3o6cQ1eX2KE06Cyrchvh+brfsTAa/ZnqLmqrW1nD/NgFIGUJkA1+2EdRnhZuvgd
         W94ejBNSk2l3lv0fkXlDkQenQEcC32xC6WDQRDtQyYnXOxUVFerBHs9qXeujZr+/c+Fo
         nXrplzEq8bbTzdVajPqdfvGRjIZlJWehqVZVnv2lLTL12t+d6M3lzYV53gwdfSUiriLe
         0QDgfcO/N2AsQT9pn9uXSh2eRBacidBaGHr77U7jHr2dGL8a0sLA/ivEW0P2t3cqt7Fz
         49/w==
X-Forwarded-Encrypted: i=1; AJvYcCUmyAZwANXyDYoO4v7iJ2sUJW8Z4VQXsLcYlGjmkoQJlSnPWRbJAIauoY7/b1uzauZKpbxEdCrJx9Xn/18g2Dui@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJxm1jZ3p1bAlmRY4MIjFJCsbLxvADI7VexdNXYLJ+yo7D3Qu
	O2+AxiIAOFjcQv44dkX3rHHKEorWGpUkQ6cjeuxkkC7vkGZr8bvUoAFW
X-Gm-Gg: ASbGncu1m2n/k+z/GZ4kMchxsbjQpJwKRm6b7z0uvU7fslWclM/HTQAIIVE6rPbnjiP
	p2GfX4WZBbgNNMs9YYHakwQgl3IGz6gFF8b8pIGkdPyjAf6rYYMHGHPaXsqMnZ7+cL2e9uvfDFg
	cD6l/xvQ+R2Kbt8+GD9bXyCN7GL3MyXjMeJeY+WE5ghf/WbCUJWzOR2X6a/gNUPjUHX12lSchBb
	YC8ZWpgetWEjsRt/ta3dy970EgGy9OLJjcsSQih8woh8k9SZq3rKB0Z7HM//sESPsH76k9QpmBZ
	szf10AcrnUmMkCVyOgxy3qh5Ubx7PuTDIuDPQZAt8QRqfvOpoTERtL26Dqe4u3iCiYYf/p2RMQk
	vQjxDaAhsifoTtQ8az4IJOmvIq1OwZZFcBg==
X-Google-Smtp-Source: AGHT+IEamBzCLObwkiGLLGjo5JGU8d4itd/AyRlsHyvnDLGXoFlCi/QE16Hobk/uQUsVbow0Br5ksA==
X-Received: by 2002:a17:90b:380e:b0:32e:d600:4fdb with SMTP id 98e67ed59e1d1-332a95c804cmr7926585a91.18.1758716702994;
        Wed, 24 Sep 2025 05:25:02 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdd63c1sm2285996a91.26.2025.09.24.05.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:25:02 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH v5 07/23] mm/ksw: add HWBP pre-allocation
Date: Wed, 24 Sep 2025 20:24:40 +0800
Message-ID: <20250924122448.9101-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924115124.194940-1-wangjinchao600@gmail.com>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-allocate per-CPU hardware breakpoints at init with a place holder
address, which will be retargeted dynamically in kprobe handler.
This avoids allocation in atomic context.

At most max_watch breakpoints are allocated (0 means no limit).

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h | 13 +++++
 mm/kstackwatch/watch.c       | 97 ++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 983125d5cf18..4eac1be3b325 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -2,6 +2,9 @@
 #ifndef _KSTACKWATCH_H
 #define _KSTACKWATCH_H
 
+#include <linux/llist.h>
+#include <linux/percpu.h>
+#include <linux/perf_event.h>
 #include <linux/types.h>
 
 #define MAX_CONFIG_STR_LEN 128
@@ -32,4 +35,14 @@ struct ksw_config {
 // singleton, only modified in kernel.c
 const struct ksw_config *ksw_get_config(void);
 
+/* watch management */
+struct ksw_watchpoint {
+	struct perf_event *__percpu *event;
+	struct perf_event_attr attr;
+	struct llist_node node; // for atomic watch_on and off
+	struct list_head list; // for cpu online and offline
+};
+int ksw_watch_init(void);
+void ksw_watch_exit(void);
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index cec594032515..1d8e24fede54 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1 +1,98 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpuhotplug.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/irqflags.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+
+#include "kstackwatch.h"
+
+static LLIST_HEAD(free_wp_list);
+static LIST_HEAD(all_wp_list);
+static DEFINE_MUTEX(all_wp_mutex);
+
+static ulong holder;
+bool panic_on_catch;
+module_param(panic_on_catch, bool, 0644);
+MODULE_PARM_DESC(panic_on_catch, "panic immediately on corruption catch");
+
+static void ksw_watch_handler(struct perf_event *bp,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs)
+{
+	pr_err("========== KStackWatch: Caught stack corruption =======\n");
+	pr_err("config %s\n", ksw_get_config()->user_input);
+	dump_stack();
+	pr_err("=================== KStackWatch End ===================\n");
+
+	if (panic_on_catch)
+		panic("Stack corruption detected");
+}
+
+static int ksw_watch_alloc(void)
+{
+	int max_watch = ksw_get_config()->max_watch;
+	struct ksw_watchpoint *wp;
+	int success = 0;
+	int ret;
+
+	init_llist_head(&free_wp_list);
+
+	//max_watch=0 means at most
+	while (!max_watch || success < max_watch) {
+		wp = kzalloc(sizeof(*wp), GFP_KERNEL);
+		if (!wp)
+			return success > 0 ? success : -EINVAL;
+
+		hw_breakpoint_init(&wp->attr);
+		wp->attr.bp_addr = (ulong)&holder;
+		wp->attr.bp_len = sizeof(ulong);
+		wp->attr.bp_type = HW_BREAKPOINT_W;
+		wp->event = register_wide_hw_breakpoint(&wp->attr,
+							ksw_watch_handler, wp);
+		if (IS_ERR((void *)wp->event)) {
+			ret = PTR_ERR((void *)wp->event);
+			kfree(wp);
+			return success > 0 ? success : ret;
+		}
+		llist_add(&wp->node, &free_wp_list);
+		mutex_lock(&all_wp_mutex);
+		list_add(&wp->list, &all_wp_list);
+		mutex_unlock(&all_wp_mutex);
+		success++;
+	}
+
+	return success;
+}
+
+static void ksw_watch_free(void)
+{
+	struct ksw_watchpoint *wp, *tmp;
+
+	mutex_lock(&all_wp_mutex);
+	list_for_each_entry_safe(wp, tmp, &all_wp_list, list) {
+		list_del(&wp->list);
+		unregister_wide_hw_breakpoint(wp->event);
+		kfree(wp);
+	}
+	mutex_unlock(&all_wp_mutex);
+}
+
+int ksw_watch_init(void)
+{
+	int ret;
+
+	ret = ksw_watch_alloc();
+	if (ret <= 0)
+		return -EBUSY;
+
+
+	return 0;
+}
+
+void ksw_watch_exit(void)
+{
+	ksw_watch_free();
+}
-- 
2.43.0

