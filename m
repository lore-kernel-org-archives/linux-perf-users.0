Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5822A813
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Jan 2026 04:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104830; cv=none; b=kv4C3/LkYwKuMYKpIbZ8IAU+a9F9Pb8ei5xsrwDLugapGx1T55lyquCxkT0rKaggCuzOPl/feA4sq8ST+akmS17g+YjsWJgPDgOqFIweKnBitDLLFfmw8RW6Y7p3xRsYBMeOqbvivocBrHWusrlI20WXz0i832hMaqMMtiZX6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104830; c=relaxed/simple;
	bh=vbotyXwHVaKQdR8kWhULvZX/q/Vx9nOv1N41aPN7mqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XNWYejiLZVqE/DdLnQVW20EM2+sKaiku2lJWMD/bdk0WRwtm3vZiw/FL72nf7M+pewY8pls5nFvmQWHPSoBeNT+J7ymVrWYOCPrA/stY/OazQUq4g0NAynDVjI9srGZ5MQacVGUN8TGLxfxnEeOw+TEsOJMJomrCs8uSsJ4yuB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lcSGs09Y; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lcSGs09Y"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11f44c1b352so25458465c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 20:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768104828; x=1768709628; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XX6WklKQED5MQz6zoFdrgpViZ0pRXopoy8NTHgEomUs=;
        b=lcSGs09Y3OB9qn9cD3IvlRhlG0pQIbvV/5ZLoPALVNBRRnj8BclZ59XOPvS+HTsM1e
         vZusKX6W0HMp1KGYmu1OXiGdUkYQHRmCqSoFQ8/vtPyynq+YA8uXSYsIk2LpQ5lw8D+8
         LCkhkzcziNoI2HiCdfgiWoQWFJbwce4USqyrlSe4plowtKEnAPRTkv3sL/dud0E7Q0PL
         qZplsU3krKQ+phsBDAv/C895QH3pjqRQ62Q6KHF9uJhIs8pJhukO9KO4W0mEDw/xdzAt
         fepRM8k9jhCa8vq9DrwmsNifOPz+OT7ta8NaGdpt57ROUYDJjNYxzgQbgA30T2wZEjLP
         EbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768104828; x=1768709628;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XX6WklKQED5MQz6zoFdrgpViZ0pRXopoy8NTHgEomUs=;
        b=p57fKz9pIUgkgCOfIwRV3Xwf2r6Px+kjS7odJwvL1IRnLaw63FHfMi3WVo33ryFx5J
         jMRlOkIRu2LsCls1WdMSGqQ0hONi8EZVg2NAUORXDG2BCH7n2UkSlCwb02RRKBeZVcJM
         QxMH2pDdy6Biqnq3DlGRsnwS2g0EO/8y8+v30Dpk32cIK5PBnJhW4M2g1ZyrOxhMzspl
         nXpY/DjJJUKfcsfzhx6c1kZEqbtxclUNqc/MBbPLMSNxp/C1KHGwaW0dLQh6Ha9Qe8M5
         k3Rr+tnGx6aKcEQZiq8N/3mtdEToc7dyN/Yp5tjyZ/erX88H2KTqhB7ORGXaBuNaRdza
         fo2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3/jbrWcqeBGHR8rpeaKqzKQDuUYH8rxsefox0VOZYe21PGwRHrMWZesVy5x7jrtXTjsWaR7OauHxz3TMsRlgZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJu+t2hO20W0VkB5DtnknP+NUJLa2JPaO4oiSe10YlOgnJYMG
	VCgCcV2Uzvon9gXeOgFaolSV0VhqESHBJMroS6bqkXN41S22Fj7Btk6Bztc0rP9gedh8v6+eFBe
	MInH8bYT9ug==
X-Google-Smtp-Source: AGHT+IFK1G1xoON7/3F189m6pWX3kWwUZdKybhURrDnYvHvCLdlYAK8IVeveMfQnoxoCRj8Y2Xi+0z5koxvH
X-Received: from dlbbz28.prod.google.com ([2002:a05:7022:239c:b0:11f:42e8:ad40])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:248b:b0:119:e56b:c758
 with SMTP id a92af1059eb24-121f8b43c16mr11028508c88.29.1768104827527; Sat, 10
 Jan 2026 20:13:47 -0800 (PST)
Date: Sat, 10 Jan 2026 20:13:33 -0800
In-Reply-To: <20260111041338.1817056-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260111041338.1817056-3-irogers@google.com>
Subject: [PATCH v3 2/7] perf addr2line: Add a libdw implementation
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
implementations are slow, particularly in the case of forking
addr2line. Add an implementation that caches the libdw information in
the dso and uses it to find the file and line number
information. Inline information is supported but because
cu_walk_functions_at visits the leaf function last add a
inline_list__append_tail to reverse the lists order.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build     |   1 +
 tools/perf/util/dso.c     |   2 +
 tools/perf/util/dso.h     |  11 +++
 tools/perf/util/libdw.c   | 153 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/libdw.h   |  60 +++++++++++++++
 tools/perf/util/srcline.c |  24 ++++++
 tools/perf/util/srcline.h |   1 +
 7 files changed, 252 insertions(+)
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
index 000000000000..e4bfd52bd172
--- /dev/null
+++ b/tools/perf/util/libdw.c
@@ -0,0 +1,153 @@
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
+struct libdw_a2l_cb_args {
+	struct dso *dso;
+	struct symbol *sym;
+	struct inline_node *node;
+	char *leaf_srcline;
+	bool leaf_srcline_used;
+};
+
+static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
+{
+	struct libdw_a2l_cb_args *args  = _args;
+	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, dwarf_diename(die));
+	const char *call_fname = die_get_call_file(die);
+	char *call_srcline = srcline__unknown;
+	struct inline_list *ilist;
+
+	if (!inline_sym)
+		return -ENOMEM;
+
+	/* Assign caller information to the parent. */
+	if (call_fname)
+		call_srcline = srcline_from_fileline(call_fname, die_get_call_lineno(die));
+
+	list_for_each_entry(ilist, &args->node->val, list) {
+		ilist->srcline =  call_srcline;
+		call_srcline = NULL;
+		break;
+	}
+	if (call_srcline && call_fname)
+		free(call_srcline);
+
+	/* Add this symbol to the chain as the leaf. */
+	inline_list__append_tail(inline_sym, args->leaf_srcline, args->node);
+	args->leaf_srcline_used = true;
+	return 0;
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
+	int lineno = 0;
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
+	/*
+	 * Get/ignore the dwarf information. Determine the bias, difference
+	 * between the regular ELF addr2line addresses and those to use with
+	 * libdw.
+	 */
+	if (!dwfl_module_getdwarf(mod, &bias))
+		return 0;
+
+	/* Find source line information for the address. */
+	dwline = dwfl_module_getsrc(mod, addr + bias);
+	if (!dwline)
+		return 0;
+
+	/* Get line information. */
+	src = dwfl_lineinfo(dwline, /*addr=*/NULL, &lineno, /*col=*/NULL, /*mtime=*/NULL,
+			    /*length=*/NULL);
+
+	if (file)
+		*file = src ? strdup(src) : NULL;
+	if (line_nr)
+		*line_nr = lineno;
+
+	/* Optionally unwind inline function call chain. */
+	if (unwind_inlines && node) {
+		Dwarf_Addr unused_bias;
+		Dwarf_Die *cudie = dwfl_module_addrdie(mod, addr + bias, &unused_bias);
+		struct libdw_a2l_cb_args args = {
+			.dso = dso,
+			.sym = sym,
+			.node = node,
+			.leaf_srcline = srcline_from_fileline(src ?: "<unknown>", lineno),
+		};
+
+		/* Walk from the parent down to the leaf. */
+		cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
+
+		if (!args.leaf_srcline_used)
+			free(args.leaf_srcline);
+	}
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
index 27c0966611ab..e2d280678b02 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -6,6 +6,7 @@
 #include "libbfd.h"
 #include "llvm.h"
 #include "symbol.h"
+#include "libdw.h"
 
 #include <inttypes.h>
 #include <string.h>
@@ -51,6 +52,25 @@ int inline_list__append(struct symbol *symbol, char *srcline, struct inline_node
 	return 0;
 }
 
+int inline_list__append_tail(struct symbol *symbol, char *srcline, struct inline_node *node)
+{
+	struct inline_list *ilist;
+
+	ilist = zalloc(sizeof(*ilist));
+	if (ilist == NULL)
+		return -1;
+
+	ilist->symbol = symbol;
+	ilist->srcline = srcline;
+
+	if (callchain_param.order == ORDER_CALLEE)
+		list_add(&ilist->list, &node->val);
+	else
+		list_add_tail(&ilist->list, &node->val);
+
+	return 0;
+}
+
 /* basename version that takes a const input string */
 static const char *gnu_basename(const char *path)
 {
@@ -120,6 +140,10 @@ static int addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
 {
 	int ret;
 
+	ret = libdw__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
+	if (ret > 0)
+		return ret;
+
 	ret = llvm__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
 	if (ret > 0)
 		return ret;
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index c36f573cd339..be9f002bf234 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -57,6 +57,7 @@ struct inline_node *inlines__tree_find(struct rb_root_cached *tree, u64 addr);
 void inlines__tree_delete(struct rb_root_cached *tree);
 
 int inline_list__append(struct symbol *symbol, char *srcline, struct inline_node *node);
+int inline_list__append_tail(struct symbol *symbol, char *srcline, struct inline_node *node);
 char *srcline_from_fileline(const char *file, unsigned int line);
 struct symbol *new_inline_sym(struct dso *dso,
 			      struct symbol *base_sym,
-- 
2.52.0.457.g6b5491de43-goog

