Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5393D646B
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881789; cv=none; b=KkbEcTVOEAUsCRYNx+UiJNWW0jBUoqkfVs1nXe0WpfCdzTfLwwooCpBsRk0q1BhVUB0lLmu3w/69c2A8DmICBvUx3wOrfK6Vo2Bdl0A+nZPV2RMDoXbV0/kw/UXFcRVnT6DUWmPgEhXhNHsVCnXOGQroLHr2gh6zG/2gMRrYlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881789; c=relaxed/simple;
	bh=JRTXo2E8jFVEXlXw7AIXOq03MTkdQZiAGpnIawYA3DQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ezb28FWydt7swfpP5+yoHF/pVZMBpoYVjht03DGg8vTWl3TAj4NN3p7+QyOfdjsdFxmIVjkneRNX8r/LKBvZ34GwWL9Ajs0qBd4ZbN6XS/3gHQvqdPjWIOg9aexGusclz/WNAIFsuTkWtpgP/gnC4pXljrPM4FIbmntAmSAX0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gsb7s0Je; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gsb7s0Je"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso3774433a91.0
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881786; x=1790486586; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ej7QDiS47m4vr4kmsblaOmtUjIeH9D89WtrFQEr6rRk=;
        b=Gsb7s0Je3R7oHKCPIKlACRHFJ313D8Ronw7XsB4aTY04uV5nzSRi0wfsdWK3+he6K4
         +N9ACZza6QZ7O7sGl8ruNhEvxTfjGN1bCF2yXZr4/TLTuyfYy5qQCf78LgYvjbCylVEp
         que+7B7jz7ujH+hdzRBXPznX4MmuTqkXt6XvoW16ITkzZA6HIyRX4NmEJrQxF3az1udT
         O+GZmJnpG5IwOOL57bSekTGRx1HBvIknXg/4YHfqljeGEllgqPZkir5GvcpEnoVGMlCM
         i0W+KC74G+qWOLi0NpFJXkqS9ElbK1b+YjIQpjw6F+fbhWcMxrxYNfWPzmlkEW8U6mcu
         8/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881786; x=1790486586;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ej7QDiS47m4vr4kmsblaOmtUjIeH9D89WtrFQEr6rRk=;
        b=quMcP7Nqu9CrOQTwJcFnFS0J0cHWegb7J/32wnYhdlfPhU7Nlfe29O8uWFG4Cub7x7
         f0gL3g44SOq3m57K814qx+e8cK/pSZOUXpQ/y1mQg30tAESsgl64piZU99QkSZFhxXt3
         PzZ2mjVf0HM5OSkpSJFJM4tSvOQtp8u2JphEDDFdoGiiMROrWJ3dzRRHld3CcYvWTGil
         udNvTt3pj3oevPeSias0SRg5labhSPS2PYBO7V2Nwa0Ti2KpUbgTLqBWyHgX86tm2CMT
         Ny52FVknTOgesB73r2YXXm5hrPVC6tX2r+uIO6jbRvZWk5F/FoYMJLdSwi1PPc6UIVwH
         aGdQ==
X-Forwarded-Encrypted: i=1; AKwUvBz01yl1kiISklJRtqOs7PHfwFhC9VhoKrzT7irRhRcPNUEY1tI5c3XpdUCX6KwKoM/fFXpYtxVKwlQgyFpm72+w@vger.kernel.org
X-Gm-Message-State: AFuF++nfxk+iQDqWUJvJgKfoJG0rn/SnjWUStMxjxdA3MI1r6VqIFv71
	oFvypy7eUQUlb4Lzh5STJBsvjrKg83sGDQFv8lmCFnRsK3jiScWsz+NKDcUDJ9/kA2FZ5zTRCTI
	EAFLLSDEpNg==
X-Received: from dldz18-n2.prod.google.com ([2002:a05:701b:4192:20b0:144:c2b6:8f47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2784:b0:39e:6a80:b797
 with SMTP id 98e67ed59e1d1-39e6a80b874mr6436355a91.39.1789881786485; Sat, 19
 Sep 2026 22:23:06 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:08 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <95294f05467e0c96f2dc4ea605f1c3ab1a2e3f71.1789880842.git.irogers@google.com>
Subject: [PATCH v1 16/49] perf python: Port stat-cpi to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port stat-cpi.py from the legacy embedded scripting framework to a
standalone Python script in tools/perf/python/ to calculate Cycles Per
Instruction (CPI) per interval per CPU or thread.

Improvements compared to the legacy script:
- Support both perf.data file mode (via perf.session stat callbacks)
  and live counter collection mode (using perf.parse_events,
  evlist.open, and evsel.read across intervals), with automatic fallback
  to user-space (:u) and self-process monitoring when perf_event_paranoid
  restricts system-wide events (EACCES).
- Compute per-interval counter deltas (val, ena, run) keyed by raw event
  name so cumulative PERF_RECORD_STAT snapshots and hybrid PMU events
  (e.g. cpu_core/cycles/, cpu_atom/cycles/) are accumulated accurately,
  and scale counts by time_enabled / time_running when multiplexed.
- Replace hard-coded CPU ([0, 1]) and thread ([0]) arrays with dynamic
  CPU and thread discovery so arbitrary system topologies work
  automatically.
- Add CLI option handling (-i, -I, -p) via argparse and type annotations
  passing mypy and pylint.

Add a shell test (test_stat_cpi_python.sh) to verify the standalone
script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/stat-cpi.py                 | 208 ++++++++++++++++++
 .../perf/tests/shell/test_stat_cpi_python.sh  | 106 +++++++++
 2 files changed, 314 insertions(+)
 create mode 100755 tools/perf/python/stat-cpi.py
 create mode 100755 tools/perf/tests/shell/test_stat_cpi_python.sh

diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
new file mode 100755
index 000000000000..87df5ad279a0
--- /dev/null
+++ b/tools/perf/python/stat-cpi.py
@@ -0,0 +1,208 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Calculate CPI from perf stat data or live."""
+from __future__ import annotations
+
+import argparse
+import os
+import signal
+import sys
+import time
+from typing import Any, Optional
+import perf
+
+class StatCpiAnalyzer:
+    """Accumulates cycles and instructions and calculates CPI."""
+
+    def __init__(self, args: argparse.Namespace) -> None:
+        self.args = args
+        self.data: dict[str, tuple[int, int, int]] = {}
+        self.prev_data: dict[str, tuple[int, int, int]] = {}
+        self.recorded_pairs: set[tuple[int, int]] = set()
+
+    def get_key(self, event: str, cpu: int, thread: int) -> str:
+        """Get key for data dictionary."""
+        return f"{event}-{cpu}-{thread}"
+
+    def store_key(self, cpu: int, thread: int) -> None:
+        """Store CPU and thread IDs."""
+        self.recorded_pairs.add((cpu, thread))
+
+    def store(self, event: str, cpu: int, thread: int,
+              counts: tuple[int, int, int], is_delta: bool = False,
+              raw_name: Optional[str] = None) -> None:
+        """Store counter values, computing difference from previous
+        absolute values if not already deltas."""
+        self.store_key(cpu, thread)
+        key = self.get_key(event, cpu, thread)
+        prev_key = self.get_key(raw_name or event, cpu, thread)
+
+        val, ena, run = counts
+        if is_delta:
+            # counts are already deltas
+            cur_val = val
+            cur_ena = ena
+            cur_run = run
+        else:
+            if prev_key in self.prev_data:
+                prev_val, prev_ena, prev_run = self.prev_data[prev_key]
+                cur_val = val - prev_val
+                cur_ena = ena - prev_ena
+                cur_run = run - prev_run
+            else:
+                cur_val = val
+                cur_ena = ena
+                cur_run = run
+            self.prev_data[prev_key] = counts  # Store absolute value for next time
+
+        if key in self.data:
+            old_val, old_ena, old_run = self.data[key]
+            self.data[key] = (old_val + cur_val, old_ena + cur_ena, old_run + cur_run)
+        else:
+            self.data[key] = (cur_val, cur_ena, cur_run)
+
+    def get(self, event: str, cpu: int, thread: int) -> float:
+        """Get scaled counter value."""
+        key = self.get_key(event, cpu, thread)
+        if key not in self.data:
+            return 0.0
+        val, ena, run = self.data[key]
+        if run > 0:
+            return val * (ena / float(run))
+        return float(val)
+
+    def process_stat_event(self, event: Any, name: Optional[str] = None) -> None:
+        """Process PERF_RECORD_STAT and PERF_RECORD_STAT_ROUND events."""
+        if event.type == perf.RECORD_STAT:
+            if name:
+                if "cycles" in name:
+                    event_name = "cycles"
+                elif "instructions" in name:
+                    event_name = "instructions"
+                else:
+                    return
+                self.store(event_name, event.cpu, event.thread,
+                           (event.val, event.ena, event.run), raw_name=name)
+        elif event.type == perf.RECORD_STAT_ROUND:
+            timestamp = getattr(event, "time", 0)
+            self.print_interval(timestamp)
+            self.data.clear()
+            self.recorded_pairs.clear()
+
+    def print_interval(self, timestamp: int) -> None:
+        """Print CPI for the current interval."""
+        for cpu, thread in sorted(self.recorded_pairs):
+            cyc = self.get("cycles", cpu, thread)
+            ins = self.get("instructions", cpu, thread)
+            cpi = 0.0
+            if ins != 0:
+                cpi = cyc / float(ins)
+            t_sec = timestamp / 1000000000.0
+            print(f"{t_sec:15f}: cpu {cpu}, thread {thread} -> cpi {cpi:f} ({cyc:.0f}/{ins:.0f})")
+
+    def read_counters(self, evlist: Any) -> None:
+        """Read counters live."""
+        for evsel in evlist:
+            name = str(evsel)
+            if "cycles" in name:
+                event_name = "cycles"
+            elif "instructions" in name:
+                event_name = "instructions"
+            else:
+                continue
+
+            for cpu in evsel.cpus():
+                for thread in evsel.threads():
+                    try:
+                        counts = evsel.read(cpu, thread)
+                        self.store(event_name, cpu, thread,
+                                   (counts.val, counts.ena, counts.run),
+                                   is_delta=True, raw_name=name)
+                    except OSError:
+                        pass
+
+    def run_file(self) -> None:
+        """Process events from file."""
+        session = perf.session(perf.data(self.args.input), stat=self.process_stat_event)
+        session.process_events()
+
+    def _open_live_evlist(self) -> Any:
+        """Open evlist for live mode, falling back to user-space or process scope on EACCES."""
+        threads = perf.thread_map(self.args.pid) if self.args.pid else None
+        candidates = [
+            ("cycles,instructions", threads),
+            ("cycles:u,instructions:u", threads),
+        ]
+        if threads is None:
+            self_threads = perf.thread_map(os.getpid())
+            candidates.append(("cycles,instructions", self_threads))
+            candidates.append(("cycles:u,instructions:u", self_threads))
+
+        last_err: Optional[OSError] = None
+        for events, tmap in candidates:
+            try:
+                evlist = perf.parse_events(events, None, tmap)
+                for evsel in evlist:
+                    evsel.read_format |= (
+                        perf.FORMAT_TOTAL_TIME_ENABLED | perf.FORMAT_TOTAL_TIME_RUNNING
+                    )
+                evlist.open()
+                evlist.enable()
+                return evlist
+            except PermissionError as e:
+                last_err = e
+            except OSError as e:
+                if e.errno == 13:
+                    last_err = e
+                else:
+                    raise
+        if last_err is not None:
+            raise last_err
+        raise RuntimeError("Failed to open events")
+
+    def run_live(self) -> None:
+        """Read counters live."""
+        try:
+            evlist = self._open_live_evlist()
+        except OSError as e:
+            print(f"Failed to open events: {e}", file=sys.stderr)
+            sys.exit(1)
+
+        def handle_signal(_signum: int, _frame: Any) -> None:
+            raise KeyboardInterrupt
+
+        signal.signal(signal.SIGINT, signal.default_int_handler)
+        signal.signal(signal.SIGTERM, handle_signal)
+
+        print("Live mode started. Press Ctrl+C to stop.")
+        try:
+            while True:
+                time.sleep(self.args.interval)
+                timestamp = time.time_ns()
+                self.read_counters(evlist)
+                self.print_interval(timestamp)
+                self.data.clear()
+                self.recorded_pairs.clear()
+        except KeyboardInterrupt:
+            print("\nStopped.")
+        finally:
+            evlist.close()
+
+def main() -> None:
+    """Main function."""
+    ap = argparse.ArgumentParser(description="Calculate CPI from perf stat data or live")
+    ap.add_argument("-i", "--input", help="Input file name (enables file mode)")
+    ap.add_argument("-I", "--interval", type=float, default=1.0,
+                    help="Interval in seconds for live mode")
+    ap.add_argument("-p", "--pid", type=int,
+                    help="Monitor specific process ID in live mode")
+    args = ap.parse_args()
+
+    analyzer = StatCpiAnalyzer(args)
+    if args.input:
+        analyzer.run_file()
+    else:
+        analyzer.run_live()
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_stat_cpi_python.sh b/tools/perf/tests/shell/test_stat_cpi_python.sh
new file mode 100755
index 000000000000..8579f9f552a8
--- /dev/null
+++ b/tools/perf/tests/shell/test_stat_cpi_python.sh
@@ -0,0 +1,106 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# stat-cpi python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+# If we don't have the perf python module, we can't test
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	return 2 2>/dev/null || exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/stat-cpi.py"
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, stat-cpi.py not found at $script_path"
+	return 2 2>/dev/null || exit 2
+fi
+
+err=0
+ran=0
+temp_data=""
+temp_out=""
+
+cleanup() {
+	[ -n "${pid}" ] && kill "$pid" 2>/dev/null || true
+	[ -n "${workload_pid}" ] && kill "$workload_pid" 2>/dev/null || true
+	rm -f "${temp_data}" "${temp_out}"
+	trap - exit term int
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
+}
+trap trap_cleanup exit term int
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_out=$(mktemp /tmp/perf.out.XXXXXX)
+
+test_live_mode() {
+	echo "Testing stat-cpi.py live mode..."
+	if ! perf stat -e cycles,instructions -- sleep 0.1 2>/dev/null; then
+		echo "perf stat failed (permissions?), skipping live mode test."
+		return 0
+	fi
+	ran=1
+
+	perf test -w noploop &
+	workload_pid=$!
+
+	# Run live mode for 1 interval in the background, give it a tiny sleep, then interrupt
+	"$PYTHON" "$script_path" -I 0.1 -p "$workload_pid" > "${temp_out}" &
+	pid=$!
+	sleep 0.5
+	kill -INT "$pid" 2>/dev/null || true
+	set +e
+	wait "$pid"
+	res=$?
+	set -e
+	pid=""
+	kill "$workload_pid" 2>/dev/null || true
+	workload_pid=""
+	if [ $res -ne 0 ] && [ $res -ne 130 ] && [ $res -ne 143 ]; then
+		echo "Live mode failed or crashed"
+		err=1
+	elif ! grep -q "cpi" "${temp_out}"; then
+		echo "Live mode produced no cpi output"
+		err=1
+	else
+		echo "Live mode test passed."
+	fi
+}
+
+test_file_mode() {
+	echo "Testing stat-cpi.py file mode..."
+	# Generate some stat events - perf stat -I represents interval reporting
+	if ! perf stat -e cycles,instructions -I 100 record -o "${temp_data}" \
+		-- sleep 0.5 2>/dev/null; then
+		echo "perf stat failed (permissions?), skipping file mode test."
+		return
+	fi
+	ran=1
+
+	out=$("$PYTHON" "$script_path" -i "${temp_data}")
+	if ! echo "$out" | grep -q "cpi"; then
+		echo "File mode test failed."
+		err=1
+	else
+		echo "File mode test passed."
+	fi
+}
+
+test_live_mode
+test_file_mode
+
+cleanup
+if [ $ran -eq 0 ]; then
+	exit 2
+fi
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

