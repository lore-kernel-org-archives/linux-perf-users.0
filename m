Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E513B6BF3
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715131; cv=none; b=J/Tw1I5DVFQUHBpIunhyGUqSyoEyWnuYP46Sc+xSf5K6pdbiI0Oo0KrmiPiKtmx9HAWJkFn5cUo8+G+vjDP1aKKSTga23hXHlA4xzHxfqB7HEXujoMmC2YJABGGSHOCedaaofGMILZ3dAp9wfiIBil1ieWMMn+Pej7x81XxidPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715131; c=relaxed/simple;
	bh=TLIcSkN4FvgTKq1zxwbkB1K415X56uDctU36yU/+SIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N/BAEw/avQiL/qux49BtKG1DiJL2kQSmDh0bHOk9sB28qBdu9ck5hbri8EHtCPBbZUBAvSoTBNgG6w7fXth+u2pstwKIeXBFwZ0SikR0tsNo4i0BbY2XiEJ5FbLfllHbepMt2rrDcbPtxRG3NaWzW3n3bwnknDe703nOtVAxkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEXERDJi; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEXERDJi"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1329791f18fso11005759c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778715128; x=1779319928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GF6+meBarktmg9PT7lIng2imybEQb4SO5LqEh3kzy3Y=;
        b=gEXERDJicMCoLljvSnfK1IWob0NjqwfC9jQgkGhJCcBTg+/nJhgDtuMws4uXOyCXas
         rKa7MABGko+Sy9rihmsNwDSF0h+uBtj4lBPA9QO7JUhzNj6MYIAPgrC4/91CY/kOS4rG
         TSc8mC8d2ebkoPO8xZk4ZPKjB7w6aqM0tDL1jvgTDbh/MN1vhRdW/aQUSu48PP1bSh8z
         rY9SRdrRww1wP8DpESJH9YRaPH0GdIQJKB1eEob40gsJtnqRoXHa9Xdk5voG82kjqeGS
         9g4onjUVdxILiyHXIrt9Z55/Skv0M5uWi4KXRm4hkNY4svrS97H9lic1JOevdNY5Ny+N
         qkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715128; x=1779319928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GF6+meBarktmg9PT7lIng2imybEQb4SO5LqEh3kzy3Y=;
        b=LbpgXw+I0P98duUejo8IjcECGrWqRsif/6pvYZDEobUonfqH0laRVkl6+Xcr3w+OJF
         BNAZrC6rERzcxOj1+7hnOr4z1SNkgWU/W9ayZL3DaJdW0iI2Y4e8EPtdT8gpAL3OdFvx
         77KSYgUbj4BWiYyGwJ/nMiuECSzGtEtjVeO8MLUtXvUBXFYOG5hAW4PC00ZghUqI+Gr5
         Gs62BQZnGQk8+k2i+zVy6fVB3leltI6qL1GIahlZlaaUEEfVNBdkFsc642uZ4SmVo5XZ
         C0c3aT8NXXefkg1qHtLBmTyiY0vNvfD7cG6BOcE0oV/yhwJgdvX6B9IUTvss/WsbJGBx
         flAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5V5eBHblmlNqwz4J84enTMxfC0Z7ywuyafFTTl8BHdDeFwqtDSRZIdkrrvAwbkpQCbgdaM7JnCvPmVvWgj0jM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ynCCKnhQOZmsxNBDb79hUiwuGXHYiixVSzipb6jJ8on8MV32
	VjFUEWjTZIICPHjZzMQYAr28f27PnoID/8L0TsUKA7vXsh1cdJ6RZJPNCt8IXCqFS2P1NodGoqr
	s18ZRVTdcPA==
X-Received: from dlbvv13.prod.google.com ([2002:a05:7022:5f0d:b0:128:cfd6:a3c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b0a:b0:12d:f0b1:75de
 with SMTP id a92af1059eb24-1349ac70cd0mr2732683c88.22.1778715127777; Wed, 13
 May 2026 16:32:07 -0700 (PDT)
Date: Wed, 13 May 2026 16:31:46 -0700
In-Reply-To: <20260513233151.572332-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413024805.1316480-1-irogers@google.com> <20260513233151.572332-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513233151.572332-3-irogers@google.com>
Subject: [PATCH v5 2/7] tools build: Deduplicate test-libunwind for different architectures
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, namhyung@kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Cc: 9erthalion6@gmail.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	howardchu95@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org, 
	leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com, 
	will@kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The separate test files only exist to pass a different #include,
instead have a single source file and pass -include to $(CC) to
include the relevant header file for the architecture being
tested. Generate the rules using a foreach loop. Include tests for all
current libunwind architectures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                  | 12 ++++-
 tools/build/feature/Makefile                  | 46 +++++++++----------
 tools/build/feature/test-libunwind-aarch64.c  | 27 -----------
 tools/build/feature/test-libunwind-arm.c      | 28 -----------
 .../test-libunwind-debug-frame-aarch64.c      | 17 -------
 .../feature/test-libunwind-debug-frame-arm.c  | 17 -------
 .../feature/test-libunwind-debug-frame.c      |  1 -
 tools/build/feature/test-libunwind-x86.c      | 28 -----------
 tools/build/feature/test-libunwind-x86_64.c   | 28 -----------
 tools/build/feature/test-libunwind.c          |  1 -
 10 files changed, 32 insertions(+), 173 deletions(-)
 delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-x86.c
 delete mode 100644 tools/build/feature/test-libunwind-x86_64.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 2f192d3bf61b..af79c6cf0229 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -104,6 +104,9 @@ FEATURE_TESTS_BASIC :=                  \
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
+
+LIBUNWIND_ARCHS:=aarch64 arm loongarch64 mips ppc32 ppc64 riscv s390x x86 x86_64
+
 FEATURE_TESTS_EXTRA :=                  \
          bionic                         \
          compile-32                     \
@@ -127,7 +130,10 @@ FEATURE_TESTS_EXTRA :=                  \
          libpfm4                        \
          libdebuginfod			\
          clang-bpf-co-re		\
-         bpftool-skeletons
+         bpftool-skeletons		\
+         libunwind			\
+         libunwind-debug-frame		\
+         $(foreach arch,$(LIBUNWIND_ARCHS),libunwind-$(arch) libunwind-debug-frame-$(arch))
 
 
 FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
@@ -212,6 +218,10 @@ ifeq ($(feature-all), 1)
   $(call feature_check,compile-x32)
   $(call feature_check,bionic)
   $(call feature_check,libbabeltrace)
+  $(call feature_check,libunwind)
+  $(call feature_check,libunwind-debug-frame)
+  $(foreach arch,$(LIBUNWIND_ARCHS),$(call feature_check,libunwind-$(arch)))
+  $(foreach arch,$(LIBUNWIND_ARCHS),$(call feature_check,libunwind-debug-frame-$(arch)))
 else
   $(foreach feat,$(FEATURE_TESTS),$(call feature_check,$(feat)))
 endif
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 704c687ed3ad..4e4a92ef5e1e 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../../scripts/Makefile.include
 
+LIBUNWIND_ARCHS:=aarch64 arm loongarch64 mips ppc32 ppc64 riscv s390x x86 x86_64
+
 FILES=                                          \
          test-all.bin                           \
          test-backtrace.bin                     \
@@ -38,12 +40,7 @@ FILES=                                          \
          test-libtracefs.bin                    \
          test-libunwind.bin                     \
          test-libunwind-debug-frame.bin         \
-         test-libunwind-x86.bin                 \
-         test-libunwind-x86_64.bin              \
-         test-libunwind-arm.bin                 \
-         test-libunwind-aarch64.bin             \
-         test-libunwind-debug-frame-arm.bin     \
-         test-libunwind-debug-frame-aarch64.bin \
+         $(foreach arch,$(LIBUNWIND_ARCHS),test-libunwind-$(arch).bin test-libunwind-debug-frame-$(arch).bin) \
          test-pthread-attr-setaffinity-np.bin   \
          test-pthread-barrier.bin		\
          test-stackprotector-all.bin            \
@@ -211,27 +208,26 @@ $(OUTPUT)test-numa_num_possible_cpus.bin:
 	$(BUILD) -lnuma
 
 $(OUTPUT)test-libunwind.bin:
-	$(BUILD) -lelf -llzma
+	$(BUILD) -include libunwind.h -lelf -llzma -lunwind
 
 $(OUTPUT)test-libunwind-debug-frame.bin:
-	$(BUILD) -lelf -llzma
-$(OUTPUT)test-libunwind-x86.bin:
-	$(BUILD) -lelf -llzma -lunwind-x86
-
-$(OUTPUT)test-libunwind-x86_64.bin:
-	$(BUILD) -lelf -llzma -lunwind-x86_64
-
-$(OUTPUT)test-libunwind-arm.bin:
-	$(BUILD) -lelf -llzma -lunwind-arm
-
-$(OUTPUT)test-libunwind-aarch64.bin:
-	$(BUILD) -lelf -llzma -lunwind-aarch64
-
-$(OUTPUT)test-libunwind-debug-frame-arm.bin:
-	$(BUILD) -lelf -llzma -lunwind-arm
-
-$(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
-	$(BUILD) -lelf -llzma -lunwind-aarch64
+	$(BUILD) -include libunwind.h -lelf -llzma -lunwind
+
+define LIBUNWIND_RULE
+$$(OUTPUT)test-libunwind-$(1).bin:
+	$$(CC) $$(CFLAGS) -MD -Wall -Werror -include libunwind-$(1).h -o $$@ \
+		test-libunwind.c $$(LDFLAGS) -lelf -llzma -lunwind-$(1) \
+		> $$(@:.bin=.make.output) 2>&1
+
+$$(OUTPUT)test-libunwind-debug-frame-$(1).bin:
+	$$(CC) $$(CFLAGS) -MD -Wall -Werror -include libunwind-$(1).h -o $$@ \
+		test-libunwind-debug-frame.c $$(LDFLAGS) -lelf -llzma -lunwind-$(1) \
+		> $$(@:.bin=.make.output) 2>&1
+
+endef
+$(foreach arch,$(LIBUNWIND_ARCHS), \
+    $(eval $(call LIBUNWIND_RULE,$(arch))) \
+)
 
 $(OUTPUT)test-libslang.bin:
 	$(BUILD) -lslang
diff --git a/tools/build/feature/test-libunwind-aarch64.c b/tools/build/feature/test-libunwind-aarch64.c
deleted file mode 100644
index 323803f49212..000000000000
--- a/tools/build/feature/test-libunwind-aarch64.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-aarch64.h>
-#include <stdlib.h>
-
-extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-					       unw_word_t ip,
-					       unw_dyn_info_t *di,
-					       unw_proc_info_t *pi,
-					       int need_unwind_info, void *arg);
-
-#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
-
-static unw_accessors_t accessors;
-
-int main(void)
-{
-	unw_addr_space_t addr_space;
-
-	addr_space = unw_create_addr_space(&accessors, 0);
-	if (addr_space)
-		return 0;
-
-	unw_init_remote(NULL, addr_space, NULL);
-	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
-
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-arm.c b/tools/build/feature/test-libunwind-arm.c
deleted file mode 100644
index cb378b7d6866..000000000000
--- a/tools/build/feature/test-libunwind-arm.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-arm.h>
-#include <stdlib.h>
-
-extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-					       unw_word_t ip,
-					       unw_dyn_info_t *di,
-					       unw_proc_info_t *pi,
-					       int need_unwind_info, void *arg);
-
-
-#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
-
-static unw_accessors_t accessors;
-
-int main(void)
-{
-	unw_addr_space_t addr_space;
-
-	addr_space = unw_create_addr_space(&accessors, 0);
-	if (addr_space)
-		return 0;
-
-	unw_init_remote(NULL, addr_space, NULL);
-	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
-
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-debug-frame-aarch64.c b/tools/build/feature/test-libunwind-debug-frame-aarch64.c
deleted file mode 100644
index 36d6646c185e..000000000000
--- a/tools/build/feature/test-libunwind-debug-frame-aarch64.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-aarch64.h>
-#include <stdlib.h>
-
-extern int
-UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
-				 unw_word_t ip, unw_word_t segbase,
-				 const char *obj_name, unw_word_t start,
-				 unw_word_t end);
-
-#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
-
-int main(void)
-{
-	dwarf_find_debug_frame(0, NULL, 0, 0, NULL, 0, 0);
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-debug-frame-arm.c b/tools/build/feature/test-libunwind-debug-frame-arm.c
deleted file mode 100644
index 8696e48e1268..000000000000
--- a/tools/build/feature/test-libunwind-debug-frame-arm.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-arm.h>
-#include <stdlib.h>
-
-extern int
-UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
-				 unw_word_t ip, unw_word_t segbase,
-				 const char *obj_name, unw_word_t start,
-				 unw_word_t end);
-
-#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
-
-int main(void)
-{
-	dwarf_find_debug_frame(0, NULL, 0, 0, NULL, 0, 0);
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-debug-frame.c b/tools/build/feature/test-libunwind-debug-frame.c
index efb55cdd8d01..4c57e37004b3 100644
--- a/tools/build/feature/test-libunwind-debug-frame.c
+++ b/tools/build/feature/test-libunwind-debug-frame.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <libunwind.h>
 #include <stdlib.h>
 
 extern int
diff --git a/tools/build/feature/test-libunwind-x86.c b/tools/build/feature/test-libunwind-x86.c
deleted file mode 100644
index e5e0f6c89637..000000000000
--- a/tools/build/feature/test-libunwind-x86.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-x86.h>
-#include <stdlib.h>
-
-extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-					       unw_word_t ip,
-					       unw_dyn_info_t *di,
-					       unw_proc_info_t *pi,
-					       int need_unwind_info, void *arg);
-
-
-#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
-
-static unw_accessors_t accessors;
-
-int main(void)
-{
-	unw_addr_space_t addr_space;
-
-	addr_space = unw_create_addr_space(&accessors, 0);
-	if (addr_space)
-		return 0;
-
-	unw_init_remote(NULL, addr_space, NULL);
-	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
-
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-x86_64.c b/tools/build/feature/test-libunwind-x86_64.c
deleted file mode 100644
index 62ae4db597dc..000000000000
--- a/tools/build/feature/test-libunwind-x86_64.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-x86_64.h>
-#include <stdlib.h>
-
-extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-					       unw_word_t ip,
-					       unw_dyn_info_t *di,
-					       unw_proc_info_t *pi,
-					       int need_unwind_info, void *arg);
-
-
-#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
-
-static unw_accessors_t accessors;
-
-int main(void)
-{
-	unw_addr_space_t addr_space;
-
-	addr_space = unw_create_addr_space(&accessors, 0);
-	if (addr_space)
-		return 0;
-
-	unw_init_remote(NULL, addr_space, NULL);
-	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
-
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind.c b/tools/build/feature/test-libunwind.c
index 53fd26614ff0..5af5dc3a73d4 100644
--- a/tools/build/feature/test-libunwind.c
+++ b/tools/build/feature/test-libunwind.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <libunwind.h>
 #include <stdlib.h>
 
 extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-- 
2.54.0.563.g4f69b47b94-goog

