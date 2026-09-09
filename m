Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2957F752
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970247; cv=none; b=nUVKsZhtpf+710oxnfzuj67ltTFqUPAcNtXbM/zFA/paOnv5sGBZjVRCWbGWO9S4x18pSBi6g6x39AMaBUZKSWl9YzsYLM6IDXQ5pHLdkThc02YOdQ6YoZKKbl1LAxUeWwllwy/qV8OFKzqE3Ukp5AVGWsxazDOyZsJVQ+OR4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970247; c=relaxed/simple;
	bh=ClX5gu7ZWQcDIfSGa03/6rAk6DOG+U+q5SX5RhoWhd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R1HY+hFFpbdD4tPmO9AfBJphbsUKak7gQxQgiokDcEC1TSl5Yh3oosXfnnRbwfxn5Cn+p1xB9LZ7S3q+2gZajjGCPNehdgij94vcPMTWSsGOBheedllg/oU46hNraRSLXVYRRXTHvZ4R6E4e9ddgvP3H/DAq61Y3BwMwi0aLkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2xEobtH; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2xEobtH"
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-45952ce9ee0so8744701fac.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2026 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788970245; x=1789575045; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5rCco+dwti6SuoG/9O0W8ePHYIwuie6+8ypN78bk8dQ=;
        b=b2xEobtHGbaw76gsFbs+gAzkz2F6xJT8gHmGphP2UcoLQAuu6HFp7NHsEk+wfJcxFf
         5wBr1mo7rePkBNdBKqcq+4zSj6WS9KwtWJfzwMLf2QhtwQkjmemIIrBPv5xfUAIYmw07
         kJn6WMoeRf3KHH7Qt/KYdyqO5l9FhWep6WUgLDSTlC7GXBJkUb1iUSOqz9u1qnetrGPX
         fFOFqJBOPy8iWSOqemPpmwwl57q49WxhseLDc19m7s27cdJ6uWj9j/Cqq70CMucOJbI/
         ihwzsXGtzTxhK93WhCJGUpnH35kG6qSW26CMrWjGbQMoNbHy7fJ92X8FIacYbMamtO6+
         QQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970245; x=1789575045;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5rCco+dwti6SuoG/9O0W8ePHYIwuie6+8ypN78bk8dQ=;
        b=OPUqB0RiyZJHi//o85nnJcd9GH+7EIXSGR0DYLdcgGpmSb6dd35wvfiEIdkQfg+bjT
         ixDKibdgCW/CXpzxT5M6xWtXbc+b82TVXUkOXhFDsJgklKn11147DwiyHJIDyUYy0GkK
         UuvQM0Nx0gcKsDBHqE0NP9gq8/Ks7+ufDFDfUF97IfVsmaOnRig9brmrZg+Rienngt10
         tQp/hs4lERr+h72l0ygwYID8Pd+wcZKspt9HsXZFQ0TcMC32spIwhAi59dCAIqhfrzvI
         V1Ci1EP0ai0zssQbrxxaGtQ8/KqYwNffke1gEhgzlo2wXmlhk3vGmmB+wJJMBnurpmqK
         h5AQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0nSeljHjgBv7O8C9r/DFulvQZTKIrZb6lUWGLVRV68eGo91sK2R/Wzhfy4OmEmy34tpcn8zPTzDMwBGnsjhad@vger.kernel.org
X-Gm-Message-State: AFuF++kRvdYOp0WYwFJwj/iqQ8dX+TcwD2pNv2sivARXvQV6PJLrzwF8
	QJnJ5tku8MH9wFTLhECTcYCTlPb5hXeW8T0q2vG5D1OlcmRr+mHcJnhYbvYPuAwbyAX44bd20Rl
	QELJ+7t91qA==
X-Received: from dlbuy19.prod.google.com ([2002:a05:7022:1e13:b0:142:d9a6:93e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:160b:b0:6bd:c2a1:3c48
 with SMTP id 006d021491bc7-6bdc2a13d0cmr4209472eaf.8.1788970244322; Wed, 09
 Sep 2026 09:10:44 -0700 (PDT)
Date: Wed,  9 Sep 2026 09:10:40 -0700
In-Reply-To: <20260903045603.3611902-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903045603.3611902-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260909161041.1745638-1-irogers@google.com>
Subject: [PATCH v3] perf tests: Improvements to build-test performance
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	mjeanson@efficios.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Replace hardcoded 'make' calls with '$(MAKE)' within tests/make
to ensure GNU Make jobserver file descriptors are properly inherited
by nested builds.

Additionally, remove the notorious 'unexport MAKEFLAGS' from
tools/perf/Makefile. This hack was originally added to prevent
the wrapper's internal '-j$(JOBS)' override from crashing when parent
jobserver tokens were present. Instead, use proper GNU Make conditionals
to check for '-j' or 'jobserver' strings within MAKEFLAGS. If a jobserver
is already orchestrating the build, gracefully back off and let GNU Make
manage parallelism natively.

Finally, optimize the 'out' target (which processes 'run_O' out-of-tree
builds) by stripping sequential bottlenecks like $(call clean) from
isolated tmp directories, and wrapping the target list in a parallel
sub-make call.

These combined changes enable 'build-test' out-of-tree targets to
build completely concurrently without severing jobserver tokens.

Unscientifically measured the change lowered the build-test from
around 15 minutes to 10 minutes on a 28 threaded Alderlake CPU. Fixing
the jobserver issues meant the machine remained somewhat usable while
running the test.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro

---
v3:
 - Added order-only tracking for make_tags_O and make_cscope_O against
   make_clean_all_O. By parallelizing the 'out' tests in v2, make_clean_all
   was sporadically deleting the source tree's './tags' file mid-sort while
   make_tags executed concurrently alongside it, resulting in ctags crashes.
 - Added explicit trap cleanup routines via bash to properly emulate standard
   GNU Make behavior on SIGINT/SIGTERM. If a user interrupts the test
   using Ctrl+C, files like 'make_debug_O' and temporal build folders get
   properly cleaned up. They are only left behind if the test errors out.
v2:
 - Re-structured build-test array in tools/perf/Makefile into explicit
   sequential $(MAKE) passes. This prevents in-tree targets (make_static,
   etc.) from racing to directory corruption when exposed to native
   jobservers.
 - Added '+' prefix to recipe modifiers in tests/make to prevent jobserver
   FDs from being stripped before sub-shell evaluation.
 - Replaced hardcoded -j$(cores) limits in the 'out' sub-make step with
   dynamic jobserver boundary detection to prevent fork-bomb override
   collisions.
 - Restored missing $(call clean) steps via O_CLEAN conditionals to prevent
   in-tree polluted runs from breaking out-of-tree sequences.
 - Removed unconditionally appended $(FEATURES_DUMP_FILE) target restrictions
   from 'out' that threw "No rule to make target" errors on unhandled tests.
 - Fixed 'test_dest_files' to check [ ! -f ] instead of [ ! -x ], removing
   long-standing ghost warnings for non-executable mode-644 targets
   like etc/bash_completion.d/perf.
 - Fixed cosmetic string formatting bugs in GNU Make's print_msg banner
   output.
---
 tools/perf/Makefile   | 35 +++++++++++++++++++-----------
 tools/perf/tests/make | 50 +++++++++++++++++++++++++++----------------
 2 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 5b713837eede..2cbf4cb5f093 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -14,23 +14,29 @@
 .SUFFIXES:
 
 #
-# We don't want to pass along options like -j:
+# If no parallel build was requested, do a parallel build with multiple jobs,
+# based on the number of CPUs online in this system: 'make -j8' on an 8-CPU
+# system, etc.
 #
-unexport MAKEFLAGS
-
-#
-# Do a parallel build with multiple jobs, based on the number of CPUs online
-# in this system: 'make -j8' on a 8-CPU system, etc.
+# If MAKEFLAGS contains '-j' or 'jobserver', JOBS is intentionally left
+# uninitialized so the native GNU Make jobserver can seamlessly control the
+# parallel bounds of the build.
 #
 # (To override it, run 'make JOBS=1' and similar.)
 #
-ifeq ($(JOBS),)
-  JOBS := $(shell (getconf _NPROCESSORS_ONLN || grep -E -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
-  ifeq ($(JOBS),0)
-    JOBS := 1
+ifeq ($(findstring -j,$(MAKEFLAGS)),)
+  ifeq ($(findstring jobserver,$(MAKEFLAGS)),)
+    ifeq ($(JOBS),)
+      JOBS := $(shell (getconf _NPROCESSORS_ONLN || grep -E -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
+      ifeq ($(JOBS),0)
+        JOBS := 1
+      endif
+    endif
+    PARALLEL_OPT := -j$(JOBS)
   endif
 endif
 
+
 #
 # Only pass canonical directory names as the output directory:
 #
@@ -58,11 +64,11 @@ else
 endif
 
 define print_msg
-  @printf '  BUILD:   Doing '\''make \033[33m-j'$(JOBS)'\033[m'\'' $(BUILD_TYPE) build\n'
+  @printf '  BUILD:   Doing '\''make\033[33m%s\033[m'\'' $(BUILD_TYPE) build\n' "$(if $(JOBS), -j$(JOBS),)"
 endef
 
 define make
-  @$(MAKE) -f Makefile.perf --no-print-directory -j$(JOBS) O=$(FULL_O) $(SET_DEBUG) $@
+  @$(MAKE) -f Makefile.perf --no-print-directory $(PARALLEL_OPT) O=$(FULL_O) $(SET_DEBUG) $@
 endef
 
 #
@@ -106,7 +112,10 @@ clean:
 # make -C tools/perf -f tests/make
 #
 build-test:
-	@$(MAKE) SHUF=1 -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory tarpkg make_static make_with_gtk2 out
+	@$(MAKE) SHUF=1 -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory tarpkg
+	@$(MAKE) SHUF=1 -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory make_static
+	@$(MAKE) SHUF=1 -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory make_with_gtk2
+	@$(MAKE) SHUF=1 -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory out
 
 build-test-tarball:
 	@$(MAKE) -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory out
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index d2c2f526e1db..4a865e58f2be 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -28,15 +28,17 @@ endif
 
 PARALLEL_OPT=
 ifeq ($(SET_PARALLEL),1)
-  ifeq ($(JOBS),)
-    cores := $(shell (getconf _NPROCESSORS_ONLN || grep -E -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
-    ifeq ($(cores),0)
-      cores := 1
+  ifeq ($(findstring jobserver,$(MAKEFLAGS))$(findstring -j,$(MAKEFLAGS)),)
+    ifeq ($(JOBS),)
+      cores := $(shell (getconf _NPROCESSORS_ONLN || grep -E -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
+      ifeq ($(cores),0)
+        cores := 1
+      endif
+    else
+      cores=$(JOBS)
     endif
-  else
-    cores=$(JOBS)
+    PARALLEL_OPT="-j$(cores)"
   endif
-  PARALLEL_OPT="-j$(cores)"
 endif
 
 # As per kernel Makefile, avoid funny character set dependencies
@@ -230,7 +232,7 @@ test_make_util_pmu_bison_o := test -f $(PERF_O)/util/pmu-bison.o
 
 define test_dest_files
   for file in $(1); do				\
-    if [ ! -x $$TMP_DEST/$$file ]; then		\
+    if [ ! -f $$TMP_DEST/$$file ]; then		\
       echo "  failed to find: $$file";		\
     fi						\
   done
@@ -310,7 +312,8 @@ clean := @(cd $(PERF); $(MAKE_F) -s $(O_OPT) clean >/dev/null && $(MAKE) -s $(O_
 
 $(run):
 	$(call clean)
-	@TMP_DEST=$$(mktemp -d); \
+	+@TMP_DEST=$$(mktemp -d); \
+	trap 'rm -rf $@ $$TMP_DEST; exit 130' INT TERM; \
 	cmd="cd $(PERF) && $(MAKE_F) $($@) $(PARALLEL_OPT) $(O_OPT) DESTDIR=$$TMP_DEST"; \
 	printf "%*.*s: %s\n" $(max_width) $(max_width) "$@" "$$cmd" && echo $$cmd > $@ && \
 	( eval $$cmd ) >> $@ 2>&1; \
@@ -320,7 +323,8 @@ $(run):
 
 make_with_gtk2:
 	$(call clean)
-	@TMP_DEST=$$(mktemp -d); \
+	+@TMP_DEST=$$(mktemp -d); \
+	trap 'rm -rf $@ $$TMP_DEST; exit 130' INT TERM; \
 	cmd="cd $(PERF) && $(MAKE_F) $($@) $(PARALLEL_OPT) $(O_OPT) DESTDIR=$$TMP_DEST"; \
 	printf "%*.*s: %s\n" $(max_width) $(max_width) "$@" "$$cmd" && echo $$cmd > $@ && \
 	( eval $$cmd ) >> $@ 2>&1; \
@@ -330,7 +334,8 @@ make_with_gtk2:
 
 make_static:
 	$(call clean)
-	@TMP_DEST=$$(mktemp -d); \
+	+@TMP_DEST=$$(mktemp -d); \
+	trap 'rm -rf $@ $$TMP_DEST; exit 130' INT TERM; \
 	cmd="cd $(PERF) && $(MAKE_F) $($@) $(PARALLEL_OPT) $(O_OPT) DESTDIR=$$TMP_DEST"; \
 	printf "%*.*s: %s\n" $(max_width) $(max_width) "$@" "$$cmd" && echo $$cmd > $@ && \
 	( eval $$cmd ) >> $@ 2>&1; \
@@ -339,9 +344,12 @@ make_static:
 	rm -rf $@ $$TMP_DEST || (cat $@ ; false)
 
 $(run_O):
+ifneq ($(O_CLEAN),0)
 	$(call clean)
-	@TMP_O=$$(mktemp -d); \
+endif
+	+@TMP_O=$$(mktemp -d); \
 	TMP_DEST=$$(mktemp -d); \
+	trap 'rm -rf $@ $$TMP_O $$TMP_DEST; exit 130' INT TERM; \
 	cmd="cd $(PERF) && $(MAKE_F) $($(patsubst %_O,%,$@)) $(PARALLEL_OPT) O=$$TMP_O DESTDIR=$$TMP_DEST"; \
 	printf "%*.*s: %s\n" $(max_width) $(max_width) "$@" "$$cmd" && echo $$cmd > $@ && \
 	( eval $$cmd ) >> $@ 2>&1 && \
@@ -363,18 +371,18 @@ endif
 make_kernelsrc:
 	@echo "- make -C <kernelsrc> $(PARALLEL_OPT) $(K_O_OPT) tools/perf"
 	$(call clean); \
-	(make -C ../.. $(PARALLEL_OPT) $(K_O_OPT) tools/perf) > $@ 2>&1 && \
+	($(MAKE) -C ../.. $(PARALLEL_OPT) $(K_O_OPT) tools/perf) > $@ 2>&1 && \
 	test -x $(KERNEL_O)/tools/perf/perf && rm -f $@ || (cat $@ ; false)
 
 make_kernelsrc_tools:
 	@echo "- make -C <kernelsrc>/tools $(PARALLEL_OPT) $(K_O_OPT) perf"
 	$(call clean); \
-	(make -C ../../tools $(PARALLEL_OPT) $(K_O_OPT) perf) > $@ 2>&1 && \
+	($(MAKE) -C ../../tools $(PARALLEL_OPT) $(K_O_OPT) perf) > $@ 2>&1 && \
 	test -x $(KERNEL_O)/tools/perf/perf && rm -f $@ || (cat $@ ; false)
 
 make_libperf:
 	@echo "- make -C lib";
-	make -C lib clean >$@ 2>&1; make -C lib >>$@ 2>&1 && rm $@
+	$(MAKE) -C lib clean >$@ 2>&1; $(MAKE) -C lib >>$@ 2>&1 && rm $@
 
 FEATURES_DUMP_FILE := $(FULL_O)/BUILD_TEST_FEATURE_DUMP
 FEATURES_DUMP_FILE_STATIC := $(FULL_O)/BUILD_TEST_FEATURE_DUMP_STATIC
@@ -383,20 +391,22 @@ all: $(run) $(run_O) tarpkg make_kernelsrc make_kernelsrc_tools
 	@echo OK
 	@rm -f $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)
 
-out: $(run_O)
+out:
+	$(call clean)
+	@$(MAKE) -f tests/make $(run_O) PARALLEL_OPT= O_CLEAN=0 $(if $(findstring jobserver,$(MAKEFLAGS))$(findstring -j,$(MAKEFLAGS)),,$(if $(cores),-j$(cores)))
 	@echo OK
 	@rm -f $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)
 
 ifeq ($(REUSE_FEATURES_DUMP),1)
 $(FEATURES_DUMP_FILE):
 	$(call clean)
-	@cmd="cd $(PERF) && make FEATURE_DUMP_COPY=$@ $(O_OPT) feature-dump"; \
+	@cmd="cd $(PERF) && $(MAKE) FEATURE_DUMP_COPY=$@ $(O_OPT) feature-dump"; \
 	echo "- $@: $$cmd" && echo $$cmd && \
 	( eval $$cmd ) > /dev/null 2>&1
 
 $(FEATURES_DUMP_FILE_STATIC):
 	$(call clean)
-	@cmd="cd $(PERF) && make FEATURE_DUMP_COPY=$@ $(O_OPT) LDFLAGS='-static' feature-dump"; \
+	@cmd="cd $(PERF) && $(MAKE) FEATURE_DUMP_COPY=$@ $(O_OPT) LDFLAGS='-static' feature-dump"; \
 	echo "- $@: $$cmd" && echo $$cmd && \
 	( eval $$cmd ) > /dev/null 2>&1
 
@@ -416,3 +426,7 @@ endif
 
 .PHONY: all $(run) $(run_O) tarpkg clean make_kernelsrc make_kernelsrc_tools make_libperf
 endif # ifndef MK
+
+# Serialize execution of tasks writing to shared in-tree files
+make_tags_O: | make_clean_all_O
+make_cscope_O: | make_clean_all_O
-- 
2.55.0.979.g7e5102b832-goog

