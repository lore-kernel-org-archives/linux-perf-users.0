Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468231EF0A6
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 03:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402808; cv=none; b=VuEfaEykXhR8qu1j7bXZOIllHDOl7I+qRVPT2JVaNIyoV0odt7AJiPHgYQEYZtDolXq5m4P0bNT7SeRsffJvJs7qewqwP9/tAeCBaPFqd/VIKDF4sUc/LGNDHA0eJsGq+FFWCefGqMUFbPOxBnbDrvJYmcLWIPqL2pGLlhGtk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402808; c=relaxed/simple;
	bh=xNIDxlQfIiKJ4wxyNS7RP5jDUpWuVCs2klHoieSL9Fw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BrlvEtIr97hzPexay9AxO44KEKIRsEVABlTHP9a3bnuqoJui4Y7iQ3aJrg434Wy8qUDmI+xpzi0yae/14UUpbuvVtoD3eOlCXIpk7BcdbHvGJ0vMPuUWNA84tXARkZT+7upNxUxvGjnjVK0kBaAexOfRi6sYebS3FdJ1cqybp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pM+A21js; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pM+A21js"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311d670ad35so542498a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402806; x=1749007606; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnnRVcWeffCiJ7bmNiIQw2qfvOmrVgzWpxYRzccEoxU=;
        b=pM+A21jsoWUY4kkAdcNy5L0NmlKE1T7K/Hl0Sm0Er3Qqa8Mq5ZOZd6iYfBtNF9Bust
         typtB1EPaXLEjiDf91fpESkytPOrYqjd1tBAGL2wCtPidCBahKlcoBBkZKnrq6U8OoV6
         sqgxl8t6xjCiCPdAFeUdLAPOZ4p18LJul0aBm86DnDwXIJcPhEaMUVPX36tpLlnl37nn
         ijpQcBKilml76qs4Pmcd0E2tjJKow6e5xXGH6MxLqLfz3kNpcep4oXcTHnqoG4ytLrrn
         O6B+3TPz/O+HD4h2Cyfac3JUZJTfJn7mOpyISRJDOpjmb0e1fIIY3gqqggZCyPVTdwH5
         6BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402806; x=1749007606;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnnRVcWeffCiJ7bmNiIQw2qfvOmrVgzWpxYRzccEoxU=;
        b=JQt2aaYO4pBzgb8ZKCnsS6/hTvIO5QWVkExmpis43zu+u/2M1aplD2NPOk83DdTxVX
         kcqGpfjMogCLjcFnkX5YunwmuKM1uuNDIfkIPdabjtFAyWiiP8Ph5384J41wJ4vQB0dR
         ilFUQD3aoO5wKe4QgbYJWPIEQ3Z9RseO+o0w4kyaV6XIMiZjtI94CZxYi6GmLKs8Y9or
         MN49kEuzB9KSReJcAguj8sklnchAhwKa4P8jbSguzRrxuv4GrKltja8TjYraZQFspCR5
         uNQXx5Eqifv8L64++mj4UNAQxOioFmzMT6PLPKGpZEuOo5t1oI9sCeUAiUlFc/qnq+L5
         8zSg==
X-Forwarded-Encrypted: i=1; AJvYcCW126BWyqtWY3nbO01Q9liXvt2Gg+ZpDkWJ/lozyvBtFdIbgS1EnSSzY4uxpFrOVi/Fp1JKkdFoNynDGnHdHcog@vger.kernel.org
X-Gm-Message-State: AOJu0YyVAnIfeudMBtPlrGQ2fDdvw4VcZm+vMB6EE7nxegLZN1mOKTGs
	1DcHDgGOVMhpUGNYAm2HsHSUjNoad5mqN8r1SQsg6KsNez6FvkQLwzlo3LmP8Vxo/g5gHl9nV6v
	9nyeIdImj9w==
X-Google-Smtp-Source: AGHT+IFJMChLC+TkmSh5O0FPRu7yheRmG1QS+8bZbiYRRriC4rfm6fuVpZgsk57MC2MAKAXqJsr4uY68qQkL
X-Received: from pjbpx18.prod.google.com ([2002:a17:90b:2712:b0:311:8076:14f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55c3:b0:2ee:94d1:7a89
 with SMTP id 98e67ed59e1d1-3110f0ee05cmr23131668a91.1.1748402806373; Tue, 27
 May 2025 20:26:46 -0700 (PDT)
Date: Tue, 27 May 2025 20:26:33 -0700
In-Reply-To: <20250528032637.198960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250528032637.198960-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250528032637.198960-4-irogers@google.com>
Subject: [PATCH v2 3/7] perf symbol: Move demangling code out of symbol-elf.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

symbol-elf.c is used when building with libelf, symbol-minimal is used
otherwise. There is no reason the demangling code with no dependencies
on libelf is part of symbol-elf.c so move to symbol.c. This allows
demangling tests to pass with NO_LIBELF=1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/demangle-cxx.h   |  2 +
 tools/perf/util/symbol-elf.c     | 86 -------------------------------
 tools/perf/util/symbol-minimal.c |  7 ---
 tools/perf/util/symbol.c         | 87 ++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 93 deletions(-)

diff --git a/tools/perf/util/demangle-cxx.h b/tools/perf/util/demangle-cxx.h
index 26b5b66c0b4e..9359937a881a 100644
--- a/tools/perf/util/demangle-cxx.h
+++ b/tools/perf/util/demangle-cxx.h
@@ -2,6 +2,8 @@
 #ifndef __PERF_DEMANGLE_CXX
 #define __PERF_DEMANGLE_CXX 1
 
+#include <stdbool.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 8734e8b6cf84..60f37f149a87 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -13,17 +13,12 @@
 #include "maps.h"
 #include "symbol.h"
 #include "symsrc.h"
-#include "demangle-cxx.h"
-#include "demangle-ocaml.h"
-#include "demangle-java.h"
-#include "demangle-rust-v0.h"
 #include "machine.h"
 #include "vdso.h"
 #include "debug.h"
 #include "util/copyfile.h"
 #include <linux/ctype.h>
 #include <linux/kernel.h>
-#include <linux/log2.h>
 #include <linux/zalloc.h>
 #include <linux/string.h>
 #include <symbol/kallsyms.h>
@@ -280,82 +275,6 @@ static int elf_read_program_header(Elf *elf, u64 vaddr, GElf_Phdr *phdr)
 	return -1;
 }
 
-static bool want_demangle(bool is_kernel_sym)
-{
-	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
-}
-
-/*
- * Demangle C++ function signature, typically replaced by demangle-cxx.cpp
- * version.
- */
-#ifndef HAVE_CXA_DEMANGLE_SUPPORT
-char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
-		       bool modifiers __maybe_unused)
-{
-#ifdef HAVE_LIBBFD_SUPPORT
-	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
-
-	return bfd_demangle(NULL, str, flags);
-#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
-	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
-
-	return cplus_demangle(str, flags);
-#else
-	return NULL;
-#endif
-}
-#endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
-
-static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
-{
-	struct demangle rust_demangle = {
-		.style = DemangleStyleUnknown,
-	};
-	char *demangled = NULL;
-
-	/*
-	 * We need to figure out if the object was created from C++ sources
-	 * DWARF DW_compile_unit has this, but we don't always have access
-	 * to it...
-	 */
-	if (!want_demangle((dso && dso__kernel(dso)) || kmodule))
-		return demangled;
-
-	rust_demangle_demangle(elf_name, &rust_demangle);
-	if (rust_demangle_is_known(&rust_demangle)) {
-		/* A rust mangled name. */
-		if (rust_demangle.mangled_len == 0)
-			return demangled;
-
-		for (size_t buf_len = roundup_pow_of_two(rust_demangle.mangled_len * 2);
-		     buf_len < 1024 * 1024; buf_len += 32) {
-			char *tmp = realloc(demangled, buf_len);
-
-			if (!tmp) {
-				/* Failure to grow output buffer, return what is there. */
-				return demangled;
-			}
-			demangled = tmp;
-			if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
-							   /*alternate=*/true) == OverflowOk)
-				return demangled;
-		}
-		/* Buffer exceeded sensible bounds, return what is there. */
-		return demangled;
-	}
-
-	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
-	if (demangled)
-		return demangled;
-
-	demangled = ocaml_demangle_sym(elf_name);
-	if (demangled)
-		return demangled;
-
-	return java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
-}
-
 struct rel_info {
 	u32		nr_entries;
 	u32		*sorted;
@@ -868,11 +787,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	return 0;
 }
 
-char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
-{
-	return demangle_sym(dso, kmodule, elf_name);
-}
-
 /*
  * Align offset to 4 bytes as needed for note name and descriptor data.
  */
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 36c1d3090689..c73fe2e09fe9 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -355,13 +355,6 @@ void symbol__elf_init(void)
 {
 }
 
-char *dso__demangle_sym(struct dso *dso __maybe_unused,
-			int kmodule __maybe_unused,
-			const char *elf_name __maybe_unused)
-{
-	return NULL;
-}
-
 bool filename__has_section(const char *filename __maybe_unused, const char *sec __maybe_unused)
 {
 	return false;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fe801880afea..9d712416f0b6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -19,6 +19,11 @@
 #include "build-id.h"
 #include "cap.h"
 #include "cpumap.h"
+#include "debug.h"
+#include "demangle-cxx.h"
+#include "demangle-java.h"
+#include "demangle-ocaml.h"
+#include "demangle-rust-v0.h"
 #include "dso.h"
 #include "util.h" // lsdir()
 #include "debug.h"
@@ -36,6 +41,7 @@
 #include "header.h"
 #include "path.h"
 #include <linux/ctype.h>
+#include <linux/log2.h>
 #include <linux/zalloc.h>
 
 #include <elf.h>
@@ -2648,3 +2654,84 @@ int symbol__validate_sym_arguments(void)
 	}
 	return 0;
 }
+
+static bool want_demangle(bool is_kernel_sym)
+{
+	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
+}
+
+/*
+ * Demangle C++ function signature, typically replaced by demangle-cxx.cpp
+ * version.
+ */
+#ifndef HAVE_CXA_DEMANGLE_SUPPORT
+char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
+		       bool modifiers __maybe_unused)
+{
+#ifdef HAVE_LIBBFD_SUPPORT
+	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
+
+	return bfd_demangle(NULL, str, flags);
+#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
+	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
+
+	return cplus_demangle(str, flags);
+#else
+	return NULL;
+#endif
+}
+#endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
+
+static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
+{
+	struct demangle rust_demangle = {
+		.style = DemangleStyleUnknown,
+	};
+	char *demangled = NULL;
+
+	/*
+	 * We need to figure out if the object was created from C++ sources
+	 * DWARF DW_compile_unit has this, but we don't always have access
+	 * to it...
+	 */
+	if (!want_demangle((dso && dso__kernel(dso)) || kmodule))
+		return demangled;
+
+	rust_demangle_demangle(elf_name, &rust_demangle);
+	if (rust_demangle_is_known(&rust_demangle)) {
+		/* A rust mangled name. */
+		if (rust_demangle.mangled_len == 0)
+			return demangled;
+
+		for (size_t buf_len = roundup_pow_of_two(rust_demangle.mangled_len * 2);
+		     buf_len < 1024 * 1024; buf_len += 32) {
+			char *tmp = realloc(demangled, buf_len);
+
+			if (!tmp) {
+				/* Failure to grow output buffer, return what is there. */
+				return demangled;
+			}
+			demangled = tmp;
+			if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
+							   /*alternate=*/true) == OverflowOk)
+				return demangled;
+		}
+		/* Buffer exceeded sensible bounds, return what is there. */
+		return demangled;
+	}
+
+	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
+	if (demangled)
+		return demangled;
+
+	demangled = ocaml_demangle_sym(elf_name);
+	if (demangled)
+		return demangled;
+
+	return java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
+}
+
+char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
+{
+	return demangle_sym(dso, kmodule, elf_name);
+}
-- 
2.49.0.1238.gf8c92423fb-goog

