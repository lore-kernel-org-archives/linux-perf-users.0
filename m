Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F81188709
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158207; cv=none; b=sulY6KmMpKsaGYragj9RWYFxzgm/xFziY5Lqd6F8NLxfeGlfxByGyKCkXE4mRiCFMbXqf5kUZbL5G8l0gL1osRtFiF18ZRv+smlLwhbqf2S4OWq5t5CajVU/D/nDLanyGYC/GYzsytSkr5HUqkauNe52QYW2GvkMQmbwNhpocTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158207; c=relaxed/simple;
	bh=C/R1IGxCC68hJSV8yW4I2Iy08ehcQxHQMz4i3spVrl0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MjVGalqovAsIjHYAKl+CwZJfzl3k0NE9ct+p6HjPyqH7ZtTqAkh18yaM4fuyVKOJ67ubyrOZvMpIRJdaSZjzDqnBT0AkA4aY0Cvu2/mjnRZZDS1dR0s1f0bENBosHQJ/pKsa4NZQbv2Z/lisd5Zk55j/0Zu+yfZv0nhI2esuNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UsIwtW7j; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UsIwtW7j"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e163641feb9so4407115276.0
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158205; x=1728763005; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhqqVaGZmOo9qC4oo0q/uwTQj9+Y9nVOVKHgeiFJY7I=;
        b=UsIwtW7j/o7b+Y7+B3HEaqX27LVsEbzKBOukCiIWOVN4RncmTzFHbjJUvbkTAtpekd
         i/Ri3xb4zk3Rb3tAkKzqyPR1JZhQJJHZxyEIqwFqfAvPj7ixE4MLMOVl/JFDzs6wZ+3l
         QglwqiQ9uzvfcFo+JZAaST5l1J90EuY9yQGG+mB3/H/Ey8RlPowFrZawfn0x1wp/lqNZ
         SfGbyPJ7FeTZHLo0ydUR/imunygOYBTXBmvkln9bMBUuacwVEA9H3S2Lhoine8s9YzoP
         tYGvnM75B8m2wcH4H+2g9lePGkLQvXqs+0L8iXw/x8RhMzATIidEqg8dqcuTvwtLtoc7
         Uthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158205; x=1728763005;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhqqVaGZmOo9qC4oo0q/uwTQj9+Y9nVOVKHgeiFJY7I=;
        b=KYnPnuR4n8InfkDRfU3b1Y0gy17GSRFBUE0UAEPCZrD6whh23qTJ5FfOGFFL8Bu0kY
         6wN1dbLcppy8uXpP1gXb80ki59XahD5CyC7dqBQL5Aic5V9t+yLE7cTDiSmbbeLrtAb0
         eXM3JJkAPIUU9Lv/FZTUtU7gRdYLumpmA+WExZOVbhzkZqEzKX0m0YvdkfB6HM2NAXl+
         DXbkTppW9+LR+zlr8/wn/+Kf3f9ZOM9MVkN3yT34Xy9bWAHPQRPKwWjN7qphyE5UqxtD
         +dAPUKFeLPa1QqNKYcr09/xJp8fMcW4L8hzfZVCKLlhoV0OjuJBOUXABBSVKoFf6hvhn
         ayXg==
X-Forwarded-Encrypted: i=1; AJvYcCVY7oficlvbHEK9I85bHqK3jkMlWTfFNYOq94a5rXeQHUDbnh5vMVibMn46wt3ytGQae0KUgYLzh4xnn9c2R+2x@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQYbJyw+nAvk9K2W/jttLFrOBPKqBKyQHMtmobxefPhEl+9fm
	cvIoXdlZo/K0NIzgaZFsThRtHFwmCx1q4Qtg9fQSftoeEL63in6xMmySQqfYndlZshfKXThAF2k
	pZgtVGA==
X-Google-Smtp-Source: AGHT+IEYRFo/fWSM7s0rsO5HBzMUs/VjHez83bNv/Y68jCxqYjWk7CUUEsc2Ty9/UzFK7TfFboZq2Mftucjl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:6f05:0:b0:e20:cfc2:a326 with SMTP id
 3f1490d57ef6-e28932a484bmr64007276.6.1728158204973; Sat, 05 Oct 2024 12:56:44
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:31 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 21/31] perf dwarf-regs: Move csky dwarf-regs out of arch
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
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Move arch/csky/util/dwarf-regs.c to util/dwarf-regs-csky.c and compile
in unconditionally. To avoid get_arch_regstr being duplicated, rename
to get_csky_regstr and add to get_dwarf_regstr switch.

Update #ifdefs to allow ABI V1 and V2 tables at the same
time. Determine the table from the ELF flags.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/csky/util/Build               |  1 -
 tools/perf/util/Build                         |  1 +
 .../dwarf-regs.c => util/dwarf-regs-csky.c}   | 19 ++++++++++---------
 tools/perf/util/dwarf-regs.c                  | 11 +++++++----
 tools/perf/util/include/dwarf-regs.h          |  2 ++
 5 files changed, 20 insertions(+), 14 deletions(-)
 rename tools/perf/{arch/csky/util/dwarf-regs.c => util/dwarf-regs-csky.c} (74%)

diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
index 1325310cab6a..5e6ea82c4202 100644
--- a/tools/perf/arch/csky/util/Build
+++ b/tools/perf/arch/csky/util/Build
@@ -1,4 +1,3 @@
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c2221ef431f3..c75366b60b88 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -202,6 +202,7 @@ endif
 perf-util-$(CONFIG_LIBDW) += probe-finder.o
 perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
diff --git a/tools/perf/arch/csky/util/dwarf-regs.c b/tools/perf/util/dwarf-regs-csky.c
similarity index 74%
rename from tools/perf/arch/csky/util/dwarf-regs.c
rename to tools/perf/util/dwarf-regs-csky.c
index ca86ecaeacbb..d38ef1f07f3e 100644
--- a/tools/perf/arch/csky/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs-csky.c
@@ -5,9 +5,8 @@
 #include <stddef.h>
 #include <dwarf-regs.h>
 
-#if defined(__CSKYABIV2__)
-#define CSKY_MAX_REGS 73
-const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
+#define CSKY_ABIV2_MAX_REGS 73
+const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] = {
 	/* r0 ~ r8 */
 	"%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1", "%regs2", "%regs3",
 	/* r9 ~ r15 */
@@ -26,9 +25,9 @@ const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
 	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 	"%epc",
 };
-#else
-#define CSKY_MAX_REGS 57
-const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
+
+#define CSKY_ABIV1_MAX_REGS 57
+const char *csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] = {
 	/* r0 ~ r8 */
 	"%sp", "%regs9", "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1",
 	/* r9 ~ r15 */
@@ -41,9 +40,11 @@ const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
 	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 	"%epc",
 };
-#endif
 
-const char *get_arch_regstr(unsigned int n)
+const char *get_csky_regstr(unsigned int n, unsigned int flags)
 {
-	return (n < CSKY_MAX_REGS) ? csky_dwarf_regs_table[n] : NULL;
+	if (flags & EF_CSKY_ABIV2)
+		return (n < CSKY_ABIV2_MAX_REGS) ? csky_dwarf_regs_table_abiv2[n] : NULL;
+
+	return (n < CSKY_ABIV1_MAX_REGS) ? csky_dwarf_regs_table_abiv1[n] : NULL;
 }
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index fd21f9e90e40..9a76f83af62c 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -29,17 +29,18 @@
 #define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n)] : NULL)
 
 /* Return architecture dependent register string (for kprobe-tracer) */
-const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
-			     unsigned int flags __maybe_unused)
+const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
-#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM
+#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
+    || EM_HOST == EM_CSKY
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
 	}
 #endif
 	switch (machine) {
-#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM
+#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
+    && EM_HOST != EM_CSKY
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
@@ -51,6 +52,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
 		return __get_dwarf_regstr(arm_regstr_tbl, n);
 	case EM_AARCH64:
 		return __get_dwarf_regstr(aarch64_regstr_tbl, n);
+	case EM_CSKY:
+		return get_csky_regstr(n, flags);
 	case EM_SH:
 		return __get_dwarf_regstr(sh_regstr_tbl, n);
 	case EM_S390:
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 0b533409d82a..b72d9d308ce4 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -83,6 +83,8 @@
 const char *get_arch_regstr(unsigned int n);
 #endif
 
+const char *get_csky_regstr(unsigned int n, unsigned int flags);
+
 /**
  * get_dwarf_regstr() - Returns ftrace register string from DWARF regnum.
  * @n: DWARF register number.
-- 
2.47.0.rc0.187.ge670bccf7e-goog

