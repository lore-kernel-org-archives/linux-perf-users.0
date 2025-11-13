Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C2305967
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004081; cv=none; b=qrFV6yzJKzugE45KOkJjS0/leJffVZaeyp39Tvz8vfjAC/uiwhbWZ0ron5nilTmnz7NcDnbpuPf64I2tWVEG4uc1E6zcFRw6Not4QejMRKUZRqfoJCTVBCsFOe+QKz7Gor8Pa4v96w+t6O97eXZsLI2a11dbY4ocgXuBqY4Bbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004081; c=relaxed/simple;
	bh=kTSeWssFGmTGZ1Polgv0aO7sDMThC57D+7hdqUdkjJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nRhoJZz00yDlwOGhPuXfIajWGJoyOOKX+EJd+JU4HGr1FvneT2Cednhc67+uXYQcwxBYO2PMaDCRrvAfIiWSUg6FX3chNdRHIHOWLNWHZ48UrlYm4lqsYIuS0qi9FwXQILcgiTIk1qgB7PqcacbyxbebmQjmIIcPTkPbs3jdi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvRZsLHQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvRZsLHQ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2982b47ce35so3991025ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004079; x=1763608879; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2lkJO2i8yVSvB4I6sd3B98h8zXra8Hjl0iYqDuXmo4=;
        b=kvRZsLHQMJnDehdi6wpwZW7m4FRFdDxvl5tcgMt91ieXOtCWtc90OrRnwzf0Bpt6Yy
         iY+NqLh5sD0FFYe261DsaFDvWOnDhBzlOu4Ef1JWUrNOEYw5Uw4lKta3Qi9Trc4TmFFl
         ETpoS0NX/aMUQWkdC/5ncrm8erTDz7i08jtf7EHtBVTTRGSX7Wp53BYNkyB3t7bxfq7z
         4w9ldgZ+COFYDzz8iWDNR1DNKRMsdA+FZkCNaf9HIspzsQkTYsMc4ck9XxBp3WonqIWZ
         oNBYS7TOdUr5T1Naw2ly7yAjYPSEJX93BFcDgHDcnjsRCHytB32zSPc5tZ8bm0AuVKjs
         eHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004079; x=1763608879;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2lkJO2i8yVSvB4I6sd3B98h8zXra8Hjl0iYqDuXmo4=;
        b=ba2v87oVwfiNsK7OjQHHaoPX5dQcj64bdmSJufW9kdhdlKoU/McZK0mEHeTuRhBx90
         s1C1LTdhpYafUJh1tcc+pjXgiK7tFps1b2QoNHQtsPASshErS8TswxDJnDo5N3Kp4bEG
         d+BZ0pT/2bWOqKGa5wXeORueYRB4Bltbiceujvk0yBjACsqA8inWLikU0gvV/bqo7OGB
         1houLn1JVCh0/3FLy4dHK1iZFosieju/LmeLoU3oOuK6Q2c0H7wGcpdjyK3xrFEXyCPI
         P4HEPgUfdWMzvRFRfhHRv6TGFDSC8/Mgdeld9xkDE95+D1JdGaKrC9jW3a0FO83ofsVc
         QCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfxHNYZNFfVD9MnTEogh9wP/UmkPdI7JZ93efsosi9Bua8hMCECCKX2ReSvavvUfEnTpxXZV8HkSNPCiYg3TJ2@vger.kernel.org
X-Gm-Message-State: AOJu0YwHh2ZZqbidql8tS1Ho5OKRYvYPj5xga4XV3u9IqX56mqghq/FR
	PhmwrNAG3FG89dS5SwOXo2AugK6uWuH/VuKTtOcj2v9UylQG9SstyLFQpGa0OfDzcBkZVN4tB8t
	qyiQc7XDdAg==
X-Google-Smtp-Source: AGHT+IF2y1yRQzK6iOvT364txR0m+E3gj1Xcj36wWeMiOotaL0ega0TpcM8wI97xCH4IKqmDZsUZmkoWDeaD
X-Received: from dycnm13.prod.google.com ([2002:a05:7300:d18d:b0:2a2:367e:4efc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce08:b0:295:3d5d:fe57
 with SMTP id d9443c01a7336-2984ed3548amr68365585ad.21.1763004079446; Wed, 12
 Nov 2025 19:21:19 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:01 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-14-irogers@google.com>
Subject: [PATCH v8 13/52] perf jevents: Build support for generating metrics
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
index afeb4e4a8a31..5c35ff9cca01 100644
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
2.51.2.1041.gc1ab5b90ca-goog

