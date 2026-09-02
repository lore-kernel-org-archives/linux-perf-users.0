Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6B4503EF
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363104; cv=none; b=KkplaAlDxc/zCznZneSI7IOZCpmvilpqrCSlq7rpvrsyaro0P2+6/hf65qSj+tdwWd7h3zz8KiaSeMC5EfgCI9Y+S/JLPh1n5TI5eaF6SOg+lbTnhAF+dxrI8TziqsL1agrCMdC9iv4ynmSyFTcykmmygz5YEcK0JdatQb61bRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363104; c=relaxed/simple;
	bh=BvFDCPax3yeDj9GiUo0hGRFjTWmgklSVoOfXHi3Mr9c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=J1qagkI9w3wvKoxFlNONg2V6C+tV7um9QodSRiTug1CHjF+XbNRt+dDdcBUx3UkcKAkGxL6qLF3XQGLEF14FFDZ+dar80aIAXN3z0kJZ79pFodkyOD07w0+PAbkISIdInTtWWXbx72Yo52jewBCe+le9WzSUXDJsn4aRVZMeGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3Lz0hGY; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3Lz0hGY"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso1770347a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2026 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788363102; x=1788967902; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JGry/fluIf0l8o3OiASIK8R7KuvirdME0/bitGdxAiw=;
        b=d3Lz0hGYEgAVZsJpBGrou01W5H8/F3XW7T3UhZI4BBJtH88HMmLZXqXy9eRSs/+Xkr
         3544sczWHysGWUOf6SR/DEyOjtfCw3bFIBBA6YLSaxzsZMp1X5RhyE5HYJFgbMQaE07/
         Og9a1NIxiAbDLQjQF4yTwHSagh+h94bqqHBsNbt1mgFSubnaNGN1qxTFc5h3WQfyTxZc
         b5uSm+B9yEStdu93M0eT/mXKnNG9ZpCAR9IAjToXLsLpohIAjyFHy+5zba/JNi7+qRiB
         wniRJSgI1nF3u8FX6OaD3X8AB1uGu1RF1H27gM+y3urlKf0zd3m0QYoGVEzmLjmE8nvV
         jkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363102; x=1788967902;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGry/fluIf0l8o3OiASIK8R7KuvirdME0/bitGdxAiw=;
        b=R/ZUkxrB86fbOEsos9KMz9d1+ohlZR35uzt24e8K7l2+3QeSlTodU1ntxGUJT6qt4o
         RdYu1FWSq5TXN0D6wyfIDfMjrhtRcC7lHGIGx8LMKrPwkKrrKRtG8xUup8PArLi4Xvww
         9q2b1RaNTL8L+vd0LgnletU/5nBySHyTIMTQm4vUcOJLJv1umDyHVGnvI+VvoirWVAOh
         Yf8tgLDe1vJeMLRAJfBKaqsjSROG50goB2/XIGtlZlkg92Q5vik+MTZJLSSkin1/ViFX
         fX2sJnoxQZtI+qYfo0A7WlTdnDGc+TydXOnpuHoplmnwkd4gV331e7CzqG04ehrP4hyW
         Ozew==
X-Forwarded-Encrypted: i=1; AKwUvBw8PntpeNWtdmdUKPkqyrVAvhokNWrThb5SlcKQeBdBigy/RtFPmK8t5XxlbND6Bk6YhN7rIZBPyTc+gm7jdJ0/@vger.kernel.org
X-Gm-Message-State: AFuF++kdR8kolgxLuis9nJ/1JF1wlov++TrqyOB+mAF7hk9sCsdCeHTG
	DEbQPVySAjPcVJJvlTbNjUyuGATM3NbFP4RYJK/UN2qpn9p8+CChKc+PmlnpKh1fldbyJOhBq3q
	I2r8IrtZLIA==
X-Received: from dlbec23.prod.google.com ([2002:a05:7022:d97:b0:141:4abc:f12d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a83:b0:3d3:adad:f178
 with SMTP id adf61e73a8af0-3d9afd02e3emr7984151637.26.1788363101368; Wed, 02
 Sep 2026 08:31:41 -0700 (PDT)
Date: Wed,  2 Sep 2026 08:31:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902153135.2067365-1-irogers@google.com>
Subject: [PATCH v1] perf tests: Improvements to build-test performance
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Michael Jeanson <mjeanson@efficios.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Replace hardcoded 'make' calls with '$(MAKE)' within tests/make
to ensure GNU Make jobserver file descriptors are properly inherited
by nested builds.

Additionally, remove the notorious 'unexport MAKEFLAGS' from
tools/perf/Makefile. This hack was originally added to prevent
the wrapper's internal '-j$(JOBS)' override from crashing when parent jobserver
tokens were present. Instead, use proper GNU Make conditionals to check
for '-j' or 'jobserver' strings within MAKEFLAGS. If a jobserver is
already orchestrating the build, gracefully back off and let GNU Make
manage parallelism natively.

Finally, optimize the 'out' target (which processes 'run_O' out-of-tree builds)
by stripping sequential bottlenecks like $(call clean) from isolated tmp directories,
and wrapping the target list in a parallel sub-make call.

These combined changes enable 'build-test' out-of-tree targets to
build completely concurrently without severing jobserver tokens.

Unscientifically measured the change lowered the build-test from
around 15 minutes to 10 minutes on a 28 threaded Alderlake CPU. Fixing
the jobserver issues meant the machine remained somewhat usable while
running the test.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Makefile   | 28 +++++++++++++++++-----------
 tools/perf/tests/make | 14 +++++++-------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 5b713837eede..45f641e24fb4 100644
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
@@ -62,7 +68,7 @@ define print_msg
 endef
 
 define make
-  @$(MAKE) -f Makefile.perf --no-print-directory -j$(JOBS) O=$(FULL_O) $(SET_DEBUG) $@
+  @$(MAKE) -f Makefile.perf --no-print-directory $(PARALLEL_OPT) O=$(FULL_O) $(SET_DEBUG) $@
 endef
 
 #
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index d2c2f526e1db..4f14c6b72416 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -339,7 +339,6 @@ make_static:
 	rm -rf $@ $$TMP_DEST || (cat $@ ; false)
 
 $(run_O):
-	$(call clean)
 	@TMP_O=$$(mktemp -d); \
 	TMP_DEST=$$(mktemp -d); \
 	cmd="cd $(PERF) && $(MAKE_F) $($(patsubst %_O,%,$@)) $(PARALLEL_OPT) O=$$TMP_O DESTDIR=$$TMP_DEST"; \
@@ -363,18 +362,18 @@ endif
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
@@ -383,20 +382,21 @@ all: $(run) $(run_O) tarpkg make_kernelsrc make_kernelsrc_tools
 	@echo OK
 	@rm -f $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)
 
-out: $(run_O)
+out: $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)
+	@$(MAKE) -f tests/make $(run_O) PARALLEL_OPT= -j$(cores)
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
2.55.0.966.g6673acef38-goog

