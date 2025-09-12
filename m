Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233B2E975F
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671958; cv=none; b=j4F68FRlCUtMI5OeXgl4SSh45/fMvMyUjVEbTkHCqPxElgte2fOmVgr2kZc5/4h2DNsATellK3hoMGVoluyjIj74ePnKq8TrQVGOZJ/t2bOZbMhMNC26R7aHqTYwB3CIJPx0dP++Wh3m8OpSJZ3S6Uf359I1gjoGiZiPIrwnaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671958; c=relaxed/simple;
	bh=i3v51fD9Nx/GpVeSYWAguecpXuWplCvYwMF4XBy55cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQyjTLOPLZ47BaWgp+U3/qCMNYEuU25c8LzIiumMZtyyuF9iNFfRv2XFE7Cc4DDLqHB/P5rvTBPrBQkrKhArQHBWelW2IcZDXApBRxP3WXLql3ejHFzljqrJ8rKI/kqg++W2c4/XztYPCv6Nx0P1uAyLsYuLHK0Po8a/6c034FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f537tpMF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f537tpMF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772843b6057so1578292b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671956; x=1758276756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBWUZGT7AQZjVN5sSaCPPhxiXndvcDbF8VJhhLu7a/o=;
        b=f537tpMFxL2Og7DF38NwCJ8buJf5RfMmKnhZtyQaKdYzjGhU0+RGIqV32N8L1jVHAW
         Y0ifJr6BiXERBCcxD7B1i7BsYT+rCr5772+pYy3xACl1PoeySygsa/0Qq8cC+YsC8SAT
         +PU2YQcnCWfahmStOWiXrhyq9D538m/KmeUmvLLNv+sbl33kXVRMwxYDryMGnwCoj6pW
         x2RQ7xKFb3fTxhBhZXXwBf3iCciOMTB2Ze5dNKUneeZi3ChtMB3IhDA+ivpH7iS2HPrW
         q6VUwoxb787SGW5T5c8PikfwwzsgGQWpq5IRztLdIW8nIssa/fMp7Tqbl1aiA8gfzXsd
         /heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671956; x=1758276756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBWUZGT7AQZjVN5sSaCPPhxiXndvcDbF8VJhhLu7a/o=;
        b=nQ4BGiCe0aBPczmyGI+DMijxxJJaYmI4akDUPHJm4vmy+PRKY7VrNdxZUD580pSJ+c
         Uv44E8HzhZx3emuN0L6EjYXie3h0v2F3+EbZ4QqFha/NZzRjsLGnwZn4xWKCEeZvRZoC
         tvo8bsLbY2kZ526NR4zBRTUVAWjx4S2gLhAMsgoGRohWOX2tIJKh/YJWEXOWVmxnrE8k
         Lt+XZwXTUaffseSNoVWdZAtPW3xLWk+runtYHANyVgzZLLnsNOBMF/yB1JlEypTnY7sP
         Ubz9L/wQmuFxlkYava4VqEkj15nsGRhL0jGRNqonTtzZZyEziCwULnME8ylPWQtuGkRJ
         ffHw==
X-Forwarded-Encrypted: i=1; AJvYcCVDUYcWUtzxtwnA9DZT6+kAzAbjuSmJyquj4UX9uuGXVBmDBmvZgq/JdSpPArOSrv9pao+WZYr6lNFKgi5PTQFh@vger.kernel.org
X-Gm-Message-State: AOJu0YyqL0UWdYxGMcZvQhBG1brifQs4YTkUnn4t5cWVcPhz31jannr7
	5B8munMI+dGb0noE0rirOt1Ea//TlhmtqW8xAvKDoo2PjcMvWU9qH/b5
X-Gm-Gg: ASbGncsrWlCNOSayPZudcsmGwCRL7LZ2PQADhIXL/VN8BpsLZ3xaRs+ZNQlXOTAFGTj
	bcfzwXnURMmynE6W8X3veQQO6vTB9TDkPtAsH71LsLmwENb7c3iW3M4IDrLADI/KxgqV7hgJMWe
	RqUDhwSkZi9OpYPJyLUta/uZmmAiZWaNnJvikJ1hxbYMt94KLgkzWbdOVgOFL6U3HpqrJYcdS5w
	Oa6OYpUn34UeeK8eSO6INmSJ82+997TDIhMGW2P9IFW8+CKhQIuQb3XfvXmBiD1XN9hLJyQvXhr
	f6KiWVr/c0g9xfjmE8+24bKgm2HW0fOgdiZEgkTKup1BoiufPAR0Hmx32gjFZwlOpROod/PpHzt
	bBjpM1Ghc7x+9vksmy/H1h9fx7Sbr4H1UlxH6z3uNzvFacmrpQg==
X-Google-Smtp-Source: AGHT+IE0smHKx/fxxESUMD26AxoS7YeR+pzOUZ9t8bbqYrL6zePDghHY9Bjvt2Dlrnb+iBu56FBUDg==
X-Received: by 2002:a17:903:3c4d:b0:24c:cc2c:9da9 with SMTP id d9443c01a7336-25d24bb3201mr28288785ad.14.1757671956234;
        Fri, 12 Sep 2025 03:12:36 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b307073sm44099805ad.144.2025.09.12.03.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:35 -0700 (PDT)
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
Subject: [PATCH v4 08/21] mm/ksw: Add atomic ksw_watch_on() and ksw_watch_off()
Date: Fri, 12 Sep 2025 18:11:18 +0800
Message-ID: <20250912101145.465708-9-wangjinchao600@gmail.com>
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

The atomic_long_cmpxchg() ensures at most one active watchpoint exists at
any time, with ksw_watch_on() succeeding only when no watch is active
(current address is placeholder) and ksw_watch_off() succeeding only when
the caller knows the active watch address.

For cross-CPU synchronization, updates are propagated using direct
modification on the local CPU and asynchronous IPIs for remote CPUs.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 +
 mm/kstackwatch/watch.c       | 73 +++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 3ea191370970..0786fa961011 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -41,5 +41,7 @@ const struct ksw_config *ksw_get_config(void);
 /* watch management */
 int ksw_watch_init(void);
 void ksw_watch_exit(void);
+int ksw_watch_on(ulong watch_addr, u16 watch_len);
+int ksw_watch_off(ulong watch_addr, u16 watch_len);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index d3399ac840b2..14549e02faf1 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/hw_breakpoint.h>
+#include <linux/irqflags.h>
 #include <linux/perf_event.h>
 #include <linux/printk.h>
 
@@ -9,10 +10,16 @@
 
 static struct perf_event *__percpu *watch_events;
 
-static unsigned long watch_holder;
+static ulong watch_holder;
+static atomic_long_t watched_addr = ATOMIC_LONG_INIT((ulong)&watch_holder);
 
 static struct perf_event_attr watch_attr;
 
+static void ksw_watch_on_local_cpu(void *info);
+
+static DEFINE_PER_CPU(call_single_data_t,
+		      watch_csd) = CSD_INIT(ksw_watch_on_local_cpu, NULL);
+
 bool panic_on_catch;
 module_param(panic_on_catch, bool, 0644);
 MODULE_PARM_DESC(panic_on_catch, "panic immediately on corruption catch");
@@ -29,6 +36,70 @@ static void ksw_watch_handler(struct perf_event *bp,
 		panic("Stack corruption detected");
 }
 
+static void ksw_watch_on_local_cpu(void *data)
+{
+	struct perf_event *bp;
+	ulong flags;
+	int cpu;
+	int ret;
+
+	local_irq_save(flags);
+	cpu = raw_smp_processor_id();
+	bp = *per_cpu_ptr(watch_events, cpu);
+	if (!bp) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	ret = modify_wide_hw_breakpoint_local(bp, &watch_attr);
+	local_irq_restore(flags);
+
+	if (ret) {
+		pr_err("failed to reinstall HWBP on CPU %d ret %d\n", cpu,
+		       ret);
+		return;
+	}
+}
+
+static void __ksw_watch_target(ulong addr, u16 len)
+{
+	int cpu;
+	call_single_data_t *csd;
+
+	watch_attr.bp_addr = addr;
+	watch_attr.bp_len = len;
+
+	/* ensure watchpoint update is visible to other CPUs before IPI */
+	smp_wmb();
+
+	for_each_online_cpu(cpu) {
+		if (cpu == raw_smp_processor_id()) {
+			ksw_watch_on_local_cpu(NULL);
+		} else {
+			csd = &per_cpu(watch_csd, cpu);
+			smp_call_function_single_async(cpu, csd);
+		}
+	}
+}
+
+static int ksw_watch_target(ulong old_addr, ulong new_addr, u16 watch_len)
+{
+	if (atomic_long_cmpxchg(&watched_addr, old_addr, new_addr) != old_addr)
+		return -EINVAL;
+	__ksw_watch_target(new_addr, watch_len);
+	return 0;
+}
+
+int ksw_watch_on(ulong watch_addr, u16 watch_len)
+{
+	return ksw_watch_target((ulong)&watch_holder, watch_addr, watch_len);
+}
+
+int ksw_watch_off(ulong watch_addr, u16 watch_len)
+{
+	return ksw_watch_target(watch_addr, (ulong)&watch_holder, watch_len);
+}
+
 int ksw_watch_init(void)
 {
 	int ret;
-- 
2.43.0

