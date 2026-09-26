Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16EB3955F7
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403712; cv=none; b=hlPaYTYoub0KGTSXKtbhJiZrag30hwhZneP3oOdr2ygDOrr9I+L/1bVUa0LN8yeAIBei3/KUXdaGUdcs/Bgs3LjPhx8nwF//qSWA/9nlFH/imWVhyMqJKl6/7Ts5IaEofOCU9qWvuVVieCjpJKbuxpY/GEgxNQnPQhtmXwIMI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403712; c=relaxed/simple;
	bh=8WRW+cQQWIv40IareULCqB/+caaxpid/+4/oLZAd65Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IOAU6AubZGkaIAw/gxtizaEOxVvMA/yAxxC7/9Yk6/6qwHFaQQtBub1OrT2/zCCYbt5uF44Spg8CP6475RleNVdKbltc4XfCiy03R1/v5yDhwlX04mdmSmGQ/OzyNpQ1Y+yW5nZ4f9bL1v+qkn5UI9ksD+dkYI4u4J/pnqz+k68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/tFku62; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/tFku62"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so3129661eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403710; x=1791008510; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VRyOC/44V7xC6boaalyU0dC17ni2MpTBxEKPm0mtmsE=;
        b=u/tFku62JhaW3b4YQpUp4iErrb8TbiCW/KNGQhqyYMcH4PA41Z6oWdW7awrTgNSBnH
         1cJ1PQsdhVLNdmjk/b9ARUoQo5d46eKRPrIiKgBJMiAMMQCha0DFjAl5U61uHdQUsEf+
         t6kZqiKT+5A6SbmRcHV8k4AsnoT8uTJlibfroZogG/8R0w+HRFh9dcG2OV2LsH1PV1vw
         bpn9hCzcwDyQcF/btdE+Gep7Fq33rh0efwZc2TZRVuN4y/h/pfX+IC3d1t4jzQ1k5BmI
         77CVu8/DcCoQAcTr1T3pzblm32hCs2NgdG+RbmkhJfAvuB4XijxgUwkp0YObdXMhSjwy
         z4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403710; x=1791008510;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VRyOC/44V7xC6boaalyU0dC17ni2MpTBxEKPm0mtmsE=;
        b=r9Hws0qxQxUizREe/dBcQTHbvE0qd8Qso4K1l9WEsubXNa9Xu1SZe/Li4yqZB6f9Xk
         HPkgZvDaoS3nCAYcPitsCdOSP9kruYHliNd+fBxVfOm4dskJsDuj8lwoO2uAOT9lfDVL
         yaZXFU7Wk+FT2MZWns7krZgz/mFRq+gN87y3wWWd6WZvshbTFP0P+hB4DVSgBqOIIBIM
         vo7H/gGeOwhh/KgYCEaoe/rGUmuVMYVZzuJ6LBk+ka7ll2j/skJiyJ0KdTg1boV/gs6B
         W9vod2cHvL99iALqSJiIjcrwJ2JNoRGcaj8EXuPH2lXp9R6Wou2tIHLA+R5nCdB3kcRo
         AZig==
X-Forwarded-Encrypted: i=1; AKwUvByxoRT7uuWP8yDfJMA2HSoxwhfgGm5AYjiznLnPRatynechz96Mf4voDFiDpqk62tj3jDjhpEDgn0J1tZBjo3bW@vger.kernel.org
X-Gm-Message-State: AFuF++lehk3EocXtCi9Og11pivNAoN4Fzt+clrE+5MAiT1aBLOfqcUUR
	S/gFkC8mSoljAIgh2KO5z4eLz9J5sE0Q2pllyr6aIY1K7vMfqQCoIE75cWNgOfXS5h9sIA+IRwn
	MdlNVFyaPfw==
X-Received: from dlbsw8.prod.google.com ([2002:a05:7022:3a88:b0:145:9130:6444])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f04:b0:143:39a0:19b5
 with SMTP id a92af1059eb24-146cffbd8cfmr2335526c88.22.1790403709739; Fri, 25
 Sep 2026 23:21:49 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:53 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-27-irogers@google.com>
Subject: [PATCH v4 26/49] perf python: Port sctop to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port sctop.py from tools/perf/scripts/python/ to a standalone script in
tools/perf/python/ using an SCTopAnalyzer class structure.

Improvements compared to the legacy script:
- Support both offline perf.data analysis (via perf.session, advancing
  display intervals deterministically using event timestamps) and live
  monitoring (via LiveSession with automatic tracepoint fallback from
  raw_syscalls:sys_enter to syscalls:sys_enter_*).
- Resolve architecture-aware syscall names via
  perf.syscall_name(id, session.e_machine) without requiring
  python-audit.
- Replace unsafe signal.SIGALRM dictionary mutation and os.popen("clear")
  subshell spawning with a synchronized threading.Lock / threading.Event
  timer and direct ANSI terminal escape sequences ('\x1b[2J\x1b[H').

Add a shell test (test_sctop_python.sh) to verify the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/sctop.py                  | 250 ++++++++++++++++++++
 tools/perf/tests/shell/test_sctop_python.sh |  78 ++++++
 2 files changed, 328 insertions(+)
 create mode 100755 tools/perf/python/sctop.py
 create mode 100755 tools/perf/tests/shell/test_sctop_python.sh

diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
new file mode 100755
index 000000000000..42e95ecfffad
--- /dev/null
+++ b/tools/perf/python/sctop.py
@@ -0,0 +1,250 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+System call top
+
+Periodically displays system-wide system call totals, broken down by
+syscall.  If a [comm] arg is specified, only syscalls called by
+[comm] are displayed. If an [interval] arg is specified, the display
+will be refreshed every [interval] seconds.  The default interval is
+3 seconds.
+
+Ported from tools/perf/scripts/python/sctop.py
+"""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+import os
+import sys
+import threading
+from typing import Optional
+import perf
+from perf_live import LiveSession
+
+
+class SCTopAnalyzer:
+    """Periodically displays system-wide system call totals."""
+
+    def __init__(self, for_comm: Optional[str], interval: int, offline: bool = False):
+        self.for_comm = for_comm
+        self.interval = interval
+        self.syscalls: dict[int, int] = defaultdict(int)
+        self.comm_cache: dict[int, str] = {}
+        self.lock = threading.Lock()
+        self.stop_event = threading.Event()
+        self.thread = threading.Thread(target=self.print_syscall_totals)
+        self.offline = offline
+        self.own_pid = os.getpid()
+        self.last_print_time: Optional[int] = None
+        self.session: Optional[perf.session] = None
+        self.e_machine: Optional[int] = None
+
+    def syscall_name(self, syscall_id: int) -> str:
+        """Lookup syscall name by ID."""
+        # Mask out the x86_64 x32 ABI bit (__X32_SYSCALL_BIT = 0x40000000) before
+        # resolving the syscall number in the architecture's syscall table.
+        raw_sc_id = syscall_id & ~0x40000000
+        try:
+            e_machine = getattr(self.session, "e_machine", self.e_machine)
+            if e_machine is not None:
+                name = perf.syscall_name(raw_sc_id, e_machine)
+            else:
+                name = perf.syscall_name(raw_sc_id)
+            if name is not None:
+                return name
+        except (TypeError, OverflowError):
+            pass
+        return str(syscall_id)
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Collect syscall events."""
+        if not self.offline and sample.sample_pid == self.own_pid:
+            return
+
+        name = str(sample.evsel)
+        # Per-syscall syscalls:sys_enter_* tracepoints expose '__syscall_nr' (or 'nr')
+        # and may have an unrelated syscall argument named 'id', whereas
+        # raw_syscalls:sys_enter (and legacy pre-2.6.35 syscalls:sys_enter) expose 'id'.
+        if name.startswith("evsel(syscalls:sys_enter_"):
+            syscall_id = getattr(sample, "__syscall_nr", -1)
+            if not (0 <= (syscall_id & ~0x40000000) <= 0xffff):
+                syscall_id = getattr(sample, "nr", -1)
+        elif name.startswith(("evsel(raw_syscalls:sys_enter", "evsel(syscalls:sys_enter")):
+            syscall_id = getattr(sample, "id", -1)
+            if not (0 <= (syscall_id & ~0x40000000) <= 0xffff):
+                syscall_id = getattr(sample, "__syscall_nr", -1)
+            if not (0 <= (syscall_id & ~0x40000000) <= 0xffff):
+                syscall_id = getattr(sample, "nr", -1)
+        else:
+            syscall_id = -1
+
+        skip = False
+        with self.lock:
+            if self.for_comm is not None:
+                is_execve = (0 <= (syscall_id & ~0x40000000) <= 0xffff and
+                             self.syscall_name(syscall_id) in ("execve", "execveat"))
+                if is_execve:
+                    self.comm_cache.pop(sample.sample_pid, None)
+
+                comm = "Unknown"
+                if hasattr(self, 'session') and self.session:
+                    # In offline perf.data mode, query session.find_thread() directly
+                    # so PERF_RECORD_COMM updates after execve (e.g. perf -> sleep)
+                    # are reflected immediately rather than returning a stale cached comm.
+                    try:
+                        proc = self.session.find_thread(sample.sample_pid, sample.sample_tid)
+                        if proc:
+                            comm = proc.comm() or "Unknown"
+                    except TypeError:
+                        pass
+                    if comm != "Unknown" and not is_execve:
+                        self.comm_cache[sample.sample_pid] = comm
+                    elif sample.sample_pid in self.comm_cache:
+                        comm = self.comm_cache[sample.sample_pid]
+                elif sample.sample_pid in self.comm_cache:
+                    comm = self.comm_cache[sample.sample_pid]
+                else:
+                    try:
+                        with open(f"/proc/{sample.sample_pid}/comm", "r",
+                                  encoding="utf-8", errors="replace") as f:
+                            comm = f.read().strip()
+                    except OSError:
+                        comm = "Unknown"
+                    # Cache both matching and non-matching comms (including "Unknown"
+                    # when a PID has exited or is inaccessible) so live system-wide
+                    # tracing does not re-open /proc/<pid>/comm on every syscall.
+                    # Do not cache during sys_enter(execve/execveat) since /proc/<pid>/comm
+                    # still holds the pre-exec command name until the syscall completes.
+                    if not is_execve:
+                        self.comm_cache[sample.sample_pid] = comm
+
+                if comm != self.for_comm:
+                    skip = True
+
+            is_enter = (name.startswith("evsel(raw_syscalls:sys_enter") or
+                        name.startswith("evsel(syscalls:sys_enter"))
+            if not skip and is_enter and 0 <= (syscall_id & ~0x40000000) <= 0xffff:
+                self.syscalls[syscall_id] += 1
+
+        if self.offline and hasattr(sample, "sample_time"):
+            interval_ns = self.interval * (10 ** 9)
+            if self.last_print_time is None:
+                self.last_print_time = sample.sample_time
+            elif sample.sample_time - self.last_print_time >= interval_ns:
+                self.print_current_totals()
+                self.last_print_time = sample.sample_time
+
+    def print_current_totals(self):
+        """Print current syscall totals."""
+        # Clear terminal
+        if not self.offline:
+            print("\x1b[2J\x1b[H", end="")
+        else:
+            print()
+
+        with self.lock:
+            for_comm = self.for_comm
+        if for_comm is not None:
+            print(f"\nsyscall events for {for_comm}:\n")
+        else:
+            print("\nsyscall events:\n")
+
+        print(f"{'event':40s}  {'count':10s}")
+        print(f"{'-' * 40:40s}  {'-' * 10:10s}")
+
+        with self.lock:
+            current_syscalls = list(self.syscalls.items())
+            self.syscalls.clear()
+            self.comm_cache.clear()
+
+        current_syscalls.sort(key=lambda kv: (-kv[1], kv[0]))
+
+        for syscall_id, val in current_syscalls:
+            print(f"{self.syscall_name(syscall_id):<40s}  {val:10d}")
+
+    def print_syscall_totals(self):
+        """Periodically print syscall totals."""
+        while not self.stop_event.is_set():
+            self.print_current_totals()
+            self.stop_event.wait(self.interval)
+        # Print final batch
+        self.print_current_totals()
+
+    def start(self):
+        """Start the background thread."""
+        self.thread.start()
+
+    def stop(self):
+        """Stop the background thread."""
+        self.stop_event.set()
+        self.thread.join()
+
+
+def main():
+    """Main function."""
+    ap = argparse.ArgumentParser(description="System call top")
+    ap.add_argument("args", nargs="*", help="[comm] [interval] or [interval]")
+    ap.add_argument("-i", "--input", help="Input file name")
+    args = ap.parse_args()
+
+    for_comm = None
+    default_interval = 3
+    interval = default_interval
+
+    if len(args.args) > 2:
+        print("Usage: python sctop.py [comm] [interval]")
+        sys.exit(1)
+
+    if len(args.args) > 1:
+        for_comm = args.args[0]
+        try:
+            interval = int(args.args[1])
+        except ValueError:
+            print(f"Invalid interval: {args.args[1]}")
+            sys.exit(1)
+    elif len(args.args) > 0:
+        try:
+            interval = int(args.args[0])
+        except ValueError:
+            for_comm = args.args[0]
+            interval = default_interval
+
+    analyzer = SCTopAnalyzer(for_comm, interval, offline=bool(args.input))
+    session = None
+
+    try:
+        if args.input:
+            session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+            analyzer.session = session
+            session.process_events()
+            analyzer.e_machine = getattr(session, "e_machine", None)
+        else:
+            try:
+                live_session = LiveSession(
+                    "raw_syscalls:sys_enter", sample_callback=analyzer.process_event
+                )
+            except OSError:
+                live_session = LiveSession(
+                    "syscalls:sys_enter_*", sample_callback=analyzer.process_event
+                )
+            analyzer.start()
+            live_session.run()
+    except KeyboardInterrupt:
+        pass
+    except (OSError, IOError) as e:
+        print(f"Error: {e}", file=sys.stderr)
+        sys.exit(1)
+    finally:
+        if args.input:
+            analyzer.print_current_totals()
+            # Break the reference cycle between perf.session and analyzer.process_event
+            # because perf.session lacks cyclic GC support (tp_traverse).
+            analyzer.session = None
+            session = None
+        elif analyzer.thread.is_alive():
+            analyzer.stop()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_sctop_python.sh b/tools/perf/tests/shell/test_sctop_python.sh
new file mode 100755
index 000000000000..cd38cdd4794c
--- /dev/null
+++ b/tools/perf/tests/shell/test_sctop_python.sh
@@ -0,0 +1,78 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# sctop python test
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
+script_path="${script_dir}/sctop.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, sctop.py not found at $script_path"
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
+echo "Testing sctop.py..."
+
+# Create a perf.data file.
+if perf list | grep -q "raw_syscalls:sys_enter"; then
+	perf record -e raw_syscalls:sys_enter -a -o "${temp_data}" \
+		-- sleep 0.1 >/dev/null 2>&1 || \
+		{ echo "Skipping test, perf record failed"; exit 2; }
+else
+	echo "Skipping test, no raw_syscalls:sys_enter event"
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
+	echo "sctop.py test failed"
+	err=1
+elif ! grep -E -q "[0-9]+$" "${temp_out}"; then
+	echo "Failed to find metric data rows in default run"
+	err=1
+elif ! "$PYTHON" "$script_path" -i "${temp_data}" sleep 1 > "${temp_out}"; then
+	echo "sctop.py comm+interval test failed"
+	err=1
+else
+	if ! grep -E -q "[0-9]+$" "${temp_out}"; then
+		echo "Failed to find metric data rows"
+		err=1
+	else
+		echo "sctop test passed."
+	fi
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

