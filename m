Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F22E7162
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671940; cv=none; b=kfbssONddeA7zUKTB+KPkIUgkvFFvzfCTG+gHlYBfihY1eMLYnBIoAB7zS9S3iFBkSzO80JJ58tf1gvTzrC0gcKcjgTgQIXVikmbQ9eqt+Ry3ecIKiATaJFG3m/iCtKrAm50BWSf61LPIn1cLanbczxszJEfuvaunqxJ0+Io93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671940; c=relaxed/simple;
	bh=khEOYcdk4y5BMxDzooYo/fDYw+JbjlL9xknm74JC/ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5k0AzNiOHUMoKsAqkhr3hWzX+f1lJXzfiXAmDDlhzJGrhmsdhMZoWwVbRWS0T/fLBsDpRvHUmwEP3D4jD8zJ8JMOrich53tiPs2u8Mpo3CtwLhgGWZRSmUH9flWpuzV8MRxCFD0jrX/bj4wPO1Cyoaa++AaPycJmlMazMIiW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvkgy2gb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvkgy2gb"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54a8c2eb5cso954419a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671938; x=1758276738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPBHXhel7rMyKaWRDIHRGBdLv/zGRcLPaVcgqECt6eI=;
        b=gvkgy2gbFNfRyTxFwuj5EtJ9DfcWKosDHF5vOLvnIdWRDKxh7ikZbX73qeu69hoW0M
         sAS+mY2Hv3f93lcO4dnbftRtjZZOhgRWw3iE08cV0rSVXpO6UIiFZi+1PNUo71x2xAxo
         9BwWAk5oYTAdalMdqwyIonwMc5ZmccGvKqNcBVNzb0mLVCtBv0BloZ5zo/2LRb6Coy5Q
         he74p7dObKrqIB4pHz34daxmnv5agclTG9pZjhQ4bhuwA7QN3wCw1ZQ1+aaYJoEzXvsB
         6LtjioEK1R6AbK37YbypbO4v9mD/LK2VveEDwPQPf4lrMyfc62+8oRq8fnhfrSXRCRNe
         RJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671938; x=1758276738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPBHXhel7rMyKaWRDIHRGBdLv/zGRcLPaVcgqECt6eI=;
        b=jWMlHGHl2Uk2OBnVc9IZoH1FSED9fgCIeorSDUTXsF59P2HCbXLyqUkvsgLIru9Crl
         E3reXU0dTFxNwSHo7GoBQ1SAU+dsCi2Yz+ug9c9x0seNgbd6Wgq15XtRoAMENobhi4Tr
         LKH1NrWfgmVy7iS8zDTXOeHQ22OWxEpNaoHF1M9owL+r5d/Wz6G5frQc5Hk1KVNs+ZmQ
         vVfBir7j8vxiXdcStCYib4mvRb/9/3P2Nwc+6zZ6z3Xey0f8TCMcJScijmqtCIhFO1N8
         McerKC32rl7/L3slG3RiprTCN9i1/f6OdXKQNLC3tEvLRWcXEaayWT3bSpKNE4FTcYkP
         pzJw==
X-Forwarded-Encrypted: i=1; AJvYcCUO6Q1a6nlI8F6iv18Kl0n59FJJ4vuvQ2Irc1tfUVGgNYyuoz4vzkI7Z4LWdKhBCy2vZslgvEXg4i/80hqXNSKn@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtmv7byXRG2hezyEOnlsYTnBBw3yUMNUV8edmd+TYrS4/Zcmh
	fX+D3upf8wS/d4on9B9m1Jiwu0cdr3E+iLptAxB035q+PsgrE5RdQRS0
X-Gm-Gg: ASbGnctyt4wrbtHDDF79WZ7j+89sHxHJnmdvo6lukGvoIxSUpIrEtdVR2vNQlop+sjY
	m4V+zQtanoOADTJP8VuKDZ0ON2wkS6UwZ8TH1zAUkctq6jd3E/P0LuiLWZr40X8RMO/EUzcwRFb
	b3ZXyN3d42gsI9TPZcZpAS1jLF9P90Xoz1SDqUsEyzHVoW3CRdRSutUxMvpzfjqrl/vaJzM0zx0
	c+cQwbeVEYUAcEA5KwuwSNuhvjGjzIhKyrRhZu9ZTqFR3ELxJ2VEkWy/axLkj0VPh4tOVc8TEas
	VwDhVVA8gyCB8VXi1IfRqE1KzZBaFXzrIoz/ZkSQFMvzQ545d/PYCuVTppiF4puMhVf4F6wP2rQ
	rBOSi6+ZHU1oprEbdkhbcFuxpi1PkhbWaabmc9So=
X-Google-Smtp-Source: AGHT+IF0a8WwW7rBxRhd3Sx4BYYreRthYgFLu+D24YzR2HNtnMsrUN51Z/p+oaiQ/+b9L1Xt/Owfnw==
X-Received: by 2002:a17:902:f68b:b0:24e:7af7:111a with SMTP id d9443c01a7336-25d281077cdmr34352375ad.49.1757671937679;
        Fri, 12 Sep 2025 03:12:17 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm44620085ad.123.2025.09.12.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:17 -0700 (PDT)
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
Subject: [PATCH v4 04/21] mm/ksw: add build system support
Date: Fri, 12 Sep 2025 18:11:14 +0800
Message-ID: <20250912101145.465708-5-wangjinchao600@gmail.com>
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

Add Kconfig and Makefile infrastructure.

The implementation is located under mm/kstackwatch/.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug             | 11 +++++++++++
 mm/Makefile                  |  1 +
 mm/kstackwatch/Makefile      |  2 ++
 mm/kstackwatch/kernel.c      | 22 ++++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h |  5 +++++
 mm/kstackwatch/stack.c       |  1 +
 mm/kstackwatch/watch.c       |  1 +
 7 files changed, 43 insertions(+)
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/watch.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 32b65073d0cc..fdfc6e6d0dec 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -309,3 +309,14 @@ config PER_VMA_LOCK_STATS
 	  overhead in the page fault path.
 
 	  If in doubt, say N.
+
+config KSTACK_WATCH
+	tristate "Kernel Stack Watch"
+	depends on HAVE_HW_BREAKPOINT && KPROBES && FPROBE
+	select HAVE_REINSTALL_HW_BREAKPOINT
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
index 000000000000..40aa7e9ff513
--- /dev/null
+++ b/mm/kstackwatch/kernel.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("Kernel Stack Watch");
+MODULE_LICENSE("GPL");
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

