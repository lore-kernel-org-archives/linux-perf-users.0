Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841A2E8DFC
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671953; cv=none; b=pEl4+hSlOiTwEg8wdMX/mLQqJaJNZdgBNZmEAB6R1c/KinjgE9dQlXqIrFpQ6OHUK9CMzbEWrF7UEmyHXT3/Inp/pYS2r4XAGecf+XG/eOzeYaK4gfqCgQPSIcBx52CUhE5mJ7wNhU0Ly8CGAt0XUkyjeqqmgbLhDDXtUj64xes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671953; c=relaxed/simple;
	bh=0LDaB0nCUJks9qfGHQUupDX5ghXvVPG655pHEUpPv0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONk+xPDp03W6uruXMbXYRKOGTjCsWZZtgfOcWQNtPaymn9pTmUq0bbKNLgp+YR8R53SvOYdp4tkvuI/LoJPdlN4/dFY4fBBGf7cFkbHCy2Qg6OtRPutwXzhFRi50QTY/FKMmyykHp4gnSkfiUWKoxHoVqs608SSIUsNf0gm0G8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVqx/HMc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVqx/HMc"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso1114585a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671951; x=1758276751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0CmyIyII1+MjAJi7HJRtv0YVAXaAwAF3MNYXoEmi5A=;
        b=YVqx/HMcx4WSO9i1YtOiiV7Z3RYtwePGk3ADWg3kZQ9pySyLlQhj3snXhTpJEx957w
         srGpnBdxagEBUTvLsPLQJewwbBYn7iWjj4/v0ayowKE2WoalDMmvhyuZdDam2JEsawor
         hk0EutrTk4+v9xlH/63Ub6gGLU2bqMw0qaJwKNuTXWRaoNhkVlCuTnRYVVuN8pqlhIlM
         K3/QMkQpDQ5J8XrQRM7fULzrOm34WCUgmaI6OS9LLYuNSu/8bFMlIW7TGsZyqaiSEjFE
         oVC29mNNaEa+kxkVYn9FuSevElViV1F3l/dHiCnoF+ibYOYYgPWCZ0fWA46ALLAg+isW
         tmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671951; x=1758276751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0CmyIyII1+MjAJi7HJRtv0YVAXaAwAF3MNYXoEmi5A=;
        b=DpRFoV/j7Eu31JW5IAdatHJC2MgcJ5VqSlQr/STmOhGaJLvkiFrQ2ZBPSNHr1N6Pfh
         oKZgAnY+Mjot+xdb/R93oWJsPV4VTKHcVsNB5iDM1KLB0RKgFJMm52Pfv0gDOCjPzFMi
         P0OpLbuC4kqwh4VF+51aZ9/EB94Mz9wScC6Ce6lI54Uz/Wqjf3Bs6l2EOAzZ0L4LLJkM
         LParpTE4m3VBVJzoTjwhyIiUbj1ZrWklLLtcHMRlS99o2PxHVLrR7f5DdMoQfRK1gKPA
         1PDM06vmCEgbEQPwgyLqLr689dLIJlYCBAlpDLZKhXTh8++9oytFPeq0cfq51YxWmV3J
         vi9g==
X-Forwarded-Encrypted: i=1; AJvYcCVjTfBh5qK+74uBxvx9Hz480bjIhuJuhJBd8yBTmh7C75k9/LGkKy89xpJRC/SlVeDVwtTmCkphWB045/NH201s@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Cj/+dt0XK/SgVuacFMWRVTyVktjXA5AaBCu3RblBto/smVKu
	W2tyuHJIClQl5T29m8rJ/VFK7PRLEiyrKwyNdSNXaWnb7GL1k7hMyDp0
X-Gm-Gg: ASbGnctkkhgFrQ/BEzLr5rLolOma7R75HiL/STAnJZoiM7nGiNaPygPV3S5yqNZ+pgc
	/IVTKUu3YPQVa8Vmo8aT410oZFG+QeR4EGjqQF1eQJshdUChqvNla0Mf+ZfH9WftxM2hwBkYYq1
	RMZbq9SCOpgg2QBWV4VyukMui7KhILWPCcXsqIU81pp0VwQx/9Cm/45r5OEGv2shmYnuhU7UGnj
	aHr1p8EBTZIX760tqDKURYTU0upf68BfBzYhMGIiI8U4/5fulIUmDZpmEN/cDqupnSMEbFficzi
	GhkZOLArBvjYstPnSz6RQBNfAe3gTGs3nti8YAWYr9HfsLdAYCBQZsjDideV7Z596lcgMmFn5oC
	NuG5aI73JWVR82q0mC7QuVCGJO7exYw/76F6k/bY=
X-Google-Smtp-Source: AGHT+IF00yk89VG+lmEZt4lMLX0bbsabe7ZkX4XQg7tfyuz6vAWZHryAYuUydwk9sktzZqpEFk926w==
X-Received: by 2002:a17:903:3c2c:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25d26663dcamr29087525ad.29.1757671951122;
        Fri, 12 Sep 2025 03:12:31 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b4f1127sm44400285ad.147.2025.09.12.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:30 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
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
Subject: [PATCH v4 07/21] mm/ksw: add HWBP pre-allocation
Date: Fri, 12 Sep 2025 18:11:17 +0800
Message-ID: <20250912101145.465708-8-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
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

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  4 +++
 mm/kstackwatch/watch.c       | 55 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 277b192f80fa..3ea191370970 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -38,4 +38,8 @@ struct ksw_config {
 // singleton, only modified in kernel.c
 const struct ksw_config *ksw_get_config(void);
 
+/* watch management */
+int ksw_watch_init(void);
+void ksw_watch_exit(void);
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index cec594032515..d3399ac840b2 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1 +1,56 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/printk.h>
+
+#include "kstackwatch.h"
+
+static struct perf_event *__percpu *watch_events;
+
+static unsigned long watch_holder;
+
+static struct perf_event_attr watch_attr;
+
+bool panic_on_catch;
+module_param(panic_on_catch, bool, 0644);
+MODULE_PARM_DESC(panic_on_catch, "panic immediately on corruption catch");
+static void ksw_watch_handler(struct perf_event *bp,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs)
+{
+	pr_err("========== KStackWatch: Caught stack corruption =======\n");
+	pr_err("config %s\n", ksw_get_config()->config_str);
+	dump_stack();
+	pr_err("=================== KStackWatch End ===================\n");
+
+	if (panic_on_catch)
+		panic("Stack corruption detected");
+}
+
+int ksw_watch_init(void)
+{
+	int ret;
+
+	hw_breakpoint_init(&watch_attr);
+	watch_attr.bp_addr = (unsigned long)&watch_holder;
+	watch_attr.bp_len = sizeof(watch_holder);
+	watch_attr.bp_type = HW_BREAKPOINT_W;
+	watch_events = register_wide_hw_breakpoint(&watch_attr,
+						   ksw_watch_handler,
+						   NULL);
+	if (IS_ERR(watch_events)) {
+		ret = PTR_ERR(watch_events);
+		pr_err("failed to register wide hw breakpoint: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ksw_watch_exit(void)
+{
+	unregister_wide_hw_breakpoint(watch_events);
+	watch_events = NULL;
+}
-- 
2.43.0

