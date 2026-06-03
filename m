Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40A4508E4
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481866; cv=none; b=Ov00UeoVqnHDMiuaf5nyBrNKnxm2C1r5VEJXAW4hc3nLfdZviMGfXl6+RejQ1Qsh2UxdxArdHslgqbUV8lhzuA/cU/1V/YsETLGsMn5W9RJf4+cnB+VoN0dNJ+LPx8KSnhJRUyOfhXVvf8JEiEpNM4fLDbKK568ukLc650QtLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481866; c=relaxed/simple;
	bh=iK+EPeGCJUL4Rd0+dg6SeeSLGmL00IoQ7KXBGN6a9ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoR6cQbj3g0jcq7JqlEI+0DJ9BKUPxAgQTxPnwvheuv/E6VKsftMWukIR3j/QrKO79a4KBmR3kk3rMq6L3fqjSd/KxMt11y2IYGo75vwdd/G1uaNqld3Ai2/uY8dKbpBxnM1HDVnfqJ470Ur3gsGI1lzLOIAbd5/l0ukY4dooI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=baON0Odg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baON0Odg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b3637b90so14802845e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481858; x=1781086658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rizj2QOS7B7uZxjiTToPLLngMMrz1F5sdLliowsZ7eA=;
        b=baON0OdgXvT5ilb0IVXgZ0SoaM/vPqrc6a4ju3yw4GbjQiZkbMS0kiq1+RQ2l7GTfF
         2jj70Qt/Gy1nqECuBrsy5f058pKmPUhnXNnIZaM3yFOW0emhkN4Oi7MapNrhvt0Q4Kqf
         GbpdTcPgIFwn9nqKf8esbmt8243PY9svVfEXo8j61ViY3cnulMROAFsU0r0uP4NvbfeA
         Y5Jeltxc73JGD6w6UHQzG4gDkweKC5dYVi/tYbgKpmioWFA+ooKausxHYXv7P97S2Boq
         P2HyLgrQn0HUFwFQOnPJHzuok0bMQldtyk1tKSbdckTlzBzbASRh+2B+T3lmHSZQcQ5+
         o4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481858; x=1781086658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rizj2QOS7B7uZxjiTToPLLngMMrz1F5sdLliowsZ7eA=;
        b=OE7qh0JtOOYap1saHYifHoSnnog5oZYKkmietWNnqnmfQXZQs7LUQbdBbA7OBs7Eub
         JmeAhgNVMC/gs420QDgKSBrKokLf6zq8DngwxCvPFf8vA2OwSZ84DHmAPguVMddCcYLz
         YVIseWLpW38u5PxoCqViGzmCj9teTeu07xrTNj1vz0uJJdoREb8bAi4XIxSGFwAQ+WPL
         cc1mKYbknSWfhHEJ8lVqAlAEdTiZEMu17404n2NSkq+Ji4IHKjnkmPtbukLEkQoGvwNL
         aVF7TyJA0CGN5s4yioojECU2QwT5U0mMGqQ6hEj85SKSpKWuqZMF3bggCABwXRVtUvzu
         sudA==
X-Forwarded-Encrypted: i=1; AFNElJ9IhjwVWDYzd049pvrPps4gmcoNOlYg+Ga8+MsL6+q0VCltGwTXUTjZfs/KqrvWqBXPCfL5Bss1URvfhQUPDHHd@vger.kernel.org
X-Gm-Message-State: AOJu0YxuTvLgC1sNE78ZKoxbNGRV0qPm/us+OMjOTa73NwFbCRz7dVy8
	bPuhM85HDH4aDAoa2sTpsVKG8djp86ky4xhhQjFup9JmHBlPTSx875BJk5r8CbZBUaE=
X-Gm-Gg: Acq92OFM6fuHdsl2GgwpP152YrKVLSucinJff6GdUooVMMMEPIIqSxHJ/0ZV3lHf9lG
	vz5vcXOZsroum22TzozPJqzfIMEwe69s4toQm6dqvNnrw1RVmz8HJxlaPbhrtiao6g2t3AFXYu8
	myMBgEU5PYoI939MzVgGxkFKopVFz2LqexO9hv+zMkbhSBkmkj7zwCw0uZ6ghFc0BJhWAOfmK04
	i7zbpLEA6H7E21fOlT+wy78vnWpufFxZooCIrst4Tmvx/SsR43yJQ2L+lsUpat3xILjJiP97oaw
	S1TmFvvVLPyTXWpgRqJxEi1fN4QLpMnILCiC41WWf4lKKV+6PFVKvkoZiee1KYOo/CIX/+iXLs8
	q1ZjeAQ+ab32HU/+lmdhwiXprkpmLXxtCxK3hjUYEdFzS//ANVgKWfTVj9dg5CSt2GEA33k9Q+Y
	tufJVHdPbI6QsEh7neIMOVtiE87mXdl8j2q3tlipcEuzA=
X-Received: by 2002:a05:600c:154f:b0:490:af90:f9c2 with SMTP id 5b1f17b1804b1-490b5eae33dmr45700215e9.12.1780481858265;
        Wed, 03 Jun 2026 03:17:38 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:19 +0100
Subject: [PATCH v3 15/19] perf test cs-etm: Remove unused Coresight
 workloads
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-15-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

These are now unused and had various issues like not working with out of
source builds and being slow to compile. Delete them.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/trace/coresight/coresight-perf.rst   |  78 +-----------
 MAINTAINERS                                        |   1 -
 tools/perf/Makefile.perf                           |  14 +--
 tools/perf/tests/shell/coresight/Makefile          |  29 -----
 .../perf/tests/shell/coresight/Makefile.miniconfig |  14 ---
 .../tests/shell/coresight/asm_pure_loop/.gitignore |   1 -
 .../tests/shell/coresight/asm_pure_loop/Makefile   |  34 ------
 .../shell/coresight/asm_pure_loop/asm_pure_loop.S  |  30 -----
 .../tests/shell/coresight/memcpy_thread/.gitignore |   1 -
 .../tests/shell/coresight/memcpy_thread/Makefile   |  33 -----
 .../shell/coresight/memcpy_thread/memcpy_thread.c  |  80 ------------
 .../tests/shell/coresight/thread_loop/.gitignore   |   1 -
 .../tests/shell/coresight/thread_loop/Makefile     |  33 -----
 .../shell/coresight/thread_loop/thread_loop.c      |  85 -------------
 .../shell/coresight/unroll_loop_thread/.gitignore  |   1 -
 .../shell/coresight/unroll_loop_thread/Makefile    |  33 -----
 .../unroll_loop_thread/unroll_loop_thread.c        |  75 ------------
 tools/perf/tests/shell/lib/coresight.sh            | 134 ---------------------
 18 files changed, 5 insertions(+), 672 deletions(-)

diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
index 30be89320621..0a77741a431e 100644
--- a/Documentation/trace/coresight/coresight-perf.rst
+++ b/Documentation/trace/coresight/coresight-perf.rst
@@ -112,78 +112,6 @@ Example for triggering AUX pause and resume with PMU event::
 Perf test - Verify kernel and userspace perf CoreSight work
 -----------------------------------------------------------
 
-When you run perf test, it will do a lot of self tests. Some of those
-tests will cover CoreSight (only if enabled and on ARM64). You
-generally would run perf test from the tools/perf directory in the
-kernel tree. Some tests will check some internal perf support like:
-
-   Check Arm CoreSight trace data recording and synthesized samples
-   Check Arm SPE trace data recording and synthesized samples
-
-Some others will actually use perf record and some test binaries that
-are in tests/shell/coresight and will collect traces to ensure a
-minimum level of functionality is met. The scripts that launch these
-tests are in the same directory. These will all look like:
-
-   CoreSight / ASM Pure Loop
-   CoreSight / Memcpy 16k 10 Threads
-   CoreSight / Thread Loop 10 Threads - Check TID
-   etc.
-
-These perf record tests will not run if the tool binaries do not exist
-in tests/shell/coresight/\*/ and will be skipped. If you do not have
-CoreSight support in hardware then either do not build perf with
-CoreSight support or remove these binaries in order to not have these
-tests fail and have them skip instead.
-
-These tests will log historical results in the current working
-directory (e.g. tools/perf) and will be named stats-\*.csv like:
-
-   stats-asm_pure_loop-out.csv
-   stats-memcpy_thread-16k_10.csv
-   ...
-
-These statistic files log some aspects of the AUX data sections in
-the perf data output counting some numbers of certain encodings (a
-good way to know that it's working in a very simple way). One problem
-with CoreSight is that given a large enough amount of data needing to
-be logged, some of it can be lost due to the processor not waking up
-in time to read out all the data from buffers etc.. You will notice
-that the amount of data collected can vary a lot per run of perf test.
-If you wish to see how this changes over time, simply run perf test
-multiple times and all these csv files will have more and more data
-appended to it that you can later examine, graph and otherwise use to
-figure out if things have become worse or better.
-
-This means sometimes these tests fail as they don't capture all the
-data needed. This is about tracking quality and amount of data
-produced over time and to see when changes to the Linux kernel improve
-quality of traces.
-
-Be aware that some of these tests take quite a while to run, specifically
-in processing the perf data file and dumping contents to then examine what
-is inside.
-
-You can change where these csv logs are stored by setting the
-PERF_TEST_CORESIGHT_STATDIR environment variable before running perf
-test like::
-
-   export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
-   perf test
-
-They will also store resulting perf output data in the current
-directory for later inspection like::
-
-   perf-asm_pure_loop-out.data
-   perf-memcpy_thread-16k_10.data
-   ...
-
-You can alter where the perf data files are stored by setting the
-PERF_TEST_CORESIGHT_DATADIR environment variable such as::
-
-   PERF_TEST_CORESIGHT_DATADIR=/var/tmp
-   perf test
-
-You may wish to set these above environment variables if you wish to
-keep the output of tests outside of the current working directory for
-longer term storage and examination.
+There are a set of Perf tests for CoreSight which can be run with::
+
+  sudo perf test coresight
diff --git a/MAINTAINERS b/MAINTAINERS
index b539be153f6a..7efb893edcbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2751,7 +2751,6 @@ F:	tools/perf/arch/arm/util/cs-etm.h
 F:	tools/perf/arch/arm/util/pmu.c
 F:	tools/perf/tests/shell/*coresight*
 F:	tools/perf/tests/shell/coresight/*
-F:	tools/perf/tests/shell/lib/*coresight*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 4ac2a0cec9ee..e4f8c979f47b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -508,16 +508,7 @@ arm64-sysreg-defs-clean:
 	$(Q)$(MAKE) -C $(arm64_gen_sysreg_dir) O=$(arm64_gen_sysreg_outdir) \
 		prefix= subdir= clean > /dev/null
 
-TESTS_CORESIGHT_DIR := $(srctree)/tools/perf/tests/shell/coresight
-
-tests-coresight-targets: FORCE
-	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR)
-
-tests-coresight-targets-clean:
-	$(call QUIET_CLEAN, coresight)
-	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) O=$(OUTPUT) clean >/dev/null
-
-all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
+all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
 # Create python binding output directory if not already present
 $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
@@ -896,7 +887,6 @@ install-tests: all install-gtk
 		$(INSTALL) tests/shell/base_report/*.txt '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight' ; \
 		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
-	$(Q)$(MAKE) -C tests/shell/coresight install-tests
 
 install-bin: install-tools install-tests
 
@@ -939,7 +929,7 @@ endif
 
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
 		arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
-		tests-coresight-targets-clean pmu-events-clean
+		pmu-events-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
 		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
deleted file mode 100644
index fa08fd9a5991..000000000000
--- a/tools/perf/tests/shell/coresight/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-include ../../../../../tools/scripts/Makefile.include
-include ../../../../../tools/scripts/Makefile.arch
-include ../../../../../tools/scripts/utilities.mak
-
-SUBDIRS = \
-	asm_pure_loop \
-	memcpy_thread \
-	thread_loop \
-	unroll_loop_thread
-
-all: $(SUBDIRS)
-$(SUBDIRS):
-	@$(MAKE) -C $@ >/dev/null
-
-INSTALLDIRS = $(SUBDIRS:%=install-%)
-
-install-tests: $(INSTALLDIRS)
-$(INSTALLDIRS):
-	@$(MAKE) -C $(@:install-%=%) install-tests >/dev/null
-
-CLEANDIRS = $(SUBDIRS:%=clean-%)
-
-clean: $(CLEANDIRS)
-$(CLEANDIRS):
-	$(call QUIET_CLEAN, test-$(@:clean-%=%)) $(MAKE) -C $(@:clean-%=%) clean >/dev/null
-
-.PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
diff --git a/tools/perf/tests/shell/coresight/Makefile.miniconfig b/tools/perf/tests/shell/coresight/Makefile.miniconfig
deleted file mode 100644
index 5f72a9cb43f3..000000000000
--- a/tools/perf/tests/shell/coresight/Makefile.miniconfig
+++ /dev/null
@@ -1,14 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-ifndef DESTDIR
-prefix ?= $(HOME)
-endif
-
-DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
-INSTALL = install
-INSTDIR_SUB = tests/shell/coresight
-
-include ../../../../../scripts/Makefile.include
-include ../../../../../scripts/Makefile.arch
-include ../../../../../scripts/utilities.mak
diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore b/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
deleted file mode 100644
index 468673ac32e8..000000000000
--- a/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-asm_pure_loop
diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile b/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
deleted file mode 100644
index 206849e92bc9..000000000000
--- a/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
+++ /dev/null
@@ -1,34 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-include ../Makefile.miniconfig
-
-# Binary to produce
-BIN=asm_pure_loop
-# Any linking/libraries needed for the binary - empty if none needed
-LIB=
-
-all: $(BIN)
-
-$(BIN): $(BIN).S
-ifdef CORESIGHT
-ifeq ($(ARCH),arm64)
-# Build line - this is raw asm with no libc to have an always exact binary
-	$(Q)$(CC) $(BIN).S -nostdlib -static -o $(BIN) $(LIB)
-endif
-endif
-
-install-tests: all
-ifdef CORESIGHT
-ifeq ($(ARCH),arm64)
-# Install the test tool in the right place
-	$(call QUIET_INSTALL, tests) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)'; \
-		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)/$(BIN)'
-endif
-endif
-
-clean:
-	$(Q)$(RM) -f $(BIN)
-
-.PHONY: all clean install-tests
diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
deleted file mode 100644
index 577760046772..000000000000
--- a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Tamas Zsoldos <tamas.zsoldos@arm.com>, 2021 */
-
-.globl _start
-_start:
-	mov	x0, 0x0000ffff
-	mov	x1, xzr
-loop:
-	nop
-	nop
-	cbnz	x1, noskip
-	nop
-	nop
-	adrp	x2, skip
-	add 	x2, x2, :lo12:skip
-	br	x2
-	nop
-	nop
-noskip:
-	nop
-	nop
-skip:
-	sub	x0, x0, 1
-	cbnz	x0, loop
-
-	mov	x0, #0
-	mov	x8, #93 // __NR_exit syscall
-	svc	#0
-
-.section .note.GNU-stack, "", @progbits
diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/.gitignore b/tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
deleted file mode 100644
index f8217e56091e..000000000000
--- a/tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-memcpy_thread
diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/Makefile b/tools/perf/tests/shell/coresight/memcpy_thread/Makefile
deleted file mode 100644
index 2db637eb2c26..000000000000
--- a/tools/perf/tests/shell/coresight/memcpy_thread/Makefile
+++ /dev/null
@@ -1,33 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-include ../Makefile.miniconfig
-
-# Binary to produce
-BIN=memcpy_thread
-# Any linking/libraries needed for the binary - empty if none needed
-LIB=-pthread
-
-all: $(BIN)
-
-$(BIN): $(BIN).c
-ifdef CORESIGHT
-ifeq ($(ARCH),arm64)
-# Build line
-	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
-endif
-endif
-
-install-tests: all
-ifdef CORESIGHT
-ifeq ($(ARCH),arm64)
-# Install the test tool in the right place
-	$(call QUIET_INSTALL, tests) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)'; \
-		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)/$(BIN)'
-endif
-endif
-
-clean:
-	$(Q)$(RM) -f $(BIN)
-
-.PHONY: all clean install-tests
diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
deleted file mode 100644
index 7e879217be30..000000000000
--- a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <pthread.h>
-
-struct args {
-	unsigned long loops;
-	unsigned long size;
-	pthread_t th;
-	void *ret;
-};
-
-static void *thrfn(void *arg)
-{
-	struct args *a = arg;
-	unsigned long i, len = a->loops;
-	unsigned char *src, *dst;
-
-	src = malloc(a->size * 1024);
-	dst = malloc(a->size * 1024);
-	if ((!src) || (!dst)) {
-		printf("ERR: Can't allocate memory\n");
-		exit(1);
-	}
-	for (i = 0; i < len; i++)
-		memcpy(dst, src, a->size * 1024);
-
-	return NULL;
-}
-
-static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
-{
-	pthread_t t;
-	pthread_attr_t attr;
-
-	pthread_attr_init(&attr);
-	pthread_create(&t, &attr, fn, arg);
-	return t;
-}
-
-int main(int argc, char **argv)
-{
-	unsigned long i, len, size, thr;
-	struct args args[256];
-	long long v;
-
-	if (argc < 4) {
-		printf("ERR: %s [copysize Kb] [numthreads] [numloops (hundreds)]\n", argv[0]);
-		exit(1);
-	}
-
-	v = atoll(argv[1]);
-	if ((v < 1) || (v > (1024 * 1024))) {
-		printf("ERR: max memory 1GB (1048576 KB)\n");
-		exit(1);
-	}
-	size = v;
-	thr = atol(argv[2]);
-	if ((thr < 1) || (thr > 256)) {
-		printf("ERR: threads 1-256\n");
-		exit(1);
-	}
-	v = atoll(argv[3]);
-	if ((v < 1) || (v > 40000000000ll)) {
-		printf("ERR: loops 1-40000000000 (hundreds)\n");
-		exit(1);
-	}
-	len = v * 100;
-	for (i = 0; i < thr; i++) {
-		args[i].loops = len;
-		args[i].size = size;
-		args[i].th = new_thr(thrfn, &(args[i]));
-	}
-	for (i = 0; i < thr; i++)
-		pthread_join(args[i].th, &(args[i].ret));
-	return 0;
-}
diff --git a/tools/perf/tests/shell/coresight/thread_loop/.gitignore b/tools/perf/tests/shell/coresight/thread_loop/.gitignore
deleted file mode 100644
index 6d4c33eaa9e8..000000000000
--- a/tools/perf/tests/shell/coresight/thread_loop/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-thread_loop
diff --git a/tools/perf/tests/shell/coresight/thread_loop/Makefile b/tools/perf/tests/shell/coresight/thread_loop/Makefile
deleted file mode 100644
index ea846c038e7a..000000000000
--- a/tools/perf/tests/shell/coresight/thread_loop/Makefile
+++ /dev/null
@@ -1,33 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-include ../Makefile.miniconfig
-
-# Binary to produce
-BIN=thread_loop
-# Any linking/libraries needed for the binary - empty if none needed
-LIB=-pthread
-
-all: $(BIN)
-
-$(BIN): $(BIN).c
-ifdef CORESIGHT
-ifeq ($(ARCH),arm64)
-# Build line
-	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
-endif
-endif
-
-install-tests: all
-ifdef CORESIGHT
-ifeq ($(ARCH),arm64)
-# Install the test tool in the right place
-	$(call QUIET_INSTALL, tests) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)'; \
-		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)/$(BIN)'
-endif
-endif
-
-clean:
-	$(Q)$(RM) -f $(BIN)
-
-.PHONY: all clean install-tests
diff --git a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
deleted file mode 100644
index 86f3f548b006..000000000000
--- a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
+++ /dev/null
@@ -1,85 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-// define this for gettid()
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <pthread.h>
-#include <sys/syscall.h>
-#ifndef SYS_gettid
-// gettid is 178 on arm64
-# define SYS_gettid 178
-#endif
-#define gettid() syscall(SYS_gettid)
-
-struct args {
-	unsigned int loops;
-	pthread_t th;
-	void *ret;
-};
-
-static void *thrfn(void *arg)
-{
-	struct args *a = arg;
-	int i = 0, len = a->loops;
-
-	if (getenv("SHOW_TID")) {
-		unsigned long long tid = gettid();
-
-		printf("%llu\n", tid);
-	}
-	asm volatile(
-		"loop:\n"
-		"add %w[i], %w[i], #1\n"
-		"cmp %w[i], %w[len]\n"
-		"blt loop\n"
-		: /* out */
-		: /* in */ [i] "r" (i), [len] "r" (len)
-		: /* clobber */
-	);
-	return (void *)(long)i;
-}
-
-static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
-{
-	pthread_t t;
-	pthread_attr_t attr;
-
-	pthread_attr_init(&attr);
-	pthread_create(&t, &attr, fn, arg);
-	return t;
-}
-
-int main(int argc, char **argv)
-{
-	unsigned int i, len, thr;
-	struct args args[256];
-
-	if (argc < 3) {
-		printf("ERR: %s [numthreads] [numloops (millions)]\n", argv[0]);
-		exit(1);
-	}
-
-	thr = atoi(argv[1]);
-	if ((thr < 1) || (thr > 256)) {
-		printf("ERR: threads 1-256\n");
-		exit(1);
-	}
-	len = atoi(argv[2]);
-	if ((len < 1) || (len > 4000)) {
-		printf("ERR: max loops 4000 (millions)\n");
-		exit(1);
-	}
-	len *= 1000000;
-	for (i = 0; i < thr; i++) {
-		args[i].loops = len;
-		args[i].th = new_thr(thrfn, &(args[i]));
-	}
-	for (i = 0; i < thr; i++)
-		pthread_join(args[i].th, &(args[i].ret));
-	return 0;
-}
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore b/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
deleted file mode 100644
index 2cb4e996dbf3..000000000000
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-unroll_loop_thread
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile b/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
deleted file mode 100644
index 6264c4e3abd1..000000000000
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
+++ /dev/null
@@ -1,33 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-include ../Makefile.miniconfig
-
-# Binary to produce
-BIN=unroll_loop_thread
-# Any linking/libraries needed for the binary - empty if none needed
-LIB=-pthread
-
-all: $(BIN)
-
-$(BIN): $(BIN).c
-ifdef CORESIGHT
-ifeq ($(ARCH),arm64)
-# Build line
-	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
-endif
-endif
-
-install-tests: all
-ifdef CORESIGHT
-ifeq ($(ARCH),arm64)
-# Install the test tool in the right place
-	$(call QUIET_INSTALL, tests) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)'; \
-		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)/$(BIN)'
-endif
-endif
-
-clean:
-	$(Q)$(RM) -f $(BIN)
-
-.PHONY: all clean install-tests
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
deleted file mode 100644
index 8f4e1c985ca3..000000000000
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
+++ /dev/null
@@ -1,75 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <pthread.h>
-
-struct args {
-	pthread_t th;
-	unsigned int in;
-	void *ret;
-};
-
-static void *thrfn(void *arg)
-{
-	struct args *a = arg;
-	unsigned int i, in = a->in;
-
-	for (i = 0; i < 10000; i++) {
-		asm volatile (
-// force an unroll of thia add instruction so we can test long runs of code
-#define SNIP1 "add %w[in], %w[in], #1\n"
-// 10
-#define SNIP2 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1
-// 100
-#define SNIP3 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2
-// 1000
-#define SNIP4 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3
-// 10000
-#define SNIP5 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4
-// 100000
-			SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5
-			: /* out */
-			: /* in */ [in] "r" (in)
-			: /* clobber */
-		);
-	}
-
-	return NULL;
-}
-
-static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
-{
-	pthread_t t;
-	pthread_attr_t attr;
-
-	pthread_attr_init(&attr);
-	pthread_create(&t, &attr, fn, arg);
-	return t;
-}
-
-int main(int argc, char **argv)
-{
-	unsigned int i, thr;
-	struct args args[256];
-
-	if (argc < 2) {
-		printf("ERR: %s [numthreads]\n", argv[0]);
-		exit(1);
-	}
-
-	thr = atoi(argv[1]);
-	if ((thr > 256) || (thr < 1)) {
-		printf("ERR: threads 1-256\n");
-		exit(1);
-	}
-	for (i = 0; i < thr; i++) {
-		args[i].in = rand();
-		args[i].th = new_thr(thrfn, &(args[i]));
-	}
-	for (i = 0; i < thr; i++)
-		pthread_join(args[i].th, &(args[i].ret));
-	return 0;
-}
diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
deleted file mode 100644
index 184d62e7e5bd..000000000000
--- a/tools/perf/tests/shell/lib/coresight.sh
+++ /dev/null
@@ -1,134 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-# This is sourced from a driver script so no need for #!/bin... etc. at the
-# top - the assumption below is that it runs as part of sourcing after the
-# test sets up some basic env vars to say what it is.
-
-# This currently works with ETMv4 / ETF not any other packet types at thi
-# point. This will need changes if that changes.
-
-# perf record options for the perf tests to use
-PERFRECMEM="-m ,16M"
-PERFRECOPT="$PERFRECMEM -e cs_etm//u"
-
-TOOLS=$(dirname $0)
-DIR="$TOOLS/$TEST"
-BIN="$DIR/$TEST"
-# If the test tool/binary does not exist and is executable then skip the test
-if ! test -x "$BIN"; then exit 2; fi
-# If CoreSight is not available, skip the test
-perf list pmu | grep -q cs_etm || exit 2
-DATD="."
-# If the data dir env is set then make the data dir use that instead of ./
-if test -n "$PERF_TEST_CORESIGHT_DATADIR"; then
-	DATD="$PERF_TEST_CORESIGHT_DATADIR";
-fi
-# If the stat dir env is set then make the data dir use that instead of ./
-STATD="."
-if test -n "$PERF_TEST_CORESIGHT_STATDIR"; then
-	STATD="$PERF_TEST_CORESIGHT_STATDIR";
-fi
-
-# Called if the test fails - error code 1
-err() {
-	echo "$1"
-	exit 1
-}
-
-# Check that some statistics from our perf
-check_val_min() {
-	STATF="$4"
-	if test "$2" -lt "$3"; then
-		echo ", FAILED" >> "$STATF"
-		err "Sanity check number of $1 is too low ($2 < $3)"
-	fi
-}
-
-perf_dump_aux_verify() {
-	# Some basic checking that the AUX chunk contains some sensible data
-	# to see that we are recording something and at least a minimum
-	# amount of it. We should almost always see Fn packets in just about
-	# anything but certainly we will see some trace info and async
-	# packets
-	DUMP="$DATD/perf-tmp-aux-dump.txt"
-	perf report --stdio --dump -i "$1" | \
-		grep -o -e I_ATOM_F -e I_ASYNC -e I_TRACE_INFO > "$DUMP"
-	# Simply count how many of these packets we find to see that we are
-	# producing a reasonable amount of data - exact checks are not sane
-	# as this is a lossy process where we may lose some blocks and the
-	# compiler may produce different code depending on the compiler and
-	# optimization options, so this is rough just to see if we're
-	# either missing almost all the data or all of it
-	ATOM_FX_NUM=$(grep -c I_ATOM_F "$DUMP")
-	ASYNC_NUM=$(grep -c I_ASYNC "$DUMP")
-	TRACE_INFO_NUM=$(grep -c I_TRACE_INFO "$DUMP")
-	rm -f "$DUMP"
-
-	# Arguments provide minimums for a pass
-	CHECK_FX_MIN="$2"
-	CHECK_ASYNC_MIN="$3"
-	CHECK_TRACE_INFO_MIN="$4"
-
-	# Write out statistics, so over time you can track results to see if
-	# there is a pattern - for example we have less "noisy" results that
-	# produce more consistent amounts of data each run, to see if over
-	# time any techinques to  minimize data loss are having an effect or
-	# not
-	STATF="$STATD/stats-$TEST-$DATV.csv"
-	if ! test -f "$STATF"; then
-		echo "ATOM Fx Count, Minimum, ASYNC Count, Minimum, TRACE INFO Count, Minimum" > "$STATF"
-	fi
-	echo -n "$ATOM_FX_NUM, $CHECK_FX_MIN, $ASYNC_NUM, $CHECK_ASYNC_MIN, $TRACE_INFO_NUM, $CHECK_TRACE_INFO_MIN" >> "$STATF"
-
-	# Actually check to see if we passed or failed.
-	check_val_min "ATOM_FX" "$ATOM_FX_NUM" "$CHECK_FX_MIN" "$STATF"
-	check_val_min "ASYNC" "$ASYNC_NUM" "$CHECK_ASYNC_MIN" "$STATF"
-	check_val_min "TRACE_INFO" "$TRACE_INFO_NUM" "$CHECK_TRACE_INFO_MIN" "$STATF"
-	echo ", Ok" >> "$STATF"
-}
-
-perf_dump_aux_tid_verify() {
-	# Specifically crafted test will produce a list of Tread ID's to
-	# stdout that need to be checked to  see that they have had trace
-	# info collected in AUX blocks in the perf data. This will go
-	# through all the TID's that are listed as CID=0xabcdef and see
-	# that all the Thread IDs the test tool reports are  in the perf
-	# data AUX chunks
-
-	# The TID test tools will print a TID per stdout line that are being
-	# tested
-	TIDS=$(cat "$2")
-	# Scan the perf report to find the TIDs that are actually CID in hex
-	# and build a list of the ones found
-	FOUND_TIDS=$(perf report --stdio --dump -i "$1" | \
-			grep -o "CID=0x[0-9a-z]\+" | sed 's/CID=//g' | \
-			uniq | sort | uniq)
-	# No CID=xxx found - maybe your kernel is reporting these as
-	# VMID=xxx so look there
-	if test -z "$FOUND_TIDS"; then
-		FOUND_TIDS=$(perf report --stdio --dump -i "$1" | \
-				grep -o "VMID=0x[0-9a-z]\+" | sed 's/VMID=//g' | \
-				uniq | sort | uniq)
-	fi
-
-	# Iterate over the list of TIDs that the test says it has and find
-	# them in the TIDs found in the perf report
-	MISSING=""
-	for TID2 in $TIDS; do
-		FOUND=""
-		for TIDHEX in $FOUND_TIDS; do
-			TID=$(printf "%i" $TIDHEX)
-			if test "$TID" -eq "$TID2"; then
-				FOUND="y"
-				break
-			fi
-		done
-		if test -z "$FOUND"; then
-			MISSING="$MISSING $TID"
-		fi
-	done
-	if test -n "$MISSING"; then
-		err "Thread IDs $MISSING not found in perf AUX data"
-	fi
-}

-- 
2.34.1

