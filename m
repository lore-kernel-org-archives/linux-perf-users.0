Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211A2D593E
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697930; cv=none; b=nnm14araoimThMbE8hd/6rsGerJbZnmvyYfoGXm78jZBOEJc850FkX5TXrXwhfTdtdSfLY+phknqSKmyV9kfAnduS+ID5uayjocp54sRDXTe4k3hEmBRC3138cPj2umRvaYXXfEReah3UsQdY6av5+s2iHerGm5KB1H9XG4OE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697930; c=relaxed/simple;
	bh=XU8iZIUdDXmn4q6EkwaImSAjzbGtzQ3lNBSz+E0Q7Uc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dtb7YInqR97gNEhvLYno9c8pTitv/8/ChNpyjqiqWOgagCEPre7z/pAhHa7D+eSbM1p+URbVvu/2iLwVDiaB46RWxFMsW5ZI+qB0yvkZoopAHwKGAL/SgLxpdQ3tJVAA8oS/pebypYZOoIAoCPdbut288QyeiIl8HYbgk4hDFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQk64bC0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQk64bC0"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6097ca315bso8345487a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697927; x=1765302727; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhsC3vL0JqFkwlmy2nMeLakiM9yqOXbDExRyj5c1I9U=;
        b=hQk64bC0t88fdCtnSAmvIX3V3xVnGcVZzlgLPuYgC2FGZdp7yh8FLgrR/dfD3vox9k
         7JTtic/LpdNUSwvl5yw4YdUIikzJLwX1Zx76FMp11RXWjn/0FmdwWOjL11q0FlUthrUO
         Ea6v866HSDjsuRlYAvuVmYP+sq0SVSJ7oWT6pwveMOtbTrh7r2N1lt6UAdV4LfrJ2k4b
         AJfiiPtaOU2j0xeLwmDY/at3EwJ/OAvC3lN641yC2E/mRto2uZXbnRc0nq2KNhVvUU23
         4w1eunwiQRYAGQqAZaRUGR9zidoTehF/NZavopN5tCOWaqg7QW267VjpJU9x/pZt+n4d
         PxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697927; x=1765302727;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhsC3vL0JqFkwlmy2nMeLakiM9yqOXbDExRyj5c1I9U=;
        b=ZhOHopU/c9iYCkyjuGPNqN8WUgLxQ1Gsoa/poZWKMerVK1KMbDL6kDD0ggyeBYAMF/
         cVEfrr1ziSqWqBhtRdyNf/vjbuGbouGBQsGmjPWf42oNKMA8dpbgxtjAVkv5LOSNlJdo
         pUhoXYDusQcO7Y6E1AEZwFjeAclpBohOc5Ki3IunaJOTKuYHMI+MvNeM2HvntAvfi2gK
         6wkUzR/sV1SzkEO6W+WZHg0IUO9fnZC6FikkLNeQ9ymcZu8g2xdUbk5Yxf1Yp+jHUyaG
         A9igMu+VVtrFqJ2pFIy6jlyEms6P4/Q37Ux2Y7ar7HMM/Ow19Ga+wUWmppSfknsI0Ow9
         opPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTYawpsTxgDS4IZ91DYsY6qq1HC65PjcZFCEBPp/QWbpQLy+ErFp7tJ0M+tbZtfVXNbBxlKZ0wFLO4WvICnUaz@vger.kernel.org
X-Gm-Message-State: AOJu0YwzYyPv8DV+n6Kdl3SEFiumy/AsIiGRbrtykWtllWxq8yTsdBik
	IwSL65WuV9ZEB2+xXKlQAF0movpLBmq8CsAAgVx39qJFy30x3ns9VwsoJLSiLJl+pwdoQjUrcMV
	DlvtnRespEA==
X-Google-Smtp-Source: AGHT+IE8NmXotDcmMxvYw2dyBgppaugCsReXo8qIOaXgMS+dzBeqLW2CPo7XqP7k3bmZRrekhMaQzqod07tl
X-Received: from dybrq3.prod.google.com ([2002:a05:7301:4683:b0:2a4:6b08:61f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:454b:b0:2a4:3594:72d5
 with SMTP id 5a478bee46e88-2a719097d14mr23351783eec.4.1764697927208; Tue, 02
 Dec 2025 09:52:07 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:08 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-14-irogers@google.com>
Subject: [PATCH v9 13/48] perf jevents: Build support for generating metrics
 from python
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/.gitignore                  |  5 +++
 tools/perf/Makefile.perf               |  2 +
 tools/perf/pmu-events/Build            | 51 +++++++++++++++++++++++++-
 tools/perf/pmu-events/amd_metrics.py   | 42 +++++++++++++++++++++
 tools/perf/pmu-events/arm64_metrics.py | 43 ++++++++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py | 42 +++++++++++++++++++++
 6 files changed, 184 insertions(+), 1 deletion(-)
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
index 80decc7ce13c..a6040e09cead 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1277,6 +1277,8 @@ ifeq ($(OUTPUT),)
 		pmu-events/metric_test.log \
 		pmu-events/test-empty-pmu-events.c \
 		pmu-events/empty-pmu-events.log
+	$(Q)find pmu-events/arch -name 'extra-metrics.json' -delete -o \
+		-name 'extra-metricgroups.json' -delete
 else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
 	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
 		$(OUTPUT)pmu-events/pmu-events.c \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a46ab7b612df..c9df78ee003c 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -29,6 +29,10 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
+# Functions to extract the model from a extra-metrics.json or extra-metricgroups.json path.
+model_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/extra-metric.*\.json@\1@')
+vendor_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/[^/]*/extra-metric.*\.json@\1@')
+
 # Copy checked-in json to OUTPUT for generation if it's an out of source build
 ifneq ($(OUTPUT),)
 $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
@@ -40,7 +44,52 @@ $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
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
index 000000000000..5f44687d8d20
--- /dev/null
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -0,0 +1,42 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+import argparse
+import os
+from metric import (
+    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+
+# Global command line arguments.
+_args = None
+
+
+def main() -> None:
+    global _args
+
+    def dir_path(path: str) -> str:
+        """Validate path is a directory for argparse."""
+        if os.path.isdir(path):
+            return path
+        raise argparse.ArgumentTypeError(
+            f'\'{path}\' is not a valid directory')
+
+    parser = argparse.ArgumentParser(description="AMD perf json generator")
+    parser.add_argument(
+        "-metricgroups", help="Generate metricgroups data", action='store_true')
+    parser.add_argument("model", help="e.g. amdzen[123]")
+    parser.add_argument(
+        'events_path',
+        type=dir_path,
+        help='Root of tree containing architecture directories containing json files'
+    )
+    _args = parser.parse_args()
+
+    all_metrics = MetricGroup("", [])
+
+    if _args.metricgroups:
+        print(JsonEncodeMetricGroupDescriptions(all_metrics))
+    else:
+        print(JsonEncodeMetric(all_metrics))
+
+
+if __name__ == '__main__':
+    main()
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
new file mode 100755
index 000000000000..204b3b08c680
--- /dev/null
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -0,0 +1,43 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+import argparse
+import os
+from metric import (
+    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+
+# Global command line arguments.
+_args = None
+
+
+def main() -> None:
+    global _args
+
+    def dir_path(path: str) -> str:
+        """Validate path is a directory for argparse."""
+        if os.path.isdir(path):
+            return path
+        raise argparse.ArgumentTypeError(
+            f'\'{path}\' is not a valid directory')
+
+    parser = argparse.ArgumentParser(description="ARM perf json generator")
+    parser.add_argument(
+        "-metricgroups", help="Generate metricgroups data", action='store_true')
+    parser.add_argument("vendor", help="e.g. arm")
+    parser.add_argument("model", help="e.g. neoverse-n1")
+    parser.add_argument(
+        'events_path',
+        type=dir_path,
+        help='Root of tree containing architecture directories containing json files'
+    )
+    _args = parser.parse_args()
+
+    all_metrics = MetricGroup("", [])
+
+    if _args.metricgroups:
+        print(JsonEncodeMetricGroupDescriptions(all_metrics))
+    else:
+        print(JsonEncodeMetric(all_metrics))
+
+
+if __name__ == '__main__':
+    main()
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
new file mode 100755
index 000000000000..65ada006d05a
--- /dev/null
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -0,0 +1,42 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+import argparse
+import os
+from metric import (
+    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+
+# Global command line arguments.
+_args = None
+
+
+def main() -> None:
+    global _args
+
+    def dir_path(path: str) -> str:
+        """Validate path is a directory for argparse."""
+        if os.path.isdir(path):
+            return path
+        raise argparse.ArgumentTypeError(
+            f'\'{path}\' is not a valid directory')
+
+    parser = argparse.ArgumentParser(description="Intel perf json generator")
+    parser.add_argument(
+        "-metricgroups", help="Generate metricgroups data", action='store_true')
+    parser.add_argument("model", help="e.g. skylakex")
+    parser.add_argument(
+        'events_path',
+        type=dir_path,
+        help='Root of tree containing architecture directories containing json files'
+    )
+    _args = parser.parse_args()
+
+    all_metrics = MetricGroup("", [])
+
+    if _args.metricgroups:
+        print(JsonEncodeMetricGroupDescriptions(all_metrics))
+    else:
+        print(JsonEncodeMetric(all_metrics))
+
+
+if __name__ == '__main__':
+    main()
-- 
2.52.0.158.g65b55ccf14-goog

