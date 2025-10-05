Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34A1D7E26
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688688; cv=none; b=toNb3VSj6wd2P57Wn7/VYctP8L3iesCf/oM8WdoFK7G1hfjz0hVb/rxY2JlYd68BH4E4c4/2cBrgeyCQ6fNsqOE+G+9L7CibTGnGrKSL3m76YzOPTIiYnEFUDktSmrGQ1pyNT7CYUMyzy/XrN8NhMTJEFAr8lNoHkjldvuyOAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688688; c=relaxed/simple;
	bh=YJcbwlUnLwSEu2r1Xs8yydLd43nrRab7kjZwGZjEA4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=agywgN9KpuekvXBf9ykwlx63WKFPrHQY0OOaX2Y5gIX484LOmcDLWCnB6D8Y+M1oQ4p5tEz2uL9cohiYu2px0Fx17iAal6TB60pBSBENkK8IfGdhZTtBtkF7Gxphsk9b34XLYVML4rYszfD3Ch4rXdaV45JNyNRG/vUSGwK7k6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vB+D5Or9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vB+D5Or9"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28eb14e3cafso16443625ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688686; x=1760293486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjwIRAj1PCOtnR8/KOpOx4ce8ZskGIY1sKqUf7sn5Ns=;
        b=vB+D5Or9a912TF/Hh7VuKvjhNBUXKFFY2q7MIoOqyChsUyKmEPOuXsnkJ6C5tbK/YP
         4gxlXcnWtRQ9Rsi8shCpzBx3ocAfIw1ZM8LBE+x/bX2g9/l2Qw1bxWfmzuGRnFWbn1UZ
         JnstM9t+fYi0wscEAv0+4s0vn2MERwsWyVrKvZlpglgf33gZAVXLjAE1jk9UXHXTrmxr
         4GC+ItOp/j1G86idSadYkfeY1OSeTHs05WmMF0adoswL8h6lpIZ43JJ3RLZAn7bUGqR4
         7ZTxhwxZWNoNLat7vjPR/+9s48FPvN/v9UJ5sjjWII2m/9HYOFOqaGUZ8aOa0sZKfYHU
         YHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688686; x=1760293486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjwIRAj1PCOtnR8/KOpOx4ce8ZskGIY1sKqUf7sn5Ns=;
        b=B16btsal5j+0OfCAMxny0RRgtBReRS7hrstOa+h7IEUud6bgnotG+W25sNEwH72890
         KLwWO5G+Jz0oSUxXGoBjkUA40aHqIkPDrtrImY3A6o1i6D8+iIgi4Eg0oScv4lVnIxfE
         P2cIloewnZBSsKODkIA0XA2n4dYXbnRkW+iuV8WbQ+R7zDaoPwaPKdpOB59BVmz7m3PM
         c3ryiBV4hBJypychs/RS/5Wd433eqEm9kLKEOzBl2ex2px66l1Cf1QgTQ7r3jT9UFeOx
         m0XNhq5WdRgaHiZsmTVdhUA5IqZbCqx8Xi/Fye3OYQUUSI9Zv3VL14YRkS1KwAKgy3mi
         6pGA==
X-Forwarded-Encrypted: i=1; AJvYcCVSvt7OQy76qBSfB6v/C1c77js/3gb6tnfv+isP90X12lHhyD7bMpEtoTM3hLyofSxDGaQ5PFpDwbqAzuXb/DWT@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZ1585h9Cv1gaKDApW3iBgwbBbv2gFkUUwVY1Yhh5JEyP2Qu3
	fkM/vIRgye/Xj8Wwy2aJAZwtrVEwrqgCR9RHtZQSH1LSO52Idov04k1qtkJVvYW9mtcFB/peA88
	9oJ8mG21vaQ==
X-Google-Smtp-Source: AGHT+IHgcezueOBMHItWAmOm58CIqtTz0kUkh8HZr7XTD3GbjVSsowuIuFYGHRYJm04nyLd/Ugj+wCDf6M2x
X-Received: from plsp11.prod.google.com ([2002:a17:902:bd0b:b0:269:a7b6:c668])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b46:b0:26a:23c7:68da
 with SMTP id d9443c01a7336-28e9a5bf107mr129724525ad.25.1759688685774; Sun, 05
 Oct 2025 11:24:45 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:08 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-6-irogers@google.com>
Subject: [PATCH v7 05/27] perf jevents: Support copying the source json files
 to OUTPUT
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
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

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf    | 21 ++++++++++++++++-----
 tools/perf/pmu-events/Build | 18 ++++++++++++------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7d6ac03a7109..278e51e4b5c6 100644
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
2.51.0.618.g983fd99d29-goog

