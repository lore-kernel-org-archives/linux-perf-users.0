Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9217E01A
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124773; cv=none; b=djRPwlPtLDobqcCCqXVVME+xBO+hwq2R5OSwhC7RTsuFfDXLzTeu4oM1pBT4rbTxRe2DzitXU7ZKkftKkr0BrqP5GTcAxUlaAJCnUrhmV0fOkgkhpCgH6sxhksMzepiqoIyXa9t6Me3TQc9j+hV+5gb2TbfwZofh89/YsUXvZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124773; c=relaxed/simple;
	bh=o1BRyYKYbb+p4McU2Dk5LlTJ9SKJ9j4mbqSMgCX4n/8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=esEss114H0MQpg1U+yNd+IC0PdDiW45jbejOMkegGKwRM6ukqfOtMcePHwLBMftKAsBg0rMrGWNwB5e5NSdPtYG2B+9nbTfSZVCFCS9ucaZ1JTNoABPQK9CSKTfyQQ4HV8RsCgosJcLEt9kPC+3trL3RBmrCnGFTauV9Yhb23eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMy0hsEX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tMy0hsEX"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29bcb5591cso675660276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124770; x=1729729570; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oW9Ciltxw29Qn009jBViVw/a9LBQmaz3mh3OQFZm1hk=;
        b=tMy0hsEXnMysiTAPGP1Z4gFmE3Q7mSlx/UfWxUAQjsgljz+qUHDjNZaSIHBDGgRxa4
         cLLwXVhhMO+y7xKE1EltBc72g9T7N/1iLgDj//bj5paG7zrg6OvEJE9YFpfqrb3tQSPw
         VHiAnJfD/vqyhP2wRx0ZssZsZ+zdaxc+HZJ7s1VaLmBreRRF+XTuMc4llBqNEqPs6ps8
         9INAmic2QtO8BFS7/88DPDp8u5qv6qY252zYseYbHEhAfysrbpDJUWTzeSNs7Mw1/T2u
         ljBuo8sqdy9338W8sco7J9sH2fPpn0FJwL5sMy72NuGj/uE24fkQ5gqMiMzkeSmZapr5
         gfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124770; x=1729729570;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oW9Ciltxw29Qn009jBViVw/a9LBQmaz3mh3OQFZm1hk=;
        b=Sh0J3pUZ1VXrdz6y+7jsgN0TcUDOFAVyU706wdCRsA5rk4IkAwQOFkLHmWkzKnyXZ4
         RmEH6T8jYCt6YmRhF8SrP/5bvnkfV1m8eMsHhw9cxPYHDwfvDJr9p91idHlcNu2nmvKy
         VTVZl6tW9keJtuEEQaiCE1myzdDHXgoJW1EkT3BigkhKyw+5CdDwJ2UlxCTSYQbnPBdC
         r3BT3oPtCh1/7EGdGK9MQ0bel8b0oDQtsI3JYLhCfly+nsJXp5+MX+QXSUmtkhIB8Vse
         hO2kLLbvXXjO++r9IvdELNOlPHbXFO2oIQzDkmbTQwAlpvvnxUojCXw1fPwv5ssTlTjI
         ibNw==
X-Forwarded-Encrypted: i=1; AJvYcCX5q4LzUBX7cjArhGchnOPdCNKkz5C2Bt0lZc2H1R7hnZyDFUequHY5nT3FWPtga+67qNsJ9F09w8J4ynNjjeez@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/M57MN5WJ8bqsON37Vq3dp/NzzamJ9VmsaxUv+gc6pzq69TX
	Iynb/GechlPmZMIZcVYKt/sEBbj+2iJFOwdsqieqJF43Mxv3kGq1CxLtEJ7D6AYD+Q9E2TPA1/z
	d5Q8gmw==
X-Google-Smtp-Source: AGHT+IGmO4W0BoMjp2vNweM4XGVSqpJs6KmKQXMJOVyvfkUJl62y1U0AKaZtgLbMJwRejRGMM6dtDDGo4NIo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a5b:60e:0:b0:e28:e97f:5394 with SMTP id
 3f1490d57ef6-e29783006ccmr3235276.4.1729124769707; Wed, 16 Oct 2024 17:26:09
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:17 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 17/20] perf sparc: Remove dwarf-regs.c
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
the function can never be called. So remove as dead code. As this is
the only file in the arch/sparc/util clean up Build files. Tidy up the
EM_NONE cases for sparc in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/sparc/Build             |  1 -
 tools/perf/arch/sparc/util/Build        |  1 -
 tools/perf/arch/sparc/util/dwarf-regs.c | 39 -------------------------
 tools/perf/util/dwarf-regs.c            |  6 ++--
 tools/perf/util/include/dwarf-regs.h    |  3 +-
 5 files changed, 6 insertions(+), 44 deletions(-)
 delete mode 100644 tools/perf/arch/sparc/Build
 delete mode 100644 tools/perf/arch/sparc/util/Build
 delete mode 100644 tools/perf/arch/sparc/util/dwarf-regs.c

diff --git a/tools/perf/arch/sparc/Build b/tools/perf/arch/sparc/Build
deleted file mode 100644
index e63eabc2c8f4..000000000000
--- a/tools/perf/arch/sparc/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-y += util/
diff --git a/tools/perf/arch/sparc/util/Build b/tools/perf/arch/sparc/util/Build
deleted file mode 100644
index 2337a0b710a2..000000000000
--- a/tools/perf/arch/sparc/util/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/sparc/util/dwarf-regs.c b/tools/perf/arch/sparc/util/dwarf-regs.c
deleted file mode 100644
index 1282cb2dc7bd..000000000000
--- a/tools/perf/arch/sparc/util/dwarf-regs.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2010 David S. Miller <davem@davemloft.net>
- */
-
-#include <stddef.h>
-#include <dwarf-regs.h>
-
-#define SPARC_MAX_REGS	96
-
-const char *sparc_regs_table[SPARC_MAX_REGS] = {
-	"%g0", "%g1", "%g2", "%g3", "%g4", "%g5", "%g6", "%g7",
-	"%o0", "%o1", "%o2", "%o3", "%o4", "%o5", "%sp", "%o7",
-	"%l0", "%l1", "%l2", "%l3", "%l4", "%l5", "%l6", "%l7",
-	"%i0", "%i1", "%i2", "%i3", "%i4", "%i5", "%fp", "%i7",
-	"%f0", "%f1", "%f2", "%f3", "%f4", "%f5", "%f6", "%f7",
-	"%f8", "%f9", "%f10", "%f11", "%f12", "%f13", "%f14", "%f15",
-	"%f16", "%f17", "%f18", "%f19", "%f20", "%f21", "%f22", "%f23",
-	"%f24", "%f25", "%f26", "%f27", "%f28", "%f29", "%f30", "%f31",
-	"%f32", "%f33", "%f34", "%f35", "%f36", "%f37", "%f38", "%f39",
-	"%f40", "%f41", "%f42", "%f43", "%f44", "%f45", "%f46", "%f47",
-	"%f48", "%f49", "%f50", "%f51", "%f52", "%f53", "%f54", "%f55",
-	"%f56", "%f57", "%f58", "%f59", "%f60", "%f61", "%f62", "%f63",
-};
-
-/**
- * get_arch_regstr() - lookup register name from it's DWARF register number
- * @n:	the DWARF register number
- *
- * get_arch_regstr() returns the name of the register in struct
- * regdwarfnum_table from it's DWARF register number. If the register is not
- * found in the table, this returns NULL;
- */
-const char *get_arch_regstr(unsigned int n)
-{
-	return (n < SPARC_MAX_REGS) ? sparc_regs_table[n] : NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 944ff4ef0290..a0bcc2529cb0 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -34,7 +34,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH
+    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH \
+    || EM_HOST == EM_SPARC || EM_HOST == EM_SPARCV9
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -43,7 +44,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH
+    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH \
+    && EM_HOST != EM_SPARC && EM_HOST != EM_SPARCV9
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 2b212ed70a15..b2cf7d9e4785 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -81,7 +81,8 @@
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__)
+    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__) \
+    && !defined(__sparc64__) && !defined(__sparc__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.105.g07ac214952-goog

