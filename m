Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29821E105
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 23:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109614; cv=none; b=E7VVbi2AxgZVVJKa/y0akY489G6swQvhUAr96WB/MZ5pK8m64OQtSthELc6xyrq8Ae+hwswBSvb0Hw4B+83I6amxZR2MurP6maItEERmU7O0baAr+PSazCnmQzRY1VyZkqqSCgFXWG/VVlcDnAjpV0dut2Onicaz8Qlp6tBmOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109614; c=relaxed/simple;
	bh=X1DpwGLvH8kRSONBEEndIwSnJXP1g5GqNf3d+yx7nTc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=P2bMr7nllBOHT4Dv/dQx8gliJsWQelMQmDPrfI77hMVnZOE/U3SD5UAhHWLLv5tGgLk9qXe/ULkkFYLrb8k/X7DFYoHNTJUaQUEQMPWycaXHWrg1GFhXU+LfBxior/xOZY2ejz/dcz9aMFTb4D92yCabDSoZAKhjtElZRRHACgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n+Ewc+XT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+Ewc+XT"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc8902e6so4981706276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 15:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109612; x=1731714412; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYN4r2dXiDDQ1/umm78N+WhLJG6p8WQgWglBPVDyni0=;
        b=n+Ewc+XTUjT4SPzF3kfKH8ecOV73LDwBiMSUsBxdL+U8BPSBBMwvDzbU39QCgtkOwM
         Y4hbAsdCVccf2f6LiIZRXSKrW2GPUtDcQPvnbcaxmgLNBwtyjH14G/os7OAOIC90T4TM
         1eLfdO80+2ka/jUvABUp/vDuw/Mzw/D/n4weQLRaBpLI0NteaK77YaSbla5HeX+kiZ0m
         2HNf77eOm8FYIQ1RzHvUwJRK91STNWrefNO58iyxAtXXYGg2aSK2NAbK6IvDP0y6SIyv
         ucrsyJY1V2p4CH8IVxE+bv13xrK9ef3V66lugWBKaaiOa/SLvTonU7dppbZUQDxfJCYX
         3pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109612; x=1731714412;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYN4r2dXiDDQ1/umm78N+WhLJG6p8WQgWglBPVDyni0=;
        b=F5sy8AI7oBar6g35hyL/Jdx/EcH+kMtKab0vjUv5AFIx1gmVVL3izECZKby4J+yFcz
         RAxnEMqkk0FM4Sq0nLRCrjQmtmzYzWBvLTnWf2XwQcxUITHZQOOKTwKPEq9BqfUNoKFP
         W3r56jQmEwztPxZnhZwM8fzi6alqQO0+BB/NWyA2NzN3y+JN88aJ6+sNKhUKqPTA9aA3
         +5wNzodo4fJ0b4luBXW2uVJ1Nl9Y3rkov3OujctUkXRFBLv7yrITPooWfAUU48CCsq+X
         6nfjiX9q2PzvLXSx3UHHiXZ5h1W0E2BTnKkBC6wRuva5QSqBbtt2uQTq5J6lrtyIa8jL
         BAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0EY09dy1+zYhi1wml125FvnXFLvoemnPfM194uOqvFI4uon2wQilAA/DXd7C5k3ghdGjrw1Xe1yA4Ts8L4pzk@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUIVsSFcx7oqu9aKg1myuOrGlJYWq2602+SKMQ8IQ7k9cZSON
	ETHOTlD2wVSvFl6jpZMkHGh9tLaH/PzYxIl6yZ3ggLAK1is4jSkR/w3GN2Q06pSIGrBP3mwKe1n
	fXJhtFg==
X-Google-Smtp-Source: AGHT+IGrTeQzmzATOMc9sc51qhHx4vN1bXYAD5BhwSzzmjme2VXQDGFuwDyPU+Bin0IaJPd5bjTzYYDXlmfz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a5b:acd:0:b0:e30:d561:dad4 with SMTP id
 3f1490d57ef6-e337f8417bemr9670276.2.1731109611796; Fri, 08 Nov 2024 15:46:51
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:46:03 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 18/20] perf xtensa: Remove dwarf-regs.c
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

The file just provides the function get_arch_regstr, however, if in
the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case
the function can never be called. So remove as dead code. As this is
the only file in the arch/xtensa/util clean up Build files. Tidy up the
EM_NONE cases for xtensa in dwarf-regs.c.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/xtensa/Build             |  1 -
 tools/perf/arch/xtensa/util/Build        |  1 -
 tools/perf/arch/xtensa/util/dwarf-regs.c | 21 ---------------------
 tools/perf/util/dwarf-regs.c             |  4 ++--
 tools/perf/util/include/dwarf-regs.h     |  2 +-
 5 files changed, 3 insertions(+), 26 deletions(-)
 delete mode 100644 tools/perf/arch/xtensa/Build
 delete mode 100644 tools/perf/arch/xtensa/util/Build
 delete mode 100644 tools/perf/arch/xtensa/util/dwarf-regs.c

diff --git a/tools/perf/arch/xtensa/Build b/tools/perf/arch/xtensa/Build
deleted file mode 100644
index e63eabc2c8f4..000000000000
--- a/tools/perf/arch/xtensa/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-y += util/
diff --git a/tools/perf/arch/xtensa/util/Build b/tools/perf/arch/xtensa/util/Build
deleted file mode 100644
index 2d1a48696ad9..000000000000
--- a/tools/perf/arch/xtensa/util/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/xtensa/util/dwarf-regs.c b/tools/perf/arch/xtensa/util/dwarf-regs.c
deleted file mode 100644
index 12f5457300f5..000000000000
--- a/tools/perf/arch/xtensa/util/dwarf-regs.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (c) 2015 Cadence Design Systems Inc.
- */
-
-#include <stddef.h>
-#include <dwarf-regs.h>
-
-#define XTENSA_MAX_REGS 16
-
-const char *xtensa_regs_table[XTENSA_MAX_REGS] = {
-	"a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
-	"a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15",
-};
-
-const char *get_arch_regstr(unsigned int n)
-{
-	return n < XTENSA_MAX_REGS ? xtensa_regs_table[n] : NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index a0bcc2529cb0..05fff75a8f59 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -35,7 +35,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
     || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH \
-    || EM_HOST == EM_SPARC || EM_HOST == EM_SPARCV9
+    || EM_HOST == EM_SPARC || EM_HOST == EM_SPARCV9 || EM_HOST == EM_XTENSA
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -45,7 +45,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
     && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH \
-    && EM_HOST != EM_SPARC && EM_HOST != EM_SPARCV9
+    && EM_HOST != EM_SPARC && EM_HOST != EM_SPARCV9 && EM_HOST != EM_XTENSA
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index cb632d1f46f3..e0f1d65895f5 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -92,7 +92,7 @@
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
     && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__) \
-    && !defined(__sparc64__) && !defined(__sparc__)
+    && !defined(__sparc64__) && !defined(__sparc__) && !defined(__xtensa__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.277.g8800431eea-goog

