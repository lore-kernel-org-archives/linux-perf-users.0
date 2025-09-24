Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B8301466
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714716; cv=none; b=uyeB0UV88HuXPXGC7ydj9zVFbRhTYdKrh6I21pVNWgEdbKV6yEo+p1r1ubXcCKlqeLOEfXRfHUdbU0o1w9lDtv0ld88ImgsQD9o49h3nLdGXwh8iMXhIUZvxz0v5sOtt13c8uxOyfc0UVVSIVk3t7vLeXZcDB9dq3jHeTadFzWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714716; c=relaxed/simple;
	bh=jXVtZ6lSnaquGQDEy0MV0UKEBAEZnx3Lv2rnYbpvrA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dis3ni6mHWccbxnkearEWa2G52FHmZlCDVHEUda7YKjUW1AAV+AtNqvtilL4yOL/ATdjRCvKKHadLU6J9C9PaFZltDVe1ds2sKH+JoY02/WlKHiXdaoj16rHOiMC4Ip6esCsH1mUb5aNS/v/jhdp6Ux5cliu7UZPNjIPL0dUKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfHfbDgL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfHfbDgL"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f2e621ef8so3896755b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714709; x=1759319509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1KSy0afhoo56zSKFToL0Rdd0rZ5LRpSk38GpQKE8pg=;
        b=DfHfbDgLV4ZBha5t6gQyH6Z6HtoJbUC/SlhISEprByp358kRbswsG4Jm1wEKBNIpuG
         gTUVsR1qbFjCI/MV3v1Lxvt8DV8/iQOPv9LkjR6U98qIcb8NsaHOexQSm+URUf1PQLR+
         M/ljuYjCx2Ad31uiJ33RY2LvxoU/1qiLpXCj13EBgtNzCD1l0/M9dzwH2ZdumIYLrdzX
         hgw3wKbHrBWYBWZgY4CXJR4+9dHAU9GmLNAm40/8jkq76jsG4RbcGTzDsa0ndzy0e/ST
         /ekQ4LFWq+cD/APMNuS7Ry2xup4l4TSmdq7s8V+bwORSfEPKF78xACfrzpaCINDvQrSA
         BrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714709; x=1759319509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1KSy0afhoo56zSKFToL0Rdd0rZ5LRpSk38GpQKE8pg=;
        b=i+m1wQ/vNizjx3xtDLEbj79iYrKzxBNnXASfWNuzbfdEyeu5d2PWxybheqfAoYGnxn
         0dsz10xTbOnLcdMObBCS78ufFN24EQxFdgSRR/uJbUKyRSXKsWUchD4XGm1nTyEi5/G8
         VOY6UfMtyf1PXOCtuGcSdU4Tg2py3vryFqoaJq62f8d19iZF55ONu3LEkp6yLkS25WOC
         Qk7EWszuyLIkR6GYxvXfjxEio/NgRfs2rmZQNyfPpG3+N62M+xO62ZKMCycSv0zV38Mv
         kIganghSu0pWdpiML0qFqFrvCSqBycX75VWbpW3puYViFhnSu9hDcr+mSaR+3vySdJi6
         pTbw==
X-Forwarded-Encrypted: i=1; AJvYcCX1OwHKi+EUtpsxbdB1Bg59mGIFxYXo3YQdgBhDuuGFRPRtk784MvBITlLqu6Pw8lANE6Y3TDVtbIxku/tevzBP@vger.kernel.org
X-Gm-Message-State: AOJu0YxxV3bkwOgWkl1Ojr00vKGR/r06nzSxU53OU070MCC+vs5qOKFd
	WKp+VwLcNMjlMdpGJZCBwB7HuEsIEMoN+n7itDXiZlxCZHC+KyxkC5BS
X-Gm-Gg: ASbGncvBscJz9HywIEW56FeDmdQqdEa/IbV58v11s4lm9DDmTyOl47uyH81x19Ieed/
	aBEn9R92iP29Xshk4C5BkL+PTZNkYmZ7AlIFeYu0AD1fEgJyyAkymp+ad6mSHT824WStZxA/N7s
	X7ywSM0oiKqLv8U0ytRWDR0mHvxhfrsDY8Hqxz8JIo9TUVkRYghMd4mvMwGpPm6E4j6pZUPaZ+C
	7LntEIsNdd+Ad4S5znftRCd2Xm7tWYQAaGWZtI6V8NCEwzPNfm/NvnIl7P724T1v6Cwmz7XK7AL
	0jgDJa7oh0+SyeeQa5gZBacGZe30HmOfPGThTZP3GClwNN8rrMlgZt7riRiYZljwl7qmyVqa7Cl
	HRgBAZVLaWdNcX4rjbIOdypiHc2wKGVZpsg5q
X-Google-Smtp-Source: AGHT+IFQ5u0/9s5WpxjOT+F0EeKSWL8MVQatB4w+7WUjpnJ2Ax15auMJ/gX34AgvPJn/yfLcWN7oSA==
X-Received: by 2002:a05:6a21:3286:b0:2df:8271:f08d with SMTP id adf61e73a8af0-2df8271fb8dmr2764157637.2.1758714708983;
        Wed, 24 Sep 2025 04:51:48 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f5f9a45dfsm3248137b3a.7.2025.09.24.04.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:51:48 -0700 (PDT)
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
Subject: [PATCH v5 04/23] mm/ksw: add build system support
Date: Wed, 24 Sep 2025 19:50:47 +0800
Message-ID: <20250924115124.194940-5-wangjinchao600@gmail.com>
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

Add Kconfig and Makefile infrastructure.

The implementation is located under `mm/kstackwatch/`.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug             |  8 ++++++++
 mm/Makefile                  |  1 +
 mm/kstackwatch/Makefile      |  2 ++
 mm/kstackwatch/kernel.c      | 23 +++++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h |  5 +++++
 mm/kstackwatch/stack.c       |  1 +
 mm/kstackwatch/watch.c       |  1 +
 7 files changed, 41 insertions(+)
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/watch.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 32b65073d0cc..89be351c0be5 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -309,3 +309,11 @@ config PER_VMA_LOCK_STATS
 	  overhead in the page fault path.
 
 	  If in doubt, say N.
+
+config KSTACK_WATCH
+	bool "Kernel Stack Watch"
+	depends on HAVE_HW_BREAKPOINT && KPROBES && FPROBE && STACKTRACE
+	help
+	  A lightweight real-time debugging tool to detect stack corrupting.
+
+	  If unsure, say N.
diff --git a/mm/Makefile b/mm/Makefile
index ef54aa615d9d..665c9f2bf987 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_KMSAN)	+= kmsan/
+obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch/
 obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
new file mode 100644
index 000000000000..84a46cb9a766
--- /dev/null
+++ b/mm/kstackwatch/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
+kstackwatch-y := kernel.o stack.o watch.o
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
new file mode 100644
index 000000000000..78f1d019225f
--- /dev/null
+++ b/mm/kstackwatch/kernel.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+
+static int __init kstackwatch_init(void)
+{
+	pr_info("module loaded\n");
+	return 0;
+}
+
+static void __exit kstackwatch_exit(void)
+{
+	pr_info("module unloaded\n");
+}
+
+module_init(kstackwatch_init);
+module_exit(kstackwatch_exit);
+
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("Kernel Stack Watch");
+MODULE_LICENSE("GPL");
+
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
new file mode 100644
index 000000000000..0273ef478a26
--- /dev/null
+++ b/mm/kstackwatch/kstackwatch.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KSTACKWATCH_H
+#define _KSTACKWATCH_H
+
+#endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
new file mode 100644
index 000000000000..cec594032515
--- /dev/null
+++ b/mm/kstackwatch/stack.c
@@ -0,0 +1 @@
+// SPDX-License-Identifier: GPL-2.0
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
new file mode 100644
index 000000000000..cec594032515
--- /dev/null
+++ b/mm/kstackwatch/watch.c
@@ -0,0 +1 @@
+// SPDX-License-Identifier: GPL-2.0
-- 
2.43.0

