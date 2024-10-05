Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D4187FF9
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158205; cv=none; b=UN2ZtJcaoClDzMtqMO80D79TowLNp3BOkn7X2SB23OYFZvbl7b4T8p33GTihHM+NhzoIA1M/jfrUXcfwYtrlBOmTlfeWTjWkYbG1Bgd/XmzQi/Rsu5XkPxyv5TjyWXUw6fk3zOCwaikYGYRLMiiF+4j2G4TV69AlmRYTrOHAdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158205; c=relaxed/simple;
	bh=kXNwRqhYw2oyTtE92Hlo7PIb68o0Ad18nbAfRGxWq8w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cs7fdPR9URFzpr1C8omFIFQZSCBDA5wuxDy11A2egarmbAwl26Zhn4X420kco1T1f5laJbFKQQeRvBlYpNiBMxfBBUXJxPQXBe+BVeXDXKEOe+vJ7I9O2cYEB4Ov5Swr9Z5Y8zm7EVd6OunsQdOKXptQ5jk2+y9ynKh7oPdHfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8mZptUz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8mZptUz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e230808455so40287317b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158203; x=1728763003; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHudwD3HxqIE2xCZ8D7KanMs36PPvPHIODUgdbqENmk=;
        b=c8mZptUz8k/TX5vlvI9UcF5EEhGcbwnABL7Y44WzFu+EDMJUpfhzmm0xySu9y/DEx3
         lcMZnpJdQqj4qwGiQwPrcJ5cnHmxQoWb0r99gnv7xvC91h+sqPN+XMT39L57YF0/dHY/
         cD6HqH4eGBZG1+uQ48VP32nG2Zibu4amAnzWcRhQINP1OA6vEd1AdF3YsIbzotFG29GM
         JblywqiJEIzsemHr0VBbgUYb87l7tbc1z2AlGC2sHMzGxjZUCdICY97I8/nM2Gnl0f5j
         ej8/lPcDKvSRtH4oLqyz2sHQhuivu7wDnEZ2BtBcOwPOgY5SOuUApgYCRK1aJu1fQVN5
         jbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158203; x=1728763003;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHudwD3HxqIE2xCZ8D7KanMs36PPvPHIODUgdbqENmk=;
        b=MIjX2uCUdHorH9L6qis5aUuc3Ywg90WVGx2R1biMRf0oXx0SYnA2lvmzOiAhLUT05z
         qQ5SY9+u/zCbTgH1dvmWFqBUd6XLhLR2WAIRdpPyyIiHMNaAv3iY4T+s5QLxFYJEMIHM
         5YHkWiYUBfAD+qhc4kdKpzAhTrQSltPt4xHLmwPW7aHVjsnt80cUDXK5rWLLOdGFL0Rq
         MIG7p3FqCZsyNs2L17bP0rsy3C1FIW9VJVW5ZSmTD4jmVG/991Zj8LE6OEDfG2R7sf1O
         eOK4QsDX1Kdt4kFeVmoc9U6GBgwiInpG4An7IlksmIb1l0HpF/e7NFRMBmRJeUYmRfjm
         jDyg==
X-Forwarded-Encrypted: i=1; AJvYcCXZSnWa6sUA4zQujn1PEvblR1tsVi8W2bmVn65GOX3m4w85QR3CEjYe9TVjNS1+66j3hE3hebWqZ0PEKUzNWUdS@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBkuBot+BWryxC6SrMugvni9K4u+6s2EqDnmOOuIfk2p+Veky
	/5dE9VWVOHWvYQa2exahdkrI9xS6ZYuV7F0AA0X5De1ExV2vmlnp+UjCGjx48iLLxwcaUT9mSS7
	U3rIbwg==
X-Google-Smtp-Source: AGHT+IGeOfTmumngcabHRBihmvSKyViFpRQ89UdAfehUtwMJwCeL6FioC5a/4B+7LmCwWalq3BF9Zy/Nx0rQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a05:690c:61c8:b0:6e2:e462:e191 with SMTP
 id 00721157ae682-6e2e462e214mr604667b3.6.1728158203030; Sat, 05 Oct 2024
 12:56:43 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:30 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 20/31] perf arm: Remove dwarf-regs.c
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
EM_NONE cases for arm in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/Build        |  2 -
 tools/perf/arch/arm/util/dwarf-regs.c | 61 ---------------------------
 tools/perf/util/dwarf-regs.c          |  4 +-
 tools/perf/util/include/dwarf-regs.h  |  2 +-
 4 files changed, 3 insertions(+), 66 deletions(-)
 delete mode 100644 tools/perf/arch/arm/util/dwarf-regs.c

diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index e06fea1ea8ff..f7a8b37d1c68 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -1,7 +1,5 @@
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
-
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
diff --git a/tools/perf/arch/arm/util/dwarf-regs.c b/tools/perf/arch/arm/util/dwarf-regs.c
deleted file mode 100644
index fc5f71c91802..000000000000
--- a/tools/perf/arch/arm/util/dwarf-regs.c
+++ /dev/null
@@ -1,61 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2010 Will Deacon, ARM Ltd.
- */
-
-#include <stddef.h>
-#include <linux/stringify.h>
-#include <dwarf-regs.h>
-
-struct pt_regs_dwarfnum {
-	const char *name;
-	unsigned int dwarfnum;
-};
-
-#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
-#define GPR_DWARFNUM_NAME(num) \
-	{.name = __stringify(%r##num), .dwarfnum = num}
-#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
-
-/*
- * Reference:
- * http://infocenter.arm.com/help/topic/com.arm.doc.ihi0040a/IHI0040A_aadwarf.pdf
- */
-static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
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
-	REG_DWARFNUM_NAME("%fp", 11),
-	REG_DWARFNUM_NAME("%ip", 12),
-	REG_DWARFNUM_NAME("%sp", 13),
-	REG_DWARFNUM_NAME("%lr", 14),
-	REG_DWARFNUM_NAME("%pc", 15),
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
-	const struct pt_regs_dwarfnum *roff;
-	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
-		if (roff->dwarfnum == n)
-			return roff->name;
-	return NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 18e916c8e993..fd21f9e90e40 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,14 +32,14 @@
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
 			     unsigned int flags __maybe_unused)
 {
-#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64
+#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
 	}
 #endif
 	switch (machine) {
-#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64
+#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index e640657f69c8..0b533409d82a 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -79,7 +79,7 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
-#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__)
+#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog

