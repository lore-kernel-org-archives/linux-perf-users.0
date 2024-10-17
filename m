Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5697185B5D
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124775; cv=none; b=iJdAS768WixsXySwMnIxDpMesma23Msxj8BasLGFivzHwMwQjZH9ajH1cRGj/8gdb+9yUCd3uLgMvRC6eogNPfQeksrVe5x6NG3Bxvy2ZVuoA1SIPVGYGMsqct1hVjdjPXJ7c0XCpBdzO6euS+RvGZcRcvYNE3saI9CgdFd8tFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124775; c=relaxed/simple;
	bh=NfxF1XWnz27bXBiL5Xjm5UV8lUk9JDBhGby9Ft11L3k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QmkzztY/bt1VMuO0Q0lUYEYOukjTA18IDF7c68/r0u/cvWoW8wjMa1izKC/rk4pN5Mb6q3y3EESJ5aDURtVBEImPgaKPi3MeyAH28+1Lp9cbY2qemptL/V/s0qYyZIFVhvsMX8tKpD3MMbd1CwTyTpYCzJxLYc9DR2nsNpxGb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=alfuo0Fo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="alfuo0Fo"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e292dbfd834so529619276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124773; x=1729729573; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uq9AxXLwl+md7pGfplbuMGPRmw11SaZaUSrHTUrrfs0=;
        b=alfuo0Fou5Eow6wLc9elAdM/o48CzEhwSKTWkrvyQ5GGw4rRvzeS1liBMLg/5fhm8K
         7CyNBRfbuIVMlFHOUhHGFfoO6LFrHVJJh/dgnSjul9TJJ83doEOxSchOAXn9W+n4UkbO
         xibD/9XO+qkVZv0HjXF3yMp8NM9vhXXs9LGKhAGicKluLdByrRfATX2RcCxiWjVJZEiZ
         K3nWDNtFyDOuHLrRczWLSlShtmg6vZBiFNAGUGr4qWkyF5F36K3Ien53E3xoicRibvKI
         7hUhEAKDKsRiRc8zaul4ekT0f2iMaLeOq7Q0VMuQPY/KKie2EvJb9E93ZZYkabxwwMvH
         y1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124773; x=1729729573;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uq9AxXLwl+md7pGfplbuMGPRmw11SaZaUSrHTUrrfs0=;
        b=ETkLoMIqsSyb5wtJDGh4kkZ7+UocBiJ7/dvlZdKC0BBVhzW2vOjvD4fFev7FpvOIl/
         GeYpD2KS/uuUZRXjWNL53ryKtvcovuQizmCgTfA3Bt8MvQH/+mBKOV9/x1hnELBT57b/
         fHTiROjkqQ28yvgR+dnRUgeqn0rRSen4d5qljM5qLhCS0fboTfQ2l5UftlnreTMXrikK
         UZ4szcysGylVi4o8K4XH1e+mEAbGVR36Qh7hYgKXFBO46cptofNmL3kIiquy1AoYpoOC
         2+bJkOQxcG3kOb51j91D3EAjTDz4AzP4Ne0odHT8AfdfFIow0eHBCS2uyMp2+9br9QBl
         HwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoWwCVBN4qnTow5OskDdC0diqDeecdR/F2druX3R+/fig1hnUdlsYMlpF7xiW6FDexIZKIa7qI7GAoWHejNSGL@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGMxS4jp5ef2jESZRxJzYvMNkaNZvtxQxutuJDy21rh9bnr6M
	eufvc8kfRGTn12rqeyEoJVU1Sy0iyRCTViEH+XomN1LMyG6wbk6w04q7ZyyAMkR7q+nQ8sCgg2m
	agQixPw==
X-Google-Smtp-Source: AGHT+IFblE5b3blF81m60FrHwxXihWa7btaVQayshFuqPR503LpiCQwiOp0I0Sdca5Yyel3RIIDwjSVp3STP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:7e04:0:b0:e25:fcb:3205 with SMTP id
 3f1490d57ef6-e29785695e6mr5028276.8.1729124772530; Wed, 16 Oct 2024 17:26:12
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:18 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 18/20] perf xtensa: Remove dwarf-regs.c
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
index b2cf7d9e4785..9dfc9abfdddd 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -82,7 +82,7 @@
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
     && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__) \
-    && !defined(__sparc64__) && !defined(__sparc__)
+    && !defined(__sparc64__) && !defined(__sparc__) && !defined(__xtensa__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.105.g07ac214952-goog

