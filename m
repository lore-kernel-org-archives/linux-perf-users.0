Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A3367294
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967303; cv=none; b=fidItzLaxdF95fYaBL6eSqvPQj8EI/1KA1K4dtqwiYbesyL8kBhqSHBcu2sktCjz8KRs+V805pudqde02K0l8e12iWRcQWi8CwrZVDm/D8MYdE87ZfsJtK3NERR/zwEeS6+sPYkHYZrGGo9BoxgUU4rYfoUqC8VUTuoel27+Bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967303; c=relaxed/simple;
	bh=vvC/9bKdNtW1D6SIoM9azCb1dqac6AgXW2gBVJIKNwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T5nJFMHLt8MwU6EvD2hXuXIhby7hMqtoKPl01LmQLC62P1mDZ6CChp0hMByr5fW0HG9zyoV3tiG7JVRuQSmSqjYbP5IBP0mjJsiXq4n3dG23sXLkvp/WwVZh9YMkSqquTGIJalB9V6Zi9iqccwj8Hz5xOLdDLaeAW3uG+FjH/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpsYh+2D; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpsYh+2D"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so6789097a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967301; x=1790572101; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1PQAolzi58qHU7RRZNY19ENhVjam2IcWgpCojxZBrHc=;
        b=tpsYh+2DH5YSNnfzYExYyKdR+FzrchQZf0Szbs4v5jiFpHOxWbPCnFMsxMum123bv/
         rXXobIwyeMbWfzoxj++d44OqmhVoHKy+xMYXJeOhJPGHauHvIVauSULCz+/ji/6CA0QJ
         QQPusnaUt9823vp09AfhIsoiPqssqpu5j43p7FQQhNIY/aI4e9KXDzdDHk4dnV/2xP+/
         6MbwQneZXAGYzV7Z/2VOgY0AKWMbVWM5aaNcpDecSntheghVsEZEtH20ek/PLKIm+Yeu
         eso49/wZ/ceT9j2Mu6Ptm8NEXercSztzvadMC2rea0awcbWMzoWF33ikokJ667Itz/ey
         Z9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967301; x=1790572101;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1PQAolzi58qHU7RRZNY19ENhVjam2IcWgpCojxZBrHc=;
        b=T2STp/Q5pCvuykcJwa2nKEk2nuuitBJXqO7T7Z59YcEBqkARhRkDXChyhWRKBuEQRL
         ELNRtn4sdAfnNznDL9VltqNYSyVLuuI7LnQy6jjzEdBHDzs/ChkCZF7kWxiXkenzL/rQ
         oFciSlYYduRngj3yX89UslqwnooYLDeMFbzKGk4F8MJ1r9k+q0bEGcqzu7glAx015V67
         4ssXRPGfylZWbSvjyIyvxEYKzZXFZrFnD6qpKv+CCjYimpxQSD7agBbXG2GNunjFr5Iv
         KKxGtvFz2irB9blt8je/L+uL5VJCtmBKR6T3Gh1Dbl0FBzA9u5J1KoPdiZJVhMghD+WH
         Ef8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxuVdQNtKI2EzzKcBNavJAd5GDZSxu/k5Sg+f5KlAK2/T6/TvPiUakKUlUXN5k2K9+C5dIDWQn0yr6CKNIUguOm@vger.kernel.org
X-Gm-Message-State: AFuF++nUWwrhuzgL9Axm7kd/4AdCeahYtLm5d/9Uf6oMdjRi/CNtem3d
	c/tfWV3uHUgLEsldTMql4U5/rUnDKp+/ITgq6uv2GUogZWFTAw3o/1KDFeTC5TIWTOugRYUfP2K
	VpkTs0zc81g==
X-Received: from dlxx3.prod.google.com ([2002:a05:7022:4083:b0:143:9303:fb4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384d:b0:39e:6c6a:656d
 with SMTP id 98e67ed59e1d1-39e6c6a6757mr8467803a91.48.1789967301154; Sun, 20
 Sep 2026 22:08:21 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:51 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <59486d9f5b83ad06a154ed3cb164d36106009df7.1789966896.git.irogers@google.com>
Subject: [PATCH v2 33/49] perf python: Port wakeup-latency from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/python/wakeup-latency.py           | 97 +++++++++++++++++++
 .../tests/shell/test_wakeup_latency_python.sh | 83 ++++++++++++++++
 2 files changed, 180 insertions(+)
 create mode 100755 tools/perf/python/wakeup-latency.py
 create mode 100755 tools/perf/tests/shell/test_wakeup_latency_python.sh

diff --git a/tools/perf/python/wakeup-latency.py b/tools/perf/python/wakeup-latency.py
new file mode 100755
index 000000000000..c7fb48225d47
--- /dev/null
+++ b/tools/perf/python/wakeup-latency.py
@@ -0,0 +1,97 @@
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
+        try:
+            self.session.process_events()
+        finally:
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

