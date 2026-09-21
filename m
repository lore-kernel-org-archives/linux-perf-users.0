Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2206376BEA
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967291; cv=none; b=OrKuHR+s7mk0svP0G3IAp3XGRMlzBsY813AJecS52QXZn8/wCgkgQGQ6cPfUvHsQfv6wGUXDOQ4y4JzniUHWgKkZulgwz43Rea/ZQdxKYt5rhMmXYW46B/wTC8DOqTGt/reWmLj0iyYp27LAnT9Y3aQGGtg3EZxMl52thRkpcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967291; c=relaxed/simple;
	bh=UdzRhh6t2lrCVi+myaDKnidF4ImDt6n7tdTPzcb7WIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cJyMKsoBMXZScXEgVNLUGs8fLvtPBcLT6jYiitr0AxY0rhX6teETlX1Xy4TmI/CJtUdtslCUyI/0xeA66d2UUji+zBjq3eF1qTrKFKARAYz1C2yfD+przGdT/tHHZIEE4hEjrBck6LHmCMcm/MHs9zBH5ArzdekEJ9aFGlsV3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMCee/Er; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMCee/Er"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so6788749a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967288; x=1790572088; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOKde/3n16LGCg97frP4KXaQAk43KJt/m20lCQU795M=;
        b=rMCee/ErhESTmuGbaC+ii9VClFE/tffBJF80Bd8QwsD9UHsVLW6Xbo48dPRepnaab3
         Z5IE+kQKs1K94VAFOszbRnAphFAx7EO4BF7Vmya1/0eGJPg6EWer52OsC2D6CJuNW9kA
         V7vgNM8zIeKQ9N51seT/AKZI89LytF4t+6Sws6UE2/pZrJ165eEdEI5oZAfX/DryBPhI
         znWh/JLD3uq7PKHmSwyzzMwgQC2Rgaxi/E+GpV5zqWXabyMZu96UGXT1/buJ+XAs6e2o
         uTOgXtdm6nfZA+0lYGMGqcYmaufTlHDFqqKpYGhKQisg4ps8r4/Qqil61AbZmMdeLVdR
         maJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967288; x=1790572088;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOKde/3n16LGCg97frP4KXaQAk43KJt/m20lCQU795M=;
        b=FyTL8Ep7E6AxRYhNGqfI8dtcmxOj0wacwzzygOaelVUPBXp6Fr2TtWUr9nWJ1o4lao
         kISw391d19c05q861K9QpG4HCdT+U0HvMmB0D9tGMLrkbXli+LkLu14HebWbfiOpXL+p
         pbbRLOojbkAe5M2rbCGBv/sbGpPRklEXxbz2J266r3CO33il1A0ciGMs5u2QJY4IraVm
         KNM/V9kwe9J/vyv0ZWJRYgIQYvP0gKxBYcsWfz8e/paAlCvalqegU/m9OIwsAW5O4Rro
         5LwV0+HKK8B5IyTj8dlpsNXaA94846vun1v1eygKe/BXw3UG8IIYfj9oJHF7f00r/oAB
         SGcw==
X-Forwarded-Encrypted: i=1; AKwUvByoecJSIsdNEs/bNr8SlV1XbE1b4bsPCbxfbNV6BiQ+yI/myJWCUusbmMRiB1FaulDgWe0NY+PBPXrPwYcWatCu@vger.kernel.org
X-Gm-Message-State: AFuF++mrHpPIcQO5H9g2v7szhw5YJaFd/pcZoMw9THZXdiKvyiKx9Rbu
	rpERMUX8CsYc5rMLxO/P7wg28tQUV6LjhKdeqLATVGScdVJujCvAdRdOvMf3WQFn2f7957XBnYw
	hy3toRTvLOg==
X-Received: from dli5-n1.prod.google.com ([2002:a05:7022:285:10b0:144:bebe:a64])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:180b:b0:3a0:3881:ead0
 with SMTP id 98e67ed59e1d1-3a03881ed91mr4341433a91.11.1789967288203; Sun, 20
 Sep 2026 22:08:08 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:44 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <34b516365b1309e631459ef0871e2330565d5150.1789966896.git.irogers@google.com>
Subject: [PATCH v2 26/49] perf python: Port sctop to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
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
 tools/perf/python/sctop.py                  | 220 ++++++++++++++++++++
 tools/perf/tests/shell/test_sctop_python.sh |  71 +++++++
 2 files changed, 291 insertions(+)
 create mode 100755 tools/perf/python/sctop.py
 create mode 100755 tools/perf/tests/shell/test_sctop_python.sh

diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
new file mode 100755
index 000000000000..e774a985dec3
--- /dev/null
+++ b/tools/perf/python/sctop.py
@@ -0,0 +1,220 @@
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
+import sys
+import threading
+from typing import Optional
+import perf
+from perf_live import LiveSession
+
+
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
+        self.last_print_time: Optional[int] = None
+        self.session: Optional[perf.session] = None
+        self.e_machine: Optional[int] = None
+
+    def syscall_name(self, syscall_id: int) -> str:
+        """Lookup syscall name by ID."""
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
+        name = str(sample.evsel)
+        if name.startswith("evsel(raw_syscalls:sys_enter"):
+            syscall_id = getattr(sample, "id", -1)
+        elif name.startswith("evsel(syscalls:sys_enter"):
+            syscall_id = getattr(sample, "__syscall_nr", -1)
+            if not (0 <= (syscall_id & ~0x40000000) <= 0xffff):
+                syscall_id = getattr(sample, "nr", -1)
+        else:
+            syscall_id = -1
+
+        skip = False
+        with self.lock:
+            if self.for_comm is not None:
+                comm = "Unknown"
+                if sample.sample_pid in self.comm_cache:
+                    comm = self.comm_cache[sample.sample_pid]
+                elif hasattr(self, 'session') and self.session:
+                    try:
+                        proc = self.session.find_thread(sample.sample_pid)
+                        if proc:
+                            comm = proc.comm() or "Unknown"
+                    except TypeError:
+                        pass
+                else:
+                    try:
+                        with open(f"/proc/{sample.sample_pid}/comm", "r",
+                                  encoding="utf-8", errors="replace") as f:
+                            comm = f.read().strip()
+                    except OSError:
+                        comm = "Unknown"
+                self.comm_cache[sample.sample_pid] = comm
+
+                if comm != self.for_comm:
+                    skip = True
+
+            is_enter = (name.startswith("evsel(raw_syscalls:sys_enter") or
+                        name.startswith("evsel(syscalls:sys_enter"))
+            if not skip and is_enter and 0 <= (syscall_id & ~0x40000000) <= 0xffff:
+                self.syscalls[syscall_id] += 1
+
+
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
+            if len(self.comm_cache) > 4096:
+                self.comm_cache.clear()
+
+        current_syscalls.sort(key=lambda kv: (kv[1], kv[0]), reverse=True)
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
+
+    if not args.input:
+        analyzer.start()
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
+            live_session.run()
+    except KeyboardInterrupt:
+        pass
+    except IOError as e:
+        print(f"Error: {e}")
+    finally:
+        if args.input:
+            analyzer.print_current_totals()
+            analyzer.session = None
+        else:
+            analyzer.stop()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_sctop_python.sh b/tools/perf/tests/shell/test_sctop_python.sh
new file mode 100755
index 000000000000..da7d9468e987
--- /dev/null
+++ b/tools/perf/tests/shell/test_sctop_python.sh
@@ -0,0 +1,71 @@
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
+elif ! "$PYTHON" "$script_path" -i "${temp_data}" sleep 1 >/dev/null; then
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
2.55.0.1082.g2b9226bbc0-goog

