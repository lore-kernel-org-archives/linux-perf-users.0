Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B11AC887
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193899; cv=none; b=sgQaPmO6Kob6BC73Ovnx9SlEO0jASgMobFhE+T+2iqiUUMNiH7MEi7LjLnhxPoKjpaiA78dVA+PSAyuoyED2AGq/6eZSQonxXh38nBhP0VBZP4aN97u6EApBU961KRyHvx7jAl8vwMB8Ct5FVGqP4vvnF3TLqZf+57pWqn33IVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193899; c=relaxed/simple;
	bh=HgtplYdqCMWgkrpqDu/oJfFklGqzSqhPOh3TiNIHB5k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RaCDqR+wJGa25ZrToqDelDN4Ih0TrVc478yxPkMTKKsZR79lTvciDah4v+nHfhhzDbrIOuXng1PGvduHbn6NQLprS5Vbta9LkdvL4ShGHQCYBCe074Pl5f57WFDfGZFE3SQSqoX0c8EqRRy474N1lA57eNjiiXst5Nl99zoGs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SgjhGvDO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgjhGvDO"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d7124938d1so114506727b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193897; x=1727798697; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/HA+7dw3RtBIuFOxFJuWuOogi0B/JaIuk1VQyQU3th8=;
        b=SgjhGvDOklX22aR2kvLbUlT+Vw7dP0F4REKHD39ROACrIor0Z408+lnGd8SDaMUTA9
         jyNyRiHWY60LdMdcxpiyIRWGQjyl2TYMI8RmxkGtTkNr/dzv2pHGnr7L82EX2MNtysGn
         1ZnMpS2gGc2Ibt6B53ESaJs/YU5ni5fo2KEK4HMJ0piSWH1J4nQDts81OcAk7urP5Y4r
         syELpHpl0F6sfWg3UsXkveLJSkVe3DI0pUD+Q0iqdgeXlEuFNNyJHJhsOJ7SNRPQhv1J
         VExJBLXG+uqBTV8hYZ8/TKesTOjvbqyThguSktaVhGNo/RcycHyKapk8mr2i17A1L2bz
         EOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193897; x=1727798697;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HA+7dw3RtBIuFOxFJuWuOogi0B/JaIuk1VQyQU3th8=;
        b=TodYh0IHzrvAKZ3HXHEmq8LMOLkqtnGzGH0Q7NtaNHETqMmmFPCWluSqQEazCwM322
         lIwOkx0XcVHXjGvJpJZ5ngy6Q84Xloveuk2MikVwiiLjOdmTPUf5ne8OtaBb/6/DF543
         9s+jhEp66Ru1WvSaY+tphS6COOI50/QhINmuSD2yenObJUlkqocdQSDJCDK1ox18Cb+8
         y2JgI3+1DRoMsERAlfRhedYspproYGGtF+m9YMfsbbddi0IEsnN6l1nGK1lWkS3vFeDe
         Wcb9jFyboSTiH9NqmiGoGyDmwej/qRvRlFdIGOm9f0I+LYzXjSylRJgk3QnbSf8fKyjg
         1tCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQKMNr5ABOM2dBtnt1TxBBkrTe+M4CjeuUkOZPYFbO7XM+wYyBQefNQi+NjoeIDw4N/8TIGqA6nT3AuLB3RiwX@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDLflHaOwYh4IvbSUFE7DKsuCQJsXV1KWRx3eYA/hZG8Pxf9U
	dwRLlmRz3+gjPJ4kK4M8Desi9DKGugiiRHaYAIPOSEUHUFYGmUvxNtVTAKOTtn+YJ7r4S/jy/mm
	xDqIiDw==
X-Google-Smtp-Source: AGHT+IHgbaLlS5UPYP2QT/IFZVE1+4hZGKpP8RHMFveYH58SJAZjQY2AHyXTkehShjGYLwStnffO/+tF37rX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a05:690c:2004:b0:6a9:3d52:79e9 with SMTP
 id 00721157ae682-6dfeeec1a9fmr2097177b3.4.1727193897074; Tue, 24 Sep 2024
 09:04:57 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:13 -0700
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Message-Id: <20240924160418.1391100-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 06/11] perf build: Combine test-dwarf-getcfi into test-libdw
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

dwarf_getcfi support in libdw is 15 years old. Make libdw imply
dwarf_getcfi support and simplify build logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature            |  1 -
 tools/build/feature/Makefile            |  4 ----
 tools/build/feature/test-dwarf_getcfi.c |  9 ---------
 tools/build/feature/test-libdw.c        | 10 +++++++++-
 tools/perf/Makefile.config              |  8 +-------
 5 files changed, 10 insertions(+), 22 deletions(-)
 delete mode 100644 tools/build/feature/test-dwarf_getcfi.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index cf6a967575ea..ef72aae3dd49 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -31,7 +31,6 @@ endef
 FEATURE_TESTS_BASIC :=                  \
         backtrace                       \
         libdw                           \
-        dwarf_getcfi                    \
         eventfd                         \
         fortify-source                  \
         get_current_dir_name            \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7683d171f744..f94afd522ebb 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -6,7 +6,6 @@ FILES=                                          \
          test-backtrace.bin                     \
          test-bionic.bin                        \
          test-libdw.bin                         \
-         test-dwarf_getcfi.bin                  \
          test-eventfd.bin                       \
          test-fortify-source.bin                \
          test-get_current_dir_name.bin          \
@@ -184,9 +183,6 @@ endif
 $(OUTPUT)test-libdw.bin:
 	$(BUILD) $(DWLIBS)
 
-$(OUTPUT)test-dwarf_getcfi.bin:
-	$(BUILD) $(DWLIBS)
-
 $(OUTPUT)test-libelf-getphdrnum.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/build/feature/test-dwarf_getcfi.c b/tools/build/feature/test-dwarf_getcfi.c
deleted file mode 100644
index 50e7d7cb7bdf..000000000000
--- a/tools/build/feature/test-dwarf_getcfi.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <elfutils/libdw.h>
-
-int main(void)
-{
-	Dwarf *dwarf = NULL;
-	return dwarf_getcfi(dwarf) == NULL;
-}
diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index 83ea5d5f235d..71c6f8e3b0ee 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -34,7 +34,15 @@ int test_libdw_getlocations(void)
 	return (int)dwarf_getlocations(&attr, offset, &base, &start, &end, &op, &nops);
 }
 
+int test_libdw_getcfi(void)
+{
+	Dwarf *dwarf = NULL;
+
+	return dwarf_getcfi(dwarf) == NULL;
+}
+
 int main(void)
 {
-	return test_libdw() + test_libdw_unwind() + test_libdw_getlocations();
+	return test_libdw() + test_libdw_unwind() + test_libdw_getlocations() +
+	       test_libdw_getcfi();
 }
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 903de48c140d..9da0dc001d98 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -161,8 +161,6 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 endif
 FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-dwarf_getcfi := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 
 # for linking with debug library, run like:
 # make DEBUG=1 LIBBABELTRACE_DIR=/opt/libbabeltrace/
@@ -467,11 +465,7 @@ else
       endif
     else
       CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
-      ifneq ($(feature-dwarf_getcfi), 1)
-        $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.142)
-      else
-        CFLAGS += -DHAVE_DWARF_CFI_SUPPORT
-      endif # dwarf_getcfi
+      CFLAGS += -DHAVE_DWARF_CFI_SUPPORT
     endif # Dwarf support
   endif # libelf support
 endif # NO_LIBELF
-- 
2.46.0.792.g87dc391469-goog

