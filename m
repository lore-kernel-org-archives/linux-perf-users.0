Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604136;
	b=uMf4pQ7+4+mPk6sutfi97w+zduqrooIuAQUPK7q0yMliq2Ct+BmJhaqxRv241WuHlLX9
	 Xwkar8/t2JTrvYcETnm0dnwp/AIerzFcBDhjrbLswUUuZaRhFUvXiKmYqKzibGRNpOQQ2
	 OGTW/Apfi+iiMzpZnsb4tiOCzGgSQD1J8El4VD14p+ib9jcOf/P1RQCArLZ0Pqoqp/0oq
	 6Jyhl36G9QKyevUSipeGs1vjeMb+qpNiXw6B4wdfW0ISIwwascrGUJpM26xus0St4z/3I
	 Yio2/gCMjjjAUr9O0v2gtRibBztRyULNX12dkqv6oewYFZXZEXFn4hEiD9tEbAHohow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=l87qNe2gCFMnCequO/xk6r+49OIRAbJukp+a4aoGAGg=;
	b=idKvFnmIE0XA4UG3iYMxIqutPQYn7HB9U7zP5dxNlYJzfqS36eTO2CNv7RQq/lwW+5xx
	 lACfQhLFdDLn3oKD4mRt5rB42b2Zs4IrySRoZg7Q2/9Q+EI2OTZz4hX1fOKnmA5NPDKKu
	 /e8KZbvKcxTMkKSsLXfzdF9Lj3NWOt+OBs6IRNG7mEvDz/9rOYdpw3AtExozb6qIo96Gb
	 /XN42v8YWA70Ug77e+J0TZlQNZlBt3MBR9u1UyRUlY2fQpT23rq8vLVr+SK/d3X3nvrIs
	 3Ka1vGVy3pEySh3jEpVw437R+lLA3wRGXOIg4VDVrFoK7abpIdKYqN8LtJgrbQZclyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X6GhvIJS;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196C60A5BCE
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1196C60A5BCE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X6GhvIJS
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-375bac6bd21so1034218eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604135; x=1795208935; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l87qNe2gCFMnCequO/xk6r+49OIRAbJukp+a4aoGAGg=;
        b=X6GhvIJSpzg810YcvFRF/hk358c8TGTwpvY8/JTDuqGt/DnYbuRCk2ZlqFWS0wF2UA
         AgZtCod8QHqaQ3Xz2kDSy3TMq0bnyesQw0vGxwoRgUMdEIvDkaMzxlYsOJUdirooWbh/
         4jQpstmclLNTuSM7M2uSnKJmi1tzRqVUvRSrxM04RuyI5lAeQsiOxKCTfLfUEgbKWziE
         0deMkQ1+hdmFP7uVSXs22u0DYDrYv04zSnf35w6zKsK/zzb1Oix+4AuuTLCY+HFT22V8
         xYFQArAq8sJihuZT/DqlDQtZevW0vgQJ7xyN+bnPfT/Bhbji9d5uUnIpCXVkzSfRJNlC
         2mAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604135; x=1795208935;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l87qNe2gCFMnCequO/xk6r+49OIRAbJukp+a4aoGAGg=;
        b=PBrtENzO6iBmJgdt7kK3/WHHkpMtdGgvY31fGGssGjQwe4F3Tcw6MkNgTFR8IPwRKO
         sObOZHwTcgcC9XawPjbY9MNtDk9o51sjoE3Y4Hs7JQL/WWxsQM4BWtrWB/XoWytiOgOT
         yVmufdtcHdUObkyvRXU3h76qShcZUqffQ3CGh26dKLF3nYBXW9nKM4TJIdfI6DjS2pvh
         soTpVvFrdolgP5+YNuJ7A9IUyYfKy3Uoiq6Te9WRLVeXUryF9a6Mhg0B75V5CIWMli4y
         JLMgO6Qb6JEt2GKJNInVWQSBjdRXSjpmyapNa2ozAQ87b5sLASeUhS5p29jxGpgz6gIr
         dvrw==
X-Forwarded-Encrypted: i=1; AL+hErEa1/ALceG27NDLjjWvbuT0OmaxNCpZV5a3nE69eQ0EOi/7KC4RWNdn6m/ebNYPGRR+mxonCQfFRyxkm9cuIu1K@vger.kernel.org
X-Gm-Message-State: APuU4Z8Knva8pU4z6yBQcHktXsCe+OzJvdZPO4Ve7JO3utRshoeEytQY
	YR4qpq4R7lmeM1Ld6uQV8i+hQ53VOgp9Dz6t7Nr6NNPNPvellJD4BtNj+sx5GL7mIZDyJSpiOpO
	LxeJRcrXhlA==
X-Received: from dycmq7.prod.google.com ([2002:a05:7301:787:b0:376:583a:e72a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1887:b0:36d:6a77:960a
 with SMTP id 5a478bee46e88-37963564b9fmr2922946eec.1.1794604134796; Fri, 13
 Nov 2026 13:08:54 -0800 (PST)
Date: Fri, 13 Nov 2026 13:08:20 -0800
In-Reply-To: <20261113210822.3112700-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113210822.3112700-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113210822.3112700-9-irogers@google.com>
Subject: [PATCH 08/10] perf build: Enable jevents string compression when available
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Pass --compress=<available> to jevents.py during regular builds to
enable block-indexed string compression (packing generated PMU event and
metric strings into independently compressed ~8 KiB blocks decompressed
on demand by (block_id << 16) | sub_offset), constructing the fallback
list from CONFIG_ZSTD, CONFIG_ZLIB, CONFIG_LZMA, and none so jevents.py
only emits decompression C code for libraries actually linked into perf
(e.g. falling back to zlib when built with NO_LIBZSTD=1, or uncompressed
strings when all three are disabled).

Expose JEVENTS_COMPRESS=<zstd|zlib|lzma|none> (or a comma-separated
preference list) in Makefile.perf to override or disable compression, and
track NO_JEVENTS, JEVENTS_ARCH, JEVENTS_MODEL, and the active compression
selection in $(OUTPUT)pmu-events/jevents-flags so changing build flags
triggers regeneration without rerunning jevents.py on incremental no-op
builds. Also cover JEVENTS_COMPRESS=none in tools/perf/tests/make.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore       |  1 +
 tools/perf/Makefile.perf    | 10 +++++++-
 tools/perf/pmu-events/Build | 47 ++++++++++++++++++++++++++++++++-----
 tools/perf/tests/make       |  2 ++
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 3b968c5158b8..faf88857abff 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,6 +39,7 @@ trace/beauty/generated/
 pmu-events/arch/common/common/legacy-cache.json
 pmu-events/pmu-events.c
 pmu-events/pmu-events-string.c
+pmu-events/jevents-flags
 pmu-events/jevents
 pmu-events/metric_test.log
 pmu-events/empty-pmu-events.log
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b74b534e1153..53ab82681569 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -129,6 +129,12 @@ include ../scripts/utilities.mak
 # Define NO_MYPY if you do not want to run mypy during build
 #
 # Define NO_PYLINT if you do not want to run pylint during build
+#
+# Define JEVENTS_COMPRESS=<zstd|zlib|lzma|none> to select or disable
+# block-indexed compression of generated PMU event and metric strings, where
+# strings are packed into ~8 KiB blocks compressed independently and
+# decompressed on demand by (block_id << 16) | sub_offset (defaults to the best
+# enabled library among zstd, zlib, lzma, or none).
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -593,7 +599,7 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
 
-export NO_JEVENTS
+export NO_JEVENTS JEVENTS_ARCH JEVENTS_MODEL JEVENTS_COMPRESS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
@@ -1036,6 +1042,7 @@ pmu-events-clean:
 ifeq ($(OUTPUT),)
 	$(call QUIET_CLEAN, pmu-events) $(RM) \
 		pmu-events/pmu-events*.c \
+		pmu-events/jevents-flags \
 		pmu-events/metric_test.log \
 		pmu-events/test-empty-pmu-events.c \
 		pmu-events/empty-pmu-events.log
@@ -1044,6 +1051,7 @@ ifeq ($(OUTPUT),)
 else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
 	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
 		$(OUTPUT)pmu-events/pmu-events*.c \
+		$(OUTPUT)pmu-events/jevents-flags \
 		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
 		$(OUTPUT)pmu-events/empty-pmu-events.log
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 5147139bbb6f..88b6b47951e0 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -22,19 +22,48 @@ $(OUTPUT)pmu-events/pmu-events-string.o: $(PMU_EVENTS_STRING_C)
 # the destination to save space in the build log.
 quiet_cmd_cp   = COPY    $(patsubst %$<,%,$@) <- $<
 
+JEVENTS_FLAGS_FILE := $(OUTPUT)pmu-events/jevents-flags
+
 # --- NO_JEVENTS=1 build ---
 ifeq ($(NO_JEVENTS),1)
-$(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
+JEVENTS_FLAGS_STR := $(NO_JEVENTS)
+
+$(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C) $(JEVENTS_FLAGS_FILE)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,cp)cp $< $@
 else
 # --- Regular build ---
 
-# Setup the JEVENTS_ARCH and JEVENTS_MODEL
+# Setup the JEVENTS_ARCH, JEVENTS_MODEL and JEVENTS_COMPRESS
 ifeq ($(JEVENTS_ARCH),)
 JEVENTS_ARCH=$(SRCARCH)
 endif
-JEVENTS_MODEL ?= all
+ifeq ($(JEVENTS_MODEL),)
+JEVENTS_MODEL=all
+endif
+
+JEVENTS_COMPRESS_AVAIL :=
+ifeq ($(CONFIG_ZSTD),y)
+JEVENTS_COMPRESS_AVAIL += zstd
+endif
+ifeq ($(CONFIG_ZLIB),y)
+JEVENTS_COMPRESS_AVAIL += zlib
+endif
+ifeq ($(CONFIG_LZMA),y)
+JEVENTS_COMPRESS_AVAIL += lzma
+endif
+JEVENTS_COMPRESS_AVAIL += none
+
+ifeq ($(JEVENTS_COMPRESS),)
+JEVENTS_COMPRESS := $(subst $(space),$(comma),$(strip $(JEVENTS_COMPRESS_AVAIL)))
+endif
+
+JEVENTS_COMPRESS_ACTIVE := $(filter $(JEVENTS_COMPRESS_AVAIL),$(subst $(comma),$(space),$(JEVENTS_COMPRESS)))
+ifeq ($(JEVENTS_COMPRESS_ACTIVE),)
+$(error JEVENTS_COMPRESS='$(JEVENTS_COMPRESS)' requires libraries not enabled in this build (available: $(strip $(JEVENTS_COMPRESS_AVAIL))))
+endif
+JEVENTS_COMPRESS_ARG := $(subst $(space),$(comma),$(strip $(JEVENTS_COMPRESS_ACTIVE)))
+JEVENTS_FLAGS_STR := $(NO_JEVENTS):$(JEVENTS_ARCH):$(JEVENTS_MODEL):$(JEVENTS_COMPRESS_ARG)
 
 # The input json/csv files
 SRC_DIR		:= pmu-events/arch
@@ -181,7 +210,7 @@ $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
 
 
 # Dependencies for jevents.py
-JEVENTS_DEPS := $(OUT_JSON) $(GEN_JSON) $(JEVENTS_PY) $(METRIC_PY) $(EMPTY_PMU_EVENTS_TEST_LOG) $(METRIC_TEST_LOG)
+JEVENTS_DEPS := $(OUT_JSON) $(GEN_JSON) $(JEVENTS_PY) $(METRIC_PY) $(EMPTY_PMU_EVENTS_TEST_LOG) $(METRIC_TEST_LOG) $(JEVENTS_FLAGS_FILE)
 
 # If there are orphaned files remove them.
 ifneq ($(strip $(ORPHAN_FILES)),)
@@ -204,14 +233,20 @@ endif
 # and inputs are dependencies.
 $(PMU_EVENTS_C): $(JEVENTS_DEPS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) \
-            $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) --compress=$(JEVENTS_COMPRESS_ARG) \
+            $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
 
 $(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
 	@:
 
 endif # ifeq ($(NO_JEVENTS),1)
 
+$(JEVENTS_FLAGS_FILE): FORCE
+	$(call rule_mkdir)
+	@if [ "$$(cat $@ 2>/dev/null)" != "$(JEVENTS_FLAGS_STR)" ]; then \
+		printf '%s' "$(JEVENTS_FLAGS_STR)" > $@; \
+	fi
+
 ifneq ($(NO_JEVENTS),1)
   PY_TESTS := $(wildcard pmu-events/*.py)
 else
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 7524de522802..5a04f67257ac 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -77,6 +77,7 @@ make_clang_nondistro := CC=clang BUILD_NONDISTRO=1
 make_extra_tests    := EXTRA_TESTS=1
 make_no_jevents     := NO_JEVENTS=1
 make_jevents_all    := JEVENTS_ARCH=all
+make_jevents_compress_none := JEVENTS_COMPRESS=none
 make_no_bpf_skel    := BUILD_BPF_SKEL=0
 make_gen_vmlinux_h  := GEN_VMLINUX_H=1
 make_no_python_module := NO_PYTHON_MODULE=1
@@ -172,6 +173,7 @@ endif
 run += make_extra_tests
 run += make_no_jevents
 run += make_jevents_all
+run += make_jevents_compress_none
 run += make_no_bpf_skel
 run += make_gen_vmlinux_h
 run += make_no_python_module
-- 
2.56.1.703.gf848ed807c-goog

