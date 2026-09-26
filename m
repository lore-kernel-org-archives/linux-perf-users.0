Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414253932FA
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403694; cv=none; b=KulP0wswJMlxmA4vdow4ksB8FzOLkE9C/v/owc5EdcqDz3RP4eUyXY/jSozkUAv0qDEKJU9mtEH5bdlrvbf7/mN4jtZ5peROX6HMMLnBwQlk7t+Jqwjn/Zgea4UhrQQXSdp+uVECmDNAWdC/q96fGsktY7yWOzd4grO0nI1fwu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403694; c=relaxed/simple;
	bh=IcHLRKnMo9Pmb5+ufSPoK4x+KX8ee3aTsNLdmYUBkgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OD+ow+mo8/mYfsIXsxsBumxvy6q6H6YVupeWqqPmKg8ugnH47v9pn/EL4QU7ZHupcbA22yd9vjACej9swfUvL3mKeNzvykhV83RN+occZfiX5AoU9f/QGlYJQR2+CHCHdi96ej1tv/FBM7EW7mr+Sth9mBaGia+FyVPoy9iq6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wNzn2lJV; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wNzn2lJV"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33baaba6371so3370084eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403690; x=1791008490; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2VTy0fhZUkh9vJnlgTm0ZQf5p9zy+2gGP4Pq+mFlu6o=;
        b=wNzn2lJVXTeviDKl/25LGMuCPDNLEXzmne1zSugaY1yZ6aH0cWj2hhkJvKOo8+5Ja3
         ywOSyZC7XcH3IjlrYu4wmIqVeaai5XEz7G5m3C4j/nO3woS0CMl0FF7kS0q7QmG3p7qr
         6mowlEPrpMivNn6PqMiMJeash6pmKDsgHNrQFY0idBDG5fEVzksvB4nSqdXTUfn1nIUF
         RFtNEbjNE1oUDzDK0d2IGZuKCDqBH0zdHjMm5tnfpsHiR1VCI8iaNZxA4cegy58VSfX7
         QKtdrreFW9DfL+X/OLqBSndk/PICE+JiHFrHvfrpzKtHCxFagGW1x6LUbv+IUIqCuX50
         Fq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403690; x=1791008490;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2VTy0fhZUkh9vJnlgTm0ZQf5p9zy+2gGP4Pq+mFlu6o=;
        b=ovWjMt3abrT/2HdI30BZgBMezdKZuP/KwdKJtCpCWPKSbHlifDbcC86S9zhTHCUal1
         N8GT0mCfodP5HzeFwuhpbGqj3f5zbJDd/OH/H4qr+g8sKMBmlLrjNOlWI4VtbA2T0nPK
         C5TQFwWZlHyyLnLrv4aqGUO+ZN2sNLSDU9kf06bdKkbTN0beZwPsZZacEVtSgJqohEHe
         bQzYS4sl/bqKS/nm412T6knCvtapMBgeWXIKhu7lyB7kg4QYS5fKXs2bZdtrsRQU/zts
         sDDg7M/gjwHgI8YZb43nBv8Ea0oE3SD3qZOmK17g6ooRa+btzh59iTpCS49T/Xfc4mGe
         aIWg==
X-Forwarded-Encrypted: i=1; AKwUvBwX2F0tqSLUc2hnxeahgwsmbaprO8QI5FOx9ojSPuwoJ5mAyF+Rc4unCdnwI8KFUtMnr520ZQ9rOiZsMGQQaiJI@vger.kernel.org
X-Gm-Message-State: AFuF++l5UWsb0rZYfwVrm4dl+zljf+OH7IYBNZabTtqS8boORdfUOexc
	nyWWncM6spNu74qrXzv57N/SG+K8CiwMGB9n4AGWrGtGQF4P764cxZie3b6q4e2oj+iyvQ6bAF0
	AcqYvs3IV2Q==
X-Received: from dyos30.prod.google.com ([2002:a05:7300:6c9e:b0:342:805e:c749])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:820c:b0:33c:e9d:6d4b
 with SMTP id 5a478bee46e88-34273057620mr2150826eec.41.1790403689769; Fri, 25
 Sep 2026 23:21:29 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:43 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-17-irogers@google.com>
Subject: [PATCH v4 16/49] perf python: Port stat-cpi to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/python/stat-cpi.py                 | 219 ++++++++++++++++++
 .../perf/tests/shell/test_stat_cpi_python.sh  | 115 +++++++++
 2 files changed, 334 insertions(+)
 create mode 100755 tools/perf/python/stat-cpi.py
 create mode 100755 tools/perf/tests/shell/test_stat_cpi_python.sh

diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
new file mode 100755
index 000000000000..0b7d76876a6c
--- /dev/null
+++ b/tools/perf/python/stat-cpi.py
@@ -0,0 +1,219 @@
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
+        self.data: dict[str, float] = {}
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
+        # Scale each raw event's delta by its own multiplexing ratio before
+        # summing across PMUs (e.g. cpu_core and cpu_atom on hybrid systems) so
+        # enabled time from an idle PMU does not inflate the multiplier of an
+        # active PMU.
+        scaled_val = cur_val * (cur_ena / float(cur_run)) if cur_run > 0 else float(cur_val)
+        self.data[key] = self.data.get(key, 0.0) + scaled_val
+
+    def get(self, event: str, cpu: int, thread: int) -> float:
+        """Get scaled counter value."""
+        key = self.get_key(event, cpu, thread)
+        return self.data.get(key, 0.0)
+
+    @staticmethod
+    def _classify_event(name: str) -> Optional[str]:
+        """Classify an event name as 'cycles' or 'instructions'."""
+        ev = name[6:-1] if name.startswith("evsel(") and name.endswith(")") else name
+        ev = ev.split(":", 1)[0]
+        if "/" in ev:
+            parts = [p for p in ev.split("/") if p]
+            if len(parts) >= 2:
+                ev = parts[1]
+        if ev in ("cycles", "cpu-cycles"):
+            return "cycles"
+        if ev == "instructions":
+            return "instructions"
+        return None
+
+    def process_stat_event(self, event: Any, name: Optional[str] = None) -> None:
+        """Process PERF_RECORD_STAT and PERF_RECORD_STAT_ROUND events."""
+        if event.type == perf.RECORD_STAT:
+            if name:
+                event_name = self._classify_event(name)
+                if not event_name:
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
+            event_name = self._classify_event(name)
+            if not event_name:
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
+        session: Optional[perf.session] = perf.session(
+            perf.data(self.args.input), stat=self.process_stat_event
+        )
+        try:
+            assert session is not None
+            session.process_events()
+        finally:
+            session = None
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
index 000000000000..0960afa4c797
--- /dev/null
+++ b/tools/perf/tests/shell/test_stat_cpi_python.sh
@@ -0,0 +1,115 @@
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
+	if ! perf stat -e cycles,instructions -- sleep 0.1 2>/dev/null && \
+	   ! perf stat -e cycles:u,instructions:u -- sleep 0.1 2>/dev/null; then
+		echo "perf stat failed (permissions?), skipping live mode test."
+		return 0
+	fi
+	perf test -w noploop &
+	workload_pid=$!
+	if ! perf stat -e cycles,instructions -p "$workload_pid" -- sleep 0.05 2>/dev/null && \
+	   ! perf stat -e cycles:u,instructions:u -p "$workload_pid" -- sleep 0.05 2>/dev/null; then
+		kill "$workload_pid" 2>/dev/null || true
+		workload_pid=""
+		echo "perf stat -p failed (ptrace_scope?), skipping live mode test."
+		return 0
+	fi
+	ran=1
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
+		-- sleep 0.5 2>/dev/null && \
+	   ! perf stat -e cycles:u,instructions:u -I 100 record -o "${temp_data}" \
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
2.56.0.rc1.315.gc6ed9934b7-goog

