Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D421C17C
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109599; cv=none; b=tzUVHCHNQ7uqVljWlmV4KqKa640LsGOGQAsTrBZpVKTDCM0zfPU3W3+hcYREhtIyGGuT4IqpjcZBziOTFH03aaI2MfA+tsfOVK6K6g6dEotVZuWOXuZDyQ41ZQGnZrdzAIPEUdcsTsX6DZngEa/moi0PctvRY+5ZA9ic6qWAKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109599; c=relaxed/simple;
	bh=DUz1E5TwPCKjr9L7E9LtFb/Eshot++fNnVRmXAXpLl4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XNGW3MO0unXEEpwgDMDtzj6cdOY0Ji08IK8Y4pnkXngJ78Q7Dh9oRqvA9Ze0waGkHP3oR+y/d3CTLglUXsJGqt26pkD8tgSzz7PgoLCr6jb4hjehn0lwMHY6eiuHS7/2sQGhKBvqyvDQ/tDi32d3b1UiQyVQXBj7Wje2fSisHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbAQ1KRs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbAQ1KRs"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc8902e6so4981432276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 15:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109597; x=1731714397; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2OyjjDbRvyutbZalHm47RzbC3FdZ2Ys1+/kav0Gy1o=;
        b=KbAQ1KRsHRh1gutKezgisgy1kF1B8VR9+PXdvmR2X/h6HSnkyJOECAw7ya46JPUMyv
         +VlIFhusMBpakOYFotMbfSF2CxRy/p2PJXqBXnoprcFXqCWq6DVntRP2cZF9FtAWEgev
         hBsDzt2QfA8Yh8DUsWIS9ElLGFHkmWt9lgznc+IeYH63TTLvR1TTzFWn9fjOSkhdluY2
         Up4iA91o8Ba4DqP75/A0Edi9oE3HDcSHT0TxUSxGjcj4K0NLAI85nkmxeTqn0Nyk0Pwh
         AXvYiFazrL5a3/fU0uDG9uMd9166ZJroevP0uaHKiSpQKlAQZj7eg/c8YE10ERsRgM4H
         Izaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109597; x=1731714397;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2OyjjDbRvyutbZalHm47RzbC3FdZ2Ys1+/kav0Gy1o=;
        b=Qe0trQFQSw5PZsDOYs6wfFKSVhYENvF5zi46cKIbQq1cfW96RIDhO2Kyr5Ci8jQv3k
         aVZIjY9JK4Tqc8tiA6TFsRvZ+MqCBE3EyHQNeU01TuvNo3Hnpkr5JkglYCAPnB1rSpCt
         LgABIMi7RA6yR63dqchdjW0v9E0F+j1GC3MOB5CWKh5ATmIqDto/nkX7XLvkEUSu8N5/
         8hC2BWOHvX2UQMhxHkjbSnp8WH74DiKeU2KbZIENetgshOJiKqGJ9cWHtvlJMQ+iQZjT
         J+RtqsTMkmg8KTJ2jBVc//PHoL+p/xuSBEoHwW8ZVUYXZ/ZNamMHQlLrubLBFZAefjNG
         fb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXj+RL51rN8QI9H4pSIBURhYGEnSd/GtWp2/PgvtLn+UR0x34xjUkukZ1Ajb66zhv3v3IRpjf1vhOTj3oOGrJdD@vger.kernel.org
X-Gm-Message-State: AOJu0YzvnQEJLkeYUCPwlQzZmWEK28I4MjZ2JJgb/97mn7j/KclDoWpQ
	nQOYFcls1qSilETdE7OGSn5edbZUbqlvY2nEo/O52lamZCb60UTmj3cgTuF7sK+Rn/I2aPnCO2o
	WM8DOBQ==
X-Google-Smtp-Source: AGHT+IGqhTm7YFbGcx/el+7wHNXMpRCyEyd2cOJXBQ6mHFUtI003Rx1t09AGgdDw/1NDsX/UK2nFtyoLebaj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:c7cf:0:b0:e28:fb8b:9155 with SMTP id
 3f1490d57ef6-e337f8e8d9fmr8052276.9.1731109597298; Fri, 08 Nov 2024 15:46:37
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:57 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 12/20] perf mips: Remove dwarf-regs.c
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
EM_NONE cases for mips in dwarf-regs.c.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/mips/util/Build        |  1 -
 tools/perf/arch/mips/util/dwarf-regs.c | 38 --------------------------
 tools/perf/util/dwarf-regs.c           |  4 +--
 tools/perf/util/include/dwarf-regs.h   |  2 +-
 4 files changed, 3 insertions(+), 42 deletions(-)
 delete mode 100644 tools/perf/arch/mips/util/dwarf-regs.c

diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/Build
index b328109fc16c..691fa2051958 100644
--- a/tools/perf/arch/mips/util/Build
+++ b/tools/perf/arch/mips/util/Build
@@ -1,3 +1,2 @@
 perf-util-y += perf_regs.o
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/mips/util/dwarf-regs.c b/tools/perf/arch/mips/util/dwarf-regs.c
deleted file mode 100644
index 25c13a91c2a7..000000000000
--- a/tools/perf/arch/mips/util/dwarf-regs.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2013 Cavium, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <stdio.h>
-#include <dwarf-regs.h>
-
-static const char *mips_gpr_names[32] = {
-	"$0", "$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9",
-	"$10", "$11", "$12", "$13", "$14", "$15", "$16", "$17", "$18", "$19",
-	"$20", "$21", "$22", "$23", "$24", "$25", "$26", "$27", "$28", "$29",
-	"$30", "$31"
-};
-
-const char *get_arch_regstr(unsigned int n)
-{
-	if (n < 32)
-		return mips_gpr_names[n];
-	if (n == 64)
-		return "hi";
-	if (n == 65)
-		return "lo";
-	return NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index efc41d0fbee9..d536964df43c 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,7 +32,7 @@
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
-    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH
+    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -40,7 +40,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 #endif
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
-    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH
+    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 4e591379f367..55f21d8082a2 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -90,7 +90,7 @@
 
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
-    && !defined(__loongarch__)
+    && !defined(__loongarch__) && !defined(__mips__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.277.g8800431eea-goog

