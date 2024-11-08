Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D9219E45
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 23:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109593; cv=none; b=BuLbnCEd9v/a3MRwW9nqjKik5FG6EPhkqiaG2xPV9sGPUYX1kcD6ua9h4Y8dRxWWNqZ6G691Vig1Ns1ELv6ybJA7A8KaiOuWezqIB17MPWCU87mlNGC/W9Zmj87lTwIPAZlKfFLxJRas7sJBp6bAj3nlOSOJCks1akdN9IuXZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109593; c=relaxed/simple;
	bh=oLWP8+yPmHd8uP5dDg+Qa9xhXSMVy3cr/qAenlwmi4c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qo+qWgfq7vKwv7/DvXuHjq0fXQAsCPq8nKnowWS+3PfMUz4GKl0aTmBoyhQxNdqHdnk0ZUq8QVbWvsEUMj8mi+taMkebMge/zvKSajQUPPfMfnAuwx3NsVcFdi8lico6t+IiO0GUu11ZHIRgGSnozuakpzP2dXFB2lPsf6D6+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLKPpITp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLKPpITp"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a238068so50028307b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 15:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109591; x=1731714391; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQmCsVPRhYPEq2sxlk0awzxNmB9PlXvoAxqxELAu7Vo=;
        b=iLKPpITpVvf9uYm92dNjmIn3g4RcaKv+sPOX3dQ6MUTSSv2+EPfRLavYb77JrlSo8D
         e6sZfjc1RoWP5IvrcP8NeOS2Mwr52ZNX46yBH6KpV5LZzOeDUmMhK3vXqIMfwxIXE7Yk
         tQhY6QYqM/VR3POe1UQOho4VQSQYzsAk1yVc4Fnc7fGz5Nvfpyu9cjaN4XgvEI38YTxr
         Ru+v/19LstCZPwVCGSiAA5UTb4bgME89uSmwAPPDQQ2hsKEdBZPpKeCa1RLoX24eavbl
         mRvrvGC/MbG+ERmpHlcxeHgjtxU/iA4L8eZba73imLGOJwWVpIy/hcYFfogUhmwEzAN6
         Ufig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109591; x=1731714391;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQmCsVPRhYPEq2sxlk0awzxNmB9PlXvoAxqxELAu7Vo=;
        b=xIO2WJhM7vzL9xsXW+Kq3OI2/PDn+fzPc2h2thluU5d/jsk0LFygLw/ToyScHOZmzn
         x0Uct6ljUiX5P1trVxJC5WZ3rIKFWt92e8oXzJjhW7c+H/orYsCsexRjQG/TLTX09iCu
         70pHCJHzY8XHM+aVXK/4uRRvbm2+ceGTRfGDaUXzSfLp4gwtFFSWjzhPtiQxqnZ7JYk7
         dV3j6W/HcNWvRA8SUZ10R+zYKIAucl0r0IcRy21OtDcoR9pqe6nxrtN4UkM9Nqr0nK1O
         RKYtdoMywAuWik4pWkevOzergu6sJZpOZvo/vN40vFfrI3RjLQrQNrYBA7zQmW6xia1Z
         N3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsLScUk1MfhuxGGZNyulnORFpdc8h8EWXnQfzO4NPha55TjS7C+KcSMps0Fek607OdJQ0L0K8CL785Q/B6Xz6H@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLmhMLQfFUgKpPhdHdBUpOIlDkrg4c66QPEt3rNqyFQ8+am5F
	btBCsnhceTHvyolTTnmlGKKiYbT1z06Yjv3KxCWhLOO72RzXBQFL7LA1NQNiOJeWZbQiO2Ck2De
	fvbiESw==
X-Google-Smtp-Source: AGHT+IFFASGHSVp8Ef02ZpRY4Z1jZ9cv/KNzpyrMsIaYpIQgk4O1dsJu+hlPKBzodupKX2SzhhfpeBrIwd7c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a0d:fd01:0:b0:6e3:6414:80c5 with SMTP id
 00721157ae682-6eadda22e76mr315447b3.0.1731109591007; Fri, 08 Nov 2024
 15:46:31 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:54 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 09/20] perf arm: Remove dwarf-regs.c
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
EM_NONE cases for arm in dwarf-regs.c.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
index f976528fdfd6..3652f9d98fe4 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -89,7 +89,7 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
-#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__)
+#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.277.g8800431eea-goog

