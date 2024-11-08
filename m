Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13321D214
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109609; cv=none; b=K45Mq6oO2IN5+w8Z+51EcHZRnkDUkC2adqjTF568FkJfH/2PMeEYeM5cOwmhAI6camxaZ3r3NoRaSy9imC1NiMeStQexLYeTm3l86JUPtsdFdQ+dvuqHYEcK/FslDzMElP0+3kOXKI3mU6MoTO41q5feuoJRDVYXX08SjKPxddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109609; c=relaxed/simple;
	bh=F1EZ1hQV9vXPSPeOP7SjKuxuxSD4VaMyL1k587a+Ruo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aoWfWwWYFyzx80vlY12J/iab+JtrpGUBPdSl/cwCQ5QvAYC2q90OOz9dXYipQ/phUqgwWLs8YIJWW2e0O7Pt7aBDO7q6KQ9wl21mZjClMahex/MXA6g43bHts3t9knUKFGXMnRErPReSFFLvplfyOShYhjirbvkL1db9XI6C8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJaQ8Khc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJaQ8Khc"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2b9f2c6559so4223260276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 15:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109607; x=1731714407; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=id1sOQMhBAfYrQkMEdKlKXMaLGpsjXQ8Stxxnq9csgo=;
        b=ZJaQ8KhcOfCkSN3hN1rtjaQXAEjUfoP0SqmGxLQwX3w3PobFRq4pgXyj4338DpLFKS
         NmL8kpr67QsXENQXrAfpPCbLzDFoeh4TxH/7lIvDQsWUaCfWiHyjyyrBL2ziRXsDnBAZ
         0jAVhTg0uGitPCMMkat6tJDMlTbyY+AvKTkUDdxcfxUUQhnscfQnw4BtifyEgGbibZl4
         uMvgWDT3DybfNP+epNuu7U9DuMk4/NU162iSvx8z9+nwouPRkgCr2Mwcn4gt6qdOQsto
         OAgtS+JMTFrZ3PlMcdYAucgwe7sRvxfZSDisnXghhlzKveCTQwtOkoPMqBCQNdMorWu2
         Cr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109607; x=1731714407;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=id1sOQMhBAfYrQkMEdKlKXMaLGpsjXQ8Stxxnq9csgo=;
        b=r0siC4sBCppaVe0UYPmxpCp/bZ0N6XBzs6jsAgvpapeqenEXBY64qeTY5R6TTyYAI/
         QjF3rQ15qB9iSnvCX3AnMzfIaSr8eI1xVL3Fu+7xlkzS1B56DOBE80TVlfaiYD+xbuAx
         s2lG/L8hweuD6fyXdmgoVJrV7gOYo/piSoclkx8FFQeCUf+KO4Y/AXKoH3aJGq3cFr3+
         9TmiZQulNvyLEH9gKKFu0ziWpftYZN6XrIC0xD/mInhAx80K0n7YnB3OEWpmOG159GCd
         Sgfc3QSOpISc55asfowtX+j0aX1A4WLNPyiEZUPP2XKSW2076QUAPFnfdYwm8Fr6vE4o
         pnyw==
X-Forwarded-Encrypted: i=1; AJvYcCX1JufhOUymEIwQ+BLmVqM//jfNLbCyjUkiuHl3yBU1FFjK6IdfSzZF41o3wxpc7RGROsX/3pDPgopheA3medXV@vger.kernel.org
X-Gm-Message-State: AOJu0YwngkZe0noYRx+8gnl1SoptIBulZ4g2X7NPXjnrctpK3wefgdHq
	eanTMT5EdKY4c2cQD3GxyjQ/EdtRowwVY5a8jDdSaOYQDONNm5z3yC9w6OcpJ6vmtAw4nlRjtwW
	bgT49rw==
X-Google-Smtp-Source: AGHT+IHjMMENyOiMnnZmF5Juh9TzpGi5bO57httE+RgDaSO3QxFM+r9r+hIADzo1e5sAnUlUjz40W/TnQ2si
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:a289:0:b0:e33:9110:27fd with SMTP id
 3f1490d57ef6-e33911028b7mr866276.9.1731109606451; Fri, 08 Nov 2024 15:46:46
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:46:01 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 16/20] perf sh: Remove dwarf-regs.c
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
the only file in the arch/sh/util clean up Build files. Tidy up the
EM_NONE cases for sh in dwarf-regs.c.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/sh/Build             |  1 -
 tools/perf/arch/sh/util/Build        |  1 -
 tools/perf/arch/sh/util/dwarf-regs.c | 41 ----------------------------
 tools/perf/util/dwarf-regs.c         |  4 +--
 tools/perf/util/include/dwarf-regs.h |  2 +-
 5 files changed, 3 insertions(+), 46 deletions(-)
 delete mode 100644 tools/perf/arch/sh/Build
 delete mode 100644 tools/perf/arch/sh/util/Build
 delete mode 100644 tools/perf/arch/sh/util/dwarf-regs.c

diff --git a/tools/perf/arch/sh/Build b/tools/perf/arch/sh/Build
deleted file mode 100644
index e63eabc2c8f4..000000000000
--- a/tools/perf/arch/sh/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-y += util/
diff --git a/tools/perf/arch/sh/util/Build b/tools/perf/arch/sh/util/Build
deleted file mode 100644
index 2337a0b710a2..000000000000
--- a/tools/perf/arch/sh/util/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/sh/util/dwarf-regs.c b/tools/perf/arch/sh/util/dwarf-regs.c
deleted file mode 100644
index 4b17fc86c73b..000000000000
--- a/tools/perf/arch/sh/util/dwarf-regs.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2010 Matt Fleming <matt@console-pimps.org>
- */
-
-#include <stddef.h>
-#include <dwarf-regs.h>
-
-/*
- * Generic dwarf analysis helpers
- */
-
-#define SH_MAX_REGS 18
-const char *sh_regs_table[SH_MAX_REGS] = {
-	"r0",
-	"r1",
-	"r2",
-	"r3",
-	"r4",
-	"r5",
-	"r6",
-	"r7",
-	"r8",
-	"r9",
-	"r10",
-	"r11",
-	"r12",
-	"r13",
-	"r14",
-	"r15",
-	"pc",
-	"pr",
-};
-
-/* Return architecture dependent register string (for kprobe-tracer) */
-const char *get_arch_regstr(unsigned int n)
-{
-	return (n < SH_MAX_REGS) ? sh_regs_table[n] : NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 1649fc07f4f5..944ff4ef0290 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -34,7 +34,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390
+    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -43,7 +43,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390
+    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 086b537690d7..7026a3d2aaa7 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -91,7 +91,7 @@
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__)
+    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.277.g8800431eea-goog

