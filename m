Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC884F391B
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187260; cv=none; b=DRQqOOWoJlMjP1bVx09Z1BSsAtBBjEISWa+fZt6ZqJ2lCOyNKu5sgiQka5bBO2LcCvdwXEsLlZ1Pgwq2+pD92aEyyiXRRMlOVpccQIS37NFXNO3uO3c0t67V2vTUwAAmf2mnBUq7BzpiSLtyzxZTVBgpxxXu0GH/8M6cfRedC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187260; c=relaxed/simple;
	bh=oDM5cfnPgZny7nNxsiE7/LxgP1gBLBrmCv98idra3p8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rV3MQGT3KlyGXLuSbY8JpXgrsvhpfFZ6E5HbFruO1UbOb3cVIBTVDGrXkuBFHjVUxkmOlgeSaLWT8g1dlEhl72fz6ZfgKrTfI1uUIGr+axPb0Zpc/xvF5JZK3YqML3Ghsr3iwNF9WsvtN7YDGGUEwo1tOAYYayXCLeu3rQrmAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzElHMwG; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzElHMwG"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1384427c3efso2025726c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187249; x=1790792049; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZAujvjsstHiHvA4EnFR19jevpQtdRujzfJuyCR5gBY=;
        b=EzElHMwG46InhAulcuItO6jVRQEuz3g1lPtFp9mPN49i/hfO2Rd1o7xj8cTf1ZJJmj
         dBL50QU5dRXz8q2qGAy+++eyfVeuFotLQYYuU25lMbpGNtbum0Noc4T6FSVa8yKHJY6A
         CE5Q8NNIJlQPupW9zOxYMzDML7nvSzrPPBnj5PVCc41Kt0iKt/MZLjRw+SEx9RM7nzV0
         0ndGdGeLRF29einlLe2PnzJ4rSZRK3ePqTY8MJgYUe5HLlQcfe7glu7wxGFEwSiclURQ
         49dA5nG6LbNR9SoIXvtTP4hKP2g5aYCLfmk6HM4OiyY9mmkWJpD8ppfsDyZI3YGzQGHj
         Neng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187249; x=1790792049;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZAujvjsstHiHvA4EnFR19jevpQtdRujzfJuyCR5gBY=;
        b=hMH9mqnCcXEUVewQrSTm4mWZApnCstpcNR+rUGykiNaqzZH1erZ9Mscwy6d5L/iXlE
         JMgunVp3BR/Eq1lEOuFQUGuqJ/vKjfPKiF4bCjMx/IkeD8zRQ9jz2OkXGxfS0WNQZWCH
         +BBw/u6KLx3sH/4HUTCj6U4VZJiSbVoZU7j2+FDJHxw0bs3uKFRF59u7Evps12+MGRvK
         xdLUzmDpvGDDpqerhK66SCO3N3SUc7bkYkFKy69ygT7m0sXkHEENGr92utHHmTVRu7KV
         BM6psRWXWtXwBJZReBEiAC32rFvwev7eDY9xFMH1Mx8Sxm9nJOmuh0A5QvXguz1jguB0
         WUhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTdgn7b34mlQvnBDnwoSdupw5v8J1p+20b1li+gGiEzRxYZpN/E+NXleg4TD7V631gMN3Yz8wI6cDwBdwK2Nli@vger.kernel.org
X-Gm-Message-State: AFuF++mBgJgjAc9UkjIOVNu5tJNOuwuhSNA/CWrKiL7SojYfqt5AjCJw
	/k4VCpcF95sA4zbSvLclwCjTQ5IW7kCOe9LJhETdUwLbYh2IP6TshTDRO29fE98HL69xlk3C34h
	KouwTvK+rNg==
X-Received: from dlea7-n1.prod.google.com ([2002:a05:701b:4207:10b0:144:e5a6:137a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:42d3:20b0:128:d4be:7428
 with SMTP id a92af1059eb24-144f9147d75mr3575101c88.19.1790187248314; Wed, 23
 Sep 2026 11:14:08 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:49 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-27-irogers@google.com>
Subject: [PATCH v3 26/49] perf python: Port sctop to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
 tools/perf/python/sctop.py                  | 246 ++++++++++++++++++++
 tools/perf/tests/shell/test_sctop_python.sh |  78 +++++++
 2 files changed, 324 insertions(+)
 create mode 100755 tools/perf/python/sctop.py
 create mode 100755 tools/perf/tests/shell/test_sctop_python.sh

diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
new file mode 100755
index 000000000000..fb709206993a
--- /dev/null
+++ b/tools/perf/python/sctop.py
@@ -0,0 +1,246 @@
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
+        # raw_syscalls:sys_enter exposes the syscall number as 'id', whereas
+        # per-syscall syscalls:sys_enter_* tracepoints expose '__syscall_nr' (or 'nr')
+        # and may have an unrelated syscall argument named 'id'.
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
2.56.0.rc1.310.g51773c2048-goog

