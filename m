Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5398488
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124051; cv=none; b=UYmcCls38D1xQ9lRr3a4pK+kzx2k2acV/tqyCzTDW2uf8po3/TcnRWmOqRK2ffu4CkLABBWguo1rAPi7fSvgIIbW28kzMnoXfQZnGbdO37uGvQJ4J1KUUGxnOqgcmT2baukGwyJ3WzcJXzeUGxUzdQvWRjcWmS8eLZ2n3eL8qKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124051; c=relaxed/simple;
	bh=lOqGJCnM71+Gsyi0UUhXOj+xkCdf5CDpasmBbB1O2po=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PLqaKQP/sb9pVKQjH1p19/w1k6WLJzjUW7YZS6qCwpGdS8tJFuEWyAIlV4FADHR731cN2Q/evmHZxepiH1axNPaPA3vCIyfcJ12UB2wcrG8Ayb/7tiRYRc+V0/KzKJL9Rha+nHTRZfaubzqrYl8h7yx9xYomp4moAgv2gbVYMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NnTiJ43x; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NnTiJ43x"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fdb4f35fso641079276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124048; x=1729728848; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHSqjk9ZRfPn8FVBcSh8Ry5Cr0JpG8eM+bHfnQinYnA=;
        b=NnTiJ43xMr4J29/O6ahx2zQsCjeBAVGfx7Tk6djlUqMhc80qct7pvxrYixnQlHsTWT
         zNMBHQ6CHsbcWIeXJvTzGr78z8NX0pro/8DFCFDJQUUi/yxqMEByAdUK2A3i5vFV+QGa
         ITsaHlPp7/jldfRANoDksUuBX9wgBakTz8zile8aqb7dzCvhbDm09qD9XIlcbEE1c3Mr
         jPYx2iKyxdu2b6BI5ZBTLESHYOe0ZqbVl7O4/RGmtZnWbZGYQ4Wbj+vPbURZVo2y2Jc6
         N+j0pwSxv+Wpv0bxISuhk82E2AjPQsFxY3XDh38fWXFnQeVAR/9zK3/DdYDOs0lMCeWI
         S7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124048; x=1729728848;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHSqjk9ZRfPn8FVBcSh8Ry5Cr0JpG8eM+bHfnQinYnA=;
        b=kTB5zpJKIFHSO0wBYCLtaMSB2grWeAr9wW/N2xwWhc+S7g+OExs59PLYXxgFNX8hJx
         9DSdp6sHP7N+fnHStE42S74uQl80N8Eo3Z2zHhB3Xu4N0A4Ldifub96xEEls8dxXtw+/
         HPP9yw4p9+jJDBk6P1JtkcsfaOs1Gk8z18w0OU7BUW3UAUjOBDhvfcdP5s/5nuGY//S/
         zfzbM2azAPa8CZAtTNrlrPrR4JzBIV7f5NJv+HDL5pelnTbYvRZo3d5OXB47PJ4tZYab
         CtujwwKJV/Vi/oiMd8TY+KDKsM6KSdbrYmKTwD8fyzLaDFUvIwC+2xbRZn+TXagsqsgf
         rcLg==
X-Forwarded-Encrypted: i=1; AJvYcCWbTewu35LM2bDZRtAlhIYr1vyOy7yYbA2rM6N4sNxP8qAkW+wVFai/1EXA4XlbSdZEj+6CbvrvYXXTgPWSZYBk@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLZtyqnjoRNViT0AGGZ/Ajvr+AKDZBpdiq1qS1FcoVntMdy2N
	nxLTd9eaQSR/qYb8V2RQhwH3ibB42aR4FP753dsGB/bt4ElDjMaH1pnLqtpnbaUsvJmBJp/n9NV
	IckzSTw==
X-Google-Smtp-Source: AGHT+IGqr9sQBXM3adIskS2P6qVNnIou3eo2nhdUZf1EX7Ra7XEm1CDhhAwb4OEVcH7WjrUyRdtR/4pRk5N1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:dc41:0:b0:e20:298c:541 with SMTP id
 3f1490d57ef6-e297857270cmr2711276.9.1729124048178; Wed, 16 Oct 2024 17:14:08
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:45 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 02/11] perf build: Rename NO_DWARF to NO_LIBDW
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

NO_DWARF could mean more than NO_LIBDW support, in particular no
libunwind support. Rename to be more intention revealing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config         | 16 ++++++++--------
 tools/perf/Makefile.perf           |  2 +-
 tools/perf/arch/arm/Makefile       |  2 +-
 tools/perf/arch/arm64/Makefile     |  2 +-
 tools/perf/arch/csky/Makefile      |  2 +-
 tools/perf/arch/loongarch/Makefile |  2 +-
 tools/perf/arch/mips/Makefile      |  2 +-
 tools/perf/arch/powerpc/Makefile   |  2 +-
 tools/perf/arch/riscv/Makefile     |  2 +-
 tools/perf/arch/s390/Makefile      |  2 +-
 tools/perf/arch/sh/Makefile        |  2 +-
 tools/perf/arch/sparc/Makefile     |  2 +-
 tools/perf/arch/x86/Makefile       |  2 +-
 tools/perf/arch/xtensa/Makefile    |  2 +-
 tools/perf/builtin-probe.c         |  2 +-
 15 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c1c7c25887a7..cc2cfc3aab40 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -432,7 +432,7 @@ ifeq ($(feature-file-handle), 1)
 endif
 
 ifdef NO_LIBELF
-  NO_DWARF := 1
+  NO_LIBDW := 1
   NO_LIBUNWIND := 1
   NO_LIBDW_DWARF_UNWIND := 1
   NO_LIBBPF := 1
@@ -474,9 +474,9 @@ else
       endif
     endif
     ifneq ($(feature-dwarf), 1)
-      ifndef NO_DWARF
+      ifndef NO_LIBDW
         $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
-        NO_DWARF := 1
+        NO_LIBDW := 1
       endif
     else
       ifneq ($(feature-dwarf_getlocations), 1)
@@ -499,7 +499,7 @@ ifeq ($(feature-libaio), 1)
   endif
 endif
 
-ifdef NO_DWARF
+ifdef NO_LIBDW
   NO_LIBDW_DWARF_UNWIND := 1
 endif
 
@@ -577,17 +577,17 @@ ifndef NO_LIBELF
     endif
   endif
 
-  ifndef NO_DWARF
+  ifndef NO_LIBDW
     ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
       $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
-      NO_DWARF := 1
+      NO_LIBDW := 1
     else
       CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
       LDFLAGS += $(LIBDW_LDFLAGS)
       EXTLIBS += ${DWARFLIBS}
       $(call detected,CONFIG_DWARF)
     endif # PERF_HAVE_DWARF_REGS
-  endif # NO_DWARF
+  endif # NO_LIBDW
 
   ifndef NO_LIBBPF
     ifeq ($(feature-bpf), 1)
@@ -636,7 +636,7 @@ ifdef PERF_HAVE_JITDUMP
 endif
 
 ifeq ($(SRCARCH),powerpc)
-  ifndef NO_DWARF
+  ifndef NO_LIBDW
     CFLAGS += -DHAVE_SKIP_CALLCHAIN_IDX
   endif
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9dd2e8d3f3c9..a144bfaf8aeb 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -40,7 +40,7 @@ include ../scripts/utilities.mak
 #
 # Define EXTRA_PERFLIBS to pass extra libraries to PERFLIBS.
 #
-# Define NO_DWARF if you do not want debug-info analysis feature at all.
+# Define NO_LIBDW if you do not want debug-info analysis feature at all.
 #
 # Define WERROR=0 to disable treating any warnings as errors.
 #
diff --git a/tools/perf/arch/arm/Makefile b/tools/perf/arch/arm/Makefile
index 1d88fdab13bf..9b164d379548 100644
--- a/tools/perf/arch/arm/Makefile
+++ b/tools/perf/arch/arm/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 5735ed4479bb..8a5ffbfe809f 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/csky/Makefile b/tools/perf/arch/csky/Makefile
index 88c08eed9c7b..119b06a64bed 100644
--- a/tools/perf/arch/csky/Makefile
+++ b/tools/perf/arch/csky/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index c89d6bb6b184..1cc5eb01f32b 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
index cd0b011b3be5..733f7b76f52d 100644
--- a/tools/perf/arch/mips/Makefile
+++ b/tools/perf/arch/mips/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index bf6d323574f6..7672d555f6cd 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 
diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index 90c3c476a242..4664a78a1afd 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -1,4 +1,4 @@
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 56994e63b43a..3f66e2ede3f7 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/sh/Makefile b/tools/perf/arch/sh/Makefile
index 88c08eed9c7b..119b06a64bed 100644
--- a/tools/perf/arch/sh/Makefile
+++ b/tools/perf/arch/sh/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Makefile
index 4031db72ba71..7741184894c8 100644
--- a/tools/perf/arch/sparc/Makefile
+++ b/tools/perf/arch/sparc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 67b4969a6738..9aa58acb5564 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/xtensa/Makefile b/tools/perf/arch/xtensa/Makefile
index 88c08eed9c7b..119b06a64bed 100644
--- a/tools/perf/arch/xtensa/Makefile
+++ b/tools/perf/arch/xtensa/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 003a3bcebfdf..91672bb3047c 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -616,7 +616,7 @@ __cmd_probe(int argc, const char **argv)
 	set_option_flag(options, 'L', "line", PARSE_OPT_EXCLUSIVE);
 	set_option_flag(options, 'V', "vars", PARSE_OPT_EXCLUSIVE);
 #else
-# define set_nobuild(s, l, c) set_option_nobuild(options, s, l, "NO_DWARF=1", c)
+# define set_nobuild(s, l, c) set_option_nobuild(options, s, l, "NO_LIBDW=1", c)
 	set_nobuild('L', "line", false);
 	set_nobuild('V', "vars", false);
 	set_nobuild('\0', "externs", false);
-- 
2.47.0.105.g07ac214952-goog

