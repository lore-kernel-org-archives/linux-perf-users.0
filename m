Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675281C69D
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124754; cv=none; b=dfUdLKsgUERJkkM+ySprXdbkZa8QNQgpHsI8wkEzs+9H/MduPkzqaZ2/9JH+DLDmtFENJOeyEMrZIIEhEZFY4L/jhvIYeGMrWWKZAtQELYln4wYId8HmJjkFRUziKwN0NIammWx//DwFy15ifcv8CPyc8dL/UnPLpL308Cw92A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124754; c=relaxed/simple;
	bh=o0PTiK+y2h1Uws8X+L8gDKhz8hsLaB6wtA4lBZEY35A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=d5ksXiRH4e+taRVEFTvTEFKjxL7N0CJDAa5f8FWcrA0gEQYM+ptoXdp5rgsP5N9Zw8X5Bzz4F/HbC4ihCf5S5PAdnuyV/PN6nTqKPEPbq4hjt4AbVOxle1mdfCQBnQa0BdC2BGRK4kcWUyZtVJirQQci4Anzf2N9Gn0a6C4ruTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEjkKY1p; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEjkKY1p"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2946a143efso584662276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124752; x=1729729552; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WG2Q2FB5LUQz01Yds7IeFcawWLtm3SGWZPYeFSNMQiM=;
        b=WEjkKY1p1uQlJfkOR6IE2d27rPTmTgeAV3zp7NP8VjjIeZV2ZfrUPMTYrtxWwQFqns
         IUn8A7Ah/WLGh1iJfQKrw1e+u4PRlCKNTD2eFXj3nG7u3VZ6J+PpmTLcUW9Q+zc8zfai
         CVT069pyHHVD2rotVyJnIXNCEfz/myxiHPkLLJ141y9eKsPdE7mMbkvZ7dzI1/YodNf3
         Z5XeNm5HPRvZvXQMuIDKFT7NjCzYgJ9pSzPL75ySV5EB7qDe1uU2JNQVSBLoifsNT1EE
         fWxZjEPect2atJoptYOxSzHvRYk/h0gYrA+OVljb1eSSP0vCU+wiceVxRPBnNIDmf2c/
         5UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124752; x=1729729552;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WG2Q2FB5LUQz01Yds7IeFcawWLtm3SGWZPYeFSNMQiM=;
        b=wJYdBrih9vJFuUZTFH29PW4SHgMFN07eviNLlTEfJItia8I2k6VqNfIhhuC0s9P2vN
         HqZvwXkNmj6RWld6P95Ehc6Xqu2HnqEVmYKLpKssCEdJlnnIgtXk2fSKCfc20a7cG0UC
         VzbQK9+m3PqcKEQ1RhAb/bFPX14h9uRrRSIpN9B6uBY12tqyfIB05OOiHjTd3F2q5mw+
         pbOiBBC96BWAISzPxOaxKAMHCdVr51Z87I4iX/6zjlv0JTgO3+xtjYRTTFXgN+ARbXCY
         qWIyMS6lJ5XHBfFS1TJaBo7YpRAYamwOTnrwhQ5GHLJh4Kz0bw9KAzCbPfVK7WT/niXw
         quBw==
X-Forwarded-Encrypted: i=1; AJvYcCXByOTlHeWb9c3MJf5prRsWm44/S5M06Nr98NljUS+ZcNhqOk7VPcSfb9eFJrqNj9/kHVHISsPnyC6jIpS9WcUo@vger.kernel.org
X-Gm-Message-State: AOJu0YxIILb0IjCj8L23gssXrBPO40Xe+u1OtzN2fj+AndqmYuaRceYl
	PbgDmU7qbFVPERzWYPCtEe6cy6ElRNlYD61/lLsGcto8vhG8aKhlgIy8XmxW7WpSORrCiwWh4sw
	AGRZBpQ==
X-Google-Smtp-Source: AGHT+IG59YkLvXbjXDygQC7BU6le1sFVoo2SJFZVP20/F7DRXE23oZyCK22C1Wgez9VaPqSPFNUmUo+ETWGD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:bd91:0:b0:e0b:f6aa:8088 with SMTP id
 3f1490d57ef6-e2b9cdec686mr2964276.1.1729124752310; Wed, 16 Oct 2024 17:25:52
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:10 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 10/20] perf dwarf-regs: Move csky dwarf-regs out of arch
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

Move arch/csky/util/dwarf-regs.c to util/dwarf-regs-csky.c and compile
in unconditionally. To avoid get_arch_regstr being duplicated, rename
to get_csky_regstr and add to get_dwarf_regstr switch.

Update #ifdefs to allow ABI V1 and V2 tables at the same
time. Determine the table from the ELF flags.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/csky/util/Build               |  1 -
 tools/perf/util/Build                         |  1 +
 .../dwarf-regs.c => util/dwarf-regs-csky.c}   | 19 ++++++++++---------
 tools/perf/util/dwarf-regs.c                  | 11 +++++++----
 tools/perf/util/include/dwarf-regs.h          |  2 ++
 5 files changed, 20 insertions(+), 14 deletions(-)
 rename tools/perf/{arch/csky/util/dwarf-regs.c => util/dwarf-regs-csky.c} (74%)

diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
index 1325310cab6a..5e6ea82c4202 100644
--- a/tools/perf/arch/csky/util/Build
+++ b/tools/perf/arch/csky/util/Build
@@ -1,4 +1,3 @@
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4c615611b9d7..99ae4e2802b8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -203,6 +203,7 @@ endif
 perf-util-$(CONFIG_LIBDW) += probe-finder.o
 perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
diff --git a/tools/perf/arch/csky/util/dwarf-regs.c b/tools/perf/util/dwarf-regs-csky.c
similarity index 74%
rename from tools/perf/arch/csky/util/dwarf-regs.c
rename to tools/perf/util/dwarf-regs-csky.c
index ca86ecaeacbb..d38ef1f07f3e 100644
--- a/tools/perf/arch/csky/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs-csky.c
@@ -5,9 +5,8 @@
 #include <stddef.h>
 #include <dwarf-regs.h>
 
-#if defined(__CSKYABIV2__)
-#define CSKY_MAX_REGS 73
-const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
+#define CSKY_ABIV2_MAX_REGS 73
+const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] = {
 	/* r0 ~ r8 */
 	"%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1", "%regs2", "%regs3",
 	/* r9 ~ r15 */
@@ -26,9 +25,9 @@ const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
 	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 	"%epc",
 };
-#else
-#define CSKY_MAX_REGS 57
-const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
+
+#define CSKY_ABIV1_MAX_REGS 57
+const char *csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] = {
 	/* r0 ~ r8 */
 	"%sp", "%regs9", "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1",
 	/* r9 ~ r15 */
@@ -41,9 +40,11 @@ const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
 	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 	"%epc",
 };
-#endif
 
-const char *get_arch_regstr(unsigned int n)
+const char *get_csky_regstr(unsigned int n, unsigned int flags)
 {
-	return (n < CSKY_MAX_REGS) ? csky_dwarf_regs_table[n] : NULL;
+	if (flags & EF_CSKY_ABIV2)
+		return (n < CSKY_ABIV2_MAX_REGS) ? csky_dwarf_regs_table_abiv2[n] : NULL;
+
+	return (n < CSKY_ABIV1_MAX_REGS) ? csky_dwarf_regs_table_abiv1[n] : NULL;
 }
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index fd21f9e90e40..9a76f83af62c 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -29,17 +29,18 @@
 #define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n)] : NULL)
 
 /* Return architecture dependent register string (for kprobe-tracer) */
-const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
-			     unsigned int flags __maybe_unused)
+const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
-#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM
+#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
+    || EM_HOST == EM_CSKY
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
 	}
 #endif
 	switch (machine) {
-#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM
+#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
+    && EM_HOST != EM_CSKY
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
@@ -51,6 +52,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
 		return __get_dwarf_regstr(arm_regstr_tbl, n);
 	case EM_AARCH64:
 		return __get_dwarf_regstr(aarch64_regstr_tbl, n);
+	case EM_CSKY:
+		return get_csky_regstr(n, flags);
 	case EM_SH:
 		return __get_dwarf_regstr(sh_regstr_tbl, n);
 	case EM_S390:
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 0b533409d82a..b72d9d308ce4 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -83,6 +83,8 @@
 const char *get_arch_regstr(unsigned int n);
 #endif
 
+const char *get_csky_regstr(unsigned int n, unsigned int flags);
+
 /**
  * get_dwarf_regstr() - Returns ftrace register string from DWARF regnum.
  * @n: DWARF register number.
-- 
2.47.0.105.g07ac214952-goog

