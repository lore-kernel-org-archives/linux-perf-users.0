Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B533ADBA
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187288; cv=none; b=dnFl23ywSTj7QDYXuqBB09UPuQ678YhTj9O7tNWA6R9Qn3gr4FvEU01r4PI1iaYz1ZLOI6xBHhSNiGnp4gTpQUxuMJeTcX7uK4e9EI9S03ZyyI09uC5ncyv8d8ldBtYzLSkhSuZ0pusKAnYRrCxsBg12p0hcieSMI2WrrtdkogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187288; c=relaxed/simple;
	bh=8XIaRrxZy/o7eJC6ehfY2haOlAh2xXoszY8sZR5v/zY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lAPTkgrqfNTTuWz17sL/+CPsXKZbRibtj+JytcACSGvdClugK+I9zJNgA/GWd5FAGAZhExDeQbhcnla/5qy1eDjNIpMCy1zD/C+papbccNQ2cLF72zTjkNjQX/creppj63C2ZOeQ1nckLmn4hSbYmuQSV5L/yzBkIoxVI6ryhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psRmKrGk; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psRmKrGk"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-32861f5448cso1248720eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187277; x=1790792077; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ERAE4xDHfx1Qx4kvlPl8ZVdiATuUJKf6O+/6VV1f7E=;
        b=psRmKrGkyQwa0MfrTqPMWgW2UD0WJVXbDFi2IWuQV/eg6vC0d09EF0rRxd1bbA4UHs
         5FEj5CMIhEOuNqe347e+lshNs4mANKUueRJ5D+/ggg8dyCzsHTdwO3+pM3SnEdBaSTN5
         I38S98YZzk1PraV9rKP0WseprV45s7H/LSHLk5GhvXw7CF35fWgAza15u/YeNpJASjN3
         UtVcD63Tuh9CgE8CjKxHzlhhuLvfwNDyCpyXSrTrNU3s6yqimtTiUbwhnWQ3hLxXlFN1
         sdsrFkPkcGBdggbicLmVWwj8t/QqTtkLA7E81gJ8m2+tpPUgSRr/CcSX2jstSS8PrHrZ
         ABBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187277; x=1790792077;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ERAE4xDHfx1Qx4kvlPl8ZVdiATuUJKf6O+/6VV1f7E=;
        b=XFGgZ39vWal1NpUgU4uWDDuagMMxX9Zm7XEMmCNhv227yafoUSwe75QiMFirn6SPlw
         +4ZxLbDbJKy0lWBGdpwyTFSUqf/h1XFKH3H8lTJlfcsNe9DttYtxK+12vja1Zjq6vyVm
         p/LSUYbSJ88GFdRhc+xbpulH8OzBUKfHyGNw3asRkX23Vr/GZYvC0x1LFosD6jOJ6cv8
         tRgPRRGU6FkDxT/2+MKciVc8NjtswqHgNKfisFeLr2XVQlam5Xag3qjGsj3FTp2sJUEN
         SGxBbzeAX84NI8G/ZN/67oFfXNnCGrM+NV+1BpRX7bE8nNlFvVosgdeCvJGsLeTeYpni
         jzhg==
X-Forwarded-Encrypted: i=1; AKwUvByaHnh9gPQXJjqNcAXnL21ktwEq1LAAIBGrjMoufSsgUMg2z+RAPm6tofc9AOFs4Ev+Iw1I9HXk55txs1CCsaXp@vger.kernel.org
X-Gm-Message-State: AFuF++nCVblehX0yE8XIymLSnseTXv7DzAZxIVocfZSwgTxUYcleRMCj
	lb0usFQ6Z9ix1pPpQYrOAAYEnfAwxrjSe/klMPAQ7iVc4E5RCH4/ACLEBpG0hNlOGYYf4EiUh+h
	mmQPa5002ng==
X-Received: from dlec1-n1.prod.google.com ([2002:a05:701b:4281:10b0:143:83fd:ad8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4244:10b0:144:c112:5f24
 with SMTP id a92af1059eb24-144f91794e8mr3544226c88.25.1790187276718; Wed, 23
 Sep 2026 11:14:36 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:56 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-34-irogers@google.com>
Subject: [PATCH v3 33/49] perf python: Port wakeup-latency from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Replace the legacy Perl script wakeup-latency.pl with a standalone
Python script in tools/perf/python/wakeup-latency.py using the perf
Python module.

Improvements compared to the legacy Perl script:
- Remove the dependency on libperl and Perf::Trace::Util.
- Track wakeup timestamps per-task (keyed by the wakee PID on
  sched:sched_wakeup and matched against next_pid on sched:sched_switch)
  rather than per-CPU, avoiding mixed latencies when multiple wakeups
  occur on a CPU before a context switch.
- Guard print_totals() when total_wakeups == 0 (printing 'N/A' instead
  of dividing by zero when a trace contains no matched wakeup/switch
  pairs).
- Add argparse CLI options (-i/--input) and full type annotations.

Add a shell test
(test_wakeup_latency_python.sh) to verify the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/wakeup-latency.py           | 103 ++++++++++++++++++
 .../tests/shell/test_wakeup_latency_python.sh |  82 ++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100755 tools/perf/python/wakeup-latency.py
 create mode 100755 tools/perf/tests/shell/test_wakeup_latency_python.sh

diff --git a/tools/perf/python/wakeup-latency.py b/tools/perf/python/wakeup-latency.py
new file mode 100755
index 000000000000..f77045d02734
--- /dev/null
+++ b/tools/perf/python/wakeup-latency.py
@@ -0,0 +1,103 @@
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
+        if event_name.startswith("evsel(") and event_name.endswith(")"):
+            event_name = event_name[6:-1]
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
+        try:
+            self.session.process_events()
+        except KeyboardInterrupt:
+            pass
+        finally:
+            # Break the reference cycle between self.session and the bound
+            # self.process_event callback so the C perf.session object is freed.
+            self.session = None
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
index 000000000000..fc39ac117609
--- /dev/null
+++ b/tools/perf/tests/shell/test_wakeup_latency_python.sh
@@ -0,0 +1,82 @@
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
2.56.0.rc1.310.g51773c2048-goog

