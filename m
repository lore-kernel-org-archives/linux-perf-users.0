Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1017BA1
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401267; cv=none; b=dUMrH38OTSIx4J2YxBgmHI9DBB60yK7FP9VGENgzJvQfF/9yNOByc3RWD4j+vUpe7Ik8pHjO2fc9nvEMP91+5zE1sNCAKeSH6jcr0/ncuRWwhrH0VY9dPNej413MBSIiIjZhdNlHj8iFMvgMcUqZPgL6qeBk9kY6MIVnsLIkzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401267; c=relaxed/simple;
	bh=3qmxm3uWpleNoQM2dTR//KfRYjSQjZ5j+IUwY35Tm4M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=neqZCERaCOvMdc9XsjRou4rfsw+vcl4DIhtZD4v93ul4LsWe0+sjGf48xAcdbK1dpE0RH0eSfUpOBfZljmfSE6DSjJirDLFbItftxW+tjFBJw9ypyV+CLiAC4TV7n3u+YiKP+P47s1RRnQqjBMVgc7Ty52FoFSMjyZ7WHf15cWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b9uOII+o; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9uOII+o"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a77eb9abdfaso161779666b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721401264; x=1722006064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BSk7wcHdurJH2vAuTggwyNuB0CqNfEgi0Xw/aIp/1Qs=;
        b=b9uOII+oRDpLgUdJLdZGmNsqFdktdaCt5HeUzkVQaM3rKN6V2n8qfrihl/p17UJyEV
         Sa6PzzrFA9uJ3CV8T40JcS3gTuOne5++7YJovdc2j1UjPrfBZ0z9LL6XfV2rXFOr4W73
         RZ/UNkavNjNaJVbxfDfFyJ4NIizbxDltU4ebd70cWCanHs4Rrya9RGuzLLtDK+jmfFJj
         7gVvyZv9R4UHE9Y1DTeEcK0U++Z2i8rVb3XzkOdM1G8PD+uGfqtfSZdKHezlhgx4Wh2W
         OnUOZ88idii0dX/vwq8UxQJc9jgwbF1MZd2zU5LS9fWpTJUM7J+WyZ3E6MirchzRlzCc
         uHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401264; x=1722006064;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSk7wcHdurJH2vAuTggwyNuB0CqNfEgi0Xw/aIp/1Qs=;
        b=PnkQh2XW8YLWonTqU+TINFVGrjVgWI7CRUhmXX7pYf0lgGuJiXbPjFexQ4tYWIAG66
         lv466X4Ych/K3nVa5E4sH/AsfcP/fSJb4VsfcG/k8XlABaQBoYqsJMKSpxQ42My0bEUn
         V2fqaGxscObfDGkUpI9S84kT/2h67rJOeBjpQ/MTOSHAqAAlxubvlWW7r/tu4Pi6o77t
         lyTa+dPfoQE+1xKMrPzrKIUikfnEBawmTR5dgA27/A8YbfIAyy0caX0iJdiduW+3yT4P
         qZv7JmeD13uOlZVsOJm1B+m2MdHTdLcycsUVRDxKmHFtcNO9zSh5RmcPTHt/rH4HVw/C
         4tWQ==
X-Gm-Message-State: AOJu0YyduuP588GHNRK3URwiL5Rpm/rwLc/9ccGXx5h/D8BKYPARW7Ht
	sYZUSG2vIva+z8lrBLJ8SFtRdWWgniExqqVoEnpPsu+8MdCGcfIkp8DLI9K3B29+0WFerdQhjg=
	=
X-Google-Smtp-Source: AGHT+IH6878HLtbUFFQS1VE4JuouTleejR4Ot2NeWoQu5diFwKBn9Vx4OTgS2kGWfZaFMrFOeC4d3IFqvw==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:5684:1eca:607a:2a0c])
 (user=sesse job=sendgmr) by 2002:a17:907:c31c:b0:a6f:53a7:adad with SMTP id
 a640c23a62f3a-a7a01190d53mr564966b.7.1721401263253; Fri, 19 Jul 2024 08:01:03
 -0700 (PDT)
Date: Fri, 19 Jul 2024 17:00:49 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719150051.520317-1-sesse@google.com>
Subject: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, "Steinar H. Gunderson" <sesse@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

In addition to the existing support for libbfd and calling out to
an external addr2line command, add support for using libllvm directly.
This is both faster than libbfd, and can be enabled in distro builds
(the LLVM license has an explicit provision for GPLv2 compatibility).
Thus, it is set as the primary choice if available.

As an example, running perf report on a medium-size profile with
DWARF-based backtraces took 58 seconds with LLVM, 78 seconds with
libbfd, 153 seconds with external llvm-addr2line, and I got tired
and aborted the test after waiting for 55 minutes with external
bfd addr2line (which is the default for perf as compiled by distributions
today). Evidently, for this case, the bfd addr2line process needs
18 seconds (on a 5.2 GHz Zen 3) to load the .debug ELF in question,
hits the 1-second timeout and gets killed during initialization,
getting restarted anew every time. Having an in-process addr2line
makes this much more robust.

As future extensions, libllvm can be used in many other places where
we currently use libbfd or other libraries:

 - Symbol enumeration (in particular, for PE binaries).
 - Demangling (including non-Itanium demangling, e.g. Microsoft
   or Rust).
 - Disassembling (perf annotate).

However, these are much less pressing; most people don't profile
PE binaries, and perf has non-bfd paths for ELF. The same with
demangling; the default _cxa_demangle path works fine for most
users, and while bfd objdump can be slow on large binaries,
it is possible to use --objdump=llvm-objdump to get the speed benefits.
(It appears LLVM-based demangling is very simple, should we want
that.)

Tested with LLVM 14, 15, 16, 18 and 19. For some reason, LLVM 12 was not
correctly detected using feature_check, and thus was not tested.

Signed-off-by: Steinar H. Gunderson <sesse@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature       |   1 +
 tools/perf/Makefile.config         |  17 ++++
 tools/perf/builtin-version.c       |   1 +
 tools/perf/tests/make              |   2 +
 tools/perf/util/Build              |   1 +
 tools/perf/util/llvm-c-helpers.cpp | 134 +++++++++++++++++++++++++++++
 tools/perf/util/llvm-c-helpers.h   |  49 +++++++++++
 tools/perf/util/srcline.c          |  58 ++++++++++++-
 8 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/llvm-c-helpers.cpp
 create mode 100644 tools/perf/util/llvm-c-helpers.h

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 1e2ab148d5db..278b26216254 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -136,6 +136,7 @@ FEATURE_DISPLAY ?=              \
          libunwind              \
          libdw-dwarf-unwind     \
          libcapstone            \
+         llvm                   \
          zlib                   \
          lzma                   \
          get_cpuid              \
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a4829b6532d8..7825832737f1 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -972,6 +972,23 @@ ifdef BUILD_NONDISTRO
   endif
 endif
 
+ifndef NO_LIBLLVM
+  $(call feature_check,llvm)
+  ifeq ($(feature-llvm), 1)
+    CFLAGS += -DHAVE_LIBLLVM_SUPPORT
+    CFLAGS += $(shell $(LLVM_CONFIG) --cflags)
+    CXXFLAGS += -DHAVE_LIBLLVM_SUPPORT
+    CXXFLAGS += $(shell $(LLVM_CONFIG) --cxxflags)
+    LIBLLVM = $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG) --system-libs)
+    EXTLIBS += -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
+    EXTLIBS += -lstdc++
+    $(call detected,CONFIG_LIBLLVM)
+  else
+    $(warning No libllvm found, slower source file resolution, please install llvm-devel/llvm-dev)
+    NO_LIBLLVM := 1
+  endif
+endif
+
 ifndef NO_DEMANGLE
   $(call feature_check,cxa-demangle)
   ifeq ($(feature-cxa-demangle), 1)
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 398aa53e9e2e..4b252196de12 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -65,6 +65,7 @@ static void library_status(void)
 	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
 	STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
 	STATUS(HAVE_LIBELF_SUPPORT, libelf);
+	STATUS(HAVE_LIBLLVM_SUPPORT, libllvm);
 	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
 	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
 	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index a1f8adf85367..3df8b030eaa3 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -92,6 +92,7 @@ make_no_libbpf	    := NO_LIBBPF=1
 make_libbpf_dynamic := LIBBPF_DYNAMIC=1
 make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
 make_no_libcrypto   := NO_LIBCRYPTO=1
+make_no_libllvm     := NO_LIBLLVM=1
 make_with_babeltrace:= LIBBABELTRACE=1
 make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
@@ -161,6 +162,7 @@ run += make_no_auxtrace
 run += make_no_libbpf
 run += make_no_libbpf_DEBUG
 run += make_no_libcrypto
+run += make_no_libllvm
 run += make_no_sdt
 run += make_no_syscall_tbl
 run += make_with_babeltrace
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0f18fe81ef0b..cfb64706ffe7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -226,6 +226,7 @@ perf-util-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
 perf-util-y += demangle-ocaml.o
 perf-util-y += demangle-java.o
 perf-util-y += demangle-rust.o
+perf-util-$(CONFIG_LIBLLVM) += llvm-c-helpers.o
 
 ifdef CONFIG_JITDUMP
 perf-util-$(CONFIG_LIBELF) += jitdump.o
diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
new file mode 100644
index 000000000000..3cc967ec6f28
--- /dev/null
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Must come before the linux/compiler.h include, which defines several
+ * macros (e.g. noinline) that conflict with compiler builtins used
+ * by LLVM.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM <= 15 */
+#include <llvm/DebugInfo/Symbolize/Symbolize.h>
+#pragma GCC diagnostic pop
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <linux/compiler.h>
+extern "C" {
+#include <linux/zalloc.h>
+}
+#include "symbol_conf.h"
+#include "llvm-c-helpers.h"
+
+using namespace llvm;
+using llvm::symbolize::LLVMSymbolizer;
+
+/*
+ * Allocate a static LLVMSymbolizer, which will live to the end of the program.
+ * Unlike the bfd paths, LLVMSymbolizer has its own cache, so we do not need
+ * to store anything in the dso struct.
+ */
+static LLVMSymbolizer *get_symbolizer()
+{
+	static LLVMSymbolizer *instance = nullptr;
+	if (instance == nullptr) {
+		LLVMSymbolizer::Options opts;
+		/*
+		 * LLVM sometimes demangles slightly different from the rest
+		 * of the code, and this mismatch can cause new_inline_sym()
+		 * to get confused and mark non-inline symbol as inlined
+		 * (since the name does not properly match up with base_sym).
+		 * Thus, disable the demangling and let the rest of the code
+		 * handle it.
+		 */
+		opts.Demangle = false;
+		instance = new LLVMSymbolizer(opts);
+	}
+	return instance;
+}
+
+/* Returns 0 on error, 1 on success. */
+static int extract_file_and_line(const DILineInfo &line_info, char **file,
+				 unsigned int *line)
+{
+	if (file) {
+		if (line_info.FileName == "<invalid>") {
+			/* Match the convention of libbfd. */
+			*file = nullptr;
+		} else {
+			/* The caller expects to get something it can free(). */
+			*file = strdup(line_info.FileName.c_str());
+			if (*file == nullptr)
+				return 0;
+		}
+	}
+	if (line)
+		*line = line_info.Line;
+	return 1;
+}
+
+extern "C"
+int llvm_addr2line(const char *dso_name, u64 addr,
+		   char **file, unsigned int *line,
+		   bool unwind_inlines,
+		   llvm_a2l_frame **inline_frames)
+{
+	LLVMSymbolizer *symbolizer = get_symbolizer();
+	object::SectionedAddress sectioned_addr = {
+		addr,
+		object::SectionedAddress::UndefSection
+	};
+
+	if (unwind_inlines) {
+		Expected<DIInliningInfo> res_or_err =
+			symbolizer->symbolizeInlinedCode(dso_name,
+							 sectioned_addr);
+		if (!res_or_err)
+			return 0;
+		unsigned num_frames = res_or_err->getNumberOfFrames();
+		if (num_frames == 0)
+			return 0;
+
+		if (extract_file_and_line(res_or_err->getFrame(0),
+					  file, line) == 0)
+			return 0;
+
+		*inline_frames = (llvm_a2l_frame *)calloc(
+			num_frames, sizeof(**inline_frames));
+		if (*inline_frames == nullptr)
+			return 0;
+
+		for (unsigned i = 0; i < num_frames; ++i) {
+			const DILineInfo &src = res_or_err->getFrame(i);
+
+			llvm_a2l_frame &dst = (*inline_frames)[i];
+			if (src.FileName == "<invalid>")
+				/* Match the convention of libbfd. */
+				dst.filename = nullptr;
+			else
+				dst.filename = strdup(src.FileName.c_str());
+			dst.funcname = strdup(src.FunctionName.c_str());
+			dst.line = src.Line;
+
+			if (dst.filename == nullptr ||
+			    dst.funcname == nullptr) {
+				for (unsigned j = 0; j <= i; ++j) {
+					zfree(&(*inline_frames)[j].filename);
+					zfree(&(*inline_frames)[j].funcname);
+				}
+				zfree(inline_frames);
+				return 0;
+			}
+		}
+
+		return num_frames;
+	} else {
+		if (inline_frames)
+			*inline_frames = nullptr;
+
+		Expected<DILineInfo> res_or_err =
+			symbolizer->symbolizeCode(dso_name, sectioned_addr);
+		if (!res_or_err)
+			return 0;
+		return extract_file_and_line(*res_or_err, file, line);
+	}
+}
diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-helpers.h
new file mode 100644
index 000000000000..19332dd98e14
--- /dev/null
+++ b/tools/perf/util/llvm-c-helpers.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_LLVM_C_HELPERS
+#define __PERF_LLVM_C_HELPERS 1
+
+/*
+ * Helpers to call into LLVM C++ code from C, for the parts that do not have
+ * C APIs.
+ */
+
+#include <linux/compiler.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct llvm_a2l_frame {
+  char* filename;
+  char* funcname;
+  unsigned int line;
+};
+
+/*
+ * Implement addr2line() using libLLVM. LLVM is a C++ API, and
+ * many of the linux/ headers cannot be included in a C++ compile unit,
+ * so we need to make a little bridge code here. llvm_addr2line() will
+ * convert the inline frame information from LLVM's internal structures
+ * and put them into a flat array given in inline_frames. The caller
+ * is then responsible for taking that array and convert it into perf's
+ * regular inline frame structures (which depend on e.g. struct list_head).
+ *
+ * If the address could not be resolved, or an error occurred (e.g. OOM),
+ * returns 0. Otherwise, returns the number of inline frames (which means 1
+ * if the address was not part of an inlined function). If unwind_inlines
+ * is set and the return code is nonzero, inline_frames will be set to
+ * a newly allocated array with that length. The caller is then responsible
+ * for freeing both the strings and the array itself.
+ */
+int llvm_addr2line(const char* dso_name,
+                   u64 addr,
+                   char** file,
+                   unsigned int* line,
+                   bool unwind_inlines,
+                   struct llvm_a2l_frame** inline_frames);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __PERF_LLVM_C_HELPERS */
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 760742fd4a7d..2e3845ac07ee 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -16,6 +16,9 @@
 #include "util/debug.h"
 #include "util/callchain.h"
 #include "util/symbol_conf.h"
+#ifdef HAVE_LIBLLVM_SUPPORT
+#include "util/llvm-c-helpers.h"
+#endif
 #include "srcline.h"
 #include "string2.h"
 #include "symbol.h"
@@ -130,7 +133,60 @@ static struct symbol *new_inline_sym(struct dso *dso,
 
 #define MAX_INLINE_NEST 1024
 
-#ifdef HAVE_LIBBFD_SUPPORT
+#ifdef HAVE_LIBLLVM_SUPPORT
+
+static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
+				    int num_frames)
+{
+	if (inline_frames != NULL) {
+		for (int i = 0; i < num_frames; ++i) {
+			zfree(&inline_frames[i].filename);
+			zfree(&inline_frames[i].funcname);
+		}
+		zfree(&inline_frames);
+	}
+}
+
+static int addr2line(const char *dso_name, u64 addr,
+		     char **file, unsigned int *line, struct dso *dso,
+		     bool unwind_inlines, struct inline_node *node,
+		     struct symbol *sym)
+{
+	struct llvm_a2l_frame *inline_frames = NULL;
+	int num_frames = llvm_addr2line(dso_name, addr, file, line,
+					node && unwind_inlines, &inline_frames);
+
+	if (num_frames == 0 || !inline_frames) {
+		/* Error, or we didn't want inlines. */
+		return num_frames;
+	}
+
+	for (int i = 0; i < num_frames; ++i) {
+		struct symbol *inline_sym =
+			new_inline_sym(dso, sym, inline_frames[i].funcname);
+		char *srcline = NULL;
+
+		if (inline_frames[i].filename) {
+			srcline =
+				srcline_from_fileline(inline_frames[i].filename,
+						      inline_frames[i].line);
+		}
+		if (inline_list__append(inline_sym, srcline, node) != 0) {
+			free_llvm_inline_frames(inline_frames, num_frames);
+			return 0;
+		}
+	}
+	free_llvm_inline_frames(inline_frames, num_frames);
+
+	return num_frames;
+}
+
+void dso__free_a2l(struct dso *)
+{
+	/* Nothing to free. */
+}
+
+#elif defined(HAVE_LIBBFD_SUPPORT)
 
 /*
  * Implement addr2line using libbfd.
-- 
2.45.2

