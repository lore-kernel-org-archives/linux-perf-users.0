Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1022301;
	Thu,  4 Sep 2025 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945318; cv=none; b=tbyg4luVSUg45sQ3VXJHP1X/0Twr/DnW10KwmZlqbvaTp4r0nUjA+USP2MgAqYvkGvz6hAd/quSviiq3seRZbZlvNptS5Rkji6pjPP0w5vtooxcvTFseYCiHqWeul4pCaNLbv5PkfvGKatEmrBkClvTX7bwKsxmfAcC+WBh5JYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945318; c=relaxed/simple;
	bh=tBX0hO0TjzB27+2RjkvnkUfPVj0tB9UkFzjloHpm/as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdIkyg+0GGErlFiosNC33p46nt6GXgw5DOBG+pKqGsBlXaIGAeDUctV6SLGAvzva3Cqv7sYrB2X+AK/56jF2KdAJgb5yCpcheDEVFPH4h1A9HZZOQ9PJEDVJkTuPjCDRxrmRib9PXndAAgs2a/72u60r6f6WYpPga98inMMB7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk4MM2RV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk4MM2RV"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77251d7cca6so416868b3a.3;
        Wed, 03 Sep 2025 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945316; x=1757550116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhhrrRkb4F3PyX047v9pUxx2LHKmYVjN4mot0t9leaw=;
        b=hk4MM2RVduke4sUg80O/IvpaaumOREqRvweF8EpXL8ZnzF/4GAkq5VcdNa8MiYvlOx
         CdexzJsfy5Fpj7bNSVVj1UM1vpKFj4Ttnsc7RuqkLxZN6t2QTsvJ3sEJ+JM9p06u6UUa
         pVqUa8t06PkTq6dWsIaCa/hYDHWaetWdCrIvzZtmONJjW+WM7i76+yFTuQ2tMk3D1kmm
         apZkNn6V+yuX0aEQKwYjTFJOvFT0wqSA1Ll3skwvhzH/fWnbolBdCFJHcrqlAQJz3Idz
         ZUUh4OTFQz7xg3HAXddQ62NQFGxJSWOthMLkN6zSGQETSIODmOVeDoRxDG10IsDEKEnK
         Q9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945316; x=1757550116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhhrrRkb4F3PyX047v9pUxx2LHKmYVjN4mot0t9leaw=;
        b=oqbLFZo8sFCNPPrlu6Lpiy59Dh7kIY7z0ODs5GElUB+zUqhEjJR8HpLDEaBZUmUmnI
         Ps+JXcysKmbwcmsWTPy+bRSVgdc42g4sDj9q4ZrGJ1pdQ9r92DbFn7nMExmM5VLEJcaH
         2CdHxppSZRZ9c3nkfyxADJU8v9s2oMUMwIQE/5a21/UuAewm6O6RBmeoyALHhV2giFQT
         QEZcKi5Gs4WPLHl6ES+obv6Q1QTOgQRa4WGQVsTv/bIQwFZ6dLLqdDT2jSrBy92w9EHh
         vt3e/hGfhZj9PkWo6U4Q1xrXQPBcvPtAg7tpmq0AQDFbdjfA5KiWfqnhwq2NsE3nsvjO
         dO1g==
X-Forwarded-Encrypted: i=1; AJvYcCWkKHH0k+KRuPLEwmV6cIXvkTfUa3bS5Z61n2o43g2dvjDUl6FtbZujIPPdZqprWwYvONDSetLiN5Ti7YahLsb5JquN@vger.kernel.org, AJvYcCXBVTkY2HAs9wXvXxuDb1yG9QwdAoU5dNTld8ICHsjO47D/VRmbuYQtZG+Zwwd1OGgDKytbH3XoXdZdaFzK6coo@vger.kernel.org
X-Gm-Message-State: AOJu0YwpcMn2SLUHaWFm7IEnYWznsoYchix0caEaNtf+mml5kzFhRWxO
	WFqbWW6LPR1v9auataIAXnLfOwZDgjqekcQ9lPdk6qZt9myOWD3i0qWu
X-Gm-Gg: ASbGncvUyFlzu1zWkzCuGBLfZJ+fpW2mJpN1xyRZwKK8yTdaKPL3DAVQumFRJf1wz6y
	0MbGqSs72B49oc0QZvym/EFys90igqY0IDHSddHL6lVPdTyQjh1fTCwCqQL8V5IQpm2TFQFBJvN
	AX8QzsLUT48mwzJh036tVg10rBiNwPTyKYIx+7HpgEzRotXlHRNjqi46lsm0vLTzM6WlCQjG3A2
	b14uVWjjunFdcWNwEc8ZEwAV+qpg1VzquEdcyfUzrLAjYEpvtQUc/0L7N8xSbL+HXdQgX0EVd/s
	4564+2A+T2OVm3YMWJap+TkvRONg45K2eN0owDyK0WLQv4AxoHSREh+UZGLzd6TVGR8bG8CngvJ
	5WgKjwNcKr/Sux8tgJclz47HGhEliIOT+C5OtZocowknud7l57rSIIuXo3U8aacA=
X-Google-Smtp-Source: AGHT+IGv0Jx86DoXMDOrUyjPpfPEAsH8ifMU/xMBIpbPH5AuwQ76YE98CDe3gaBbQQj+tqsd+VcU6g==
X-Received: by 2002:a05:6a00:2306:b0:76b:fd26:162f with SMTP id d2e1a72fcca58-7723e367f77mr18894886b3a.20.1756945316384;
        Wed, 03 Sep 2025 17:21:56 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:21:55 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 01/18] mm/ksw: add build system support
Date: Thu,  4 Sep 2025 08:20:58 +0800
Message-ID: <20250904002126.1514566-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904002126.1514566-1-wangjinchao600@gmail.com>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Kconfig and Makefile infrastructure for KStackWatch, a real-time tool
for debugging kernel stack corruption.

The implementation is located under `mm/kstackwatch/`.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug             | 10 ++++++++++
 mm/Makefile                  |  1 +
 mm/kstackwatch/Makefile      |  2 ++
 mm/kstackwatch/kernel.c      | 24 ++++++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h |  5 +++++
 mm/kstackwatch/stack.c       |  1 +
 mm/kstackwatch/watch.c       |  1 +
 7 files changed, 44 insertions(+)
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/watch.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 32b65073d0cc..c2cc8c7b595f 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -309,3 +309,13 @@ config PER_VMA_LOCK_STATS
 	  overhead in the page fault path.
 
 	  If in doubt, say N.
+
+config KSTACK_WATCH
+	tristate "Kernel Stack Watch"
+	depends on STACKPROTECTOR && HAVE_HW_BREAKPOINT && KPROBES && FPROBE
+	help
+	  A lightweight real-time debugging tool to detect stack corruption.
+	  It can watch either the canary or local variable and tracks
+	  the recursive depth of the monitored function.
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
index 000000000000..93379a0a0f7e
--- /dev/null
+++ b/mm/kstackwatch/kernel.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("Kernel Stack Watch");
+MODULE_LICENSE("GPL");
+
+static int __init kstackwatch_init(void)
+{
+	pr_info("KSW: module loaded\n");
+	pr_info("KSW: usage:\n");
+	pr_info("KSW: echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
+
+	return 0;
+}
+
+static void __exit kstackwatch_exit(void)
+{
+	pr_info("KSW: Module unloaded\n");
+}
+
+module_init(kstackwatch_init);
+module_exit(kstackwatch_exit);
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

