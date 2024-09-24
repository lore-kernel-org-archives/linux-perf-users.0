Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32801AB6F4
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193887; cv=none; b=R/iuy6gXGYQB/22dUCIrwvYyYBnF26DcBKLiISViFmdedWL/HoCjDeMcJbgBqI3Rz7/yM3TbirhZ03Iw9P0voHE24qtZxpB7genG/h8fCFcdGGdpi5OlkCBfVKuztxnZxu3y1bxKpK2WG8MIXIFPX7EbZ98vVUT5hrPn0Yv3XIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193887; c=relaxed/simple;
	bh=6ldSzspe4/zfU6p8RY13b2Whrjh9/0dgtmSSNim1Au8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hx4U6XBxe7W+3xel+Qk0vUJaHXgpniWjc2kNTEWvHW3lWSxdO/Db0Okm/GNSr+1n8f4bL8CnLmP8jJKc8LmkI3fXbEdBHLWsLdoZCZpmMqU8BUhEU7D65x7XtmuwL2D/pyQ7c/d4hmVXaJAmMIyCdWZa7OqKHwypg6msGvVV+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IKpVOd7v; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKpVOd7v"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db7a8c6910so85563397b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 09:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193885; x=1727798685; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIuym/Se3whvq0Q9G+aE4AofiMsCpDlgHN99NPdUOcI=;
        b=IKpVOd7vQRvifirkxe62PUozDdL5tkaliBMoSyr0NzuaFcacDZbqzFp/9eNqCqdaII
         AaZl/2yVBelczhD5LEmUsBBZ6BjkqUWjtOCa7bxJeu3IQ4nazljuimCPmFds1Net+cri
         3h5Vna9d9MwYzq6fosHvJ0lNVvokgwY+xkdW/nV1j31KIR35lzmWQZ9rwUiTT5TnUJB9
         cdxj8RSrHnycB05bDAd049RmDCn2bB+g30zELoycSw9HuIs7m8QoYUM+xZpEvd5CfL4T
         ob4NeHyfIKcn3TzercuJQ+z2J8ChmH/fr36Be33vUj7QY169Y2pmIgWPRtWnqZ0ZzRVE
         SjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193885; x=1727798685;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIuym/Se3whvq0Q9G+aE4AofiMsCpDlgHN99NPdUOcI=;
        b=bs0fPsVgp0vnc0udu/pthqq2z6P+ITnWtjFQMhITrVXPfyTw/dbuYBfrYnJJ2kr/6V
         1+BiWPEAh7MQ3nwIw5wAc8YOTV9Ur3Tt/dLQvict+cv6I9zQBsEghffNi81D+mT/Vwkk
         0xggHqsZpLpZFrmoOTBg5GrHy1oG2aWtl2qlh426a1K+L69ds6A4ap+l5SJgBpzCtGgH
         HZIs55rmvLgn9gDg/F/QEkLgWiyMXpqZrqQc6VWCLxrKzevG54w3PRdvbqT/KyZF2Uk8
         QH6/RUb3gHtA/7BiHEawrGDNqqwulEyooVv66020dO2yfcv+U7UztgGpF324Cxrp89JS
         xOng==
X-Forwarded-Encrypted: i=1; AJvYcCXpy9Fu/AoZtWx74ovwYwyarZE4sBRbKhCmv+mwGdklpGzC++7Y4dkPM/XlgKapgTcBAnLh96S5GOyLUcsJc862@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvPstFn9nCLLZsWTqHNUynQ9D/BtRe19tpZ4sFFCuFOfRlXkd
	pG//xo7hAK5uJB+ufnwEx0iNVgVzSX8Oe0yuO4WdR8e+UMXlfv30o4G4u4swuZ7+u/jSGFvXlMR
	IqYn65Q==
X-Google-Smtp-Source: AGHT+IEhjsG2ZGO2x/HqgX5T0/aN9BdMijIJURe/2RWcP8Yo1jU3pzKYrC3MPs4BlLhOz9cbMlLyoTQB57zn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a81:8603:0:b0:6b0:57ec:c5f9 with SMTP id
 00721157ae682-6dfeea02193mr1014117b3.0.1727193884972; Tue, 24 Sep 2024
 09:04:44 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:08 -0700
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Message-Id: <20240924160418.1391100-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 01/11] perf build: Rename NO_DWARF to NO_LIBDW
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
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
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
index 5e26d3a91b36..55a39211496d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -429,7 +429,7 @@ ifeq ($(feature-file-handle), 1)
 endif
 
 ifdef NO_LIBELF
-  NO_DWARF := 1
+  NO_LIBDW := 1
   NO_LIBUNWIND := 1
   NO_LIBDW_DWARF_UNWIND := 1
   NO_LIBBPF := 1
@@ -471,9 +471,9 @@ else
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
@@ -496,7 +496,7 @@ ifeq ($(feature-libaio), 1)
   endif
 endif
 
-ifdef NO_DWARF
+ifdef NO_LIBDW
   NO_LIBDW_DWARF_UNWIND := 1
 endif
 
@@ -574,17 +574,17 @@ ifndef NO_LIBELF
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
@@ -633,7 +633,7 @@ ifdef PERF_HAVE_JITDUMP
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
2.46.0.792.g87dc391469-goog

