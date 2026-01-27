Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7602E7F38
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539530; cv=none; b=eYF6FxeJjhRSwXz88RknVeK1b/CSgfUnwYdqS98Sk476Ru5jZqfkkxjSJagizLc0M71BUpl/d6k4RE8TJAKY4rXqLbE2ZeCr9tqNDe1vrX6tfnNNPET1Dv/uU+V9whRIwLsashXqrZLzLRThT9Ao6DIiIjQZXhAv8//B8qirdxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539530; c=relaxed/simple;
	bh=LWyXHg1/6L2/WGjiMiMdFwDJJPEHEzKOc78/gRx7f0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZdbB0Wf63RavcuDXL3gRzpgh49W/yNMv5uQ7RQoxO5Y2CmODBVS9Q1dveXBf8mF0C7Ti04HPbMDamNeZ1ZO+j3MD+pKr9PhvodCLf9n/rHO0GWTR7Yk3DQRFpX0JuCeEu1ixwQlOZhCQuzEdzL0wvC5RgN4V7ApqjGjfGAzf+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+L5eka6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+L5eka6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b70d8095daso5753452eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539528; x=1770144328; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwmGp6g/MKzw6N7iSeG1R53h0Yy2ZWPAUIOjpExNYSY=;
        b=j+L5eka6L56jS5/veXJulwQyrvOQwLhISCq9vHpMnRLcrqB2w5CeEpZnBzHMFC3a2K
         jO+1Kx0tLriPUlVfRccVotguuG3Zs8PPHNW6Oq1C93S6su3wxDykVvoJwZG0TX+g+LFt
         LOTJhUOvvs47ZlonEVmzeekMunKzLLc8VwdCjaYiTQEea7LcW7eNK2WacO595fNr47nS
         TpTJgwZtdNXxIND0GuIO9MpHUgMjS/h2r4Ewvk0hRz+H6qAcAmpZU64ceLgGvURQm+Zf
         5DIRnekJvZ3bOXKvgMHlwKr1oxAtBXV8h6ZkhWbFUxXFxLfl7CZ0pxRKPdctOrdjNPwq
         h/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539528; x=1770144328;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwmGp6g/MKzw6N7iSeG1R53h0Yy2ZWPAUIOjpExNYSY=;
        b=gqClyISD9LrwT1GE+g3JTYvCx6KXv/yQijcCXBVpaumcFJKJpit1CQ6vONM5P6jGnp
         9huCurcgpPLnW8nC1ZMchaoxgDZbaF3qxsbiJjofiXZpYmHn3totR+aKPooDQrX71YsY
         1LOENJZuD5T+It7jqVmmg4tC59lGnDG0lzlsfrzHx4EzWQPt67KM1PVoBGyht3zWYsxL
         B18nyzvbwvG790WVt+0ZG+IKvks6FBs3x6OXF7U9xRbqTjnkmkKdM2e86RIl/FebKQOA
         QRrEoZGlqA5YdDqSpnCQUsvsQ+3MoZmYSEIf/kUUD2lSIihNzzR9iy4NaGvUGe4Ia2lW
         vG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTEciRJvpic5yl7ZQxw3x2OfmFhl6QwQ/f4dwXZWUVSx2lrrJP+a1KK5fWw5FDxE2oe2v+Ep5p0oSaVqzZbRdd@vger.kernel.org
X-Gm-Message-State: AOJu0Yysm/XHMDVtyuociCodMHeTDBWGf5oImONvDNh+DMO4x4Pwzgfj
	KV9P1UFfHOQJ1Xp69o4Rt8WRKi5MfDiOc9fp9B49/8HeQTJTaT/iJ0RA4DLGeFfOkZUl006w+hK
	j33jrpQCzYw==
X-Received: from dybkl23.prod.google.com ([2002:a05:7301:d17:b0:2b6:b833:a98d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8605:b0:2b7:2a17:af32
 with SMTP id 5a478bee46e88-2b78da04efbmr1735066eec.27.1769539527890; Tue, 27
 Jan 2026 10:45:27 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:32 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-2-irogers@google.com>
Subject: [PATCH v11 01/35] perf jevents: Build support for generating metrics
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
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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
index 5c59f954f52a..0f9451a6e39c 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -43,6 +43,11 @@ pmu-events/metric_test.log
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
index 45d5a59a02cb..b6edc8100c8e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1273,6 +1273,8 @@ ifeq ($(OUTPUT),)
 		pmu-events/metric_test.log \
 		pmu-events/test-empty-pmu-events.c \
 		pmu-events/empty-pmu-events.log
+	$(Q)find pmu-events/arch -name 'extra-metrics.json' -delete -o \
+		-name 'extra-metricgroups.json' -delete
 else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
 	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
 		$(OUTPUT)pmu-events/pmu-events.c \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a46ab7b612df..3f2b26e5c6d5 100644
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
+ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*|grep -v cmn)
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

