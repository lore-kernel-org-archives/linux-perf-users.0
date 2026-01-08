Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4F31A545
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899490; cv=none; b=R/lhYmgC7ZZLtPWofMOn7C8ttj8MtyZGTSWGCsOKfqDLQj6bYvYMrL1pE5bFuF0KUcTtjC8K2JlFKFzlpGnAIzlsca9C9/b0LuJCC9fKq7iKpPJafyQ5/21darF8352EWnFOBHliAmigXkktcG9q4RGebcs+oW8c3Su3rht7qho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899490; c=relaxed/simple;
	bh=+gTQNryLEr3/Hv6b1sFXvK918lbzAnY34/Ic4iQIbPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YAb2z9ImnPjOIWOjXmjg5QHnzgeDsI1WuTvm2kIW7bp9cRcVdyYXf3xlUyBKko2zKE/mX72q7H8aTVProbh3LBLNwUwh1KJB+XY7fW5SQG0ilHfhHrEM8pTS3T9p7XBuw78HyWo945h+M997+WeTViFROaNEE2Zap4waxckkCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHdpeVsG; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHdpeVsG"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11f4500c7ebso4021775c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899488; x=1768504288; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdVij/CdHS3wRypY/uVWHzN4Zg9aAQVd2lazFiqQTms=;
        b=fHdpeVsGGySO1px4Hnl7NaVlkXGkZ56E31LdmtHilEsP9JMer07c5jwCspxV4Jniwh
         fy/BldZMAi/Y9IppvaD4RXcs0Kk6sLrkPRM2mDxdrR9vu0IFaV8PAoPFNK4tOtkzjlOV
         GKAWshhKu3KVuP2BpbMhlDlJswEVtI5x+LQ8KTrv0M78Luls356GRDGdYhswDp7S6+p9
         mLHFkgIBd1yjU/UrIHgSd6RrnjlT4vRbMh2typSBr/4tkMCEowne4U+YAv0uQFA97ps0
         Tqg0V+iQbCE6/nz0EBEf6o8nnXsJZBLdo+U0YuPYx//y8BDtyf+7sDluqs+SkFoxDDe7
         Y1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899488; x=1768504288;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdVij/CdHS3wRypY/uVWHzN4Zg9aAQVd2lazFiqQTms=;
        b=wE/mjBY8ME/sRt6sjs0pv7ozx9x+XWDRG1wdJpFezoSe/S4hhLK0mBi6VH+8reeQAB
         lhurYSiSo3D7ABymL+vF7Y7fQU3ZNNrfTpQGSVVBiuOEmAQdd7hXjQNRvT0TveKrtSB5
         6Y3bYN5HIMGjeaR1wNoFm9kzNSSLbFgvnhqscr5dD6dKIoRmjwDYIq9fXu/o3d2fjWZu
         IBjwQHdQamRaBdZ8meA7d1CCISgZR157ryvhxM/nf7DeYsWPea++7GffO7hUcdCDqvea
         TIJwGxSEEwK/bMBwKijQsaY7ZBM5uDLihVn5fTPy/t8eR6noSj+J+aDPEeHbiNxrDu6a
         9oMA==
X-Forwarded-Encrypted: i=1; AJvYcCU9PT+6WJvf0Ls3noRDKOcM7AHiNJqd5G6C9Fsi5H+c+RvizaVWm2Cg/pLJvokYO3hyVlTvPx2N2mBrTY8U9STN@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpMu7MsTuR2m9FUVFdYG9ZWwPHeVJnPL+C2Q79hDHavSJhEIs
	DcC6kLw+DferQ+PqtyEnAK19vZG4Qtqi1trQj8Poegq42dfaSCgZk8JYJp7QX4Cppo66afocfNo
	P+HanJq+NqQ==
X-Google-Smtp-Source: AGHT+IHFBkOJ16gxPN8Npq4T+lUGZaKXI3+m6DOic9M52B+SeBca7P9pygG89WJD9554cWVJ0W+2zllRdAxP
X-Received: from dlbbq37.prod.google.com ([2002:a05:7022:6725:b0:11f:45c3:e5f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41a7:b0:121:9f05:c4c2
 with SMTP id a92af1059eb24-121f8b7baf9mr4895707c88.23.1767899487987; Thu, 08
 Jan 2026 11:11:27 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:31 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-2-irogers@google.com>
Subject: [PATCH v10 01/35] perf jevents: Build support for generating metrics
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

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
index b3f481a626af..3714288fc2f8 100644
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
2.52.0.457.g6b5491de43-goog

