Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E3208B8
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124737; cv=none; b=okvQnWj6NMhGJ2pUVS3Mrn3IjUOsmKbb7fKvYbWaPTbFtQKhb19OCAKl4QUm+oPeeudcLEBz7j3FJKlEPD2tznwau8FeNSdV4f6tzlzDkFLnt+7492yog0NOHff13cPAKCaGkk7DAi1gxnckwkhK4uN++VhMYOhkF/wkoXLk4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124737; c=relaxed/simple;
	bh=QXxA9SYK3EN2y48SSr+iBdwYuUIiiVJnjpzRH9g/bXU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oAwzz0X/3UQLORoXR44rvgWDLylUuNOZQ8OVHLGGUv/KbxIdZAiN4oNWJJ2glCCUrgOs5olX5uNQLydSf9weEZkyZGopOcPjXTUvNihGHC5hb2WP3FdRZ3aKJ1MCjJVHy4jHr/07oaIpi+l1cxIjPP10rzAYOXd1Bmzw25SDv2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qU9zDy/A; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qU9zDy/A"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d660a1afso9870417b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124735; x=1729729535; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPuJy23SWmMfM/R7Lv+B/JUCmZ6weqPIHtsQlmnrHas=;
        b=qU9zDy/A3enYLcIaMadrTZIeoWItMw6xDYhEW8FHH8E0RzZ3S0bkIUft5aX9YNDt5T
         uAZRW7yh0jnpySvvZNv178IdgqUzkksNEp1PNj84SDiPtffwHkJn8t81PPNlX4zY2Hmv
         cMbv0LE0zLGHIpnRiMriNZ01bktaqSu+5Tzj9e8TQUhz+Fy/mHebGq8Ipf/eUwD+JuVx
         svEc1Udc8vZ2pPhOWvcPYFE21fUreUYLOB8MYjU4Qa+z7BwQE1h9JDOqu6si+3ByvF8l
         WDK7rD/uJwXPXuUHm/Y29OEaNO29rFJsCeiUKvGTI6UJqDnzN77ilFJuz5PHgMVCHj+S
         7+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124735; x=1729729535;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPuJy23SWmMfM/R7Lv+B/JUCmZ6weqPIHtsQlmnrHas=;
        b=p/3iqXAVeGbEXVbLrq+/8yPhMaftsC82fUTDh+3F9vxV8O232mT7OeM0yjUVVGJhbX
         O13ckZsxHBDxn2ksRt3B0aN+cYizeeed+9CMREKDPczd2hyKxqivO8KUmw73XIQMSVbq
         Eqk5+vzl6ymzKv1QfOspLbIglZlX1Xh/By7o3i9N0eO/nsERsnMgoQR50yzY/XBacPnU
         oSGie0DnrpxjXa+UuznTqVgwlIUOZe3W0UnJznRq34kY/xLv782v4Nxa+Zy4eHScWx9s
         fquJbamzwdbqCYbPc8Y2aqiq9eDBDPpEFnJq0UwBg9f8V2XQscWrd+a38jIBhh6RRrjU
         YSnA==
X-Forwarded-Encrypted: i=1; AJvYcCWlMPm3jgvqsjMxKLIjw3J/GbZXqsRNk5Fq/r9wAoP99ZS5iuot7s4WGdU35thjW40FmRez9tAvfer54nSOehW4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38LpoaTKV5YGTHVZPb13JvmJYcF/vHbLROWk3dy1LIQ7gWAH/
	9ruqI7A0r0HmnsAgvWEY6Gr3sh8Qm4uOO6gh3bUvkuNd6m7PmEOaKcRpn6rEDdPkWKjiOjjL6Ui
	3/cDNoQ==
X-Google-Smtp-Source: AGHT+IGVbm7ifaHt/Fl/drq6Q4bQa5ufX0E3xNqrZof9j3qtFmTHHwBTTD4/diJBn39+kY+JKl2TpaixKpZq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:aa09:0:b0:e29:74e3:616c with SMTP id
 3f1490d57ef6-e29782e9e9cmr2959276.3.1729124735151; Wed, 16 Oct 2024 17:25:35
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:03 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 03/20] perf dwarf-regs: Add EM_HOST and EF_HOST defines
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

Computed from the build architecture defines, EM_HOST and EF_HOST give
values that can be used in dwarf register lookup. Place in
dwarf-regs.h so the value can be shared. Move some dwarf-regs.c
constants used for EM_HOST to dwarf-regs.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-regs.c         |  8 ----
 tools/perf/util/include/dwarf-regs.h | 72 ++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 5b7f86c0063f..7c01bc4d7e5b 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -13,14 +13,6 @@
 #include <errno.h>
 #include <linux/kernel.h>
 
-#ifndef EM_AARCH64
-#define EM_AARCH64	183  /* ARM 64 bit */
-#endif
-
-#ifndef EM_LOONGARCH
-#define EM_LOONGARCH	258 /* LoongArch */
-#endif
-
 /* Define const char * {arch}_register_tbl[] */
 #define DEFINE_DWARF_REGSTR_TABLE
 #include "../arch/x86/include/dwarf-regs-table.h"
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index fbdd7307e0c2..f4f87ded5e3d 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -2,6 +2,78 @@
 #ifndef _PERF_DWARF_REGS_H_
 #define _PERF_DWARF_REGS_H_
 #include "annotate.h"
+#include <elf.h>
+
+#ifndef EM_AARCH64
+#define EM_AARCH64	183  /* ARM 64 bit */
+#endif
+
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH	258 /* LoongArch */
+#endif
+
+/* EM_HOST gives the ELF machine for host, EF_HOST gives additional flags. */
+#if defined(__x86_64__)
+  #define EM_HOST EM_X86_64
+#elif defined(__i386__)
+  #define EM_HOST EM_386
+#elif defined(__aarch64__)
+  #define EM_HOST EM_AARCH64
+#elif defined(__arm__)
+  #define EM_HOST EM_ARM
+#elif defined(__alpha__)
+  #define EM_HOST EM_ALPHA
+#elif defined(__arc__)
+  #define EM_HOST EM_ARC
+#elif defined(__AVR__)
+  #define EM_HOST EM_AVR
+#elif defined(__AVR32__)
+  #define EM_HOST EM_AVR32
+#elif defined(__bfin__)
+  #define EM_HOST EM_BLACKFIN
+#elif defined(__csky__)
+  #define EM_HOST EM_CSKY
+  #if defined(__CSKYABIV2__)
+    #define EF_HOST EF_CSKY_ABIV2
+  #else
+    #define EF_HOST EF_CSKY_ABIV1
+  #endif
+#elif defined(__cris__)
+  #define EM_HOST EM_CRIS
+#elif defined(__hppa__) // HP PA-RISC
+  #define EM_HOST EM_PARISC
+#elif defined(__loongarch__)
+  #define EM_HOST EM_LOONGARCH
+#elif defined(__mips__)
+  #define EM_HOST EM_MIPS
+#elif defined(__m32r__)
+  #define EM_HOST EM_M32R
+#elif defined(__microblaze__)
+  #define EM_HOST EM_MICROBLAZE
+#elif defined(__MSP430__)
+  #define EM_HOST EM_MSP430
+#elif defined(__powerpc64__)
+  #define EM_HOST EM_PPC64
+#elif defined(__powerpc__)
+  #define EM_HOST EM_PPC
+#elif defined(__riscv)
+  #define EM_HOST EM_RISCV
+#elif defined(__s390x__)
+  #define EM_HOST EM_S390
+#elif defined(__sh__)
+  #define EM_HOST EM_SH
+#elif defined(__sparc64__) || defined(__sparc__)
+  #define EM_HOST EM_SPARC
+#elif defined(__xtensa__)
+  #define EM_HOST EM_XTENSA
+#else
+  /* Unknown host ELF machine type. */
+  #define EM_HOST EM_NONE
+#endif
+
+#if !defined(EF_HOST)
+  #define EF_HOST 0
+#endif
 
 #define DWARF_REG_PC  0xd3af9c /* random number */
 #define DWARF_REG_FB  0xd3affb /* random number */
-- 
2.47.0.105.g07ac214952-goog

