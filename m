Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF293EB0F3
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539199; cv=none; b=aIKuhgPwfelykgzDdxp/cGo8vFwidGrF2NNkeAbc22N2ob+vkLpkoXnhUt8IlyWyW4k697F4pqMsidOIe/vkD740ZfZxZOwHdcBoEAfwdjzhJtJwTAUNuTicv6XLzzeK5JvyukaB+2FKYOU1hamZRV9SVxlmS5Hetb6fYPjMAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539199; c=relaxed/simple;
	bh=aSRn2a84aJ5XKChOsQsFTIditSg7lvW/7uN1eZsfU6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GHAlVQ1Dcn5nQMSjTpUPGDJXVqlr1oaeYWsyU6Pk/EYv22lN6fd2xobvKWvU+xp3kgKWOyWIO9hWe+UWso5aM+mvJwxar4stPt7LYV8/PW7n+9i8EKpjPRtiShO94V7KhI9Gp9WPj3qrF16XfvmN51Z6wbXYMDohdiLrNH6tBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEc1o/n5; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEc1o/n5"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso8080029a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789539196; x=1790143996; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCHS0z59fUPYMY565s32kon+1X6H9/iNUQvbm+yc4VA=;
        b=ZEc1o/n5e6iAsJK9kcJnGXfBUDS/rPSU4fMi01KEvechY7NFKX4bu1cSHCFiulyiNO
         8J5fwOUsrJW66cYBBtsL3EEhtgV6trQ7UIUvIVF5Ej3lZYmUaq6My1CBrsNnIu0c82lm
         al/8IiI0KUbNCW/6NWXM9vQ5bkT33AZzZJN/mwL+SdX4hTR5ThokDRyvH8lP/3YTBqOx
         y2NtfN92j/k9TnZFT/2EJageiSVHx8A6s6V7G7/IJ2YGFNTL/KG/o/lVVJP6sV1ie4sM
         PrztXLpqy1OdX8g04HBJyX9VKf7zPvuhG7R5jWpN1de4QQaV4y3GVthLBwcU0SVwZBz9
         q35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539196; x=1790143996;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VCHS0z59fUPYMY565s32kon+1X6H9/iNUQvbm+yc4VA=;
        b=P/sJ3T3hfbRmTQ+UBI4GULuFXZOOSYJDEZrBcKq3IVxrzkgF/444SeFL7gqyEPwmQa
         n0IEJuvC4vdU2Crt4PASm5i+dJEWPPEqMkebcnPXpsnoaxGm+Wd71MllRM8uaHv/XiD6
         Z7LOFdgiUXqTfxVxtmRfiBu+qfHOLlWg+Bt1bpB6XI96Chpm58G95kedm4T/Uqxh44wY
         o/mgfUNbq238bH9QOdrGL1SfFlvSC47VzrxYjazmYI/RyRKmtWXmCBZJUj7elpqSBfK1
         ROJmZI36ygbKrj6t368/aqQ6Zpd1PCtPG29M/brva5QcL4SsRk93nOxfNLNS3W0U9QEF
         yz+g==
X-Forwarded-Encrypted: i=1; AKwUvByh3PstR1UEXU5iswrEE+zT5fQZN3eV8xdWWg5mPQ5pDoNDjYcT8Gs/QC3GQz0+106HpxduOvJQsML9AsowfaYl@vger.kernel.org
X-Gm-Message-State: AFuF++mB2Ub+4yCdru6hgvhDWtI6LTkWM47ITDKwFjBM7VOW5veLmRj0
	bMT+DTn964hzphT5E7r9mvULQqwpBHk5O5B/H8lZQ/7Tj6ZNvykDFWYWDwnTW5DtTV2kGTjO9ec
	6eoqsEZeB8A==
X-Received: from dlea16-n1.prod.google.com ([2002:a05:701b:4210:10b0:144:bbd4:62e0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a11d:b0:3b3:216b:2743
 with SMTP id adf61e73a8af0-3dd5f4038f0mr3242885637.4.1789539195928; Tue, 15
 Sep 2026 23:13:15 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:12:11 -0700
In-Reply-To: <20260916061218.3061216-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916061218.3061216-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916061218.3061216-3-irogers@google.com>
Subject: [PATCH 2/9] perf symbol: Fix the build when demangling with libbfd
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

cxx_demangle_sym() calls bfd_demangle() with the DMGL_PARAMS and
DMGL_ANSI flags, but nothing declares them. The
"#define PACKAGE 'perf'", "#include <bfd.h>" and the DMGL_ definitions
were left behind in symbol-elf.c when the demangling code moved to
symbol.c, and libiberty's demangle.h that defines the flags isn't
installed by every binutils package. The cplus_demangle() variant is
missing a declaration for the same reason.

The code is only built when the C++ ABI's __cxa_demangle() is
unavailable, so most builds never compile it:

  $ make BUILD_NONDISTRO=1 NO_DEMANGLE=1
  util/symbol.c:2714: error: 'DMGL_PARAMS' undeclared
  util/symbol.c:2714: error: 'DMGL_ANSI' undeclared
  util/symbol.c:2716: error: implicit declaration of 'bfd_demangle'

Move the libbfd demangling into libbfd.c, which already includes bfd.h,
and declare in symbol.c the libiberty interfaces the cplus_demangle()
variant needs.

Fixes: 4d9b5146f0d9 ("perf symbol: Move demangling code out of symbol-elf.c")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/libbfd.c | 17 +++++++++++++++++
 tools/perf/util/libbfd.h |  9 +++++++++
 tools/perf/util/symbol.c | 18 +++++++++++++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 8ac6670a39aa..131bfedf48cd 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -72,6 +72,23 @@ static void ensure_bfd_init(void)
 	pthread_once(&bfd_init_once, perf_bfd_init);
 }
 
+/*
+ * Flags from libiberty's demangle.h. bfd.h declares bfd_demangle but not the
+ * flags to pass to it, and demangle.h isn't installed by every binutils
+ * package.
+ */
+#ifndef DMGL_PARAMS
+#define DMGL_PARAMS	(1 << 0)	/* Include function arguments. */
+#define DMGL_ANSI	(1 << 1)	/* Include const, volatile, etc. */
+#endif
+
+char *libbfd__demangle_sym(const char *str, bool params, bool modifiers)
+{
+	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
+
+	return bfd_demangle(/*abfd=*/NULL, str, flags);
+}
+
 static int bfd_error(const char *string)
 {
 	const char *errmsg;
diff --git a/tools/perf/util/libbfd.h b/tools/perf/util/libbfd.h
index 953886f3d62f..14171db8b112 100644
--- a/tools/perf/util/libbfd.h
+++ b/tools/perf/util/libbfd.h
@@ -31,6 +31,8 @@ int libbfd_filename__read_debuglink(const char *filename, char *debuglink, size_
 
 int symbol__disassemble_bpf_libbfd(struct symbol *sym, struct annotate_args *args);
 
+char *libbfd__demangle_sym(const char *str, bool params, bool modifiers);
+
 #else // !defined(HAVE_LIBBFD_SUPPORT)
 #include "annotate.h"
 
@@ -77,6 +79,13 @@ static inline int symbol__disassemble_bpf_libbfd(struct symbol *sym __always_unu
 	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
 }
 
+static inline char *libbfd__demangle_sym(const char *str __always_unused,
+					 bool params __always_unused,
+					 bool modifiers __always_unused)
+{
+	return NULL;
+}
+
 #endif // defined(HAVE_LIBBFD_SUPPORT)
 
 #endif /* __PERF_LIBBFD_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3587ad243159..3206929473a2 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -27,6 +27,7 @@
 #include "dso.h"
 #include "util.h" // lsdir()
 #include "event.h"
+#include "libbfd.h"
 #include "machine.h"
 #include "map.h"
 #include "symbol.h"
@@ -2707,13 +2708,24 @@ static bool want_demangle(bool is_kernel_sym)
  * version.
  */
 #ifndef HAVE_CXA_DEMANGLE_SUPPORT
+#ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
+/*
+ * Declarations from libiberty's demangle.h, the header isn't installed by
+ * every binutils package.
+ */
+#ifndef DMGL_PARAMS
+#define DMGL_PARAMS	(1 << 0)	/* Include function arguments. */
+#define DMGL_ANSI	(1 << 1)	/* Include const, volatile, etc. */
+#endif
+
+char *cplus_demangle(const char *mangled, int options);
+#endif
+
 char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
 		       bool modifiers __maybe_unused)
 {
 #ifdef HAVE_LIBBFD_SUPPORT
-	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
-
-	return bfd_demangle(NULL, str, flags);
+	return libbfd__demangle_sym(str, params, modifiers);
 #elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
 	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
 
-- 
2.55.0.1032.g73a4cd73de-goog

