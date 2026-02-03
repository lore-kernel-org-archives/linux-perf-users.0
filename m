Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297C3AE6F3
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137009; cv=none; b=GN9aWTWbUyakiwcvq47mQhEJSHUNByp7ClSHjiE7IsdxrKTMgu5WcxOHqv4C9+TCUuOAS8YXcOXqhlOJhzire/u5yTRDlXhre7d6HrhdhYGIKXiB7yMpbWlRjC+nINarKKFsw0WzOivjQO2YxIgXSAQsVYGnAmGF4w2Hm6sr4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137009; c=relaxed/simple;
	bh=RLNKVlOKkJzLUwlafheA7IQSgz5Ovz2beJezIXGEgvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ivO+x8XnJ+RxyTD5xubF3zQWge75kQnDssUvnYncpCx83OMCPgH1Pk7ywulrVDp/OhqLBeixwhkIqtRCGW/pV2g0jL+AcDmMNznURkqNFKX7uCO8D2BAlzE9VOEu3EZndSCQIojkLTmpvCBNUZ31vJwpa0IKryFjuJKe67OJL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngje2d9B; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngje2d9B"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1233b91de6bso10081901c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 08:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770137007; x=1770741807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/T78ZFqCfcedKy0u/Cx/4LqedC1ptLGKw16Vm5zbBA=;
        b=ngje2d9Bt9aLslikKvL9QZztzHG3Z9VvjZh+fRV38Oz0MfLW/9EtPgxBR/W9AgNvzi
         h7qJDRMxwSiD0Gg3LxNTb2J3v3Ycl5h4udBbCDXNPlazswP2PMa1eKIcvjpIMdEKJDmD
         x27AuOVxlu9O3tkKXMOInQAAAyDhCITQYkIIOj2nMaCfX1XStPD08bt3lEFBpAAjXu4p
         AIfc1jtZvfpR1xtbeSVECqV1xKi7VjP/XTt9hGzi85+nm7yaE8uhqM9uiVU20TtKtuKz
         gCHK+5RX6ipKamqmL1xdukEr168Q6BsQXznuzSJ3jvnmw/tieXV4CN6vvcc0uFlh/o4N
         8A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770137007; x=1770741807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/T78ZFqCfcedKy0u/Cx/4LqedC1ptLGKw16Vm5zbBA=;
        b=uGhmXr71DAH7+Rx9TNxscfHkkeQFtfPKzrdSUbqGjcBuImvccm6TDYR8hD7S7qgoJI
         Js0MvUZ2vNRN+VjDqI7HtxgOeRqNaIU3LsswJ90hhzQpmCij9Rszs38MCeX6I5XjpBIx
         88+ds4BRpPfE0BlFoa0vpi8S1CV55Wfs6MrkFzIbcSVhIkB+BJeCPKFadd0JndR9u/gB
         i7dHJZzKmq3HcQ6pGocgew8Y8Z1gepC/l4BWae/GEQZEJGJka49OGfEGsLCKesUZtwwQ
         nOZ16roOuOjn2G0h2jh+37opxc7iE3KN49fYozxp3FIIchK2LLdzx6QhOAdeOCkVIX8N
         EvyA==
X-Forwarded-Encrypted: i=1; AJvYcCVQKxO53YVih1JsvlNItkYK4i/KCoZdg3Wx6FAflv08edlWWKl3v90eAG0UHrjK/z8Sax0gCg2xuxospgxZw3oL@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMKYK9ZZeus8fHIGGpx5IY6pzK50VLGOh1AuG8iaXK47cPdnV
	juJj/Rs50mrwQSnuECcg1XM+PfzjvSjg/jjZ4+NepTOEjdYlLXejqKy7qpou1T0V3cTwtyWOCvL
	dIWjDOhLdOw==
X-Received: from dlbut9.prod.google.com ([2002:a05:7022:7e09:b0:124:a00b:6685])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b15:b0:11b:9386:8255
 with SMTP id a92af1059eb24-126f48d7a26mr10578c88.42.1770137006526; Tue, 03
 Feb 2026 08:43:26 -0800 (PST)
Date: Tue,  3 Feb 2026 08:43:23 -0800
In-Reply-To: <aYILIOanehkzQx0M@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYILIOanehkzQx0M@x1>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203164323.3447826-1-irogers@google.com>
Subject: [PATCH v2] perf build: Reduce pmu-events related copying and mkdirs
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When building to an output directory the previous code would remove
files and then copy the source files over. Each source file copy would
have a rule to make its directory. All json for every architecture was
considered a source file. This led to unnecessary copying as a file
would be deleted and then the same file copied again, unnecessary
directory making, and copying of files not used in the build. A
side-effect would be a lot of build messages.

This change makes it so that all computed output files are created and
then compared to all files in the OUTPUT directory. By filtering out
the files that would be copied, unnecessary files can be determined
and then deleted - note, this is a phony target which would remake the
pmu-events.c if always depended upon, and so the dependency is
conditional on there being files to remove. This has some overhead as
the $(OUTPUT)/pmu-events is "find" over rather than just "rm -fr", but
the savings from unnecessary copying, etc. should make up for this new
make overhead. The copy target just does copying but has a dependency
on the directory it needs being built, avoiding repetitive mkdirs. The
source files for copying only consider the JEVENTS_ARCH unless the
JEVENTS_ARCH is all. The metric json is only generated if appropriate,
rather than always being generated and jevents.py deciding whether or
not to use the files. The mypy and pylint targets are fixed as
variable names had changed but the rules not updated.

The line count of a build with "make -C tools/perf O=/tmp/perf clean all"
prior to this change was 2181 lines, after this change it is 1596
lines. This is a reduction of 585 lines or about 27%.

The generated pmu-events.c for JEVENTS_ARCH "x86" and "all" were
validated as being identical after this change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Avoid creating a COPY_RULE for a file that is in GEN_JSON,
    something that happens if builds aren't cleaned up, as described
    in a reply to the v1 patch:
    https://lore.kernel.org/lkml/20260203051327.2836070-1-irogers@google.com/
---
 tools/perf/pmu-events/Build | 217 +++++++++++++++++++++++++-----------
 1 file changed, 149 insertions(+), 68 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index ec964ed05974..63c65788d442 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,63 +1,61 @@
-pmu-events-y	+= pmu-events.o
-JSON		=  $(shell find pmu-events/arch -name '*.json' -o -name '*.csv')
-JSON_DIRS	=  $(shell find pmu-events/arch -type d)
-JDIR_TEST	=  pmu-events/arch/test
-JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
-			find $(JDIR_TEST) -name '*.json')
-JEVENTS_PY	=  pmu-events/jevents.py
-METRIC_PY	=  pmu-events/metric.py
-METRIC_TEST_PY	=  pmu-events/metric_test.py
 EMPTY_PMU_EVENTS_C = pmu-events/empty-pmu-events.c
+# pmu-events.c will be generated by jevents.py or copied from EMPTY_PMU_EVENTS_C
 PMU_EVENTS_C	=  $(OUTPUT)pmu-events/pmu-events.c
-METRIC_TEST_LOG	=  $(OUTPUT)pmu-events/metric_test.log
-TEST_EMPTY_PMU_EVENTS_C = $(OUTPUT)pmu-events/test-empty-pmu-events.c
-EMPTY_PMU_EVENTS_TEST_LOG = $(OUTPUT)pmu-events/empty-pmu-events.log
-LEGACY_CACHE_PY	=  pmu-events/make_legacy_cache.py
-LEGACY_CACHE_JSON = $(OUTPUT)pmu-events/arch/common/common/legacy-cache.json
+pmu-events-y	+= pmu-events.o
 
-ifeq ($(JEVENTS_ARCH),)
-JEVENTS_ARCH=$(SRCARCH)
-endif
-JEVENTS_MODEL ?= all
+# pmu-events.c file is generated in the OUTPUT directory so it needs a
+# separate rule to depend on it properly
+$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
 
-#
-# Locate/process JSON files in pmu-events/arch/
-# directory and create tables in pmu-events.c.
-#
+# Message for $(call echo-cmd,cp), possibly remove the src file from
+# the destination to save space in the build log.
+quiet_cmd_cp   = COPY    $(patsubst %$<,%,$@) <- $<
 
+# --- NO_JEVENTS=1 build ---
 ifeq ($(NO_JEVENTS),1)
 $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)cp $< $@
+	$(Q)$(call echo-cmd,cp)cp $< $@
 else
-# Functions to extract the model from a extra-metrics.json or extra-metricgroups.json path.
-model_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/extra-metric.*\.json@\1@')
-vendor_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/[^/]*/extra-metric.*\.json@\1@')
+# --- Regular build ---
 
-# Copy checked-in json to OUTPUT for generation if it's an out of source build
-ifneq ($(OUTPUT),)
-# Remove all output directories when any source directory timestamp changes
-# so there are no stale deleted files
-JSON_DIRS_ROOT = $(OUTPUT)pmu-events/arch/
-$(JSON_DIRS_ROOT): $(JSON_DIRS)
-	$(Q)$(call echo-cmd,gen)rm -rf $@
-	$(Q)mkdir -p $@
+# Setup the JEVENTS_ARCH and JEVENTS_MODEL
+ifeq ($(JEVENTS_ARCH),)
+JEVENTS_ARCH=$(SRCARCH)
+endif
+JEVENTS_MODEL ?= all
 
-$(OUTPUT)pmu-events/arch/%: pmu-events/arch/% $(JSON_DIRS_ROOT)
-	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)cp $< $@
+# The input json/csv files
+SRC_DIR		:= pmu-events/arch
+ifeq ($(JEVENTS_ARCH),all)
+SRC_JSON	:= $(shell find $(SRC_DIR) -name '*.json' -o -name '*.csv')
+else
+SRC_JSON	:= $(shell find $(SRC_DIR)/common $(SRC_DIR)/test $(SRC_DIR)/$(JEVENTS_ARCH) -name '*.json' -o -name '*.csv')
 endif
 
-$(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY) $(JSON_DIRS_ROOT)
+# Python to build the generic legacy cache events
+LEGACY_CACHE_PY	=  pmu-events/make_legacy_cache.py
+LEGACY_CACHE_JSON = $(OUTPUT)pmu-events/arch/common/common/legacy-cache.json
+GEN_JSON = $(LEGACY_CACHE_JSON)
+
+$(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
 
+# Python to generate architectural metrics
 GEN_METRIC_DEPS := pmu-events/metric.py pmu-events/common_metrics.py
+# Functions to extract the model from an extra-metrics.json or extra-metricgroups.json path.
+model_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/extra-metric.*\.json@\1@')
+vendor_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/[^/]*/extra-metric.*\.json@\1@')
 
+ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
 # Generate AMD Json
 ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
 ZEN_METRICS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metrics.json)
 ZEN_METRICGROUPS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metricgroups.json)
+GEN_JSON += $(ZEN_METRICS) $(ZEN_METRICGROUPS)
 
 $(ZEN_METRICS): pmu-events/amd_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
@@ -67,10 +65,14 @@ $(ZEN_METRICGROUPS): pmu-events/amd_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) pmu-events/arch > $@
 
+endif
+
+ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),arm64 all))
 # Generate ARM Json
 ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*|grep -v cmn)
 ARM_METRICS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metrics.json)
 ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
+GEN_JSON += $(ARM_METRICS) $(ARM_METRICGROUPS)
 
 $(ARM_METRICS): pmu-events/arm64_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
@@ -80,10 +82,14 @@ $(ARM_METRICGROUPS): pmu-events/arm64_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call vendor_name,$@) $(call model_name,$@) pmu-events/arch > $@
 
+endif
+
+ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
 # Generate Intel Json
 INTELS = $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
 INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
 INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
+GEN_JSON += $(INTEL_METRICS) $(INTEL_METRICGROUPS)
 
 $(INTEL_METRICS): pmu-events/intel_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
@@ -93,18 +99,69 @@ $(INTEL_METRICGROUPS): pmu-events/intel_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) pmu-events/arch > $@
 
-GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) \
-            $(LEGACY_CACHE_JSON) \
-            $(JSON_DIRS) \
-            $(ZEN_METRICS) $(ZEN_METRICGROUPS) \
-            $(ARM_METRICS) $(ARM_METRICGROUPS) \
-            $(INTEL_METRICS) $(INTEL_METRICGROUPS)
+endif
+
+OUT_DIR		:= $(OUTPUT)pmu-events/arch
+
+ifeq ($(OUTPUT),)
+OUT_JSON	:= $(SRC_JSON)
+ORPHAN_FILES	:=
+else
+# Things that need to be built in the OUTPUT directory. Note, ensure
+# there is a slash after the directory name so that it matches what
+# $(dir) gives in COPY_RULE.
+OUT_JSON	:= $(patsubst $(SRC_DIR)/%,$(OUT_DIR)/%,$(SRC_JSON))
+OUT_DIRS	:= $(sort $(patsubst %/,%,$(dir $(OUT_JSON))))
+
+# Things already in the OUTPUT directory
+CUR_OUT_JSON	:= $(shell [ -d $(OUT_DIR) ] && find $(OUT_DIR) -type f)
+
+# Things in the OUTPUT directory but shouldn't be there as computed by
+# OUT_JSON and GEN_JSON.
+ORPHAN_FILES	:= $(filter-out $(OUT_JSON) $(GEN_JSON),$(CUR_OUT_JSON))
+
+# Message for $(call echo-cmd,mkd). There is already a mkdir message
+# but it assumes $@ is a file to mkdir the directory for.
+quiet_cmd_mkd  = MKDIR   $@
+
+$(OUT_DIRS):
+	$(Q)$(call echo-cmd,mkd)mkdir -p $@
+
+# Explicitly generate rules to copy SRC_JSON files as $(dir) cannot
+# apply to $@ in a dependency. Exclude from the copy rules any that
+# look like they are copying generated json. This happens as a perf
+# build within the tools/perf directory will leave generated json
+# files within the tree, these then get picked up by SRC_JSON find.
+define COPY_RULE
+$(2): $(1) | $(3)
+	$$(Q)$$(call echo-cmd,cp)cp $(1) $(2)
+endef
+$(foreach src,$(SRC_JSON), \
+    $(eval dest := $(patsubst $(SRC_DIR)/%,$(OUT_DIR)/%,$(src))) \
+    $(eval ddir := $(patsubst %/,%,$(dir $(dest)))) \
+    $(if $(filter $(dest),$(GEN_JSON)),, \
+        $(eval $(call COPY_RULE,$(src),$(dest),$(ddir))) \
+    ) \
+)
+
+endif # ifneq ($(OUTPUT),)
+
+JEVENTS_PY	=  pmu-events/jevents.py
+METRIC_PY	=  pmu-events/metric.py
+
+# Rule to run the metric test.
+METRIC_TEST_PY	=  pmu-events/metric_test.py
+METRIC_TEST_LOG	=  $(OUTPUT)pmu-events/metric_test.log
 
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
 
-$(TEST_EMPTY_PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
+# Rule to create then ensure the empty-pmu-events.c is in sync.
+TEST_EMPTY_PMU_EVENTS_C = $(OUTPUT)pmu-events/test-empty-pmu-events.c
+EMPTY_PMU_EVENTS_TEST_LOG = $(OUTPUT)pmu-events/empty-pmu-events.log
+
+$(TEST_EMPTY_PMU_EVENTS_C): $(OUT_JSON) $(GEN_JSON) $(JEVENTS_PY) $(METRIC_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none $(OUTPUT)pmu-events/arch $@
 
@@ -112,36 +169,60 @@ $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)diff -u $^ 2> $@ || (cat $@ && false)
 
+
+# Dependencies for jevents.py
+JEVENTS_DEPS := $(OUT_JSON) $(GEN_JSON) $(JEVENTS_PY) $(METRIC_PY) $(EMPTY_PMU_EVENTS_TEST_LOG) $(METRIC_TEST_LOG)
+
+# Rules to run mypy if enabled.
 ifdef MYPY
-  PMU_EVENTS_PY_TESTS := $(wildcard *.py)
-  PMU_EVENTS_MYPY_TEST_LOGS := $(JEVENTS_PY_TESTS:%=%.mypy_log)
-else
-  PMU_EVENTS_MYPY_TEST_LOGS :=
+define MYPY_RULE
+$(2): $(1)
+	$$(Q)$$(call echo-cmd,test)mypy $(1) > $(2) || (cat $(2) && rm $(2) && false)
+endef
+$(foreach src,$(wildcard pmu-events/*.py), \
+    $(eval dest := $(patsubst pmu-events/%,$(OUTPUT)pmu-events/%.mypy_log,$(src))) \
+    $(eval $(call MYPY_RULE,$(src),$(dest))) \
+)
+
+MYPY_INPUTS := $(wildcard pmu-events/*.py)
+MYPY_OUTPUTS := $(patsubst pmu-events/%,$(OUTPUT)pmu-events/%.mypy_log,$(MYPY_INPUTS))
+JEVENTS_DEPS += $(MYPY_OUTPUTS)
 endif
 
-$(OUTPUT)%.mypy_log: %
-	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
-
+# Rules to run pylint if enabled.
 ifdef PYLINT
-  PMU_EVENTS_PY_TESTS := $(wildcard *.py)
-  PMU_EVENTS_PYLINT_TEST_LOGS := $(JEVENTS_PY_TESTS:%=%.pylint_log)
-else
-  PMU_EVENTS_PYLINT_TEST_LOGS :=
+define PYLINT_RULE
+$(2): $(1)
+	$$(Q)$$(call echo-cmd,test)pylint $(1) > $(2) || (cat $(2) && rm $(2) && false)
+endef
+$(foreach src,$(wildcard pmu-events/*.py), \
+    $(eval dest := $(patsubst pmu-events/%,$(OUTPUT)pmu-events/%.pylint_log,$(src))) \
+    $(eval $(call PYLINT_RULE,$(src),$(dest))) \
+)
+
+PYLINT_INPUTS := $(wildcard pmu-events/*.py)
+PYLINT_OUTPUTS := $(patsubst pmu-events/%,$(OUTPUT)pmu-events/%.pylint_log,$(PYLINT_INPUTS))
+JEVENTS_DEPS += $(PYLINT_OUTPUTS)
 endif
 
-$(OUTPUT)%.pylint_log: %
-	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+# If there are orphaned files remove them.
+ifneq ($(strip $(ORPHAN_FILES)),)
+.PHONY: prune_orphans
 
-$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
-    $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PMU_EVENTS_PYLINT_TEST_LOGS)
-	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
+# Message for $(call echo-cmd,rm). Generally cleaning files isn't part
+# of a build step.
+quiet_cmd_rm  = RM      $^
+
+prune_orphans: $(ORPHAN_FILES)
+	$(Q)$(call echo-cmd,rm)rm -f $^
+
+JEVENTS_DEPS += prune_orphans
 endif
 
-# pmu-events.c file is generated in the OUTPUT directory so it needs a
-# separate rule to depend on it properly
-$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
+# Finally, the rule to build pmu-events.c using jevents.py. All test
+# and inputs are dependencies.
+$(PMU_EVENTS_C): $(JEVENTS_DEPS)
 	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUT_DIR) $@
+
+endif # ifeq ($(NO_JEVENTS),1)
-- 
2.53.0.rc1.225.gd81095ad13-goog

