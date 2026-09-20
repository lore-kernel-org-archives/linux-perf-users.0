Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A73E0080
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881813; cv=none; b=IB1jV2ajB9wZLAZBpit2bkgN/FHx0hhRfnbBoAUCUfJkHX259PbbrU3RfBnk3jyhSOSzIDC+1a+eu89btWHgks6wJYFUCAnw++JnKZKktwRNMwOOq8L1qSSL2qhH8cXS+KTzq2bFAYlXvCVuj39WK4CfvsK4mp6VGDTnHUcrXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881813; c=relaxed/simple;
	bh=0/SYaViQrMbs8XryOfnVRjJuEPjHfcAjshkszToaPG4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WjsXp7lfXz68m1IyYQE5kYnz11AviUxinvLsZuFBWGqJzQtGrjkxyDPVdKvJdBPq8XFHurTyH9CmV5f616f7FchWgDCIwP0c/FCvHZsWgjJ2LAmPh2GhA8UWGHD4iSH7yxLP7m1O/fs6WespS1Zg44DTPIw2bICKZaEABXFj0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5Ju8Pbh; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5Ju8Pbh"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso1958172a91.1
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881810; x=1790486610; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Xepk2apfuOboZqT//NbHCVV/SSJkRYFPLlKI6PrXvk=;
        b=P5Ju8PbhvwnPsO4qU78yvbz6dhru44eAxQH54xtttK79xnQtIxP0F5alhSw9chor+I
         o7WAF5yAtj6KHybgzUJWYTuxmNyTuQxNmb5nzg5LSWmGYvsA6Vb30650AbdP7PJ9DQ73
         XyZR2pDFOhqDsqkQ++4v+0IdJdJQFfafS8VkixCEKRkH5qnnpx9cHmEoTBfzrUFFEnGv
         eCH5xcdNwab+H9N9NVi3PB5CwY85non+lCz9sVE0l3f8NM/T4h+Hc/1IgjSf33YG6qew
         fX0BucztE7zjjSXWeJy4ogNkRGuCLm75iWhBt5Ot6jtPBUIB2NjmiT0ZVaqXboAOdBku
         kogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881810; x=1790486610;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Xepk2apfuOboZqT//NbHCVV/SSJkRYFPLlKI6PrXvk=;
        b=eBErILuSXK57eWYTuM2kqsTM7LMz0WDnIMqSLZzbbOwU64ivXVsssZp1lVh5pkuNE4
         YqOg9yKKbeEya5yFaUtNb9OrmY9kFY0KXhZpHKruo7tp/OaF2P/v8OblUakmVoA52S3n
         KrRtrHb8pSzGDxv+Qjj4bwJBRqpB0PxhZKY5OhV3+dm3cNPAbvsJ0zvBp1WkCUYMfRW3
         gBbFzNEyrucQLjyxGUZPFvNZvD0Emk/3FrSpWudqylfNz3fnw/KB1wbdL7H6CpKG0wTA
         Q+EdiMV0x8JbTgNSDJgsm+/Bgyzak8JzZdIVjBh0eF565rndGQOY7/4Yxa7Z6eprPKX2
         ecWw==
X-Forwarded-Encrypted: i=1; AKwUvBwIgMcKzL60A8tcQPGtHm0YjLRs7lfaKsVvlMHjRwuEyR4KeqW6jSl8HT659aY7pdW8vNdyeW0OiR+51QXlJOFg@vger.kernel.org
X-Gm-Message-State: AFuF++kG10aGCz+h1ekshXiuzobQU76OS0S4lSMvVPGj0Eb2VIibKLcV
	dfCEE0DtUc0poOQv2Y8ULvFSA/tj7rPtpqp6VKZ6/9BxB4Nw74st8ODAyWEuez+1IS5MuQJJgcO
	ycebCvE06XQ==
X-Received: from dlae20.prod.google.com ([2002:a05:701b:2314:b0:143:7cf0:d45a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4c:b0:39e:4c7f:7307
 with SMTP id 98e67ed59e1d1-39e5506f80fmr11995215a91.30.1789881809819; Sat, 19
 Sep 2026 22:23:29 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:21 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <d3441510cb4fe4ddd442f2ea17d96b775f24f35f.1789880842.git.irogers@google.com>
Subject: [PATCH v1 29/49] perf python: Port rwtop from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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

