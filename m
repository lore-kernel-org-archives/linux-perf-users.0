Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947F21A717
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109596; cv=none; b=adozVBA+6CRRioUmkfXnf/iEzwQ+l4HhC7Op22nlayygTF2Oy1A5J6Dym5vtmknbav+HGxVkklzjX3Vr5RPZ8mM5SQqeEe6rRjCwEMGgSlBE4P1IKaBcue44vqEPkYSCPN1lLXYO9IQBFBIuFg3N1ygdL0KftG6+zfhU7dCoLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109596; c=relaxed/simple;
	bh=29T1y97kB+lhr6TadqNlBMzJFRSDRopLP2kzM6BqLHA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ku2e2eMG0Jl9VhsdPxmBV/zRKTCtmn+TNU2Zzq48Kn9YyRo61Z8RjAPp5kIJQ1AvkrCfBJGx+KE3+kACYrsTvtrrg6gf54K03e+AW6zqN1gF/ZDsxGDqxUj0pMXoIW/t26O2yDiZv/EPKRCF6D1k8q5Ngiv3E64lHDFEa9+kHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5aFe+ac; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5aFe+ac"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea9618de40so574327b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 15:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109593; x=1731714393; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PwSQD5rPF8FyaIrPq7KuguhdmexCo6TmzlSGry04ok=;
        b=p5aFe+ac8XGuw1SOaTcAzW2nGljxP0TF22X/CGVAUhk16loUORwo+q0jnmrvar5fGz
         M04av9ReZEU+ZKN0i+4aMji/mGz9HKzond+pdYTDR4lleUNDztbhDfLdj4pkcbC72BpI
         JvoJ/T3BIQqITd5yX9ICfbHEGSheVoSNrEwiGDqjNC23qUfBsDfCyIi8kXCv4aAzdyCo
         8F16+z9gsB6UBN9FE1Wk0lvmT9589IWTmSifSP2No2OoCp1MF/N4q0B29xA9BGkbxjpr
         ihSJW3EwyCLP0RbgosfX5oOrjWmn+GShbNcr7x3WURBbtBM9SGms1ZLbnZFxglM5BqQo
         gj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109593; x=1731714393;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PwSQD5rPF8FyaIrPq7KuguhdmexCo6TmzlSGry04ok=;
        b=L2ovIyUE+6XK/z6WlVaqpo0rGycBQXBoPiG+nsL26XzZdN9++qa5gkbhEPyop7qj8d
         JG631jbAJ1VVWkNFce3op9+PBpqwJblDbIO6PHn7MjUiAeesxw1gS7zTWLEV7abQJ0GR
         vgyMoJJAM2T78sDB9N44JRF+AdOwMO3/epjxy4NEQqI0aUe9LpPtTUT0FaIIznfFA+qs
         YPDUpXY8FTL0UHxDf/5oScePnMO7VWaeijOR1UmP8Z8FEeO7QpQc3QCUxEekQkcoc1Ia
         53PqtMYsGHqrOgi+R9o3e+gFLuj0oTX8xY8h0VvhDgaZLCSauMvyCpjgRDTBVhUYqFVZ
         Bfww==
X-Forwarded-Encrypted: i=1; AJvYcCUJICAtG86VQXMWJi46aw0j0hQ4QNlpqhNx7BsquD9onbXXHrrvTsrDjisjE9C23cPGqgLSW0M/PGWYFXoKPvEH@vger.kernel.org
X-Gm-Message-State: AOJu0YywuNe3IlnrbzokQKn49KC9VzWjVQMGancmp0u/XCsXIENEjpGy
	/k7o+oleR0798HrC+Na+ndrH7MI8SPZuUEH9NENecb3YlwrGmdqoUjqgEPIVpwoNyB3eXjW2uy8
	bFASH+Q==
X-Google-Smtp-Source: AGHT+IHBYZ/o09AHQKMYb06lTJXmOE6GhHv0V4FjCIxjCSvh+yJRbzHl2yi0vhbJNIkRxA6ZAQm1zUkIswk5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a05:690c:34c1:b0:6db:c6eb:bae9 with SMTP
 id 00721157ae682-6eaddd75f78mr475957b3.2.1731109593320; Fri, 08 Nov 2024
 15:46:33 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:55 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 10/20] perf dwarf-regs: Move csky dwarf-regs out of arch
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

Move arch/csky/util/dwarf-regs.c to util/dwarf-regs-csky.c and compile
in unconditionally. To avoid get_arch_regstr being duplicated, rename
to get_csky_regstr and add to get_dwarf_regstr switch.

Update #ifdefs to allow ABI V1 and V2 tables at the same
time. Determine the table from the ELF flags.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
index 4c615611b9d7..99ae4e2802b8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -203,6 +203,7 @@ endif
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
index 3652f9d98fe4..0641c2942b01 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -93,6 +93,8 @@
 const char *get_arch_regstr(unsigned int n);
 #endif
 
+const char *get_csky_regstr(unsigned int n, unsigned int flags);
+
 /**
  * get_dwarf_regstr() - Returns ftrace register string from DWARF regnum.
  * @n: DWARF register number.
-- 
2.47.0.277.g8800431eea-goog

