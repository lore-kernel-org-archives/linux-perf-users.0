Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AD74418
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143025; cv=none; b=U5RBianz1MoF9Rs6PiAQABDHIdDwnC85GePoPhYm564mHFgctj1kSnNdK00VmxTKVG6xMKCxY1aLja0bum9YG9tRpsTafe9L1G+U2jIOf02KrH2Q4bSDcMPyRFqFna5Fg3aiLtCBkphBhGjxFKG6VON1vAnc83aD/w4T0zW/yuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143025; c=relaxed/simple;
	bh=NSu422446Xoc5zOhUBvYe9tHlRZVGRf9I7BLLIUpgeE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QtL9yG9ccVTcxlj7jPLVYKFIRql0djMRJf3eZR9jcqeE9GwMkf8YqX2dPXN/hzovZwcSXKymu5b+/ikQH/rVhPibk+0f9IUjzZQpGxFoCkwKSWEjrF05cJpUew8BbFdqfKCtFy7sOzVIvGesJ3ZuB4v0MWrmQJZRHJ0TD/SDigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xRTatDiK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xRTatDiK"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so106479276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143022; x=1709747822; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+5JcwzWXYPI3Y1eGyU5MCULUVPOFuil2ShWagn8k+c=;
        b=xRTatDiKwafaGcTGZwj6nxOzvoJEZeCcKuU75DWg0P8+69sn/P29JUiukg4DHjNwDF
         RP2+ojZHJQsKvEt/MGnG98qRdLfI9DmynK19sK6SgCJfjKFb0P1tCkSqM9OmhooAm0ZI
         RRXlwF0J1Jue5WWRKXdzC47qaFlGi+52VDT3DGolFkDpBcCL/1FP+6TnLCksGpavz5Y7
         Z24jmD6M38V/gCqrQsE+GTQufHu7MtmZVL/ULkgv6URhIs1ik3sDZCskm/qruHmznIh0
         BOCaAtxMTL+8zX/lzIjt9UE86uPDxc31EB2iFGC7ZjvAkKPZr1LgfJflWi+7+apcdeix
         71TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143022; x=1709747822;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+5JcwzWXYPI3Y1eGyU5MCULUVPOFuil2ShWagn8k+c=;
        b=F/sD6cGXtxvrQ3H5V1fascdBnww2L952u7I1GOuQ94Gk1Ws3glI5iahFjJiWDBaSMs
         Xp6NyemZLHEtGftks1QkpMXK1K6ODEQnvmR4JsP/7HoRD3WxNgsP9fPytrQGf1AGjjfu
         zC1CyV7FboQ5Z88C/lvKBLKI56uiemIz2ESX36QjUhT9nnLyAGVfISdj6p2bo9wgZart
         WERS2ok2i5+ND+Qi53nFPYiJDh+eMyt3X/mwKDxX52ynGKhb6JbW3jtEKtzynqUFDWnY
         1PirznCgbycOQvMLJOztenyDazRne8sFRlU1u7lXZxZhwsWAWOPjwfOh1eSBQKmaWt6V
         xJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4FeoDL2XIc9qa1BPwu6P+ZnXQ0CeAtTfzCThaRJ4Qom1vifi1U7O+zaDxd1abo7XGV0Y8/Y1gihkWz5KCFI5j1GvivefPRUZjANBk0rFS4w==
X-Gm-Message-State: AOJu0Yx2zMvDRtw2jsgt83yVonmJbnCAJW0WDBGJ96Nl0DhyMYDdYfVj
	4qG73VsLBKTDlTcXhSr2aTp2az1sGsuN/haoUvxc90hjzPAsFcOfAJO91fY3Q36geYdGxcxw3MD
	CkVzdwQ==
X-Google-Smtp-Source: AGHT+IHddQbOs/CuXBa0QH2tHevFFlJWx0m2l8GDAf4etv/Q0cMRDWV9A4FXIiKW/5bJ//PfT9e0dM1Rc2AH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a25:fc24:0:b0:dcd:ad52:6932 with SMTP id
 v36-20020a25fc24000000b00dcdad526932mr2949ybd.5.1709143022676; Wed, 28 Feb
 2024 09:57:02 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:16 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 11/12] perf jevents: Build support for generating metrics
 from python
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate extra-metrics.json and extra-metricgroups.json from python
architecture specific scripts. The metrics themselves will be added in
later patches.

If a build takes place in tools/perf/ then extra-metrics.json and
extra-metricgroups.json are generated in that directory and so added
to .gitignore. If there is an OUTPUT directory then the
tools/perf/pmu-events/arch files are copied to it so the generated
extra-metrics.json and extra-metricgroups.json can be added/generated
there.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore                  |  2 +
 tools/perf/Makefile.perf               | 17 ++++++--
 tools/perf/pmu-events/Build            | 60 ++++++++++++++++++++++++--
 tools/perf/pmu-events/amd_metrics.py   | 17 ++++++++
 tools/perf/pmu-events/arm64_metrics.py | 18 ++++++++
 tools/perf/pmu-events/intel_metrics.py | 17 ++++++++
 6 files changed, 124 insertions(+), 7 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f5b81d439387..c9a8da5bfc56 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,6 +39,8 @@ trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
 pmu-events/metric_test.log
+pmu-events/arch/**/extra-metrics.json
+pmu-events/arch/**/extra-metricgroups.json
 tests/shell/*.shellcheck_log
 tests/shell/coresight/*.shellcheck_log
 tests/shell/lib/*.shellcheck_log
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 86afdaad246f..88a7d7ef8269 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1177,7 +1177,20 @@ endif # CONFIG_PERF_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
-clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
+pmu-events-clean:
+ifeq ($(OUTPUT),)
+	$(call QUIET_CLEAN, pmu-events) $(RM) \
+		pmu-events/pmu-events.c \
+		pmu-events/metric_test.log
+	$(Q)find pmu-events/arch -name 'extra-metrics.json' -delete -o \
+		-name 'extra-metricgroups.json' -delete
+else
+	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
+		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)pmu-events/metric_test.log
+endif
+
+clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean pmu-events-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
@@ -1185,8 +1198,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
-		$(OUTPUT)pmu-events/pmu-events.c \
-		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(fsconfig_arrays) \
 		$(OUTPUT)$(fsmount_arrays) \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 1d18bb89402e..9af15e3498f1 100644
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
@@ -27,13 +26,66 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
+# Extract the model from a extra-metrics.json or extra-metricgroups.json path
+model_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/extra-metric.*\.json@\1@')
+vendor_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/[^/]*/extra-metric.*\.json@\1@')
+
+# Copy checked-in json for generation.
+$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)cp $< $@
+
+# Generate AMD Json
+ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
+ZEN_METRICS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metrics.json)
+ZEN_METRICGROUPS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(ZEN_METRICS): pmu-events/amd_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) > $@
+
+$(ZEN_METRICGROUPS): pmu-events/amd_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) > $@
+
+# Generate ARM Json
+ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*)
+ARM_METRICS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metrics.json)
+ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(ARM_METRICS): pmu-events/arm64_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call vendor_name,$@) $(call model_name,$@) > $@
+
+$(ARM_METRICGROUPS): pmu-events/arm64_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call vendor_name,$@) $(call model_name,$@) > $@
+
+# Generate Intel Json
+INTELS = $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
+INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
+INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(INTEL_METRICS): pmu-events/intel_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) > $@
+
+$(INTEL_METRICGROUPS): pmu-events/intel_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) > $@
+
+GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) \
+            $(ZEN_METRICS) $(ZEN_METRICGROUPS) \
+            $(ARM_METRICS) $(ARM_METRICGROUPS) \
+            $(INTEL_METRICS) $(INTEL_METRICGROUPS)
+
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
 
-$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
+$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
 endif
 
 # pmu-events.c file is generated in the OUTPUT directory so it needs a
diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
new file mode 100755
index 000000000000..cb850ab1ed13
--- /dev/null
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -0,0 +1,17 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+
+parser = argparse.ArgumentParser(description="AMD perf json generator")
+parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+parser.add_argument("model", help="e.g. amdzen[123]")
+args = parser.parse_args()
+
+all_metrics = MetricGroup("",[])
+
+if args.metricgroups:
+  print(JsonEncodeMetricGroupDescriptions(all_metrics))
+else:
+  print(JsonEncodeMetric(all_metrics))
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
new file mode 100755
index 000000000000..a54fa8aae2fa
--- /dev/null
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -0,0 +1,18 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+
+parser = argparse.ArgumentParser(description="ARM perf json generator")
+parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+parser.add_argument("vendor", help="e.g. arm")
+parser.add_argument("model", help="e.g. neoverse-n1")
+args = parser.parse_args()
+
+all_metrics = MetricGroup("",[])
+
+if args.metricgroups:
+  print(JsonEncodeMetricGroupDescriptions(all_metrics))
+else:
+  print(JsonEncodeMetric(all_metrics))
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
new file mode 100755
index 000000000000..8b67b9613ab5
--- /dev/null
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -0,0 +1,17 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+
+parser = argparse.ArgumentParser(description="Intel perf json generator")
+parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+parser.add_argument("model", help="e.g. skylakex")
+args = parser.parse_args()
+
+all_metrics = MetricGroup("",[])
+
+if args.metricgroups:
+  print(JsonEncodeMetricGroupDescriptions(all_metrics))
+else:
+  print(JsonEncodeMetric(all_metrics))
-- 
2.44.0.278.ge034bb2e1d-goog

