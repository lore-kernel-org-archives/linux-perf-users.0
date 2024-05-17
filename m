Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2813DDCD
	for <linux-perf-users@vger.kernel.org>; Fri, 17 May 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972078; cv=none; b=TB2gWYX5eyQvsiX/bIb+JSWpRb1QMiFqbgQ1JNv7rpP63ywtBOSRxiv+2yeilsreo0Xxy3psuHgv6E3C79KQZcmi86FdxPDDHSfELswhF7souiT5O8C4xyloCaKaMgVUEiR6wUIzas9ETY2sWSmt+0pf2i4gRpggTkVfCUFGRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972078; c=relaxed/simple;
	bh=Af/LX4nYJ+p/G72D0JNppNxNj4GdBNAcHU4aOn6XHxU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lk6tH5FOS1nInpk3bIAdu3Twfh/6tiB3dPIY5zn+nsARx1aKfa2roC6FaVfj8946J7apVXifV+0xN0izptd6Hxkdu4X2RL7kp70m1LjnfRqTXJmtkdTh25RMI2FvCOYuQCPgY4bzgUW2xzYbvNyin3Wt2EDqqSR9HU3sDBm0Luw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blKnvbI1; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blKnvbI1"
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-51fa975896eso8468802e87.3
        for <linux-perf-users@vger.kernel.org>; Fri, 17 May 2024 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715972075; x=1716576875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xfbZ6HcOz3jd5IZxyShCM+13zycHkUJfmzDmYqdGA8k=;
        b=blKnvbI1zQO2o96A1p3l+tHrwspP5nT8ucHCefnODyQsMc55A6w2+6MBpCiJ/rCYIw
         AyFi/DFChnBcThy+pFN21I/9MEq3VHHIvurp+U+P1ppG75KKlvYAUk6opTyGUjGXmScC
         GbKxdLynJKNI8cbQYeYzRpDaZXEBBa0BKy/U+QVKmQukeFadrYm2gA5OIpgRxAMyEctd
         E5E5dAkpwhRoFYpwNVh4RykGyEG0dMrPHaJ0udPiR9KLZCbTAZmONLU7A4ZK5b1ulF5p
         F66tBZ4iUxHOugOy6Rl5Rq1AJ2XEY5/JK9Wx/IdS1FOUh/yNcJqf9LtpPihtkGGlyz3U
         1oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715972075; x=1716576875;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfbZ6HcOz3jd5IZxyShCM+13zycHkUJfmzDmYqdGA8k=;
        b=h4e32WMfKQ8ozlvAkAY7KzUM5+mDjfPz5cnT4d69Huzpcj5qQVqWQD4t/yt+BivNjm
         RTgwvdhC/AkENNyLJF4qBHjKNzX+8+p+2JH1MLjhHipoB7K41OVtAB329fs1qeeDFqbL
         RqfhyYRVstEplxiJ/QJiKKlm5Zmn8DmHmE2BOLRwXegGyx62MoQS6zeI8Baq1kMyOhJF
         bJ3q5hshqicq4LAGUhK1Ys1KKhMfr5+ibGZ6CwdprIGSRlm1b8TszCFV4WfvY/YMQRYh
         01gsOUwvccUOn42JNhFUsem8pE8i3AZqAdmhQaIM2NvBDji4fecni9b2DEQyCdbAOewV
         mkgw==
X-Gm-Message-State: AOJu0YxxzOMfkIU/2ZrEcMKkMr56fBafJ1YsecvR3jO7Jd6ZOTC7YqCl
	k05v+F8s5OSFgYoihc8HUe1I1QaDzELy2XXT3i1DQKlzb0fBSCdq6SWC/leHUUqR3RuzAU3OwQ=
	=
X-Google-Smtp-Source: AGHT+IH3xQWfW2sqCVMgWeQI/O+hicItdSMCyV0dMHA+kE7gjt5NUH3NTw6QktRng57Ud5tv22U+VFJjOQ==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:ee94:fca6:48e6:9bb8])
 (user=sesse job=sendgmr) by 2002:a19:741a:0:b0:520:53cb:85de with SMTP id
 2adb3069b0e04-5220ff70b27mr22680e87.2.1715972074502; Fri, 17 May 2024
 11:54:34 -0700 (PDT)
Date: Fri, 17 May 2024 20:54:26 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240517185426.3659651-1-sesse@google.com>
Subject: [PATCH] perf report: Support LLVM for addr2line()
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, "Steinar H. Gunderson" <sesse@google.com>
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
users. And for disassembling, external objdump works fairly well;
bfd objdump can be slow on large binaries, but it is possible
to use --objdump=llvm-objdump to get the speed benefits.
(It appears LLVM-based demangling is very simple, and that LLVM-based
disassembling is somewhat more involved.)

Tested with LLVM 14, 16, 18 and 19. For some reason, LLVM 12 was not
correctly detected using feature_check, and thus was not tested.

Signed-off-by: Steinar H. Gunderson <sesse@google.com>
---
 tools/perf/Makefile.config         |  15 ++++
 tools/perf/builtin-version.c       |   1 +
 tools/perf/util/Build              |   1 +
 tools/perf/util/llvm-addr2line.cpp | 134 +++++++++++++++++++++++++++++
 tools/perf/util/llvm-addr2line.h   |  42 +++++++++
 tools/perf/util/srcline.c          |  55 +++++++++++-
 6 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/llvm-addr2line.cpp
 create mode 100644 tools/perf/util/llvm-addr2line.h

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..414a37f712bd 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -969,6 +969,21 @@ ifdef BUILD_NONDISTRO
   endif
 endif
 
+ifndef NO_LLVM
+  $(call feature_check,llvm)
+  ifeq ($(feature-llvm), 1)
+    CFLAGS += -DHAVE_LLVM_SUPPORT
+    CXXFLAGS += -DHAVE_LLVM_SUPPORT
+    CXXFLAGS += $(shell $(LLVM_CONFIG) --cxxflags)
+    LIBLLVM = $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG) --system-libs)
+    EXTLIBS += -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
+    $(call detected,CONFIG_LLVM)
+  else
+    $(warning No libllvm found, slower source file resolution, please install llvm-devel/llvm-dev)
+    NO_LLVM := 1
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
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index da64efd8718f..1cf17afd51f4 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -226,6 +226,7 @@ perf-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
 perf-y += demangle-ocaml.o
 perf-y += demangle-java.o
 perf-y += demangle-rust.o
+perf-$(CONFIG_LLVM) += llvm-addr2line.o
 
 ifdef CONFIG_JITDUMP
 perf-$(CONFIG_LIBELF) += jitdump.o
diff --git a/tools/perf/util/llvm-addr2line.cpp b/tools/perf/util/llvm-addr2line.cpp
new file mode 100644
index 000000000000..145488ed1346
--- /dev/null
+++ b/tools/perf/util/llvm-addr2line.cpp
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Must come before the linux/compiler.h include, which defines several
+ * macros (e.g. noinline) that conflict with compiler builtins used by LLVM. */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM 14. */
+#include <llvm/DebugInfo/Symbolize/Symbolize.h>
+#pragma GCC diagnostic pop
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <linux/compiler.h>
+#include "symbol_conf.h"
+#include "llvm-addr2line.h"
+
+using namespace llvm;
+using llvm::symbolize::LLVMSymbolizer;
+
+/*
+ * Allocate a static LLVMSymbolizer, which will live to the end of the program.
+ * Unlike the bfd paths, LLVMSymbolizer has its own cache, so we do not need
+ * to store anything in the dso struct.
+ */
+static LLVMSymbolizer *GetSymbolizer()
+{
+	static LLVMSymbolizer *instance = nullptr;
+	if (instance == nullptr) {
+		LLVMSymbolizer::Options Opts;
+		/*
+		 * LLVM sometimes demangles slightly different from the rest
+		 * of the code, and this mismatch can cause new_inline_sym()
+		 * to get confused and mark non-inline symbol as inlined
+		 * (since the name does not properly match up with base_sym).
+		 * Thus, disable the demangling and let the rest of the code
+		 * handle it.
+		 */
+		Opts.Demangle = false;
+		instance = new LLVMSymbolizer(Opts);
+	}
+	return instance;
+}
+
+/* Returns 0 on error, 1 on success. */
+static int extract_file_and_line(const DILineInfo& line_info, char **file,
+				 unsigned int *line)
+{
+	if (file) {
+		if (line_info.FileName == "<invalid>") {
+			/* Match the convention of libbfd. */
+			*file = nullptr;
+		} else {
+			/* The caller expects to get something it can free(). */
+			*file = strdup(line_info.FileName.c_str());
+			if (*file == nullptr) {
+				return 0;
+			}
+		}
+	}
+	if (line) {
+		*line = line_info.Line;
+	}
+	return 1;
+}
+
+extern "C"
+int llvm_addr2line(const char *dso_name, u64 addr,
+		   char **file, unsigned int *line,
+		   bool unwind_inlines,
+		   llvm_a2l_frame** inline_frames)
+{
+	LLVMSymbolizer *symbolizer = GetSymbolizer();
+	object::SectionedAddress sectioned_addr = {
+		addr,
+		object::SectionedAddress::UndefSection
+	};
+
+	if (unwind_inlines) {
+		Expected<DIInliningInfo> res_or_err =
+			symbolizer->symbolizeInlinedCode(dso_name,
+							 sectioned_addr);
+		if (!res_or_err) {
+			return 0;
+		}
+		unsigned num_frames = res_or_err->getNumberOfFrames();
+		if (num_frames == 0) {
+			return 0;
+		}
+
+		if (extract_file_and_line(
+			res_or_err->getFrame(0), file, line) == 0) {
+			return 0;
+		}
+
+		*inline_frames = (llvm_a2l_frame*)malloc(
+			sizeof(**inline_frames) * num_frames);
+		if (*inline_frames == nullptr) {
+			return 0;
+		}
+
+		for (unsigned i = 0; i < num_frames; ++i) {
+			const DILineInfo& src = res_or_err->getFrame(i);
+			llvm_a2l_frame& dst = (*inline_frames)[i];
+			if (src.FileName == "<invalid>") {
+				/* Match the convention of libbfd. */
+				dst.filename = nullptr;
+			} else {
+				dst.filename = strdup(src.FileName.c_str());
+			}
+			dst.funcname = strdup(src.FunctionName.c_str());
+			dst.line = src.Line;
+
+			if (dst.filename == nullptr ||
+			    dst.funcname == nullptr) {
+				for (unsigned j = 0; j <= i; ++j) {
+					free((*inline_frames)[j].filename);
+					free((*inline_frames)[j].funcname);
+				}
+				free(*inline_frames);
+				return 0;
+			}
+		}
+
+		return num_frames;
+	} else {
+		*inline_frames = nullptr;
+
+		Expected<DILineInfo> res_or_err =
+			symbolizer->symbolizeCode(dso_name, sectioned_addr);
+		if (!res_or_err) {
+			return 0;
+		}
+		return extract_file_and_line(*res_or_err, file, line);
+	}
+}
diff --git a/tools/perf/util/llvm-addr2line.h b/tools/perf/util/llvm-addr2line.h
new file mode 100644
index 000000000000..2de4fe79a3d0
--- /dev/null
+++ b/tools/perf/util/llvm-addr2line.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_LLVM_ADDR2LINE
+#define __PERF_LLVM_ADDR2LINE 1
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct llvm_a2l_frame {
+	char *filename;
+	char *funcname;
+	unsigned int line;
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
+int llvm_addr2line(const char *dso_name,
+		   u64 addr,
+		   char **file,
+		   unsigned int *line,
+		   bool unwind_inlines,
+		   struct llvm_a2l_frame **inline_frames);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __PERF_LLVM_ADDR2LINE */
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 9d670d8c1c08..f69ad21a18d4 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -16,6 +16,7 @@
 #include "util/debug.h"
 #include "util/callchain.h"
 #include "util/symbol_conf.h"
+#include "util/llvm-addr2line.h"
 #include "srcline.h"
 #include "string2.h"
 #include "symbol.h"
@@ -130,7 +131,59 @@ static struct symbol *new_inline_sym(struct dso *dso,
 
 #define MAX_INLINE_NEST 1024
 
-#ifdef HAVE_LIBBFD_SUPPORT
+#ifdef HAVE_LLVM_SUPPORT
+
+static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
+				    int num_frames)
+{
+	if (inline_frames != NULL) {
+		for (int i = 0; i < num_frames; ++i) {
+			free(inline_frames[i].filename);
+			free(inline_frames[i].funcname);
+		}
+		free(inline_frames);
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
+		if (inline_frames[i].filename)
+			srcline = srcline_from_fileline(
+				inline_frames[i].filename,
+				inline_frames[i].line);
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
2.43.0

