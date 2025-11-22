Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6142F068E
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804381; cv=none; b=mRb6x8t3WZWlDq3kcs89247R5IUwHExbtVORrCRIL31fUud5WaHWdBWQY5gn9YKFQYYrS7e43ioJaHYtQe3Zm7tp47eNH9GHqlCmJ7WM35Z1IabYA3f73tAVSUSKnU8AVgAUuH+2jNF3sf7b+DOg0/MzXl7j7qN8a57/a6nQdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804381; c=relaxed/simple;
	bh=M1Lv66lBOlUL0S9vjDpwss+M1zKHXqnjtEP/ZOEfk7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Zt6e6QPsD66AIri1lx+/KqV/a0GQvlyW50uWUKKIfrgj0fxHo9UsBs/SfNDmfyrn+erYGMusjudlAGSVhANGx06p6Ns1AczM/g2zWgYMxGAiFhiZqUoEzBn0G035Yyo6Ti7d4hDwcrJ6FNgonOBD9OMS2evprilHOU8Rs+mRmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m979gj+A; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m979gj+A"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bce224720d8so5767096a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763804379; x=1764409179; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S4YkWQjq9/dm65LbO1t0z9KMAXrWJjZjmnqtJHIq/H8=;
        b=m979gj+A2tIS75RrpGsvgqkr06vtx1p/imdyDCUMcn74u2ddhxz8DSGbDvWnwY+lQW
         Wg/o9upleX+ERvkOeA3kRwDKfgwbZ6BzKuU+TRwJs7z+IycE09g3xpHrpv6xriQ6Enqy
         /bOJaLm/7T7P9kBgmw+59BBMBk8wEBRY6TFrJVGjULY/+jCXRIOk8dHHOvakEUXnMqEV
         WgY43egTBdWUxBPO0+31jORl16UMQg8zP6qUoS/c3m18C+mVo+f97xvk/UEj4g1hI7pY
         Lj2oCW1Hokodl7BnXmbo+fwydt5UdPYidpN/yU4NBmzKEFMbteVkbWEiZyInCqdAz7jW
         dipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763804379; x=1764409179;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4YkWQjq9/dm65LbO1t0z9KMAXrWJjZjmnqtJHIq/H8=;
        b=VqMQSxzFB67cfzGyVC7bh+J6xHLB6rNBhAnHsPromQPRJaNIMqwTrUgAJpU/W7TnZn
         SYaUVacch+TuuCp9XcEMl0pLuJUc5M2j7VheoPzR/Aoq2M5YdIrFwtPpP3YPagSaqe0n
         vywMhD/iGLCH5DzRsuygIwwylOxIBSTuww6CrSvV3GBL5/qfIRahTQbyNTL1tD8ngMWn
         8/ModVm+b4Q/qChLm+ixfsZEAxldO6/VFkIC9WjSCcCX5A+4ZPxHpDC8IhfCIn15iRgk
         2lyTvj9On6XbzKSi1jMIfymTpY6kfDn/oJzX/FS8tQqq36TINHgEBLRLIek4MoX74ttH
         xVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSvdzU0WheBkzT6Yu6+R15v4a3cNMGSHhFtDzdg7ji+JfeXJyds251PsCh9787mdJx1Aw9pXInjbn8e7ND0+fN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zkrBELQbyEdNKfxRGRri8eM4CuODHZHKug21Tc6Y52i7bxJN
	JuOrjsYD6TIXdTyEOha1Nc8BGF5sCzh8t+EdtHrzFHDJpRZk74OYnKaWspwuNHzrBxmbhF7Jbey
	sgh5/w5Fcnw==
X-Google-Smtp-Source: AGHT+IH9/M7s9+GAG5xuwJo2NpUTXIRBSvzKUv4n4vEWVE98HTYkIbjNVctReFma3PkpAQheXQ34UNq7khz9
X-Received: from dybor21.prod.google.com ([2002:a05:7301:1f15:b0:2a4:7bd8:45d4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:51fc:b0:2a4:3593:645a
 with SMTP id 5a478bee46e88-2a71910148amr1951323eec.10.1763804379030; Sat, 22
 Nov 2025 01:39:39 -0800 (PST)
Date: Sat, 22 Nov 2025 01:39:34 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122093934.94971-1-irogers@google.com>
Subject: [PATCH v1] perf addr2line: Add a libdw implementation
From: Ian Rogers <irogers@google.com>
To: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an implementation of addr2line that uses libdw. Other addr2line
implementations or, in the case of forking addr2line, slow. Add an
implementation that caches the libdw information in the dso and uses
it to find the file and line number information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build     |   1 +
 tools/perf/util/dso.c     |   2 +
 tools/perf/util/dso.h     |  11 +++
 tools/perf/util/libdw.c   | 136 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/libdw.h   |  60 +++++++++++++++++
 tools/perf/util/srcline.c |   5 ++
 6 files changed, 215 insertions(+)
 create mode 100644 tools/perf/util/libdw.c
 create mode 100644 tools/perf/util/libdw.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1c2a43e1dc68..2bed6274e248 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -224,6 +224,7 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
+perf-util-$(CONFIG_LIBDW) += libdw.o
 
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 344e689567ee..06980844c014 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -32,6 +32,7 @@
 #include "string2.h"
 #include "vdso.h"
 #include "annotate-data.h"
+#include "libdw.h"
 
 static const char * const debuglink_paths[] = {
 	"%.0s%s",
@@ -1605,6 +1606,7 @@ void dso__delete(struct dso *dso)
 	auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
 	dso_cache__free(dso);
 	dso__free_a2l(dso);
+	dso__free_a2l_libdw(dso);
 	dso__free_symsrc_filename(dso);
 	nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
 	mutex_destroy(dso__lock(dso));
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f8ccb9816b89..4aee23775054 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -268,6 +268,7 @@ DECLARE_RC_STRUCT(dso) {
 	const char	 *short_name;
 	const char	 *long_name;
 	void		 *a2l;
+	void		 *a2l_libdw;
 	char		 *symsrc_filename;
 #if defined(__powerpc__)
 	void		*dwfl;			/* DWARF debug info */
@@ -334,6 +335,16 @@ static inline void dso__set_a2l(struct dso *dso, void *val)
 	RC_CHK_ACCESS(dso)->a2l = val;
 }
 
+static inline void *dso__a2l_libdw(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->a2l_libdw;
+}
+
+static inline void dso__set_a2l_libdw(struct dso *dso, void *val)
+{
+	RC_CHK_ACCESS(dso)->a2l_libdw = val;
+}
+
 static inline unsigned int dso__a2l_fails(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->a2l_fails;
diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
new file mode 100644
index 000000000000..c4331fa8e1a3
--- /dev/null
+++ b/tools/perf/util/libdw.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "dso.h"
+#include "libdw.h"
+#include "srcline.h"
+#include "symbol.h"
+#include "dwarf-aux.h"
+#include <fcntl.h>
+#include <unistd.h>
+#include <elfutils/libdwfl.h>
+
+void dso__free_a2l_libdw(struct dso *dso)
+{
+	Dwfl *dwfl = dso__a2l_libdw(dso);
+
+	if (dwfl) {
+		dwfl_end(dwfl);
+		dso__set_a2l_libdw(dso, NULL);
+	}
+}
+
+int libdw__addr2line(const char *dso_name, u64 addr,
+		     char **file, unsigned int *line_nr,
+		     struct dso *dso, bool unwind_inlines,
+		     struct inline_node *node, struct symbol *sym)
+{
+	static const Dwfl_Callbacks offline_callbacks = {
+		.find_debuginfo = dwfl_standard_find_debuginfo,
+		.section_address = dwfl_offline_section_address,
+		.find_elf = dwfl_build_id_find_elf,
+	};
+	Dwfl *dwfl = dso__a2l_libdw(dso);
+	Dwfl_Module *mod;
+	Dwfl_Line *dwline;
+	Dwarf_Addr bias;
+	const char *src;
+	int lineno;
+
+	if (!dwfl) {
+		/*
+		 * Initialize Dwfl session.
+		 * We need to open the DSO file to report it to libdw.
+		 */
+		int fd;
+
+		fd = open(dso_name, O_RDONLY);
+		if (fd < 0)
+			return 0;
+
+		dwfl = dwfl_begin(&offline_callbacks);
+		if (!dwfl) {
+			close(fd);
+			return 0;
+		}
+
+		/*
+		 * If the report is successful, the file descriptor fd is consumed
+		 * and closed by the Dwfl. If not, it is not closed.
+		 */
+		mod = dwfl_report_offline(dwfl, dso_name, dso_name, fd);
+		if (!mod) {
+			dwfl_end(dwfl);
+			close(fd);
+			return 0;
+		}
+
+		dwfl_report_end(dwfl, /*removed=*/NULL, /*arg=*/NULL);
+		dso__set_a2l_libdw(dso, dwfl);
+	} else {
+		/* Dwfl session already initialized, get module for address. */
+		mod = dwfl_addrmodule(dwfl, addr);
+	}
+
+	if (!mod)
+		return 0;
+
+	/* Find source line information for the address. */
+	dwline = dwfl_module_getsrc(mod, addr);
+	if (!dwline)
+		return 0;
+
+	/* Get line information. */
+	src = dwfl_lineinfo(dwline, &addr, &lineno, /*col=*/NULL, /*mtime=*/NULL, /*length=*/NULL);
+
+	if (file)
+		*file = src ? strdup(src) : NULL;
+	if (line_nr)
+		*line_nr = lineno;
+
+	/* Optionally unwind inline function call chain. */
+	if (unwind_inlines && node && src) {
+		Dwarf_Die *cudie = dwfl_module_addrdie(mod, addr, &bias);
+		Dwarf_Die *scopes = NULL;
+		int nscopes;
+
+		if (!cudie)
+			return 1;
+
+		nscopes = die_get_scopes(cudie, addr, &scopes);
+		if (nscopes > 0) {
+			int i;
+			const char *call_file = src;
+			unsigned int call_line = lineno;
+
+			for (i = 0; i < nscopes; i++) {
+				Dwarf_Die *die = &scopes[i];
+				struct symbol *inline_sym;
+				char *srcline = NULL;
+				int tag = dwarf_tag(die);
+
+				/* We are interested in inlined subroutines. */
+				if (tag != DW_TAG_inlined_subroutine &&
+				    tag != DW_TAG_subprogram)
+					continue;
+
+				inline_sym = new_inline_sym(dso, sym, dwarf_diename(die));
+
+				if (call_file)
+					srcline = srcline_from_fileline(call_file, call_line);
+
+				inline_list__append(inline_sym, srcline, node);
+
+				/* Update call site for next level. */
+				if (tag == DW_TAG_inlined_subroutine) {
+					call_file = die_get_call_file(die);
+					call_line = die_get_call_lineno(die);
+				} else {
+					/* Reached the root subprogram. */
+					break;
+				}
+			}
+			free(scopes);
+		}
+	}
+
+	return 1;
+}
diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
new file mode 100644
index 000000000000..0f8d7b4a11a5
--- /dev/null
+++ b/tools/perf/util/libdw.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef PERF_LIBDW_H
+#define PERF_LIBDW_H
+
+#include <linux/types.h>
+
+struct dso;
+struct inline_node;
+struct symbol;
+
+#ifdef HAVE_LIBDW_SUPPORT
+/*
+ * libdw__addr2line - Convert address to source location using libdw
+ * @dso_name: Name of the DSO
+ * @addr: Address to resolve
+ * @file: Pointer to return filename (caller must free)
+ * @line_nr: Pointer to return line number
+ * @dso: The dso struct
+ * @unwind_inlines: Whether to unwind inline function calls
+ * @node: Inline node list to append to
+ * @sym: The symbol associated with the address
+ *
+ * This function initializes a Dwfl context for the DSO if not already present,
+ * finds the source line information for the given address, and optionally
+ * resolves inline function call chains.
+ *
+ * Returns 1 on success (found), 0 on failure (not found).
+ */
+int libdw__addr2line(const char *dso_name, u64 addr, char **file,
+		     unsigned int *line_nr, struct dso *dso,
+		     bool unwind_inlines, struct inline_node *node,
+		     struct symbol *sym);
+
+/*
+ * dso__free_a2l_libdw - Free libdw resources associated with the DSO
+ * @dso: The dso to free resources for
+ *
+ * This function cleans up the Dwfl context used for addr2line lookups.
+ */
+void dso__free_a2l_libdw(struct dso *dso);
+
+#else /* HAVE_LIBDW_SUPPORT */
+
+static inline int libdw__addr2line(const char *dso_name __maybe_unused,
+				   u64 addr __maybe_unused, char **file __maybe_unused,
+				   unsigned int *line_nr __maybe_unused,
+				   struct dso *dso __maybe_unused,
+				   bool unwind_inlines __maybe_unused,
+				   struct inline_node *node __maybe_unused,
+				   struct symbol *sym __maybe_unused)
+{
+	return 0;
+}
+
+static inline void dso__free_a2l_libdw(struct dso *dso __maybe_unused)
+{
+}
+#endif /* HAVE_LIBDW_SUPPORT */
+
+#endif /* PERF_LIBDW_H */
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 27c0966611ab..4b456c4d4138 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -6,6 +6,7 @@
 #include "libbfd.h"
 #include "llvm.h"
 #include "symbol.h"
+#include "libdw.h"
 
 #include <inttypes.h>
 #include <string.h>
@@ -120,6 +121,10 @@ static int addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
 {
 	int ret;
 
+	ret = libdw__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
+	if (ret > 0)
+		return ret;
+
 	ret = llvm__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
 	if (ret > 0)
 		return ret;
-- 
2.52.0.rc2.455.g230fcf2819-goog

