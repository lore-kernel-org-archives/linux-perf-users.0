Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489B492E4A
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405690; cv=none; b=LvUNXOrTlHa6wP2+45TOEdiMEByshJAIbfwLRymhN5xTdpAwpGZq+6NPWkORPZ3/IQ0/zpLN82cPNhLlO13BIYlbjpUigCqJCwgswnIjz4Cjp5RKP0Re5DI9QM5DmgWQ7vLcwtYVr43H3GSkN382bzg5drI0tSWs+CXDvIf3hQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405690; c=relaxed/simple;
	bh=wGpV5wpe4E683mPi9fgb4FrlNrrhEWStM6C6INZoRt0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=qOgjtezICRBya0ZGeUgMWVLLCpYv46wVe0qXq8eqnb3bswvfzvVQhLfC2J9xxVIv9gptAZGwBtBvXZ+QlSbUVbbAcmvtbStwYxYNePAerP3bopBiqfyy2phBUL64grPxl/s7jb00C15CyjT2OmDpEOcaz69L5FeOwqrsp2GJhg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6loUknE; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6loUknE"
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6b1ac969b92so4332043eaf.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789405687; x=1790010487; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OZKXo6ORuZaokVoe1mT1egXcHURKmuRMWdn3r8xoBX8=;
        b=o6loUknEjGyV+DtwrPpUx+GneCHcOe94PHMV79Xra8sFzml+BkEpQjy4aj0YDy97xd
         y5hc8RPiL8ijT9tRINmgsNcWfYnURaSkaVAjkfIX1Glv/ugX5Ki1Xlz1XwmPnYCEjv7W
         3UvVxBNLltGWjKCGq0QaO2tkxJIDluM4qFJweo40uf77Kt4kZ8RLFWBjPCahTpmlrwQJ
         mm5PBU9BnOFjpvqsWBvP5RiZ8r24r6o8oc8jsfXbUlDF/oz6NgzlESVaDvr58e2GioQD
         YyY1YMYlhaapSCjHAyw7ZpMQEU5zSJOmMGseYkoWt94+rsnLCKGwX+qNWDWPdqxVXXxg
         2PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789405687; x=1790010487;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZKXo6ORuZaokVoe1mT1egXcHURKmuRMWdn3r8xoBX8=;
        b=tJR34NmC6vy+OhKL6SHFY/p6Diy0z55zDgBLZr4Iv8Z53q76e8BCiI3HT0+sPJ0z2O
         Xo9zdnqVHQMnURYv1wnfskodS23mcSiUeUOf1iTOUN5hYi8CSsQzhovhNOAoDr4N4AQU
         SzebkYaC9GUr2vZLjZljmDo8haiiT5vi0+dtHMn3H8y+XYKiHVG/TAO9f1gjkvmnW48Z
         +HhNgn2SgQnO8knZsZQHzYuJ+JKFuLS/eiQvQY9Ken8GNEYTkiTRBwGsSrrlB6A/1IwV
         vyRdiOwF0SWEQcb9eEiyk8clt9TKQd8SL2yMv+pYrCjkkExMZCwDeFLovkXdTiUFOQ6f
         M05Q==
X-Forwarded-Encrypted: i=1; AKwUvBzYlSEpe/0ZR4OSVxA//pxRWplBGqkqvSj0D42qttGGRdGkux0nWPYZjsQ4TdfJtJACKhXEB/y5UZE2yJVuIybG@vger.kernel.org
X-Gm-Message-State: AFuF++mzMH0qfM6LVS6PLhaWuXmq7mPPa+3nwvxnMDnpxuf3Q77O4Gyo
	bNMMlJhrpOYjqvr4Y6Qg0B0ApZd7i80o9coeEbqjiF7AGIGrdzV6iUZaeJWjP4seR0kBcq3m6sU
	aNTBNskoKRw==
X-Received: from dlbbs39.prod.google.com ([2002:a05:7022:927:b0:143:31fa:f744])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:80c7:b0:6b1:7ee7:8ea9
 with SMTP id 006d021491bc7-6c541f440a9mr1633588eaf.31.1789405686910; Mon, 14
 Sep 2026 10:08:06 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:07:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260914170759.1992947-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf libdw: Fix Dwfl discovery with split files
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch dynamically frees the cached Dwfl object and alternative a2l
caches whenever a newly discovered split-debug file is assigned to a
dso, and scopes accessors behind a mutex. To safely implement cache
teardowns upon rediscovery without introducing races with active readers,
the teardown is performed locked.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 .../arch/powerpc/util/skip-callchain-idx.c    |  4 +-
 tools/perf/util/addr2line.c                   | 35 ++++++++---
 tools/perf/util/dso.c                         |  9 +++
 tools/perf/util/dso.h                         |  5 +-
 tools/perf/util/libbfd.c                      | 28 ++++++---
 tools/perf/util/libdw.c                       | 39 ++++++++----
 tools/perf/util/srcline.c                     | 61 ++++++++++++------
 tools/perf/util/unwind-libdw.c                |  2 +
 tools/perf/util/unwind-libunwind.c            | 62 ++++++++++++++-----
 9 files changed, 178 insertions(+), 67 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index e57f10798fa6..472714cfad38 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -152,9 +152,10 @@ static int check_return_addr(struct dso *dso, Dwarf_Addr mapped_pc)
 	Dwarf_Addr	end = mapped_pc;
 	bool		signalp;
 
+	mutex_lock(dso__lock(dso));
 	dwfl = dso__libdw_dwfl(dso);
 	if (!dwfl)
-		return -1;
+		goto out;
 
 	mod = dwfl_addrmodule(dwfl, mapped_pc);
 	if (!mod) {
@@ -183,6 +184,7 @@ static int check_return_addr(struct dso *dso, Dwarf_Addr mapped_pc)
 	rc = check_return_reg(ra_regno, frame);
 
 out:
+	mutex_unlock(dso__lock(dso));
 	return rc;
 }
 
diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index 4b0d349ed334..7c7eea3cc8dd 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -284,7 +284,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 		   struct inline_node *node,
 		   struct symbol *sym __maybe_unused)
 {
-	struct child_process *a2l = dso__a2l(dso);
+	struct child_process *a2l;
 	char *record_function = NULL;
 	char *record_filename = NULL;
 	unsigned int record_line_nr = 0;
@@ -296,10 +296,14 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	ssize_t written;
 	struct io io = { .eof = false };
 	enum cmd_a2l_style cmd_a2l_style;
+	const char *current_dso_name;
+
+	mutex_lock(dso__lock(dso));
+	a2l = dso__a2l(dso);
 
 	if (!a2l) {
 		if (!filename__has_section(dso_name, ".debug_line"))
-			goto out;
+			goto out_unlock;
 
 		dso__set_a2l(dso,
 			     addr2line_subprocess_init(symbol_conf.addr2line_path, dso_name));
@@ -309,11 +313,19 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	if (a2l == NULL) {
 		if (!symbol_conf.addr2line_disable_warn)
 			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
-		goto out;
+		goto out_unlock;
 	}
 	cmd_a2l_style = cmd_addr2line_configure(a2l, dso_name);
 	if (cmd_a2l_style == BROKEN)
-		goto out;
+		goto out_unlock;
+
+	/*
+	 * Take ownership of the a2l subprocess so we can safely perform
+	 * blocking IPC without holding the dso lock. If another thread
+	 * resolves a symbol concurrently, it will spawn a new a2l process.
+	 */
+	dso__set_a2l(dso, NULL);
+	mutex_unlock(dso__lock(dso));
 
 	/*
 	 * Send our request and then *deliberately* send something that can't be
@@ -414,12 +426,21 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	}
 
 out:
+	mutex_lock(dso__lock(dso));
 	free(record_function);
 	free(record_filename);
-	if (io.eof) {
-		dso__set_a2l(dso, NULL);
+
+	current_dso_name = dso__symsrc_filename(dso) ?: dso__long_name(dso);
+	if (!io.eof && dso__a2l(dso) == NULL && current_dso_name &&
+	    !strcmp(current_dso_name, dso_name))
+		dso__set_a2l(dso, a2l);
+	else
 		addr2line_subprocess_cleanup(a2l);
-	}
+	mutex_unlock(dso__lock(dso));
+	return ret;
+
+out_unlock:
+	mutex_unlock(dso__lock(dso));
 	return ret;
 }
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 42bfe30a3b51..df39e6ca88e6 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2075,3 +2075,12 @@ struct debuginfo *dso__debuginfo(struct dso *dso)
 	free(name);
 	return dinfo;
 }
+
+void dso__set_symsrc_filename(struct dso *dso, char *val)
+{
+	RC_CHK_ACCESS(dso)->symsrc_filename = val;
+	dso__free_libdw(dso);
+	dso__free_a2l(dso);
+	dso__set_has_srcline(dso, true);
+	dso__set_a2l_fails(dso, 0);
+}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 55c4aaa53c38..7966c7048c85 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -735,10 +735,7 @@ static inline const char *dso__symsrc_filename(const struct dso *dso)
 	return RC_CHK_ACCESS(dso)->symsrc_filename;
 }
 
-static inline void dso__set_symsrc_filename(struct dso *dso, char *val)
-{
-	RC_CHK_ACCESS(dso)->symsrc_filename = val;
-}
+void dso__set_symsrc_filename(struct dso *dso, char *val);
 
 static inline void dso__free_symsrc_filename(struct dso *dso)
 {
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 33dc6158b2b1..d0a27b14ee0d 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -226,7 +226,10 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 		      struct symbol *sym)
 {
 	int ret = 0;
-	struct a2l_data *a2l = dso__a2l(dso);
+	struct a2l_data *a2l;
+
+	mutex_lock(dso__lock(dso));
+	a2l = dso__a2l(dso);
 
 	if (!a2l) {
 		a2l = addr2line_init(dso_name);
@@ -236,7 +239,8 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 	if (a2l == NULL) {
 		if (!symbol_conf.addr2line_disable_warn)
 			pr_warning("addr2line_init failed for %s\n", dso_name);
-		return 0;
+		ret = -1;
+		goto out;
 	}
 
 	a2l->addr = addr;
@@ -244,14 +248,18 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 
 	bfd_map_over_sections(a2l->abfd, find_address_in_section, a2l);
 
-	if (!a2l->found)
-		return 0;
+	if (!a2l->found) {
+		ret = 0;
+		goto out;
+	}
 
 	if (unwind_inlines) {
 		int cnt = 0;
 
-		if (node && inline_list__append_dso_a2l(dso, node, sym))
-			return 0;
+		if (node && inline_list__append_dso_a2l(dso, node, sym)) {
+			ret = 0;
+			goto out;
+		}
 
 		while (bfd_find_inliner_info(a2l->abfd, &a2l->filename,
 					     &a2l->funcname, &a2l->line) &&
@@ -261,8 +269,10 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 				a2l->filename = NULL;
 
 			if (node != NULL) {
-				if (inline_list__append_dso_a2l(dso, node, sym))
-					return 0;
+				if (inline_list__append_dso_a2l(dso, node, sym)) {
+					ret = 0;
+					goto out;
+				}
 				// found at least one inline frame
 				ret = 1;
 			}
@@ -277,6 +287,8 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 	if (line)
 		*line = a2l->line;
 
+out:
+	mutex_unlock(dso__lock(dso));
 	return ret;
 }
 
diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index 4ca7e7e4fbe9..c4504cceb313 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -35,7 +35,7 @@ struct Dwfl *dso__libdw_dwfl(struct dso *dso)
 	if (dwfl)
 		return dwfl;
 
-	dso_name = dso__long_name(dso);
+	dso_name = dso__symsrc_filename(dso) ?: dso__long_name(dso);
 	/*
 	 * Initialize Dwfl session.
 	 * We need to open the DSO file to report it to libdw.
@@ -167,32 +167,41 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 		     struct dso *dso, bool unwind_inlines,
 		     struct inline_node *node, struct symbol *sym)
 {
-	Dwfl *dwfl = dso__libdw_dwfl(dso);
+	Dwfl *dwfl;
 	Dwfl_Module *mod;
 	Dwfl_Line *dwline;
 	Dwarf_Addr bias;
 	const char *src;
 	int lineno = 0;
+	int ret = 0;
 
+	mutex_lock(dso__lock(dso));
+	dwfl = dso__libdw_dwfl(dso);
 	if (!dwfl)
-		return 0;
+		goto out;
 
 	mod = dwfl_addrmodule(dwfl, addr);
-	if (!mod)
-		return 0;
+	if (!mod) {
+		ret = 0;
+		goto out;
+	}
 
 	/*
 	 * Get/ignore the dwarf information. Determine the bias, difference
 	 * between the regular ELF addr2line addresses and those to use with
 	 * libdw.
 	 */
-	if (!dwfl_module_getdwarf(mod, &bias))
-		return 0;
+	if (!dwfl_module_getdwarf(mod, &bias)) {
+		ret = -1;
+		goto out;
+	}
 
 	/* Find source line information for the address. */
 	dwline = dwfl_module_getsrc(mod, addr + bias);
-	if (!dwline)
-		return 0;
+	if (!dwline) {
+		ret = -1;
+		goto out;
+	}
 
 	/* Get line information. */
 	src = dwfl_lineinfo(dwline, /*addr=*/NULL, &lineno, /*col=*/NULL, /*mtime=*/NULL,
@@ -219,7 +228,8 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 				free(*file);
 				*file = NULL;
 			}
-			return 0;
+			ret = 0;
+			goto out;
 		}
 
 		/* Walk from the parent down to the leaf. */
@@ -235,8 +245,13 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 				*file = NULL;
 			}
 			inline_node__clear_frames(node);
-			return 0;
+			ret = 0;
+			goto out;
 		}
 	}
-	return 1;
+	ret = 1;
+
+out:
+	mutex_unlock(dso__lock(dso));
+	return ret;
 }
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index b082178c279b..e60dea472507 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -1,40 +1,48 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "srcline.h"
+
+#include <inttypes.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/string.h>
+#include <linux/zalloc.h>
+
 #include "addr2line.h"
-#include "dso.h"
 #include "callchain.h"
+#include "debug.h"
+#include "dso.h"
 #include "libbfd.h"
+#include "libdw.h"
 #include "llvm.h"
 #include "symbol.h"
-#include "libdw.h"
-#include "debug.h"
 #include "util.h"
 
-#include <inttypes.h>
-#include <string.h>
-#include <linux/string.h>
-#include <linux/zalloc.h>
-
 bool srcline_full_filename;
 
 char *srcline__unknown = (char *)"??:0";
 
-static const char *srcline_dso_name(struct dso *dso)
+static char *srcline_dso_name(struct dso *dso)
 {
 	const char *dso_name;
+	char *ret = NULL;
 
+	mutex_lock(dso__lock(dso));
 	if (dso__symsrc_filename(dso))
 		dso_name = dso__symsrc_filename(dso);
 	else
 		dso_name = dso__long_name(dso);
 
 	if (dso_name[0] == '[')
-		return NULL;
+		goto out;
 
 	if (is_perf_pid_map_name(dso_name))
-		return NULL;
+		goto out;
 
-	return dso_name;
+	ret = strdup(dso_name);
+out:
+	mutex_unlock(dso__lock(dso));
+	return ret;
 }
 
 int inline_list__append(struct symbol *symbol, char *srcline, struct inline_node *node)
@@ -258,7 +266,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	char *file = NULL;
 	unsigned line = 0;
 	char *srcline;
-	const char *dso_name;
+	char *dso_name;
 
 	if (!dso__has_srcline(dso))
 		goto out;
@@ -268,8 +276,11 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		goto out_err;
 
 	if (!addr2line(dso_name, addr, &file, &line, dso,
-		       unwind_inlines, /*node=*/NULL, sym))
+		       unwind_inlines, /*node=*/NULL, sym)) {
+		free(dso_name);
 		goto out_err;
+	}
+	free(dso_name);
 
 	srcline = srcline_from_fileline(file, line);
 	free(file);
@@ -277,16 +288,20 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	if (!srcline)
 		goto out_err;
 
+	mutex_lock(dso__lock(dso));
 	dso__set_a2l_fails(dso, 0);
+	mutex_unlock(dso__lock(dso));
 
 	return srcline;
 
 out_err:
+	mutex_lock(dso__lock(dso));
 	dso__set_a2l_fails(dso, dso__a2l_fails(dso) + 1);
 	if (dso__a2l_fails(dso) > A2L_FAIL_LIMIT) {
 		dso__set_has_srcline(dso, false);
 		dso__free_a2l(dso);
 	}
+	mutex_unlock(dso__lock(dso));
 out:
 	if (!show_addr)
 		return (show_sym && sym) ?
@@ -305,7 +320,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
 {
 	char *file = NULL;
-	const char *dso_name;
+	char *dso_name;
 
 	if (!dso__has_srcline(dso))
 		return NULL;
@@ -315,18 +330,25 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
 		goto out_err;
 
 	if (!addr2line(dso_name, addr, &file, line, dso, /*unwind_inlines=*/true,
-			/*node=*/NULL, /*sym=*/NULL))
+			/*node=*/NULL, /*sym=*/NULL)) {
+		free(dso_name);
 		goto out_err;
+	}
+	free(dso_name);
 
+	mutex_lock(dso__lock(dso));
 	dso__set_a2l_fails(dso, 0);
+	mutex_unlock(dso__lock(dso));
 	return file;
 
 out_err:
+	mutex_lock(dso__lock(dso));
 	dso__set_a2l_fails(dso, dso__a2l_fails(dso) + 1);
 	if (dso__a2l_fails(dso) > A2L_FAIL_LIMIT) {
 		dso__set_has_srcline(dso, false);
 		dso__free_a2l(dso);
 	}
+	mutex_unlock(dso__lock(dso));
 
 	return NULL;
 }
@@ -420,13 +442,16 @@ void srcline__tree_delete(struct rb_root_cached *tree)
 struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
 					    struct symbol *sym)
 {
-	const char *dso_name;
+	char *dso_name;
+	struct inline_node *node;
 
 	dso_name = srcline_dso_name(dso);
 	if (dso_name == NULL)
 		return NULL;
 
-	return addr2inlines(dso_name, addr, dso, sym);
+	node = addr2inlines(dso_name, addr, dso, sym);
+	free(dso_name);
+	return node;
 }
 
 void inline_node__clear_frames(struct inline_node *node)
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 8d9fa6fd81c3..60989d1ed4a0 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -42,8 +42,10 @@ static int __find_debuginfo(Dwfl_Module *mod __maybe_unused, void **userdata,
 	const struct dso *dso = *userdata;
 
 	assert(dso);
+	mutex_lock(dso__lock((struct dso *)dso));
 	if (dso__symsrc_filename(dso) && strcmp(file_name, dso__symsrc_filename(dso)))
 		*debuginfo_file_name = strdup(dso__symsrc_filename(dso));
+	mutex_unlock(dso__lock((struct dso *)dso));
 	return -1;
 }
 
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 73d191ce51a5..3bccab303282 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -1,20 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "unwind.h"
+
+#include <inttypes.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <elf.h>
+#include <fcntl.h>
+#include <gelf.h>
+
+#include <dwarf-regs.h>
+
 #include "callchain.h"
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
+#include "libunwind-arch/libunwind-arch.h"
 #include "map.h"
 #include "perf_regs.h"
 #include "session.h"
 #include "symbol.h"
 #include "thread.h"
-#include "unwind.h"
-#include "libunwind-arch/libunwind-arch.h"
-#include <dwarf-regs.h>
-#include <elf.h>
-#include <fcntl.h>
-#include <gelf.h>
-#include <inttypes.h>
 
 #define DW_EH_PE_FORMAT_MASK	0x0f	/* format of the encoded value */
 #define DW_EH_PE_APPL_MASK	0x70	/* how the value is to be applied */
@@ -293,10 +299,19 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 		}
 
 		if (ofs <= 0) {
-			fd = open(dso__symsrc_filename(dso), O_RDONLY);
-			if (fd >= 0) {
-				ofs = elf_section_offset(fd, ".debug_frame");
-				close(fd);
+			char *alloc_name;
+
+			mutex_lock(dso__lock(dso));
+			alloc_name = dso__symsrc_filename(dso) ?
+					strdup(dso__symsrc_filename(dso)) : NULL;
+			mutex_unlock(dso__lock(dso));
+			if (alloc_name) {
+				fd = open(alloc_name, O_RDONLY);
+				if (fd >= 0) {
+					ofs = elf_section_offset(fd, ".debug_frame");
+					close(fd);
+				}
+				free(alloc_name);
 			}
 		}
 
@@ -321,6 +336,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 				}
 			}
 			if (ofs > 0) {
+				mutex_lock(dso__lock(dso));
 				if (dso__symsrc_filename(dso) != NULL) {
 					pr_warning(
 						"%s: overwrite symsrc(%s,%s)\n",
@@ -330,6 +346,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 					dso__free_symsrc_filename(dso);
 				}
 				dso__set_symsrc_filename(dso, debuglink);
+				mutex_unlock(dso__lock(dso));
 			} else {
 				free(debuglink);
 			}
@@ -429,12 +446,23 @@ int __libunwind__find_proc_info(void *as, uint64_t ip, void *pi, int need_unwind
 			dso__data_put_fd(dso);
 		}
 
-		symfile = dso__symsrc_filename(dso) ?: dso__name(dso);
-
-		if (libunwind_arch__dwarf_find_debug_frame(ui->e_machine, /*found=*/0, &di, ip,
-							   base, symfile, start, map__end(map))) {
-			ret = libunwind_arch__dwarf_search_unwind_table(ui->e_machine, as, ip, &di, pi,
-									need_unwind_info, arg);
+		mutex_lock(dso__lock(dso));
+		symfile = dso__symsrc_filename(dso) ?
+				strdup(dso__symsrc_filename(dso)) :
+				strdup(dso__name(dso));
+		mutex_unlock(dso__lock(dso));
+
+		if (symfile) {
+			if (libunwind_arch__dwarf_find_debug_frame(ui->e_machine,
+								   /*found=*/0, &di, ip,
+								   base, symfile, start,
+								   map__end(map))) {
+				ret = libunwind_arch__dwarf_search_unwind_table(ui->e_machine, as,
+										ip, &di, pi,
+										need_unwind_info,
+										arg);
+			}
+			free((char *)symfile);
 		}
 	}
 	map__put(map);
-- 
2.55.0.1032.g73a4cd73de-goog

