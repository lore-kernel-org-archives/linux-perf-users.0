Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D12288C25;
	Wed, 10 Sep 2025 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481901; cv=none; b=mnkAAHYAUVhucsTQM4Z60OOYSJMCl9uw7jQQK/oxJaoTbUwQ2q0KtTwj6xahzt7Hg22dQxxCf25bdxMpieh/DCq1NChx6xQ8d/lYJGPnwmViXzTpLF6jZbOOgOOsV/woD9GFLNe/DlgeQVBz5w8XU8i/VHKZWeLyAB6NdCWX9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481901; c=relaxed/simple;
	bh=7ttVIuDBVE7PZ5litpidUE+C+Z6P8rGScqr7xr/smxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAn1g4segAFr76zMnBrEW/OTdgUCWzUMs7d3jRz2DLrA1U5RQFfTVgnSSrY82ACeaWvf2WanxOpnvZQDinJe1z0VjtIpKLrHWCXQAFRN572BkhGJm+K2aDCmCg1PdmYpDIRcg1Zd6Z/cdSmKbHbY/Qdv6xTi8NTKZvHE6q3PJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD/ZGLyR; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD/ZGLyR"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c53892a56so5742300a12.2;
        Tue, 09 Sep 2025 22:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757481899; x=1758086699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHbowSqCEXMKo5URxnvlReujWCnQ6OEftSHn5bkAAuU=;
        b=XD/ZGLyRc3iFK7IFLkqGd6XA5dv2n21+4wkxOdMKRHydueny6epXh2rqMjGa/OOLwo
         Y7GtzrH5jo1vietGlrVXozrvutmTrfSHeLM/eEGtbJwLc1Id+nVaT1S0ZkrjsRTPX7KA
         UC4989FVg3Oyih8dbseS7MnlE1i5LaAAhk+pz+eQl3jfo6HCZiOkZHFJDpO8gAV9Um5o
         BHyZ1aetpOFztwN+UArrR0l+pn7dKznwWLfqZ/OvndnaA6yAfBKXz9H5sLRFEn+E/ymo
         8C65TO2PLeOjY39Ix4ppkR2oFWxsJ0lOt2/hxDxKZRZQOXKS6sPOo2CQicjibgxhfUKI
         wVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481899; x=1758086699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHbowSqCEXMKo5URxnvlReujWCnQ6OEftSHn5bkAAuU=;
        b=twIRFc9nSLcg/X06c+pJ+C92kD1pLf2LY7Sahbjll9PyO96H6moHZD2UQRZEpys1A0
         k5sCXVtLYmBIMp0pjhn2Vj8t4WCQG0VZcS95nrqxcaEaIb1mpOd02+/AdZ1RChyhAjdo
         AtiJkZViRHF4FoK4HZbVpWHH6OPx1j4QN7rYRfvpD3OQa4TMLULVfXRfHa0mXX4It2jW
         xl8kq8tbOoVkvicrEGdUcAjbigxMfaFE6HBD5F+asfAkb2PTGsB/sA+0KkykN6g9kj/9
         ardkJbeNh8rZ7wFtAHMKc2YBxZeS2duJYUwnImkLX2i060+rvhJxeDf4yfvuS6HQLdCX
         sq/A==
X-Forwarded-Encrypted: i=1; AJvYcCUfNJgomX0fyhQRj5ouUPNFBXwSE6rYi9Tw/AA+i7nIScs5qzqc+SkpeU4YEiWepUDCCJmYRkrm/q4i/Z6zZVMKhS6/@vger.kernel.org, AJvYcCWPeZgS8xG5UAlcuwLrMmxHkjLb1SbDHKxulqpaS2TrTAsNb7lBjcsrHDoF/69pn/FqIE7fRURaFRzjM5YrP4a3@vger.kernel.org
X-Gm-Message-State: AOJu0YwwB7oMbQr6h4/iom8FLHYu5mzLgYXcm7opvqNgyivwHG5NAuvj
	ayTx5jrRt/+qJUoawWluP2oSpaoXizbruZNbO4WjE6X/ISH7vqBe8KqT
X-Gm-Gg: ASbGncvzg24HoTyG6K9nwGsEPSQpC483nCoP13t3nUYTO9J0r+qyZrsCAe6lhCa80zV
	nkYDIfVKqKd41wIgoY38ywoeTRaTZ8wuEVoFw6CGkCBX8dUq87Qr3OBQhbp4r2bIGZT+S2k0b4a
	Q+uUrP+52QIxpPfH5aSNgm15gD1t2lBl/0BbB4sJWZTOhf48X4qD+RTxuFtjXVk+GduXpGMrrV7
	dJZ5XGZK6M+5fmYc8WCP/Ub0Ksyy0xwbqX7SNyJHjS/58Yc8c7xPSp0FaBuXGHWsVm9xaolLG11
	09+VHZoLkeiZ99sILtC92Mm58j6Wey1NJJqiSQp+bRhKAzDQv7aS4iuAK9AUnSNiN/N25AALWvf
	4JifrDxmMD1Eitm6EWgpnRev14B+OxQsaIg==
X-Google-Smtp-Source: AGHT+IFnARFkczLWUmMFLlSc0N6UFfpoaihRfxkgeMdDrbimMHZoHGnBjY9ltFHgpchLFFWHUqeu0g==
X-Received: by 2002:a17:903:22d1:b0:252:fa17:bc95 with SMTP id d9443c01a7336-252fa17c03cmr200824935ad.48.1757481899190;
        Tue, 09 Sep 2025 22:24:59 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:4007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422ebcsm14815125ad.29.2025.09.09.22.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:24:58 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 03/19] mm/ksw: add build system support
Date: Wed, 10 Sep 2025 13:23:12 +0800
Message-ID: <20250910052335.1151048-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052335.1151048-1-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
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

