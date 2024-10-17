Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E113AD06
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124757; cv=none; b=bgCZ90kVIpTzR4aU74vPp405MlHQcibqXYcDLmaJ8Be5UW2dsdOVYZq1SFRgh/k7Thrumh9wP88G2FaCUw/wReHcpeNyBIIdAM1+/i54RiyetQR3IH9RWMzvUs1qSyO07vaC9/JHzlgebm77T2PO7nRT/AgnO2lc7tMc4rLcdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124757; c=relaxed/simple;
	bh=yB9luoxNfz1ZB0ZSIvo+9O35nSVN9IWONPN5tQ/jUuA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hbEk/ZHrGtLhLZOLk1MnvmnnqrPq8jy7vLxa/s/YntT+MtBO/KLEQL1eZwYaiK5KUaiz2w09stVWMLlLV7bhOJF6KY7cW/ZBS7X/gtb0/leqmMsu4TPWYuOPyUWKGCjfragnBiA6bmTRkosZQ2Y4eINtaLaQHOm5cE+1dCMJsHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9jXfHP1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9jXfHP1"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e390b164c7so8997667b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124755; x=1729729555; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQMh1GkNDXXWwo5/jydOz7DZ+MfVb3HK+m6RjxS97PU=;
        b=K9jXfHP1iY8/o9jrCqS44Xut4mXRrFfWdo56ol40WuaD9crx62hU6ExM90BaUlxw6Z
         tUtmVincZMUH8zJACzB8uB0Y58/fwANdqNHIBXSniIBuZlre78nRy8YwyQcBR3V0BGKQ
         NS1AEegQB/hwGngEkeHDExGkQ+YMJxot0t+Z1o6vUH+Brpw9lQHHgS8blpnmyvgXDa27
         n+NPdRs4CJeuTnWLnw1+vgXFB2qPCMZnW5nZAHVD6fwdFoHy3Mvr87nQYzc8GX4b/VqD
         M1WzOs2yywAcHfJsn/a47Zq/Eg3n7eKJ6a0EbvGZKUOj47Py+ViQu+9W+frtt+PtoXUP
         GMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124755; x=1729729555;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQMh1GkNDXXWwo5/jydOz7DZ+MfVb3HK+m6RjxS97PU=;
        b=ibPGok4VBnu6b0+cyDUYXcpKmEFBh5L1dtdD5jUtAD5kWLXvA37svf9Qytso4P8evF
         BKSx3TjW60PlynFzFGbsQXQdsEts9bU1Ez02udnR8G+04S9MLj5/eFPzQoKZ96g1wY05
         SABvAPCjYgqDUK8srp91doSPQPT/ErCImek2wKzpJ015R4eSJzInMWG9HKSuOapYs9gt
         p6fKz9qsnVxQHAKV2Y+IOGMJ6rr+3Dsow9Lvo5/g+VTTGstTn1f2ASjcTgrPv7j/2Hxg
         fiV9TjWae048YfbYeu0T03TE04sSiTcmbPq00wVm91B3q/+FlJFHWSVrkYbXX27pE/Pr
         n5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZvJ5kWh2q3woyvZ1wcDIBH5NbRWbJidcfeuRXcZRvR9l96CpvP/tavnZd4HVA4X6mUYyXjh8tM5rVbkMO7Cz8@vger.kernel.org
X-Gm-Message-State: AOJu0YxqK/VzsIw8BgkrM1lbdzYWGlPqPU6QNfvyhlVZbiTi4d9tLPf6
	Q82M2EfcH0Kyhbjxc9CiOexfoeZLIF4wexfgLFnY5lTjgw/Jy0RcrgBiT+lBu4lKuJTwFrACuvk
	UFesjtQ==
X-Google-Smtp-Source: AGHT+IFbm6vwQJDAC4QPC5+PLfr8ycUWXoPY5PpZT0CV0PYSnLWVe//zo2w300WIdP2MxiCfoWlmNy3scmw0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a0d:c405:0:b0:6b2:3ecc:817 with SMTP id
 00721157ae682-6e3d41eb817mr501607b3.8.1729124754732; Wed, 16 Oct 2024
 17:25:54 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:11 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 11/20] perf loongarch: Remove dwarf-regs.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The file just provides the function get_arch_regstr, however, if in
the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case
the function can never be called. So remove as dead code. Tidy up the
EM_NONE cases for loongarch in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/loongarch/util/Build        |  1 -
 tools/perf/arch/loongarch/util/dwarf-regs.c | 34 ---------------------
 tools/perf/util/dwarf-regs.c                |  4 +--
 tools/perf/util/include/dwarf-regs.h        |  3 +-
 4 files changed, 4 insertions(+), 38 deletions(-)
 delete mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c

diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index 06ff95394921..0aa31986ecb5 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,7 +1,6 @@
 perf-util-y += header.o
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
diff --git a/tools/perf/arch/loongarch/util/dwarf-regs.c b/tools/perf/arch/loongarch/util/dwarf-regs.c
deleted file mode 100644
index bee08fdcf2fd..000000000000
--- a/tools/perf/arch/loongarch/util/dwarf-regs.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
- */
-
-#include <stdio.h>
-#include <errno.h> /* for EINVAL */
-#include <string.h> /* for strcmp */
-#include <dwarf-regs.h>
-
-struct pt_regs_dwarfnum {
-	const char *name;
-	unsigned int dwarfnum;
-};
-
-static struct pt_regs_dwarfnum loongarch_gpr_table[] = {
-	{"%r0", 0}, {"%r1", 1}, {"%r2", 2}, {"%r3", 3},
-	{"%r4", 4}, {"%r5", 5}, {"%r6", 6}, {"%r7", 7},
-	{"%r8", 8}, {"%r9", 9}, {"%r10", 10}, {"%r11", 11},
-	{"%r12", 12}, {"%r13", 13}, {"%r14", 14}, {"%r15", 15},
-	{"%r16", 16}, {"%r17", 17}, {"%r18", 18}, {"%r19", 19},
-	{"%r20", 20}, {"%r21", 21}, {"%r22", 22}, {"%r23", 23},
-	{"%r24", 24}, {"%r25", 25}, {"%r26", 26}, {"%r27", 27},
-	{"%r28", 28}, {"%r29", 29}, {"%r30", 30}, {"%r31", 31},
-	{NULL, 0}
-};
-
-const char *get_arch_regstr(unsigned int n)
-{
-	n %= 32;
-	return loongarch_gpr_table[n].name;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 9a76f83af62c..efc41d0fbee9 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,7 +32,7 @@
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
-    || EM_HOST == EM_CSKY
+    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -40,7 +40,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 #endif
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
-    && EM_HOST != EM_CSKY
+    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index b72d9d308ce4..4f205a58db89 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -79,7 +79,8 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
-#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__)
+#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
+    && !defined(__loongarch__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.105.g07ac214952-goog

