Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951FB18B46A
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158219; cv=none; b=DtitVilH5RUYneHSvE3xc5nQBsXJrRvkoGDplbJ1pGpsqDfEfxUxw5jttyg22NWFm9K5oWg5LTQb4t4sSPfYw+5CpUBYMepVd95tXlfFouPL4ZqsYXvT9w87E7B5fK18k+hU6Eq/4zjArNbIMzDIu832dFANUaTuP4BM5zKkd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158219; c=relaxed/simple;
	bh=r9NbAC8gxz8l4gFDeMBDREY0VhNgL6sfqWYNqXH4PTo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Xj6GtipT1x8y/U+SZQyj/5P1NQZjrDIswZJJe1yV1a+Bep/oy21710i1YIM2e+eLHdKa4hh/7qmJ5F8STOcMig8CAFnZjXRNzDbXWxPg+xbEaKrWntJ4o+SzgI3VcwuobQmfXw1oZsQ3amwJPDctIN1A3P6JWqAksLWJiOsG7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOA6tcNb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOA6tcNb"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e26046ed465so4642748276.3
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158217; x=1728763017; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/F9b72Zkf2GsIFu+2DXDg5IeMJO1DkrHhzQ8sRYn1M=;
        b=hOA6tcNbLVtKVy5Q0nJh/WgtxSlRWzraNrEnr6I7bFUM/1vMdZLqTV1ec+oGXtXCzn
         E3XSetYl/apcQXgCn5OWe4K48uyeT/k/YYWiBti7W8azZJOX9FY8B6cmQ9/jH6t4+aT1
         EVuslUEN7lRQyMiyRr1CLWDRAxGB2DNnx5atEUqxG0+p3K3EINTTQoKrSjUVQT17HuoU
         Yswlz3pFgZE1uHNaHcVZmEuLCJ1xcci6gQueYbEHzdVhLLer42ApmhJ8zlp6S2MNmCVa
         23txZbNNIaeZ3UGWRvmkflzvvB5QbSG4KBK9+lBSIO7+lLbTKPmZdnLUDQPR42gY2nVn
         QO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158217; x=1728763017;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/F9b72Zkf2GsIFu+2DXDg5IeMJO1DkrHhzQ8sRYn1M=;
        b=geNxCltTjNJDj4Lh7yP07kAkzd1ELG7BvpA6miPnBZFlFFtdIkUFsJRyVcmoOMzHCG
         cAUIDvmkwg64gjb5e9ptbrLd5Ghm2vviV8F+NvcDiA7R0XJZKSZGuxSY0sS2rxfn4kQi
         WudwXFShPCagCgqQYIE/Mjp/skfkolAat3tHYzMGBaxt25UthGwM1734nFJ4JwBdyveo
         xrC4sgbehnMVV9D4y7vnStWnQFqqCrnPd2qLFNg+marHvVdStDT9ZQx67mPqT5ePt7g5
         yolAO8ayqSjkWLBcy/BqhvqmrO/iDG7gpcBfXEbIslR3lX+aFjj7MXBiFcClMWS/neyn
         qeUA==
X-Forwarded-Encrypted: i=1; AJvYcCV94zH96tWo4TcZtGJGEFaE/cd9Y/cJL+rDHlkv+I7/yfNDjBG9Qu9aqf9KTf9L30FGz76+yXnuTC7YFTps+oRI@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhQz82/1sPdqNf/gaNt59S01cb41anL9P0kHa1NZWGS4DVLKU
	A7P6K918UMCdTNLBUxTJeU67l+W0/5LLAYfP04jEQf0qrJ6YRryXcr8mxBUElPe7rVZE/nZrmBn
	kAwoPcg==
X-Google-Smtp-Source: AGHT+IEj5O0gwc8Gc93w9xy2xazDNAARz52y6kjE2x/HhCkqgnOqkwvm6mvHCmrWAxypq0YrA/EuiMHDARCd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:7488:0:b0:e16:51f9:59da with SMTP id
 3f1490d57ef6-e289391f800mr15573276.6.1728158216595; Sat, 05 Oct 2024 12:56:56
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:36 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 26/31] perf s390: Remove dwarf-regs.c
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
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The file just provides the function get_arch_regstr, however, if in
the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case
the function can never be called. So remove as dead code. Tidy up the
EM_NONE cases for s390 in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/s390/util/Build        |  1 -
 tools/perf/arch/s390/util/dwarf-regs.c | 16 ----------------
 tools/perf/util/dwarf-regs.c           |  4 ++--
 tools/perf/util/include/dwarf-regs.h   |  2 +-
 4 files changed, 3 insertions(+), 20 deletions(-)
 delete mode 100644 tools/perf/arch/s390/util/dwarf-regs.c

diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index 787410f99bb3..736c0ad09194 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -2,7 +2,6 @@ perf-util-y += header.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
 perf-util-y += machine.o
diff --git a/tools/perf/arch/s390/util/dwarf-regs.c b/tools/perf/arch/s390/util/dwarf-regs.c
deleted file mode 100644
index 5bcf3192623a..000000000000
--- a/tools/perf/arch/s390/util/dwarf-regs.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright IBM Corp. 2010, 2017
- * Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
- *
- */
-
-#include <linux/kernel.h>
-#include "dwarf-regs-table.h"
-
-const char *get_arch_regstr(unsigned int n)
-{
-	return (n >= ARRAY_SIZE(s390_dwarf_regs)) ? NULL : s390_dwarf_regs[n];
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 2c6b197556dd..1649fc07f4f5 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -34,7 +34,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV
+    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -43,7 +43,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV
+    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 35f4f33205da..25f3d6b90f10 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -81,7 +81,7 @@
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__) && !defined(__riscv__)
+    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog

