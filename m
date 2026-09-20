Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F83E2747
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881820; cv=none; b=Ht3CRdupNt/sYMO2ijU5B0kl/S8kliQhVseRM43emNkPkkLgK1UfLZvhd4YT1hLjBjTXfRVOMGekRnd257AKXGAthQ2dRB3HqZn/GXyshKYn1FRDGmBSmvG9NmtlBx/UU03itpnlYHX+A6KlHP6KdDeK55pid+iqfH7IJep7WC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881820; c=relaxed/simple;
	bh=1pF+F8/rrhK1sgaK/62IrgWTApjoUONlVIFq1RlD9VY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T2UsBMa6WRAQ4L7A190nX6BBWXoaEUtzUwOfUgajQ5kkkpJB7EHFzAnSYaNYyNI0G5UIQmMUmGgkOMbDcX1XpTbDH8jj/6Y5jxpJJiDMVIdr4gp9adOI+EM7/j147zHzaePkuFUW3HkPnRPrSSzW0oaqxvyVBmBJsD9hmeH2mq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z/aMCbbs; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z/aMCbbs"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39d865b11b4so2922996a91.3
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881818; x=1790486618; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jA4fMUG+Tfjs2RJ6tMERLNU0m4vElSViwb9YOy8pOoM=;
        b=Z/aMCbbsQv+MnDRXUpskdTaqOlp1m8D4ZR9i1IzyI1sMhxFxqm2jzRm83ScFSO6cd2
         nzSrcLtMcIQnBCw+zlLkdIHLAgIu4ZMd1/lApRYykJQQE8GkA5uGdhZp7PBoOWJTunZs
         X7rCdx44NokmdRyT1bE/7JaIh5YiLLuFtOFVhC9r3SHslkvG2l22dYGLTd6e3+OKZDs+
         sBBPAEmP3cqFySxVzkcgGszQu7/NU4sDrnEtefL+/ISrbWXJj8QfvAbCRJc7hdRYWkpJ
         Q9R6+C6tYT5NLitYuW1J9YLX2UZ04NAaKJSK1SqLR5LyQcbQv+iu8gVm2hSUN/SdxQ0c
         +49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881818; x=1790486618;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jA4fMUG+Tfjs2RJ6tMERLNU0m4vElSViwb9YOy8pOoM=;
        b=uCPY/LZnklUGT6JNg3TV4kBNdmK4I9Sp3PCW2EQJ3CXHRjQifYcFnlAcSk3OHAmYZR
         R2VMFyKMcXmaaGcbJZ8Mco1S2L5lUTL0uzcIIEESP8/cfI4BJcewPZ7Jl/10bAxxyR1C
         /xk1CvlNqnWKRbBD2j3dXrwXMHBqLPlAlFnXbFv6FPv6tfeqI922M6m+5ySgyYY9fYaR
         OeEQrEguYkjlKI7wAu57oBgU7/tHJnxdEIMcXN958LLCIrnn3DE5+PEB5G4thzOMICBj
         s3bPrRnc+6va5dsObuhaHazGveLBp0VF+RKeZnBgwrwLLuKi3fxdLOARd7BrV7q0Kqeu
         KQeg==
X-Forwarded-Encrypted: i=1; AKwUvBxWyL2xNOK485my1tVBhld71fizJsr5o/9kdpW/HohbpKSdYxxZ9CyhLhCLHMOL4DxqcW6eywNt6EMt1vbUWniN@vger.kernel.org
X-Gm-Message-State: AFuF++lOO/m9o8+nnQT+RUT4S4KbQc/hN0tFG2xPZ1G/lcvC5kZikhUR
	7Ks1wTCyfXDfPqlYk3/Q1IIh9votVdAQA9cYJU8cTI9rmQ7BoKdh+H0Qx0nOlWyQKmTJzFn44p8
	dEiYMD/O+Pw==
X-Received: from dlbek20.prod.google.com ([2002:a05:7022:c94:b0:143:7b2d:7e10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c02:b0:39e:2036:8243
 with SMTP id 98e67ed59e1d1-39e54eb71f7mr11377763a91.25.1789881817536; Sat, 19
 Sep 2026 22:23:37 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:25 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <82f565299e985e7af24e9031d3d9c62a513897c0.1789880842.git.irogers@google.com>
Subject: [PATCH v1 33/49] perf python: Port wakeup-latency from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Replace the legacy Perl script wakeup-latency.pl with a standalone
Python script in tools/perf/python/wakeup-latency.py using the perf
Python module.

Improvements compared to the legacy Perl script:
- Remove the dependency on libperl and Perf::Trace::Util.
- Guard print_totals() when total_wakeups == 0 (printing 'N/A' instead
  of dividing by zero when a trace contains no matched wakeup/switch
  pairs).
- Add argparse CLI options (-i/--input) and full type annotations.

Add a shell test
(test_wakeup_latency_python.sh) to verify the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/wakeup-latency.py           | 94 +++++++++++++++++++
 .../tests/shell/test_wakeup_latency_python.sh | 83 ++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100755 tools/perf/python/wakeup-latency.py
 create mode 100755 tools/perf/tests/shell/test_wakeup_latency_python.sh

diff --git a/tools/perf/python/wakeup-latency.py b/tools/perf/python/wakeup-latency.py
new file mode 100755
index 000000000000..6113fa92b501
--- /dev/null
+++ b/tools/perf/python/wakeup-latency.py
@@ -0,0 +1,94 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Display avg/min/max wakeup latency."""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional, Dict
+import perf
+
+class WakeupLatency:
+    """Tracks and displays wakeup latency statistics."""
+    def __init__(self) -> None:
+        self.last_wakeup: Dict[int, int] = defaultdict(int)
+        self.max_wakeup_latency: int = 0
+        self.min_wakeup_latency: Optional[int] = None
+        self.total_wakeup_latency = 0
+        self.total_wakeups = 0
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = str(sample.evsel)
+        sample_time = sample.sample_time
+
+        if "sched:sched_wakeup" in event_name:
+            try:
+                pid = sample.pid
+                self.last_wakeup[pid] = sample_time
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif "sched:sched_switch" in event_name:
+            try:
+                next_pid = sample.next_pid
+                wakeup_ts = self.last_wakeup.get(next_pid, 0)
+                if wakeup_ts:
+                    latency = sample_time - wakeup_ts
+                    self.max_wakeup_latency = max(self.max_wakeup_latency, latency)
+                    if self.min_wakeup_latency is None:
+                        self.min_wakeup_latency = latency
+                    else:
+                        self.min_wakeup_latency = min(self.min_wakeup_latency, latency)
+                    self.total_wakeup_latency += latency
+                    self.total_wakeups += 1
+                    del self.last_wakeup[next_pid]
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        else:
+            self.unhandled[event_name] += 1
+
+    def print_totals(self) -> None:
+        """Print summary statistics."""
+        print("wakeup_latency stats:\n")
+        print(f"total_wakeups: {self.total_wakeups}")
+        if self.total_wakeups:
+            avg = self.total_wakeup_latency // self.total_wakeups
+            print(f"avg_wakeup_latency (ns): {avg}")
+            print(f"min_wakeup_latency (ns): {self.min_wakeup_latency}")
+            print(f"max_wakeup_latency (ns): {self.max_wakeup_latency}")
+        else:
+            print("avg_wakeup_latency (ns): N/A")
+            print("min_wakeup_latency (ns): N/A")
+            print("max_wakeup_latency (ns): N/A")
+
+        if self.unhandled:
+            print("\nunhandled events:\n")
+            print(f"{'event':<40s}  {'count':>10s}")
+            print(f"{'-'*40}  {'-'*10}")
+            for event_name, count in self.unhandled.items():
+                print(f"{event_name:<40s}  {count:10d}")
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
+        self.print_totals()
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace wakeup latency")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = WakeupLatency()
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_wakeup_latency_python.sh b/tools/perf/tests/shell/test_wakeup_latency_python.sh
new file mode 100755
index 000000000000..d68c9b31d6ed
--- /dev/null
+++ b/tools/perf/tests/shell/test_wakeup_latency_python.sh
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# wakeup-latency python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+if ! perf check feature -q libtraceevent; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/wakeup-latency.py"
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, wakeup-latency.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+temp_out=""
+
+cleanup() {
+	rm -f "${temp_data}" "${temp_out}"
+}
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_out=$(mktemp /tmp/perf.out.XXXXXX)
+
+echo "Testing wakeup-latency.py..."
+
+# Create a perf.data file. Try to get tracepoint data.
+if perf list | grep -q "sched:sched_wakeup"; then
+	ev="sched:sched_wakeup,sched:sched_wakeup_new,sched:sched_switch"
+	perf record -e "$ev" -a -o "${temp_data}" \
+		-- sleep 0.1 >/dev/null 2>&1 || \
+		{ echo "Skipping test, perf record failed"; exit 2; }
+else
+	echo "Skipping test, no sched:sched_wakeup event"
+	exit 2
+fi
+
+
+if [ ! -s "${temp_data}" ]; then
+	echo "Skipping test, perf record failed to create data"
+	exit 2
+fi
+
+# Check that the script executes
+if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	echo "wakeup-latency.py test failed"
+	err=1
+else
+	if ! grep -E -q "avg_wakeup_latency.*[0-9]+" "${temp_out}"; then
+		echo "Failed to find metric data rows"
+		err=1
+	else
+		echo "wakeup-latency test passed."
+	fi
+fi
+
+# Also test zero-wakeups / unhandled events path to verify division-by-zero protection
+if perf record -e cycles -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}" || \
+	   ! grep -q "avg_wakeup_latency (ns): N/A" "${temp_out}"; then
+		echo "wakeup-latency zero-wakeups guard test failed"
+		err=1
+	fi
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

