Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A4184D
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124055; cv=none; b=Y/tdNoPrp45DDl277KZzgfSFvj/2jXwc3PZhGKA8K7DoCFp6mgs3kxDpWVhsMglQwNHnzbGMpiBarqvDc/8YOWGCAcG7GPn/7Jz6FQZQP7K93wVm1JPmVLPAQIjveJhbJv1/BNMvSaics8IR3dw+ZLXTsvMTkOjtI+R8ywhBr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124055; c=relaxed/simple;
	bh=O0SufrLYyv6P+q8PwNmwPDGHg2Zc8tfEsXP2c513YrI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=s0jKq7d9cVH9bLLsYyV7l/pQGQI9QWiQDJOCdkAOgTfO+GoqzJhqZvUaBKQdaA5tyY6YDZ/EzLNFFfPUcuqtFwGSJZY6qwTuQPO7oXReDh6Yr6cx9Q0X/loCaSKFier5nDfIQy5e1fq7cJ07HmNvXUzZh6G76cQHOxj0ZYTvcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N92MC3Pm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N92MC3Pm"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so744561276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124053; x=1729728853; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gv4rC21EH5vKyMLFGXp6RuMwHEpZG+2xqNlyQiSYUJM=;
        b=N92MC3Pmm1V9C3LHf0IP0V32oyX8yX+V62NsFCfbhGx/y/MCk+edPaUF3VdeY+kror
         uN+GrldLsOrbLzOiJGhHl6UX4iVLDU/WjgqgIin1wUO0q5CW78PRzNLwtDUlS1rj2Vkf
         BvO7v2kO1rP3blPUpZ7cF2j0UOZ5AvX2OHxb0kxkCTHG3CRhQBZKznxgiqy31bvPLCHe
         T3WDyNfoqpRSPBBBnM366UxVJhDN8TJeUKxF6QqfoaoHbvIWMkEqcDYdZ2dDKc3bHGU6
         R1JP9RrW44/27pQI/sIJkCUegskC6xhFZp1LfS3XDhw5fAODT2djtS8muTJLqeUmm9rp
         AFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124053; x=1729728853;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gv4rC21EH5vKyMLFGXp6RuMwHEpZG+2xqNlyQiSYUJM=;
        b=YoBEuB0ht68Wzz+xbPqK0+TFA5tUFQpJnd14MWU0kLZxc3E81EbAC0+5oc9Hc0+td0
         Bje0Svf+vEwu3SMnRao2ZsDyZk9WbW8Z3nG/FFxCSiIQhk2d0ZRY6MeleQI2r39gHOd5
         g8rXQ4MOVI+dnBD8+tn0gCp7Z3xfvKsTPryMSKmUFl9NEBVjfESbSAmP2JQX2bDLGyRR
         BrB7R4Hqk4PM4ttPvCWpNJs9VzEsVFJ48tfygK95D2qkQWnGB+OJDQ8N8H+SltiEivKq
         QTu5VXdnDSExv/kO8W99ViNNF1mL8ET+Irz74jsiAknMYWWnd/er6S2Z+KYLWAmaLvyr
         1BeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/UDGwI97P2NY22H4V1O+AnKk+t6adXtA3joRnZ0DTe602mHYExT+J39og3ZK7KFDgWL4MN+GTTnX1EE9U6GaU@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLmiLMeuvXjmhVlBXmljUr8z0s7oghBX9SkR1rB6MiTdfRSIn
	vlBLkHzoj6i6Qg/IJOkbKliHPOjkmAcOqnNcUkr6PhjD9SV82G2uj5Z4PvI5sLc+YRjc/ahkOaS
	BUepL3Q==
X-Google-Smtp-Source: AGHT+IGzsdwJDBoPyKd/XtgGR0BEXokuFHhXrbu1xDLmXdK+oi96DfZVdRcJHcGkPuy4Owl251BGxQBLx/5T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:ad64:0:b0:e16:68fb:f261 with SMTP id
 3f1490d57ef6-e297830baadmr2824276.5.1729124052807; Wed, 16 Oct 2024 17:14:12
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:47 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 04/11] perf build: Rename test-dwarf to test-libdw
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

Be more intention revealing that the dwarf test is actually testing
for libdw support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                     |  6 +++---
 tools/build/feature/Makefile                     | 16 ++++++++--------
 tools/build/feature/test-all.c                   |  6 +++---
 .../build/feature/{test-dwarf.c => test-libdw.c} |  0
 tools/perf/Makefile.config                       |  6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)
 rename tools/build/feature/{test-dwarf.c => test-libdw.c} (100%)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ffd117135094..6025810cc346 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -30,7 +30,7 @@ endef
 #
 FEATURE_TESTS_BASIC :=                  \
         backtrace                       \
-        dwarf                           \
+        libdw                           \
         dwarf_getlocations              \
         dwarf_getcfi                    \
         eventfd                         \
@@ -120,7 +120,7 @@ ifeq ($(FEATURE_TESTS),all)
 endif
 
 FEATURE_DISPLAY ?=              \
-         dwarf                  \
+         libdw                  \
          dwarf_getlocations     \
          glibc                  \
          libbfd                 \
@@ -233,7 +233,7 @@ endef
 
 #
 # generates feature value assignment for name, like:
-#   $(call feature_assign,dwarf) == feature-dwarf=1
+#   $(call feature_assign,libdw) == feature-libdw=1
 #
 feature_assign = feature-$(1)=$(feature-$(1))
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1658596188bf..7a1c028ce40b 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -5,7 +5,7 @@ FILES=                                          \
          test-all.bin                           \
          test-backtrace.bin                     \
          test-bionic.bin                        \
-         test-dwarf.bin                         \
+         test-libdw.bin                         \
          test-dwarf_getlocations.bin            \
          test-dwarf_getcfi.bin                  \
          test-eventfd.bin                       \
@@ -168,9 +168,9 @@ $(OUTPUT)test-libopencsd.bin:
 	$(BUILD) # -lopencsd_c_api -lopencsd provided by
 		 # $(FEATURE_CHECK_LDFLAGS-libopencsd)
 
-DWARFLIBS := -ldw
+DWLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
+  DWLIBS += -lelf -lz -llzma -lbz2 -lzstd
 
   LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
@@ -179,21 +179,21 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   # Elfutils merged libebl.a into libdw.a starting from version 0.177,
   # Link libebl.a only if libdw is older than this version.
   ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
-    DWARFLIBS += -lebl
+    DWLIBS += -lebl
   endif
 
   # Must put -ldl after -lebl for dependency
   DWARFLIBS += -ldl
 endif
 
-$(OUTPUT)test-dwarf.bin:
-	$(BUILD) $(DWARFLIBS)
+$(OUTPUT)test-libdw.bin:
+	$(BUILD) $(DWLIBS)
 
 $(OUTPUT)test-dwarf_getlocations.bin:
-	$(BUILD) $(DWARFLIBS)
+	$(BUILD) $(DWLIBS)
 
 $(OUTPUT)test-dwarf_getcfi.bin:
-	$(BUILD) $(DWARFLIBS)
+	$(BUILD) $(DWLIBS)
 
 $(OUTPUT)test-libelf-getphdrnum.bin:
 	$(BUILD) -lelf
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 6f4bf386a3b5..d60e072b6eca 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -38,8 +38,8 @@
 # include "test-glibc.c"
 #undef main
 
-#define main main_test_dwarf
-# include "test-dwarf.c"
+#define main main_test_libdw
+# include "test-libdw.c"
 #undef main
 
 #define main main_test_dwarf_getlocations
@@ -187,7 +187,7 @@ int main(int argc, char *argv[])
 	main_test_get_current_dir_name();
 	main_test_gettid();
 	main_test_glibc();
-	main_test_dwarf();
+	main_test_libdw();
 	main_test_dwarf_getlocations();
 	main_test_eventfd();
 	main_test_libelf_getphdrnum();
diff --git a/tools/build/feature/test-dwarf.c b/tools/build/feature/test-libdw.c
similarity index 100%
rename from tools/build/feature/test-dwarf.c
rename to tools/build/feature/test-libdw.c
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index dd5468b8b5de..f1e24c4ae123 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -162,8 +162,8 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   # Must put -ldl after -lebl for dependency
   DWARFLIBS += -ldl
 endif
-FEATURE_CHECK_CFLAGS-dwarf := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-dwarf := $(LIBDW_LDFLAGS) $(DWARFLIBS)
+FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
@@ -473,7 +473,7 @@ else
         $(warning No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR)
       endif
     endif
-    ifneq ($(feature-dwarf), 1)
+    ifneq ($(feature-libdw), 1)
       ifndef NO_LIBDW
         $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
         NO_LIBDW := 1
-- 
2.47.0.105.g07ac214952-goog

