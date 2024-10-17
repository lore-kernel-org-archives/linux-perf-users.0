Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD39F4ED
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124750; cv=none; b=qub2yn5lEKMgfqtK8N6uXuS76xSES4taPZCtyHGenhXtK8cFShl2WwinoDhpcehs+FRJYYQYiAOi6WFC2NIUw2qUY7ZsTJyeaiTftcFWlAdfZ1iU8qepBVaag+vWeDhxVv9wuXTdeSsq4P1WqDNEz9MbucL+uK9GMTK7On0CiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124750; c=relaxed/simple;
	bh=jRBIWpJEX0aE5/ws37l0m5t2Darx3S6uVGOdkwAgjeg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Q8R8lYoYtPtat6CQhGIc5V2vGUN2AdqnPt8CYICfZ+yIkruhlN71PKfuzji4fNJdrIAXs5oIbIxjZfArYvDmeOSVoJK9t0BmfWDbG0YHZRIaOJTBRaORFHGTKWpydR8cnbSaxb3YHRLO6HQeD67LX23veuFmnKxxN7Fxvhzxwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yENPOAKW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yENPOAKW"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so748186276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124747; x=1729729547; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dslSAnjJv4+bi+jw9vLrzNQpv+NsibScELb0cgIuYNw=;
        b=yENPOAKWHaCIX2xI90PL18Ym8n5chyJ5vVFCYUVDEf8EmCp26NlT96EWqlKF38sU+5
         VDjg3JOsXDdo2ZM0bCGbqqP95H98wqiRtnGjwRAhclSL8Yv+Tipd8C9WLhcXc35FPHru
         CAIeUBoCVEGewBPoWvsQh5rsCTSMKkUENv2Rd++6TdcdLQwRyUqyYEMcHsrbADZbfVU3
         XwkllFcePZxaRhKXq65I7z05Zw6hLIKguR/qjLO2eybNBqta052gN7Qugifi+izDh7st
         n5PQmPnQ3XStBhR6SZHQ5irB+/20Amrwq6/3JDoMwnlgftMhp0dXd2B0DukWnQz/g5nb
         psIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124747; x=1729729547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dslSAnjJv4+bi+jw9vLrzNQpv+NsibScELb0cgIuYNw=;
        b=ub6d3XqGIHppmcf3+OoGO94UJO2IpshYhemBnFZwRCiq0tv0W7Cqdb4t6+i93l8E43
         WDs3HNxaa4m2eeRE6AnuBzdZaepVcVwwgKb6fS687MwMU4nR3F3d6kf7Reinur+M+1sN
         +9+qdoKIPgmY7w14lJwfHSRjvJ0LSadA1qNxaXAulgEiHXKzWNPLruA/8fMbT/991+LV
         zYwJOKXwBEVcM+RNeNqTgN9knSxSpALPradoT/W8BJHFR1TWYcgRbDIUbnAgJX5PlGh4
         YSw2B76YIOekC+LbPAnrJbmaB/tmrB7yUewpF8r1u5nbcyKWuCbtcuKvCi7skc/jjpuh
         B9mg==
X-Forwarded-Encrypted: i=1; AJvYcCUHOKEx/Z3hqkVSpN4v2B1jaiujsH8btAmX1VmnoRJMWOmmdVTLVeJHlfGXCsrvXzCWxuref3sapb0K5fBFn5IQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmh1XtE+ArXnbmFS4FLiJRbyMlMAwkRlsh4kctcyMAEuu0a0R
	yuys5AcVX0ZWXA8B/KIGbJMhhxezv5lN9YrlvKbwc9cJubBlcAOa+NdhQjpiwAVT10udYIV0vOU
	us7Sk1g==
X-Google-Smtp-Source: AGHT+IGX+xXJQajfsUo21pSiHMMPg3ixWu0rLrNuUSYK4yFL/4dyDAI12MBtvoLY2sM/xxmxtpwsQUR20SGF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a5b:505:0:b0:e28:8f00:896a with SMTP id
 3f1490d57ef6-e2978594c30mr3203276.8.1729124747028; Wed, 16 Oct 2024 17:25:47
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:08 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 08/20] perf arm64: Remove dwarf-regs.c
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
the function can never be called. So remove as dead code. Tidy up the
EM_NONE cases for arm64 in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/Build        |  1 -
 tools/perf/arch/arm64/util/dwarf-regs.c | 80 -------------------------
 tools/perf/util/dwarf-regs.c            |  4 +-
 tools/perf/util/include/dwarf-regs.h    |  2 +-
 4 files changed, 3 insertions(+), 84 deletions(-)
 delete mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 4387a6d6a6c3..a74521b79eaa 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -4,7 +4,6 @@ perf-util-y += perf_regs.o
 perf-util-y += tsc.o
 perf-util-y += pmu.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
diff --git a/tools/perf/arch/arm64/util/dwarf-regs.c b/tools/perf/arch/arm64/util/dwarf-regs.c
deleted file mode 100644
index 343a62fa4199..000000000000
--- a/tools/perf/arch/arm64/util/dwarf-regs.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2010 Will Deacon, ARM Ltd.
- */
-
-#include <errno.h>
-#include <stddef.h>
-#include <string.h>
-#include <dwarf-regs.h>
-#include <linux/stringify.h>
-
-struct regs_dwarfnum {
-	const char *name;
-	unsigned int dwarfnum;
-};
-
-#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
-#define GPR_DWARFNUM_NAME(num) \
-	{.name = __stringify(%x##num), .dwarfnum = num}
-#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
-
-/*
- * Reference:
- * http://infocenter.arm.com/help/topic/com.arm.doc.ihi0057b/IHI0057B_aadwarf64.pdf
- */
-static const struct regs_dwarfnum regdwarfnum_table[] = {
-	GPR_DWARFNUM_NAME(0),
-	GPR_DWARFNUM_NAME(1),
-	GPR_DWARFNUM_NAME(2),
-	GPR_DWARFNUM_NAME(3),
-	GPR_DWARFNUM_NAME(4),
-	GPR_DWARFNUM_NAME(5),
-	GPR_DWARFNUM_NAME(6),
-	GPR_DWARFNUM_NAME(7),
-	GPR_DWARFNUM_NAME(8),
-	GPR_DWARFNUM_NAME(9),
-	GPR_DWARFNUM_NAME(10),
-	GPR_DWARFNUM_NAME(11),
-	GPR_DWARFNUM_NAME(12),
-	GPR_DWARFNUM_NAME(13),
-	GPR_DWARFNUM_NAME(14),
-	GPR_DWARFNUM_NAME(15),
-	GPR_DWARFNUM_NAME(16),
-	GPR_DWARFNUM_NAME(17),
-	GPR_DWARFNUM_NAME(18),
-	GPR_DWARFNUM_NAME(19),
-	GPR_DWARFNUM_NAME(20),
-	GPR_DWARFNUM_NAME(21),
-	GPR_DWARFNUM_NAME(22),
-	GPR_DWARFNUM_NAME(23),
-	GPR_DWARFNUM_NAME(24),
-	GPR_DWARFNUM_NAME(25),
-	GPR_DWARFNUM_NAME(26),
-	GPR_DWARFNUM_NAME(27),
-	GPR_DWARFNUM_NAME(28),
-	GPR_DWARFNUM_NAME(29),
-	REG_DWARFNUM_NAME("%lr", 30),
-	REG_DWARFNUM_NAME("%sp", 31),
-	REG_DWARFNUM_END,
-};
-
-/**
- * get_arch_regstr() - lookup register name from it's DWARF register number
- * @n:	the DWARF register number
- *
- * get_arch_regstr() returns the name of the register in struct
- * regdwarfnum_table from it's DWARF register number. If the register is not
- * found in the table, this returns NULL;
- */
-const char *get_arch_regstr(unsigned int n)
-{
-	const struct regs_dwarfnum *roff;
-
-	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
-		if (roff->dwarfnum == n)
-			return roff->name;
-	return NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index eac99a246737..18e916c8e993 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,14 +32,14 @@
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
 			     unsigned int flags __maybe_unused)
 {
-#if EM_HOST == EM_X86_64 || EM_HOST == EM_386
+#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
 	}
 #endif
 	switch (machine) {
-#if EM_HOST != EM_X86_64 && EM_HOST != EM_386
+#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 062623aefd5a..e640657f69c8 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -79,7 +79,7 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
-#if !defined(__x86_64__) && !defined(__i386__)
+#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.105.g07ac214952-goog

