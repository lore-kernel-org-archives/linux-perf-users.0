Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2645379C2E
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967296; cv=none; b=jTlvS57oUf12MNgq/ou/ZxW8tQLnZywZqBrARRi6xyIg4Yr/8Iy/yMv9ofpROyD4XVGhj6Ov/wqtGTlfGRwWbelefyk61+G4eJLsepmYj/iDgZm9gPpibOEvEEric72kOlwSkvXC2im4W1qxH8HF/F1seey8Kg8hmudgXcchdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967296; c=relaxed/simple;
	bh=0/SYaViQrMbs8XryOfnVRjJuEPjHfcAjshkszToaPG4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ruY8d9FoY1UFC9mBlS4+uJO1Yei6j4VbGBqIySRdwoGQ5iuUw6c2nOAP2nv8n0MzUBScpVRhfQs6kZooxE3W+mATMGvnpzjNZOQXrvNh7PJbtmIdPtJlwn4ZJGpc86FlD3eqzPEwEqDjkYQbbvQ4hU5it8JIOIfDm3Q2j8osHDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrnJp0J8; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrnJp0J8"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e3dad7ab3so3618852a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967294; x=1790572094; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Xepk2apfuOboZqT//NbHCVV/SSJkRYFPLlKI6PrXvk=;
        b=RrnJp0J8plH21mLzjO57B2L16OBEIeZKE9+XxxZ9oFqc1+PmJmk8UHC4+YZLgkDCwE
         apuXHtt9iM+PZvJ9JhIrb/dHipbdDboUcfKIvT1tJbcR1L8qONAQM1Kl7ghjKadiR/9D
         gdUITO8IOlNia8eIcJnTcin0YDouKJL6ZGmSEH/qnouAR02U0rlLksBhM0mBYeXGNMs9
         1nKlb5kSAQXx8kb0WcpUUyetwiX3WWnT5JVxPpRXxqaR1XEfKAhIACKvwF+j9pwxFbcY
         ggvH5B0XUv/3iMBzsNVMX8hFkjNJADuytocMQzYjKheoxmt/mIThR93gU+SBLxbgyE+N
         nF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967294; x=1790572094;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Xepk2apfuOboZqT//NbHCVV/SSJkRYFPLlKI6PrXvk=;
        b=fXz8uHyh1urvU/M/zlGQiclPaR2Qe55Zva7jlROerO1zxo4CsNdFMYzZ4bhlxTXKCa
         KQoWt1BrgjE007l2IjsoEwV2x3v5CTEBPpzNaiOBfL0ghjxCPGQjSb5bvlvmN1iXZ8zc
         NrlPxehr44gMU3WNfguwPMjEtkJveHzxYWcan3V2TOEXTkcVKYoayj69IEZj9D76AYQb
         1JzpQ53+QBkjQa/N2+XqQsk6BZTMOGrTbPO3d7QVhRC1VzpCDpPXN4lHmctwqtd8k8am
         ENMp0pWKAcUCKizyKlZqz4zKTXv5t3zTtJUpYscRRMbEFtre+spvuscBkeynA0EGR0VB
         WIlA==
X-Forwarded-Encrypted: i=1; AKwUvBzbJGHis7CUpqbIiF6EMNA0reW+0wNSWqJCjFXGG5HXYSwFfeRH8oOsd/UB+d/M2W7CI7y7PPYF3AKhYqmLriOR@vger.kernel.org
X-Gm-Message-State: AFuF++n+wwpjdBG8IiOb1JjqA1Yu7fbAx6mHnEJ9KVt/qMpKqukm1ogq
	8PYrcMBus1FxIFmyYvP09hzwxqTxnafXwJRwC2kTbzXLA5oda6h/K7f7BN4SQvP6kP7UzlOH6yp
	ZG+UinhU7tw==
X-Received: from dlbvv19.prod.google.com ([2002:a05:7022:5f13:b0:143:6e9d:bb50])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dcd:b0:3a0:42a9:9c82
 with SMTP id 98e67ed59e1d1-3a04d4b9ec4mr1560622a91.43.1789967293616; Sun, 20
 Sep 2026 22:08:13 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:47 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <86e60126f2e97659c60583883a31e2c3e390dffe.1789966896.git.irogers@google.com>
Subject: [PATCH v2 29/49] perf python: Port rwtop from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Replace the legacy Perl script rwtop.pl with a standalone Python script
in tools/perf/python/rwtop.py using the perf Python module.

Improvements compared to the legacy Perl script:
- Remove the dependency on libperl and Perf::Trace::Util.
- Support both offline perf.data files (via perf.session) and live
  recording (via LiveSession with --live), driving periodic interval
  summaries from event timestamps rather than wall-clock SIGALRM timers
  so both live and offline runs produce deterministic output.
- Use session.is_64_bit (falling back to host bitness in live mode) when
  checking for negative syscall return values so 64-bit byte counts in
  0xfffff000..0xffffffff are not misclassified as 32-bit errors.
- Sanitize non-printable characters in /proc/<pid>/comm to prevent
  terminal control sequence injection.

Add a shell test
(test_rwtop_python.sh) to verify the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/rwtop.py                  | 247 ++++++++++++++++++++
 tools/perf/tests/shell/test_rwtop_python.sh |  76 ++++++
 2 files changed, 323 insertions(+)
 create mode 100755 tools/perf/python/rwtop.py
 create mode 100755 tools/perf/tests/shell/test_rwtop_python.sh

diff --git a/tools/perf/python/rwtop.py b/tools/perf/python/rwtop.py
new file mode 100755
index 000000000000..68366bf5b0de
--- /dev/null
+++ b/tools/perf/python/rwtop.py
@@ -0,0 +1,247 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Periodically displays system-wide r/w call activity, broken down by pid."""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+import os
+import sys
+from typing import Optional, Dict, Any
+import perf
+from perf_live import LiveSession
+
+class RwTop:
+    """Periodically displays system-wide r/w call activity."""
+    def __init__(self, interval: int = 3, nlines: int = 20) -> None:
+        self.offline = False
+        self.interval_ns = interval * 1000000000
+        self.nlines = nlines
+        self.reads: Dict[int, Dict[str, Any]] = defaultdict(
+            lambda: {
+                "bytes_requested": 0,
+                "bytes_read": 0,
+                "total_reads": 0,
+                "comm": "",
+                "errors": defaultdict(int),
+            }
+        )
+        self.writes: Dict[int, Dict[str, Any]] = defaultdict(
+            lambda: {
+                "bytes_requested": 0,
+                "bytes_written": 0,
+                "total_writes": 0,
+                "comm": "",
+                "errors": defaultdict(int),
+            }
+        )
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.comm_cache: Dict[int, str] = {}
+        self.session: Optional[perf.session] = None
+        self.last_print_time: int = 0
+        machine = os.uname().machine
+        self.host_64_bit = ("64" in machine or machine in ("s390x", "alpha")
+                            or sys.maxsize > 0xffffffff)
+
+    def get_comm(self, pid: int) -> str:
+        """Resolve and cache the comm(and) of a pid."""
+        comm = self.comm_cache.get(pid)
+        if comm:
+            return comm
+        comm = None
+        try:
+            if self.session:
+                thread = self.session.find_thread(pid)
+                comm = thread.comm() if thread else None
+            else:
+                with open(f"/proc/{pid}/comm", "r", encoding="utf-8", errors="replace") as f:
+                    comm = f.read().strip()
+        except (TypeError, AttributeError):
+            # find_thread returns None when the thread isn't known.
+            pass
+        except OSError:
+            # The thread may have exited before /proc could be read.
+            pass
+        if not comm:
+            comm = f"PID({pid})"
+        comm = ''.join(c if c.isprintable() else '?' for c in comm)
+        self.comm_cache[pid] = comm
+        return comm
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = str(sample.evsel)
+        pid = sample.sample_pid
+        sample_time = sample.sample_time
+
+        if self.last_print_time == 0:
+            self.last_print_time = sample_time
+
+        # Check if interval has passed
+        if sample_time > self.last_print_time and sample_time - self.last_print_time >= self.interval_ns:
+            self.print_totals()
+            self.last_print_time = sample_time
+
+        # Map each event onto the totals it updates. "enter" events count the
+        # requested bytes, "exit" events the transferred bytes or the error.
+        handlers = {
+            "evsel(syscalls:sys_enter_read)": (self.reads, "total_reads", None),
+            "evsel(syscalls:sys_exit_read)": (self.reads, None, "bytes_read"),
+            "evsel(syscalls:sys_enter_write)": (self.writes, "total_writes", None),
+            "evsel(syscalls:sys_exit_write)": (self.writes, None, "bytes_written"),
+        }
+        handler = handlers.get(event_name)
+        if not handler:
+            self.unhandled[event_name] += 1
+            return
+
+        totals, count_key, bytes_key = handler
+        try:
+            value = sample.count if count_key else sample.ret
+        except AttributeError:
+            self.unhandled[event_name] += 1
+            return
+
+        data = totals[pid]
+        data["comm"] = self.get_comm(pid)
+        if count_key:
+            data["bytes_requested"] += value
+            data[count_key] += 1
+        elif bytes_key:
+            is_64_bit = (getattr(self.session, "is_64_bit", self.host_64_bit)
+                         if self.session else self.host_64_bit)
+            if value > 0:
+                if not is_64_bit and 0xfffff000 <= value <= 0xffffffff:
+                    value -= 0x100000000
+                elif value >= 0xfffffffffffff000:
+                    value -= 0x10000000000000000
+            if value >= 0:
+                data[bytes_key] += value
+            else:
+                data["errors"][value] += 1
+
+    def print_totals(self) -> None:
+        """Print summary tables."""
+        if not self.offline:
+            print('\x1b[H\x1b[2J', end='')
+        print("read counts by pid:\n")
+        print(
+            f"{'pid':>6s}  {'comm':<20s}  {'# reads':>10s}  "
+            f"{'bytes_req':>10s}  {'bytes_read':>10s}"
+        )
+        print(f"{'-'*6}  {'-'*20}  {'-'*10}  {'-'*10}  {'-'*10}")
+
+        count = 0
+        for pid, data in sorted(self.reads.items(),
+                                key=lambda kv: kv[1]["bytes_read"], reverse=True):
+            print(
+                f"{pid:6d}  {data['comm']:<20s}  {data['total_reads']:10d}  "
+                f"{data['bytes_requested']:10d}  {data['bytes_read']:10d}"
+            )
+            count += 1
+            if count >= self.nlines:
+                break
+
+        print("\nfailed reads by pid:\n")
+        print(f"{'pid':>6s}  {'comm':<20s}  {'error #':>6s}  {'# errors':>10s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*6}  {'-'*10}")
+
+        errcounts = []
+        for pid, data in self.reads.items():
+            for error, cnt in data["errors"].items():
+                errcounts.append((pid, data["comm"], error, cnt))
+
+        sorted_errcounts = sorted(errcounts, key=lambda x: x[3], reverse=True)
+        for pid, comm, error, cnt in sorted_errcounts[:self.nlines]:
+            print(f"{pid:6d}  {comm:<20s}  {error:6d}  {cnt:10d}")
+
+        print("\nwrite counts by pid:\n")
+        print(
+            f"{'pid':>6s}  {'comm':<20s}  {'# writes':>10s}  "
+            f"{'bytes_req':>10s}  {'bytes_written':>13s}"
+        )
+        print(f"{'-'*6}  {'-'*20}  {'-'*10}  {'-'*10}  {'-'*13}")
+
+        count = 0
+        for pid, data in sorted(self.writes.items(),
+                                key=lambda kv: kv[1]["bytes_written"], reverse=True):
+            print(
+                f"{pid:6d}  {data['comm']:<20s}  {data['total_writes']:10d}  "
+                f"{data['bytes_requested']:10d}  {data['bytes_written']:13d}"
+            )
+            count += 1
+            if count >= self.nlines:
+                break
+
+        print("\nfailed writes by pid:\n")
+        print(f"{'pid':>6s}  {'comm':<20s}  {'error #':>6s}  {'# errors':>10s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*6}  {'-'*10}")
+
+        errcounts = []
+        for pid, data in self.writes.items():
+            for error, cnt in data["errors"].items():
+                errcounts.append((pid, data["comm"], error, cnt))
+
+        sorted_errcounts = sorted(errcounts, key=lambda x: x[3], reverse=True)
+        for pid, comm, error, cnt in sorted_errcounts[:self.nlines]:
+            print(f"{pid:6d}  {comm:<20s}  {error:6d}  {cnt:10d}")
+
+        # Reset counts
+        self.reads.clear()
+        self.writes.clear()
+        self.comm_cache.clear()
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        try:
+            self.session.process_events()
+        finally:
+            self.session = None
+
+        # Print final totals if there are any left
+        if self.reads or self.writes:
+            self.print_totals()
+
+        if self.unhandled:
+            print("\nunhandled events:\n")
+            print(f"{'event':<40s}  {'count':>10s}")
+            print(f"{'-'*40}  {'-'*10}")
+            for event_name, count in self.unhandled.items():
+                print(f"{event_name:<40s}  {count:10d}")
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace r/w activity by PID")
+    parser.add_argument(
+        "interval", type=int, nargs="?", default=3, help="Refresh interval in seconds"
+    )
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    parser.add_argument("-l", "--live", action="store_true", help="Run in live mode")
+    args = parser.parse_args()
+
+    analyzer = RwTop(args.interval)
+    try:
+        if args.live or (not os.path.exists(args.input) and args.input == "perf.data"):
+            # Live mode
+            events = (
+                "syscalls:sys_enter_read,syscalls:sys_exit_read,"
+                "syscalls:sys_enter_write,syscalls:sys_exit_write"
+            )
+            live_session = LiveSession(events, sample_callback=analyzer.process_event)
+            print("Live mode started. Press Ctrl+C to stop.", file=sys.stderr)
+            live_session.run()
+        else:
+            analyzer.offline = True
+            analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+    except KeyboardInterrupt:
+        if not analyzer.offline:
+            print("\nStopping live mode...", file=sys.stderr)
+        if analyzer.reads or analyzer.writes:
+            analyzer.print_totals()
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_rwtop_python.sh b/tools/perf/tests/shell/test_rwtop_python.sh
new file mode 100755
index 000000000000..43471a777199
--- /dev/null
+++ b/tools/perf/tests/shell/test_rwtop_python.sh
@@ -0,0 +1,76 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# rwtop python test
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
+script_path="${script_dir}/rwtop.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, rwtop.py not found at $script_path"
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
+echo "Testing rwtop.py..."
+
+# Create a perf.data file. Try to get tracepoint data.
+if perf list | grep -q "syscalls:sys_enter_read"; then
+	ev="syscalls:sys_enter_read,syscalls:sys_exit_read"
+	ev="${ev},syscalls:sys_enter_write,syscalls:sys_exit_write"
+	perf record -e "$ev" -a -o "${temp_data}" \
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
+# Check that the script executes
+if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	echo "rwtop.py test failed"
+	err=1
+else
+	if ! grep -E -q "^ *[0-9]+" "${temp_out}"; then
+		echo "Failed to find metric data rows"
+		err=1
+	else
+		echo "rwtop test passed."
+	fi
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

