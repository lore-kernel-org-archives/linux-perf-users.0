Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4510446B4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124747; cv=none; b=qpqPJfUGpNZhq5aspMRvsQkR+qUUFBtlOExfmYuqlDXzeqJuoSzzqViRLuIFfjF7YxWiamTQCR39KQ+mS2s4nBdG3qQ0iajXXU6c7d1Q1CyqedcyFvRxWXn2qCp5vk8PiO9rXn74bFk1PziKwNvXKAh5QpKIbc/GjtbEKZ3G7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124747; c=relaxed/simple;
	bh=cSnnzLtCUsybzckZ1r7qlceOaKrcnA6b3R9CwCRFJyY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FfPMLn3w6xlwPTikNqDhL/MANNMnvOKZdYJwpKN2WCI5q6Y8MQ0KwBgy+t/NdZfHrpA3oR47jpkQtnFuTJsMoXw6+Q43FT+yWDYH/4axc6vlGK+85D6g909jJEGIZMwcHbEkgfeUMEFH093+xIIsi8nLXz/5i4gV7mKx/J6MuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2MSmBRz8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2MSmBRz8"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2939e25402so617254276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124745; x=1729729545; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkIA/FyfXW8ws5sjRdf4oBh+1+aldg/GVrUyDFRat30=;
        b=2MSmBRz8uu62uY4Rz1bMOQa6x48qnYuJ5Q3qOKy+7lQv5LuHCt8UX/Ljmzsp42KqSV
         YacK9Bf09HjuJ+jkuVnP8+UeL0i2E8CbCZJsNSXeciy8piqLzvMXOdtY10ybMqV8CJLT
         9/ZhFRbiB3R1/14hjUCgrufp4iRX7UFKxQMvdg13QHglL2sIiKcfmrQAZ1abPSZEK7eV
         WjkzJMt4fV9bDaV3GF/j+A63oIJTO9juLEiROSXNkAeRyw6Swp5dfFWoiy7nd6i4lljN
         1r9ryCg0xeTdvlLjY0CVlpe9ysdB90yJiFydA3dozWxtCnEExtoGorivoRCcOO918QHI
         ZFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124745; x=1729729545;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkIA/FyfXW8ws5sjRdf4oBh+1+aldg/GVrUyDFRat30=;
        b=ElJBJUb8qS+Tk9cLh7d9EkPpAi7IzfNEDdek6Ju6TL44mhEr1EXsvm6vNEVQ8KCB/J
         /mtotPPOMVuohCgygqJ3dOETrKV6UngDKlgHGP8RrwEV8TAX/pMm/5r3xeoeaebceDKC
         NeAsY2tQMugywDF+pP4aWQeMRLdK22vTLHHWO16ImbJ/L8y9SsgpfAyvMIi7F+7+RAlr
         UKmlkLWdqGLHfsmqbP/KwB5WuErZfm8pMk8JlxuE+gDKyob4oguo3zVaNJuC6bA4QNbW
         RuAnhHcjj8WMiWs0aOFRVcn72d9pbam7YIqO78Z5KDiq+HjuVs3kXe2Qg+I6XYSWRjc7
         aGBw==
X-Forwarded-Encrypted: i=1; AJvYcCUaPc9pHzrpg3YdvNCwpVT3MWNPC8LXxcKdeK2yn5PvC732QdAerQVs+bJM7LrfczLKzj83MFaETz4ySZU1H4Uf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2zYtIWUMfwU3nnckIHzvamBYTHq/VY4MqlKIAcuUt7vkyQ9jc
	etDmXkc0Q96hA8rlul2XUqzeAko6ACnBCfrIY0GOJhGHBC/+kV5APzSDVArFzE6RKrzQlZUHhcq
	kovc/Og==
X-Google-Smtp-Source: AGHT+IFe1Hb6lpRahuVZ4DDC/bHM6yCUrUEOQ+AJ0+tNqmO08JGP6ePh7fxc0X0rMoFvoFsezm94Q0V+zEE6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:a267:0:b0:e28:ec75:75ed with SMTP id
 3f1490d57ef6-e29780ec57amr6223276.0.1729124744652; Wed, 16 Oct 2024 17:25:44
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:07 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 07/20] perf dwarf-regs: Move x86 dwarf-regs out of arch
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

Move arch/x86/util/dwarf-regs.c to util/dwarf-regs-x86.c and compile
in unconditionally. To avoid get_arch_regnum being duplicated, rename
to get_x86_regnum and add to get_dwarf_regnum switch.

For get_arch_regstr, this was unused on x86 unless the machine type
was EM_NONE. Map that case to EM_HOST and remove get_arch_regstr from
dwarf-regs-x86.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/Build                |  3 ---
 tools/perf/util/Build                         |  1 +
 .../dwarf-regs.c => util/dwarf-regs-x86.c}    | 24 +------------------
 tools/perf/util/dwarf-regs.c                  | 17 +++++++++++++
 tools/perf/util/include/dwarf-regs.h          |  8 +++++++
 5 files changed, 27 insertions(+), 26 deletions(-)
 rename tools/perf/{arch/x86/util/dwarf-regs.c => util/dwarf-regs-x86.c} (77%)

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 9705cda4f240..70af491a6dd7 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -12,9 +12,6 @@ perf-util-y += evsel.o
 perf-util-y += iostat.o
 perf-util-y += env.o
 
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
-perf-util-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
-
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1eedead5f2f2..4c615611b9d7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -203,6 +203,7 @@ endif
 perf-util-$(CONFIG_LIBDW) += probe-finder.o
 perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
 
diff --git a/tools/perf/arch/x86/util/dwarf-regs.c b/tools/perf/util/dwarf-regs-x86.c
similarity index 77%
rename from tools/perf/arch/x86/util/dwarf-regs.c
rename to tools/perf/util/dwarf-regs-x86.c
index 530905118cd4..7a55c65e8da6 100644
--- a/tools/perf/arch/x86/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs-x86.c
@@ -11,28 +11,6 @@
 #include <linux/kernel.h> /* for ARRAY_SIZE */
 #include <dwarf-regs.h>
 
-#define DEFINE_DWARF_REGSTR_TABLE 1
-#include "dwarf-regs-table.h"
-
-/* Return architecture dependent register string (for kprobe-tracer) */
-const char *get_arch_regstr(unsigned int n)
-{
-#if defined(__i386__)
-	size_t len = ARRAY_SIZE(x86_32_regstr_tbl);
-#else
-	size_t len = ARRAY_SIZE(x86_64_regstr_tbl);
-#endif
-
-	if (n >= len)
-		return NULL;
-
-#if defined(__i386__)
-	return x86_32_regstr_tbl[n];
-#else
-	return x86_64_regstr_tbl[n];
-#endif
-}
-
 struct dwarf_regs_idx {
 	const char *name;
 	int idx;
@@ -58,7 +36,7 @@ static const struct dwarf_regs_idx x86_regidx_table[] = {
 	{ "rip", DWARF_REG_PC },
 };
 
-int get_arch_regnum(const char *name)
+int get_x86_regnum(const char *name)
 {
 	unsigned int i;
 
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 86b3ef638fbb..eac99a246737 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,9 +32,17 @@
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
 			     unsigned int flags __maybe_unused)
 {
+#if EM_HOST == EM_X86_64 || EM_HOST == EM_386
+	if (machine == EM_NONE) {
+		/* Generic arch - use host arch */
+		machine = EM_HOST;
+	}
+#endif
 	switch (machine) {
+#if EM_HOST != EM_X86_64 && EM_HOST != EM_386
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
+#endif
 	case EM_386:
 		return __get_dwarf_regstr(x86_32_regstr_tbl, n);
 	case EM_X86_64:
@@ -65,10 +73,12 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
 	return NULL;
 }
 
+#if EM_HOST != EM_X86_64 && EM_HOST != EM_386
 __weak int get_arch_regnum(const char *name __maybe_unused)
 {
 	return -ENOTSUP;
 }
+#endif
 
 /* Return DWARF register number from architecture register name */
 int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags __maybe_unused)
@@ -90,9 +100,16 @@ int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags
 		machine = EM_HOST;
 	}
 	switch (machine) {
+#if EM_HOST != EM_X86_64 && EM_HOST != EM_386
 	case EM_HOST:
 		reg = get_arch_regnum(regname);
 		break;
+#endif
+	case EM_X86_64:
+		fallthrough;
+	case EM_386:
+		reg = get_x86_regnum(regname);
+		break;
 	default:
 		pr_err("ELF MACHINE %x is not supported.\n", machine);
 	}
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 925525405e2d..062623aefd5a 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -79,7 +79,10 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
+#if !defined(__x86_64__) && !defined(__i386__)
 const char *get_arch_regstr(unsigned int n);
+#endif
+
 /**
  * get_dwarf_regstr() - Returns ftrace register string from DWARF regnum.
  * @n: DWARF register number.
@@ -88,7 +91,12 @@ const char *get_arch_regstr(unsigned int n);
  */
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags);
 
+int get_x86_regnum(const char *name);
+
+#if !defined(__x86_64__) && !defined(__i386__)
 int get_arch_regnum(const char *name);
+#endif
+
 /*
  * get_dwarf_regnum - Returns DWARF regnum from register name
  * name: architecture register name
-- 
2.47.0.105.g07ac214952-goog

