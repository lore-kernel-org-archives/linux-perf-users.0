Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00A309EF2
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411370; cv=none; b=f+PrTUyNHplXPK336fpU+J9qjVpvCVwL5p8qUsxnxb7bYhM6XBbhrzG3CPGm11ciJ02MXK8wMvbBEFJjaFhK9MYGD6znxV6KmyhXVXzOBC9DTi8NAELdQwpqsFgOzGFD03HN8eVddhqp0V2hz7wZpIkz2n6y932vTvIABDHoKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411370; c=relaxed/simple;
	bh=9d5bJTZoze3EweLxHCAQDp4r/qheSO1cRUlgaXuIQLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XBSIVb/WDqcwtE8LvjkC8yjTI2XbdQXDdSqZlLP3AKKODftRDle2Hro8Orh2x1gyQRGdfGhtRMWGnyBQXwHanaKICzB8pOUXE8yQU9TkoY2rCHuOzVxAdemk8nmff3ni+lnYC4SsxooyADWkcNsuCiADle+BfUdEUS9RXV63FHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oE/TFvqS; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oE/TFvqS"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398e1fafe17so2788332a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2026 21:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788411367; x=1789016167; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAJRiyqxDNbqNovLMx0HCQdku/X8Sgrg7Q1N4V/JMDI=;
        b=oE/TFvqSVPXniKMcSYd1UI8fvuSVvH7BickME5oNo9lsrrIH83iUqyGsJa960zXWgP
         iRv6HrgDBKcLr7F0sEjWkLVQud6wMEkSrqeWxRxKz0zuXghfm7/FCdjyN58YA47cE4OM
         MCNjluk+DyV1/ObxBPc/MHmzJAmC9RcKWetB0hfBgZEmIHIPQn8rQRHvJJ75j5dJTScO
         NCS5zB26T6xGm3/7rRbld25PLEmQj+ptmdzkOGhJyvFgYQ0iyJ+Khiy/SlhIMaIYRc1k
         lM5+Hv31Y6kR6Y9QmdNLSlhtg6SU/xLlil5oQPWzbUj3+xG/nhnFZtwA7LaQs71amLZ3
         gnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411367; x=1789016167;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAJRiyqxDNbqNovLMx0HCQdku/X8Sgrg7Q1N4V/JMDI=;
        b=SCOdc9GMRuJmbUKpJk8HFLUjmw4v785pqHwOakZz9sqv9A1/EeJs+G1uLS/J55Jvvp
         FHW4HjBYWpkLZ6yquccdwzo2vI14dhJYEiJhzsx5IRYHfpWbR8vxly+d87eoK9tNfLXB
         TlPhCc+B7njMEozE4qedTpBxUYX8q6nrm3GCceJNfrl9UuggRdSC3QgppMgqvxXf1HkI
         O2S/Q6oxTV+6pWBfgMw4r/rrzv/LL0l12PT70eQOWv1HxkELrSwLxNxUjU7UBwSys3Bi
         nrY9G9oTxUfXGoqw7q2qhIrpC2/jHdhafpux2sNRJVpTtxivGKfcNA/iyjzVkPXrkhVW
         Gtwg==
X-Forwarded-Encrypted: i=1; AKwUvBw0+YfSDpZlD9TDYdBDJjm44F5LcK1dCv59r6OHK1qPmoHqUYpt0mDJhMBc4sSiD8mThRHkRk7eWss//mLM2Xlp@vger.kernel.org
X-Gm-Message-State: AFuF++lwkC5xwNsPk6Tv7RsBe2+ubaTC6hl8+6NXffMzHxwvumcmpwMU
	lKmwfQihJ8L04/C4AJNj66MYTlZnIV2xTrPdFZdzRM7NOk1oqNbzqrhU7rGTXb8/dU+jiW2KmLR
	QuT128JqX/A==
X-Received: from dlag28.prod.google.com ([2002:a05:701b:251c:b0:141:4cd7:9d61])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5908:b0:38e:5b59:c2ff
 with SMTP id 98e67ed59e1d1-39aedec4caamr15609087a91.3.1788411367246; Wed, 02
 Sep 2026 21:56:07 -0700 (PDT)
Date: Wed,  2 Sep 2026 21:56:03 -0700
In-Reply-To: <20260902153135.2067365-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902153135.2067365-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260903045603.3611902-1-irogers@google.com>
Subject: [PATCH v2] perf tests: Improvements to build-test performance
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, mjeanson@efficios.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Replace hardcoded 'make' calls with '$(MAKE)' within tests/make to
ensure GNU Make jobserver file descriptors are properly inherited by
nested builds.

Additionally, remove the 'unexport MAKEFLAGS' from
tools/perf/Makefile. This hack was originally added to prevent the
wrapper's internal '-j$(JOBS)' override from crashing when parent
jobserver tokens were present. Instead, use proper GNU Make
conditionals to check for '-j' or 'jobserver' strings within
MAKEFLAGS. If a jobserver is already orchestrating the build,
gracefully back off and let GNU Make manage parallelism natively.

Finally, optimize the 'out' target (which processes 'run_O'
out-of-tree builds) by stripping sequential bottlenecks like $(call
clean) from isolated tmp directories, and wrapping the target list in
a parallel sub-make call.

These combined changes enable 'build-test' out-of-tree targets to
build completely concurrently without severing jobserver tokens.

Unscientifically measured the change lowered the build-test from
around 15 minutes to 10 minutes on a 28 threaded Alderlake CPU. Fixing
the jobserver issues meant the machine remained somewhat usable while
running the test.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
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
 tools/perf/Makefile   | 35 ++++++++++++++++++++++-------------
 tools/perf/tests/make | 42 ++++++++++++++++++++++++------------------
 2 files changed, 46 insertions(+), 31 deletions(-)

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
index d2c2f526e1db..d1d99f5a85ae 100644
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
@@ -310,7 +312,7 @@ clean := @(cd $(PERF); $(MAKE_F) -s $(O_OPT) clean >/dev/null && $(MAKE) -s $(O_
 
 $(run):
 	$(call clean)
-	@TMP_DEST=$$(mktemp -d); \
+	+@TMP_DEST=$$(mktemp -d); \
 	cmd="cd $(PERF) && $(MAKE_F) $($@) $(PARALLEL_OPT) $(O_OPT) DESTDIR=$$TMP_DEST"; \
 	printf "%*.*s: %s\n" $(max_width) $(max_width) "$@" "$$cmd" && echo $$cmd > $@ && \
 	( eval $$cmd ) >> $@ 2>&1; \
@@ -320,7 +322,7 @@ $(run):
 
 make_with_gtk2:
 	$(call clean)
-	@TMP_DEST=$$(mktemp -d); \
+	+@TMP_DEST=$$(mktemp -d); \
 	cmd="cd $(PERF) && $(MAKE_F) $($@) $(PARALLEL_OPT) $(O_OPT) DESTDIR=$$TMP_DEST"; \
 	printf "%*.*s: %s\n" $(max_width) $(max_width) "$@" "$$cmd" && echo $$cmd > $@ && \
 	( eval $$cmd ) >> $@ 2>&1; \
@@ -330,7 +332,7 @@ make_with_gtk2:
 
 make_static:
 	$(call clean)
-	@TMP_DEST=$$(mktemp -d); \
+	+@TMP_DEST=$$(mktemp -d); \
 	cmd="cd $(PERF) && $(MAKE_F) $($@) $(PARALLEL_OPT) $(O_OPT) DESTDIR=$$TMP_DEST"; \
 	printf "%*.*s: %s\n" $(max_width) $(max_width) "$@" "$$cmd" && echo $$cmd > $@ && \
 	( eval $$cmd ) >> $@ 2>&1; \
@@ -339,8 +341,10 @@ make_static:
 	rm -rf $@ $$TMP_DEST || (cat $@ ; false)
 
 $(run_O):
+ifneq ($(O_CLEAN),0)
 	$(call clean)
-	@TMP_O=$$(mktemp -d); \
+endif
+	+@TMP_O=$$(mktemp -d); \
 	TMP_DEST=$$(mktemp -d); \
 	cmd="cd $(PERF) && $(MAKE_F) $($(patsubst %_O,%,$@)) $(PARALLEL_OPT) O=$$TMP_O DESTDIR=$$TMP_DEST"; \
 	printf "%*.*s: %s\n" $(max_width) $(max_width) "$@" "$$cmd" && echo $$cmd > $@ && \
@@ -363,18 +367,18 @@ endif
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
@@ -383,20 +387,22 @@ all: $(run) $(run_O) tarpkg make_kernelsrc make_kernelsrc_tools
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
 
-- 
2.55.0.979.g7e5102b832-goog

