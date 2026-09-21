Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3AE364057
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967293; cv=none; b=o37Z7SxgsT8//450IS3+Y6DLFg5P+iPVGwC+EtkpW8q3nVWwUsz+k+vyXQFEOLufWiQBugDxYocOcUpOJ19RxpHRBIY360T6kcDmxI+1XzBSVNA1wZMMH5ey4XJsnpOpxvjjS4HvX9OIqADkp7KHI9U9AX1GVl4TCovc0H/X59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967293; c=relaxed/simple;
	bh=hnaVlqODTwUOk/YFzN16AifbgTxN1raKOhoOtywImBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XCZzKgY3cQk9CM7mFToyfG4NqDkLMbNs6qtl5p0v0KEXBIC/XTM7pG5Jq/OJgfxz0o8lHh0PfCS1bu8WROyy8mEVM/GTRrXQfKcU0Mik5BBH3Gzd1BUPhpR0twspuHcDMi6jxJgTYi7AxtMnl2D7JeVOKwf7sSZRCxNAWtMeIE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8ApjsUe; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8ApjsUe"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f80c76e6so51930245ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967290; x=1790572090; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfvi0BwphfpKK/iPZatKZpSJf0Eu4x0akzlSfOkhTzo=;
        b=M8ApjsUe90Gx/Pe4cKTQnG7E2zxtihEGIfaQS169DwJtZN/hlH0500dI1+gABV390+
         jLbP4n2sVnvQLUKDYPxuoIG2o/lKgNn+cFmeLwLIKzJpf1ndU5sGK0+DIBVX2xVSAyRY
         jBWmb+/wzcuLXy2O3xgE00D6o5SwOtHMgM7rejXVmzIY7JVpc+wgw48zMf7ZLh545KPV
         v+svFUsbSrcIy5OV6CJ+w5vajWkC5Gx8a2lwk/0HNqM3CU3YjBtaQ1YCGnCs1xg9gJdK
         34KMifx0i9LdSui963qfTdTYzxkUGDM/Fh7tCsDQdTHR+QHKNjx1sabfh4r09qD7ukPd
         LHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967290; x=1790572090;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mfvi0BwphfpKK/iPZatKZpSJf0Eu4x0akzlSfOkhTzo=;
        b=SC6hYaU2zdrt4XIvXUXEZ9H8KlbVDGAJ4WQOx1QPa++S6PRKFmw9FzP30fCSVdOetN
         vi8jy/vjr5BlF3k/rj2XL+yCoxWHv9k75BWFBxFbydm1G1cIVqngO/4YxFkeA64MXmmp
         yLRZK8mgcjY9e72EZkIOFo+K5jnO9BVMq14XRwdhDaRAJepHM3s05fk83PA1RSIWF8XK
         icO9BBnVANMDhgjcTMIiSUdwgDPlqUZZOjaSKOxwD1BWTXJPt7MHnszQIBLsymSegI6a
         OeEhUml2uOHqUOFQ/VNmgKtPYMFYUm3fCL+//XW4UtVCifpK87vd4UJNpt/m0Ku8f4fC
         0q4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwmenCMZ13CLJiPeEFNWXiFFQCYyq5eMFZTo8h1p9LIV5BXUvciy5OFyyHmohsy3A8m4vx4YaCWkg52JqOHU1S2@vger.kernel.org
X-Gm-Message-State: AFuF++nduE7dm//LXC5iEEbVJEK7JRQnblySZaHij31yV3oFwCW9KyuM
	HKzFTqPGv2wvlNDXHkazZvXJ0x4GeESau+C3JGBY+pQdKPDBYR0YDHs5ORGhk5z/QtBxoxzF1tS
	xecnnBdVpTw==
X-Received: from dybdx22.prod.google.com ([2002:a05:7300:b196:b0:33c:286e:b614])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c2:b0:2d8:de9f:9a44
 with SMTP id d9443c01a7336-2ddb1c15766mr129229975ad.19.1789967289816; Sun, 20
 Sep 2026 22:08:09 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:45 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <5c9f991f3b01de3f4f548d31166b691a6b7ef15c.1789966896.git.irogers@google.com>
Subject: [PATCH v2 27/49] perf python: Port rw-by-file from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Replace the legacy Perl script rw-by-file.pl with a standalone Python
script in tools/perf/python/rw-by-file.py using the perf Python module.

Improvements compared to the legacy Perl script:
- Remove the dependency on libperl and Perf::Trace::Util.
- Encapsulate per-file-descriptor read/write byte and call count
  aggregation in an RwByFile class using perf.session and resolve thread
  command names via session.find_thread(pid, sample_tid).
- Add argparse CLI support (-i/--input and target program filter) and
  full type annotations.

Add a shell test
(test_rw_by_file_python.sh) to verify the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/rw-by-file.py               | 109 ++++++++++++++++++
 .../tests/shell/test_rw_by_file_python.sh     |  70 +++++++++++
 2 files changed, 179 insertions(+)
 create mode 100755 tools/perf/python/rw-by-file.py
 create mode 100755 tools/perf/tests/shell/test_rw_by_file_python.sh

diff --git a/tools/perf/python/rw-by-file.py b/tools/perf/python/rw-by-file.py
new file mode 100755
index 000000000000..562ee7f7fd7e
--- /dev/null
+++ b/tools/perf/python/rw-by-file.py
@@ -0,0 +1,109 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Display r/w activity for files read/written to for a given program."""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional, Dict
+import perf
+
+class RwByFile:
+    """Tracks and displays read/write activity by file descriptor."""
+    def __init__(self, comm: str) -> None:
+        self.for_comm = comm
+        self.reads: Dict[int, Dict[str, int]] = defaultdict(
+            lambda: {"bytes_requested": 0, "total_reads": 0}
+        )
+        self.writes: Dict[int, Dict[str, int]] = defaultdict(
+            lambda: {"bytes_written": 0, "total_writes": 0}
+        )
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        raw_name = str(sample.evsel)
+        event_name = raw_name[6:-1] if raw_name.startswith("evsel(") else raw_name
+
+        pid = sample.sample_pid
+        assert self.session is not None
+        try:
+            thread = self.session.find_thread(pid, sample.sample_tid)
+            comm = (thread.comm() if thread else None) or "unknown"
+        except (TypeError, AttributeError):
+            comm = "unknown"
+
+        if comm != self.for_comm:
+            return
+
+        if event_name == "syscalls:sys_enter_read":
+            try:
+                fd = sample.fd
+                count = sample.count
+                self.reads[fd]["bytes_requested"] += count
+                self.reads[fd]["total_reads"] += 1
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif event_name == "syscalls:sys_enter_write":
+            try:
+                fd = sample.fd
+                count = sample.count
+                self.writes[fd]["bytes_written"] += count
+                self.writes[fd]["total_writes"] += 1
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        else:
+            self.unhandled[event_name] += 1
+
+    def print_totals(self) -> None:
+        """Print summary tables."""
+        print(f"file read counts for {self.for_comm}:\n")
+        print(f"{'fd':>6s}  {'# reads':>10s}  {'bytes_requested':>15s}")
+        print(f"{'-'*6}  {'-'*10}  {'-'*15}")
+
+        for fd, data in sorted(self.reads.items(),
+                               key=lambda kv: kv[1]["bytes_requested"], reverse=True):
+            print(f"{fd:6d}  {data['total_reads']:10d}  {data['bytes_requested']:15d}")
+
+        print(f"\nfile write counts for {self.for_comm}:\n")
+        print(f"{'fd':>6s}  {'# writes':>10s}  {'bytes_written':>15s}")
+        print(f"{'-'*6}  {'-'*10}  {'-'*15}")
+
+        for fd, data in sorted(self.writes.items(),
+                               key=lambda kv: kv[1]["bytes_written"], reverse=True):
+            print(f"{fd:6d}  {data['total_writes']:10d}  {data['bytes_written']:15d}")
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
+    parser = argparse.ArgumentParser(description="Trace r/w activity by file")
+    parser.add_argument("comm", help="Filter by command name")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = RwByFile(args.comm)
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_rw_by_file_python.sh b/tools/perf/tests/shell/test_rw_by_file_python.sh
new file mode 100755
index 000000000000..a305d5eded75
--- /dev/null
+++ b/tools/perf/tests/shell/test_rw_by_file_python.sh
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# rw-by-file python test
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
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/rw-by-file.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, rw-by-file.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+cleanup() {
+	rm -f "${temp_data}" "${temp_out}"
+}
+trap 'cleanup' EXIT TERM INT
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_out=$(mktemp /tmp/perf.out.XXXXXX)
+
+echo "Testing rw-by-file.py..."
+
+# Create a perf.data file. Try to get tracepoint data.
+if perf list | grep -q "syscalls:sys_enter_read"; then
+	perf record -e syscalls:sys_enter_read,syscalls:sys_enter_write -a -o "${temp_data}" \
+		-- dd if=/dev/urandom of=/dev/null bs=1M count=10 >/dev/null 2>&1 || \
+		{ echo "Skipping test, perf record failed"; exit 2; }
+else
+	echo "Skipping test, no syscalls:sys_enter_read event"
+	exit 2
+fi
+
+
+if [ ! -s "${temp_data}" ]; then
+	echo "Skipping test, perf record failed to create data"
+	exit 2
+fi
+
+# Check that the script executes - filtering for "dd" since that's what we ran
+if ! "$PYTHON" "$script_path" -i "${temp_data}" "dd" > "${temp_out}"; then
+	echo "rw-by-file.py test failed"
+	err=1
+else
+	if ! grep -E -q "^ *[0-9]+" "${temp_out}"; then
+		echo "Failed to find metric data rows"
+		err=1
+	else
+		echo "rw-by-file test passed."
+	fi
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

