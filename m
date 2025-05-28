Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BEC1FDE09
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748466545; cv=none; b=JSXAD/fgpcyzpuSuI4x6ZH7MDaT2WOTR9u0ZuBj1D2RwvV7Ei1z+aYI8shVbNwMkvXZL2cbnxr4nJBc5UxrkoTkXagNJUfivc/24Y9cAcy6ZYyGYCwU9AXTycxVzSeHnBLpLtNUIWAP8P9I+yeFktpGExZwTEDQgjUdYPJVV5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748466545; c=relaxed/simple;
	bh=LIQqj/rBG4WJ9Who6aNm8nmVF5Zg8C2dGZq6Mmu5uXE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=WAu0b2wFENdA18kFoTBNptlmKoqwD97sX6CBO3Ue1eH4moeV9xrp2fEFFDhKIrfLBUtUSm6wrLWWoAEkF1oajhpsWikVA8gogr9/eRRY/CRTWCTdOFTs3wgRl1c118QPj6sgXKxSkSiDPypfmeQC78guxbjqNLzWDEIKPV+lcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvt8rGyG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvt8rGyG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23202dacd94so3240065ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748466543; x=1749071343; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fgz4RLpwM5kTcN0bNVkBpOujZlSaW0l8gHcBwYFiKWw=;
        b=pvt8rGyGD4Jhka+GB2O/Th3WwmgPfghY8ZkIUD47dCkKJ84uCqYST9DmcJe/neqtXd
         BEGPvq4ph4sX3UeFBupNaV0Xr2kYtpyL603JpAShBu9OmCnZv3/hQ7knDsPSqeidTS5W
         2szKSr9z3rQgWPH35lXzBetb17ij1001MAIgjQ6AbkM1m+OO47oVPT4YVdpjbpM2BQ/M
         N0Dpvf8etruwMVH/nLkL/7BWPV19fRxpbBB0yw//wUCp2o95n2VKkBw+RMBFat83vRwk
         AGOjhTYLbBEzZW3uTpDcQkuTa9qZfU3+tBGP25jGVjzcoSGKh3eVrxyZPUORKf7p+dwv
         g2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748466543; x=1749071343;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fgz4RLpwM5kTcN0bNVkBpOujZlSaW0l8gHcBwYFiKWw=;
        b=LCKbGGlEV2PZTDvF6DVdE//rQQR1XpKQKxW8vZVPoKlQwuwWBMK21qu2zAb1WxEOGv
         lB9LtI42s1SFTCOXk5nPBOxTEtt4wWtw4hUxjGJAfosm21k8QxXU2KreIIajB2JByHf9
         qpbJecGkpBf48ka+YfUiiGRyu7TTw3vVqOPJpavvYyCZAHMjJHhFW99zZtpJt9hQTqE6
         j/AfO641ohM0SnrQe3rNRLFx/SjNoySpGyorwsmifF37h9QA0yDaFsBqn/0eQDQmLlXu
         /Yvgl1fL1MSPjpM0Oyt8LaMdQZJkf9RRfJukehmpLY9cmhDUEqaBoPai42qRpIj9W2TA
         rZzw==
X-Forwarded-Encrypted: i=1; AJvYcCV3yI51B4ZrbQfKBx+94ST1YZqJPCGNkeJ3sszGT9soigriCuIBQGztuUXvAUtFwbAFvEsx/cQz6MnZV+jvK4s/@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSt53GdN2+xfazpgoLCC6EEvpeWhjZ4dNGzUpkhwP65vgRGQl
	1NcO58X7AaKgC+kdFlIlprxINCo4quvA81H12lqBXO0Ppe2SHxQ1nXW0Auo4XN/6m8aALdMV0T3
	YGCIPJIauhw==
X-Google-Smtp-Source: AGHT+IHEuBh0mTSW0osNedaN9qHRnf++NfYvmP1VWxvfmSTBGmGBn6W3fdTiYgeI8fDDxSyFi1cnq5SSmGu7
X-Received: from plky7.prod.google.com ([2002:a17:902:7007:b0:234:6701:babc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c4:b0:234:a033:b6f6
 with SMTP id d9443c01a7336-234a033ba9bmr124093795ad.31.1748466543024; Wed, 28
 May 2025 14:09:03 -0700 (PDT)
Date: Wed, 28 May 2025 14:08:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250528210858.499898-1-irogers@google.com>
Subject: [PATCH v3] perf symbol: Move demangling code out of symbol-elf.c
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

Structurally, while moving the functions rename demangle_sym to
dso__demangle_sym which is already a function exposed in symbol.h and
the only purpose of which in symbol-elf.c was to call
demangle_sym. Change the calls to demangle_sym in symbol-elf.c to
calls to dso__demangle_sym.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3. Separate patch as most of v2 landed already. Fix issues with
    libelf build while merging dso__demangle_sym and demangle_sym to
    remove some unneeded complexity.
    The thread comm_lock fix also isn't included:
https://lore.kernel.org/lkml/20250528032637.198960-8-irogers@google.com/
    as discussion on that has moved to a revert by Arnaldo:
https://lore.kernel.org/lkml/aDcyVLVpZRui1ole@x1/
---
 tools/perf/util/demangle-cxx.h   |  2 +
 tools/perf/util/symbol-elf.c     | 92 ++------------------------------
 tools/perf/util/symbol-minimal.c |  7 ---
 tools/perf/util/symbol.c         | 82 ++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 96 deletions(-)

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
index 8734e8b6cf84..01818abd02df 100644
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
@@ -641,7 +560,7 @@ static bool get_plt_got_name(GElf_Shdr *shdr, size_t i,
 	/* Get the associated symbol */
 	gelf_getsym(di->dynsym_data, vr->sym_idx, &sym);
 	sym_name = elf_sym__name(&sym, di->dynstr_data);
-	demangled = demangle_sym(di->dso, 0, sym_name);
+	demangled = dso__demangle_sym(di->dso, /*kmodule=*/0, sym_name);
 	if (demangled != NULL)
 		sym_name = demangled;
 
@@ -839,7 +758,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 		gelf_getsym(syms, get_rel_symidx(&ri, idx), &sym);
 
 		elf_name = elf_sym__name(&sym, symstrs);
-		demangled = demangle_sym(dso, 0, elf_name);
+		demangled = dso__demangle_sym(dso, /*kmodule=*/0, elf_name);
 		if (demangled)
 			elf_name = demangled;
 		if (*elf_name)
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
@@ -1861,7 +1775,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			}
 		}
 
-		demangled = demangle_sym(dso, kmodule, elf_name);
+		demangled = dso__demangle_sym(dso, kmodule, elf_name);
 		if (demangled != NULL)
 			elf_name = demangled;
 
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
index fe801880afea..8b30c6f16a9e 100644
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
@@ -2648,3 +2654,79 @@ int symbol__validate_sym_arguments(void)
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
+char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
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
-- 
2.49.0.1204.g71687c7c1d-goog

