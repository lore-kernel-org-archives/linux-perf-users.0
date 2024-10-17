Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040CF1EA6F
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124060; cv=none; b=Vz/5WfKXHLw2WUSNLDxitJV3KDSyKG+7WBRfIM1y0yPTbRr1V8FdqWLDNM0/p6cU4+inNEMERboyrDXzOalH2Zc5OJ5ZY04GDjTlUagGSC7LjQdrDlMGZxuHZvN8Zk3RpCgun2bGYLBbfSHTEBX5h3ioB3+PL+d8HoCbQvL9huM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124060; c=relaxed/simple;
	bh=c+RNSVrajXZbL2PxHVupjZCGKA40ZynQd8s2vT+EMco=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IcxZFpMI66jYyD/q0twm6Ie8NQtn2xsRiv48FZRUcN+kInFAA8GX8OynCUtlyaAnv+C+xcmCGkE6jQO/5j8oa6W6UOptNjReiOuy6VYjR3wcyrBxSLvUj5a8f5d2Xhyer0PAyBIvCBRwOm7Pqr2UaqKCKRgVwpjhs9lxkVjPXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0hF1Sun9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0hF1Sun9"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31e5d1739so9105887b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124058; x=1729728858; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7WUOc/nN0htnP5Qn5PJQ6QB/5aNVItHGUNec9g68b8=;
        b=0hF1Sun9l3gutvWRri0ZfUF9yuO235VGcvITOCKE9KdGU+cv3XxYp0++etJq8PsnSI
         FcBLJbB86steAHNgaLOMG9QlD/Z/79rRspRln5M9DzjAhThxLR5c6Srix5S4xs3JrZMO
         DE4sHKAGSBKWKZEPeVPdqnjdi600PIHIeTau1ADf0to0442jTLiIIpCVrFtxS2qj+Oz0
         95X6T6pbfdospzRHwLd+uzD54GoQge6rUsLAzXwhyCsDJA0Rhvx0pPwULqBtlbiVJ1aY
         3t3yvCu/fS/19+Aa/Fdz5GUTtEia3B+Afz0ht9FC2CFNx445/+/x0cRBAi1I/wEkzbzf
         MpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124058; x=1729728858;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7WUOc/nN0htnP5Qn5PJQ6QB/5aNVItHGUNec9g68b8=;
        b=lVpswUeP+6J74DIwc372gmN3K4yH4eSYDCILd45XSmuoRLvJFBcDZErmVC1mFhixw8
         47lwFI00HFUBN5fSTygmjN89QxyNLNU4GFt00nLMm2GpzUrZ+jTCuXUeDvSrPu0w+Egb
         5Wvm5+3a9kKfu1idm9+1/LUbVyPlxHyMKS0o0v3mkamZgWLQ0I1zoMj461WU9Gane1YO
         2HkQD8TLwAuTQYmUXAhXa7CnsAufQasa9fbdXswxsN0IJIbotjDRFZSozdjkgE79wEtl
         ydbNukZ9uj1D72NxJW5lJ6DnJ4sw2tuhPU/gbS46XGi+K8NXu17kf1Epz3heIU7L7k6k
         Sc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdGX/dBAgUpFlu/5AOF1dcbVOf6p+cLQvmMdICQ82n0Pg/28saCOjS9detkJ2ClxNS2SOA/qKHypyAm95egka+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1S9pYsAc8GEBusnAp9gWXuq5SGhQWMXtcVjwwR5raEoLKICTn
	eeYGhqYruQZ352EW+KvmgiIJv40usiw0RaJAv5vOIFRFdV36LRT4dF0/EFAa9LSa3KIZxKbCq/D
	Bxq5n1g==
X-Google-Smtp-Source: AGHT+IEsN3civIpKI+BCSs9jbzR3oJOWunf56Opf1iE62vNrYt8ntggM/1ixugg8sijBq6dmPI8iBQCDTStP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f11:b0:6c1:298e:5a7 with SMTP id
 00721157ae682-6e3d41f5921mr1446847b3.5.1729124057807; Wed, 16 Oct 2024
 17:14:17 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:49 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 06/11] perf build: Combine test-dwarf-getlocations into test-libdw
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

dwarf_getlocations support in libdw is more than 10 years old. Make
libdw imply dwarf_getlocations support and simplify build logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                  |  2 --
 tools/build/feature/Makefile                  |  4 ----
 tools/build/feature/test-all.c                |  5 -----
 tools/build/feature/test-dwarf_getlocations.c | 13 -------------
 tools/build/feature/test-libdw.c              | 14 +++++++++++++-
 tools/perf/Makefile.config                    | 10 ++--------
 6 files changed, 15 insertions(+), 33 deletions(-)
 delete mode 100644 tools/build/feature/test-dwarf_getlocations.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index db3695ec5f83..cf6a967575ea 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -31,7 +31,6 @@ endef
 FEATURE_TESTS_BASIC :=                  \
         backtrace                       \
         libdw                           \
-        dwarf_getlocations              \
         dwarf_getcfi                    \
         eventfd                         \
         fortify-source                  \
@@ -120,7 +119,6 @@ endif
 
 FEATURE_DISPLAY ?=              \
          libdw                  \
-         dwarf_getlocations     \
          glibc                  \
          libbfd                 \
          libbfd-buildid		\
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 18f8fef5e843..0af3e0255fed 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -6,7 +6,6 @@ FILES=                                          \
          test-backtrace.bin                     \
          test-bionic.bin                        \
          test-libdw.bin                         \
-         test-dwarf_getlocations.bin            \
          test-dwarf_getcfi.bin                  \
          test-eventfd.bin                       \
          test-fortify-source.bin                \
@@ -188,9 +187,6 @@ endif
 $(OUTPUT)test-libdw.bin:
 	$(BUILD) $(DWLIBS)
 
-$(OUTPUT)test-dwarf_getlocations.bin:
-	$(BUILD) $(DWLIBS)
-
 $(OUTPUT)test-dwarf_getcfi.bin:
 	$(BUILD) $(DWLIBS)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 863c82516433..59ef3d7fe6a4 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -42,10 +42,6 @@
 # include "test-libdw.c"
 #undef main
 
-#define main main_test_dwarf_getlocations
-# include "test-dwarf_getlocations.c"
-#undef main
-
 #define main main_test_eventfd
 # include "test-eventfd.c"
 #undef main
@@ -184,7 +180,6 @@ int main(int argc, char *argv[])
 	main_test_gettid();
 	main_test_glibc();
 	main_test_libdw();
-	main_test_dwarf_getlocations();
 	main_test_eventfd();
 	main_test_libelf_getphdrnum();
 	main_test_libelf_gelf_getnote();
diff --git a/tools/build/feature/test-dwarf_getlocations.c b/tools/build/feature/test-dwarf_getlocations.c
deleted file mode 100644
index 78fb4a1fa68c..000000000000
--- a/tools/build/feature/test-dwarf_getlocations.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdlib.h>
-#include <elfutils/libdw.h>
-
-int main(void)
-{
-	Dwarf_Addr base, start, end;
-	Dwarf_Attribute attr;
-	Dwarf_Op *op;
-        size_t nops;
-	ptrdiff_t offset = 0;
-        return (int)dwarf_getlocations(&attr, offset, &base, &start, &end, &op, &nops);
-}
diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index 793f4ac49514..83ea5d5f235d 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
 #include <dwarf.h>
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
@@ -22,7 +23,18 @@ int test_libdw_unwind(void)
 	return 0;
 }
 
+int test_libdw_getlocations(void)
+{
+	Dwarf_Addr base, start, end;
+	Dwarf_Attribute attr;
+	Dwarf_Op *op;
+	size_t nops;
+	ptrdiff_t offset = 0;
+
+	return (int)dwarf_getlocations(&attr, offset, &base, &start, &end, &op, &nops);
+}
+
 int main(void)
 {
-	return test_libdw() + test_libdw_unwind();
+	return test_libdw() + test_libdw_unwind() + test_libdw_getlocations();
 }
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fa59ecce4470..fefa779041a0 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -164,8 +164,6 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 endif
 FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-dwarf_getlocations := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-dwarf_getcfi := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 
@@ -467,15 +465,11 @@ else
   else
     ifneq ($(feature-libdw), 1)
       ifndef NO_LIBDW
-        $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
+        $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.157, disables dwarf support. Please install new elfutils-devel/libdw-dev)
         NO_LIBDW := 1
       endif
     else
-      ifneq ($(feature-dwarf_getlocations), 1)
-        $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157)
-      else
-        CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
-      endif # dwarf_getlocations
+      CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
       ifneq ($(feature-dwarf_getcfi), 1)
         $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.142)
       else
-- 
2.47.0.105.g07ac214952-goog

