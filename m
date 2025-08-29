Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2725A2C7
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436873; cv=none; b=on80aVS5NahEjFvtEcxycM5aPj8fN/v9g//L/y3IzmX89SJ2cSIKqtbAYKzy7rlvvC3p3g73zT/UxlmVNuFWwS9YW6SwZjN0Y/Rpir5vVKs1V7BEciIeOuZdTonJt4bZJlCNcSF7NMhCmTDGA+ne52u8Vvo5C2rJPklVLHch2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436873; c=relaxed/simple;
	bh=FJ2GIBG1BsAUWQpMLjlonQ8xF0TkI0HYkC/wcGmiYkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a1Xjv2XdM8vbaiRASwaK08RmCjUEa6KHwFhMNCNFZHZJP66kAALdRrx+nII8VdlJUz0YodSIhIMgM4lILW1DZ7JU5hoZSoSxdIUiMMiBUZxBhvQLuWq73wDJ0vweJIIUO8gbXIiPbKmVojM/5Jg66l8TtQYGuec7g60Lx3Pchw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOLo0W5K; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOLo0W5K"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e4c3af5fso1751952a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436871; x=1757041671; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdHUScYT7W2VGRMgw68PcJ7pKiSlfY+0dw+HmuAdspg=;
        b=GOLo0W5Kd1crfouTzg6htZZVdqQjta/Q1vHBDAX4m2aY6+kYd22EuKQ6UaQMg7U4NA
         yr0xzfeK4MO2mfgtXfZWYBSNW4zuYYhSate1UWm5dbro8guIWNYLJeuD98RPuxcT0hSM
         m/2pW6w1+AgUR43iqMq7Po8f2BKQbr4dDc15F39wXabtd/jHNrIeBEvkoOZpLcY4mTWh
         YSWC2Lsd8jgnzj5bpsL3A5sA/ySFi4+dJZnGXcY2e+WzlPuFHBTXAp9kr1lxJ+CGw/zW
         pe3nCqNT/Sley0RYvOiAkVMf+2Ec9zyc/W46NiZlGLiYQ2VqEYVBv0zKyTq6oZvfTSzb
         E2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436871; x=1757041671;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdHUScYT7W2VGRMgw68PcJ7pKiSlfY+0dw+HmuAdspg=;
        b=pzceTUkqMj5bZ+JfjQyVZuiL9fwHcZX00EddvUqZqSnVyHBCY9//0y58mSae/r4l4l
         MVV7MtPGv/lhFhAw5JQ6/QLTjmsv/2SwhWLe/83EeChBW/jU+Z7ZTwfP7J1dwQEYBoEL
         TYcxUBPNmhISbk8SHoqgHOoTYSl9jFAuRCj4Z/AXhMcLx/r+Eg+kkLCb450TboYMpZ7J
         KjlU8ghbCXxGsSHs4RynnY3kMZh/MOheKXh6/2df82cT2LPVmqFuE7ONYZzv8GudzLFa
         ZUAkdB5WYbjnPfJLb8l8wFXihLvoPbJ3q7MnPr4PF2pl+GVIsaxEbwf0cQp4HCvpwKnF
         +k9g==
X-Forwarded-Encrypted: i=1; AJvYcCUSKfu/jbFIEXvnRLWti88moCg2ZEaQpCmHhmLI5rrp0D2lMhZAC6QkF2WxRYrPu1+xtTTmSeOeS9/ZmPLSIWOk@vger.kernel.org
X-Gm-Message-State: AOJu0YycJM9PBTYJXfA3flHTZDhOnBkz4MenP96lnIwMizUZBwmBrRvW
	PxgmZfEe/yvRP2Hz9tdRBnPBM20KvUb2oe2yWINyDdkcKBxnFrRrBfMI/CGSbcohhTz/SEnVjPE
	MF3lXqqCx7Q==
X-Google-Smtp-Source: AGHT+IG314ujKFfTaDY0VW2hUce2/LUImMQR+ihljf4A+twxxq05CUzMuW4zeIgA+if1zd/ANQmJ0eI6fV4N
X-Received: from plem10.prod.google.com ([2002:a17:902:e40a:b0:248:d08b:a337])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80c:b0:246:b3d4:5c82
 with SMTP id d9443c01a7336-246b3d4620amr283293095ad.16.1756436871187; Thu, 28
 Aug 2025 20:07:51 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:25 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-12-irogers@google.com>
Subject: [PATCH v5 11/12] perf jevents: Build support for generating metrics
 from python
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
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
 tools/perf/.gitignore                  |  5 +++
 tools/perf/Makefile.perf               |  2 +
 tools/perf/pmu-events/Build            | 51 +++++++++++++++++++++++++-
 tools/perf/pmu-events/amd_metrics.py   | 38 +++++++++++++++++++
 tools/perf/pmu-events/arm64_metrics.py | 39 ++++++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py | 38 +++++++++++++++++++
 6 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index b64302a76144..133e343bf44e 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -42,6 +42,11 @@ pmu-events/metric_test.log
 pmu-events/empty-pmu-events.log
 pmu-events/test-empty-pmu-events.c
 *.shellcheck_log
+pmu-events/arch/**/extra-metrics.json
+pmu-events/arch/**/extra-metricgroups.json
+tests/shell/*.shellcheck_log
+tests/shell/coresight/*.shellcheck_log
+tests/shell/lib/*.shellcheck_log
 feature/
 libapi/
 libbpf/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cc1635335586..96ad9ea60f68 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1279,6 +1279,8 @@ ifeq ($(OUTPUT),)
 		pmu-events/metric_test.log \
 		pmu-events/test-empty-pmu-events.c \
 		pmu-events/empty-pmu-events.log
+	$(Q)find pmu-events/arch -name 'extra-metrics.json' -delete -o \
+		-name 'extra-metricgroups.json' -delete
 else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
 	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
 		$(OUTPUT)pmu-events/pmu-events.c \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 4ebf37c14978..162d5f74cbe8 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -30,6 +30,10 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
+# Extract the model from a extra-metrics.json or extra-metricgroups.json path
+model_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/extra-metric.*\.json@\1@')
+vendor_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/[^/]*/extra-metric.*\.json@\1@')
+
 # Copy checked-in json for generation.
 $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
 	$(call rule_mkdir)
@@ -39,7 +43,52 @@ $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
 
-GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
+GEN_METRIC_DEPS := pmu-events/metric.py
+
+# Generate AMD Json
+ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
+ZEN_METRICS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metrics.json)
+ZEN_METRICGROUPS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(ZEN_METRICS): pmu-events/amd_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) arch > $@
+
+$(ZEN_METRICGROUPS): pmu-events/amd_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) arch > $@
+
+# Generate ARM Json
+ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*)
+ARM_METRICS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metrics.json)
+ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(ARM_METRICS): pmu-events/arm64_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call vendor_name,$@) $(call model_name,$@) arch > $@
+
+$(ARM_METRICGROUPS): pmu-events/arm64_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call vendor_name,$@) $(call model_name,$@) arch > $@
+
+# Generate Intel Json
+INTELS = $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
+INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
+INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(INTEL_METRICS): pmu-events/intel_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) arch > $@
+
+$(INTEL_METRICGROUPS): pmu-events/intel_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) arch > $@
+
+GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) \
+            $(LEGACY_CACHE_JSON) \
+            $(ZEN_METRICS) $(ZEN_METRICGROUPS) \
+            $(ARM_METRICS) $(ARM_METRICGROUPS) \
+            $(INTEL_METRICS) $(INTEL_METRICGROUPS)
 
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
new file mode 100755
index 000000000000..7ab2ee4fdb17
--- /dev/null
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+import os
+
+# Global command line arguments.
+_args = None
+
+def main() -> None:
+  global _args
+
+  def dir_path(path: str) -> str:
+    """Validate path is a directory for argparse."""
+    if os.path.isdir(path):
+      return path
+    raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+  parser = argparse.ArgumentParser(description="AMD perf json generator")
+  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+  parser.add_argument("model", help="e.g. amdzen[123]")
+  parser.add_argument(
+      'events_path',
+      type=dir_path,
+      help='Root of tree containing architecture directories containing json files'
+  )
+  _args = parser.parse_args()
+
+  all_metrics = MetricGroup("",[])
+
+  if _args.metricgroups:
+    print(JsonEncodeMetricGroupDescriptions(all_metrics))
+  else:
+    print(JsonEncodeMetric(all_metrics))
+
+if __name__ == '__main__':
+  main()
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
new file mode 100755
index 000000000000..a9f0e6bc751b
--- /dev/null
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+import os
+
+# Global command line arguments.
+_args = None
+
+def main() -> None:
+  global _args
+
+  def dir_path(path: str) -> str:
+    """Validate path is a directory for argparse."""
+    if os.path.isdir(path):
+      return path
+    raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+  parser = argparse.ArgumentParser(description="ARM perf json generator")
+  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+  parser.add_argument("vendor", help="e.g. arm")
+  parser.add_argument("model", help="e.g. neoverse-n1")
+  parser.add_argument(
+      'events_path',
+      type=dir_path,
+      help='Root of tree containing architecture directories containing json files'
+  )
+  _args = parser.parse_args()
+
+  all_metrics = MetricGroup("",[])
+
+  if _args.metricgroups:
+    print(JsonEncodeMetricGroupDescriptions(all_metrics))
+  else:
+    print(JsonEncodeMetric(all_metrics))
+
+if __name__ == '__main__':
+  main()
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
new file mode 100755
index 000000000000..f004c27640d2
--- /dev/null
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+import os
+
+# Global command line arguments.
+_args = None
+
+def main() -> None:
+  global _args
+
+  def dir_path(path: str) -> str:
+    """Validate path is a directory for argparse."""
+    if os.path.isdir(path):
+      return path
+    raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+  parser = argparse.ArgumentParser(description="Intel perf json generator")
+  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+  parser.add_argument("model", help="e.g. skylakex")
+  parser.add_argument(
+      'events_path',
+      type=dir_path,
+      help='Root of tree containing architecture directories containing json files'
+  )
+  _args = parser.parse_args()
+
+  all_metrics = MetricGroup("",[])
+
+  if _args.metricgroups:
+    print(JsonEncodeMetricGroupDescriptions(all_metrics))
+  else:
+    print(JsonEncodeMetric(all_metrics))
+
+if __name__ == '__main__':
+  main()
-- 
2.51.0.318.gd7df087d1a-goog

