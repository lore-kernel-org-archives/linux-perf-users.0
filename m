Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C72E1C78
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414804; cv=none; b=mnz6nD6KKHQ1ao6udIp9lliB5WIEv6INUwVr7lwqzAGJ2btBQhKXnVEi2tTos29TfVbziqCPm99YUB6sDggEyXb/5i3b3QYdivIk07N9xyCd6RwJM2xg+wiQ0UjQAIs1bnPy8tFBJ93ip3NLAyN8iFX6ho77QqBl6gcjVNMkVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414804; c=relaxed/simple;
	bh=+HAnbdKBBqj6TtyyeamW8KehhbEz5Je2LadZ/axysQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YsZ6LZxGuZ5O4oaVBeTPJx8o4/J8gA3oqxIAIkB+wbg1xHiF2azIX02wUbuXSPcCpUsOTiAc7fkglPjjEeQeZ4r1cyDXTvc4H7IXz9LJP51NzXenN0CkepuGopQNh6lFWjnK3kqYS4UUfTsP6RwCj5HTKF+nUQmF0lcyu3aw6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bp+04Vkk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bp+04Vkk"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248f7745075so8257955ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 14:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414801; x=1757019601; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XH4+0uX/I/txm4lEtgm6/TOUthuHMUrkrgBJwwFQ9BQ=;
        b=Bp+04Vkkw7l0v2AUMvDnAkqo00nUJ/GTEOBT/ZUa27+Haon0HB1m7354UVyNHz6bOc
         /Bael9ZZaZdgLWIKzDwXotbOTVz1WFo9deYkhDDVOj9WefmdpvHtB7SS94zzyDmBLZFu
         +CLEEgJpoxjqBpsC1eUpr5vGMRYnXIgUNOJ13WhPccJVDg10BMetLf316pkHm5ScQoDE
         sFUBQJhVvemxwMOG4UxsjWjZSSZkbxSwLql5UCKUH2ItmFcQ78enfG36jxs7waUbi6Y5
         AN93kipJzjyJsVqINPEC3/3s2vtr5IxPeHNSFL4VDQ+6yddWu7b6DECJFlBIXsOHUzxQ
         Y8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414801; x=1757019601;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XH4+0uX/I/txm4lEtgm6/TOUthuHMUrkrgBJwwFQ9BQ=;
        b=h4/Pbh6zgELQBhqSPejQ28d6atBYysLjqa34RsA/CSRrHn0+byeODQ7knPQ6h1rxA8
         eKFEtpQbErXgnPY80as5dc5sXzygNe74phBckY/1ESm8JVp8P+hRsNlZWHieEKlnV+jh
         ZleBV5W5Hi4RGz2UvijvK6RwoHLkK5b+KaepPwlfXxkGb4NpWBB+xVg9JAlMNLZO4ztO
         jHYTTEGV14FckvUrRutn9/dJN/24RwXisjW3WhYyNX+5Q0pYUTxaDeiyvK2gWZ49ueY9
         6dsAM5tV2YJypENS3nsPj2ci8gemb3bx/7lx9ME4fVEnQ34xMd7p5zyg2GrLK66AdhrM
         Dygw==
X-Forwarded-Encrypted: i=1; AJvYcCUV5a8pEu5FHiGTlT0ZMDaIZTWXrmcYL1ZFVg20Dv0wvN5o/Bmrs1DVYIvcWoh6FH7bVOmGv9LHqntCrVsyiqwa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy452aDOua3Pf9mr1gWkZW22e9mau/MztelU/4WAP1B8Y/BI7gf
	BlK3H6L/W60xWlC7Y+cR5l/RpMlgRs9rYgLsI303pI8Z577ric2xYN7LgrTQ0QDubAsmj/oFJu1
	9vnQYCi+rfw==
X-Google-Smtp-Source: AGHT+IHeYx8XcZQ27r9OjXn6WiGze/oG/NP+C+yiWS/fUsuw4G5xb5UttD5KpVdv/9uCFphKupje26GFSpk5
X-Received: from pjbhl14.prod.google.com ([2002:a17:90b:134e:b0:327:7322:3ac0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4d2:b0:248:9964:3796
 with SMTP id d9443c01a7336-24899643b24mr103809225ad.43.1756414800696; Thu, 28
 Aug 2025 14:00:00 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:19 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-5-irogers@google.com>
Subject: [PATCH v3 04/15] perf jevents: Support copying the source json files
 to OUTPUT
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

The jevents command expects all json files to be organized under a
single directory. When generating json files from scripts (to reduce
laborious copy and paste in the json) we don't want to generate the
json into the source directory if there is an OUTPUT directory
specified. This change adds a GEN_JSON for this case where the
GEN_JSON copies the JSON files to OUTPUT, only when OUTPUT is
specified. The Makefile.perf clean code is updated to clean up this
directory when present.

This patch is part of:
https://lore.kernel.org/lkml/20240926173554.404411-12-irogers@google.com/
which was similarly adding support for generating json in scripts for
the consumption of jevents.py.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf    | 21 ++++++++++++++++-----
 tools/perf/pmu-events/Build | 18 ++++++++++++------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e2150acc2c13..cc1635335586 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1272,9 +1272,24 @@ endif # CONFIG_PERF_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
+pmu-events-clean:
+ifeq ($(OUTPUT),)
+	$(call QUIET_CLEAN, pmu-events) $(RM) \
+		pmu-events/pmu-events.c \
+		pmu-events/metric_test.log \
+		pmu-events/test-empty-pmu-events.c \
+		pmu-events/empty-pmu-events.log
+else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
+	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
+		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)pmu-events/metric_test.log \
+		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
+		$(OUTPUT)pmu-events/empty-pmu-events.log
+endif
+
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
 		arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
-		tests-coresight-targets-clean
+		tests-coresight-targets-clean pmu-events-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
 		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
@@ -1287,10 +1302,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
-		$(OUTPUT)pmu-events/pmu-events.c \
-		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
-		$(OUTPUT)pmu-events/empty-pmu-events.log \
-		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(fsconfig_arrays) \
 		$(OUTPUT)$(fsmount_arrays) \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 32f387d48908..1503a16e662a 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,6 @@
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
-JSON		=  $(shell [ -d $(JDIR) ] &&				\
-			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
+JSON		=  $(shell find pmu-events/arch -name *.json -o -name *.csv)
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
@@ -29,13 +28,20 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
+# Copy checked-in json for generation.
+$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)cp $< $@
+
+GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON))
+
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
 
-$(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
+$(TEST_EMPTY_PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none $(OUTPUT)pmu-events/arch $@
 
 $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
@@ -63,10 +69,10 @@ $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
 
-$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
+$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
     $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PMU_EVENTS_PYLINT_TEST_LOGS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
 endif
 
 # pmu-events.c file is generated in the OUTPUT directory so it needs a
-- 
2.51.0.318.gd7df087d1a-goog

