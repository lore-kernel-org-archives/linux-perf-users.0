Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA653EFD24
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049373; cv=none; b=lMzkrYIkFrX75rui7Z13E5fM7qCmJFrQyNdX8EFowFHXuyBazX+fx4TDngw9DuOucfU9pAS9hUhAMjNGBTHbdJV2mEp8YKD72vVzPjIpYVY1r39LO7tHHVGbizxTXPo6QxBEUye5aZaxdzmLbrseYuT8g6jExEDB3WIXCjiobLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049373; c=relaxed/simple;
	bh=YfKxsLwSufjzQZJ2Vhab4VgJEYHLZpmPCV1BFI/tOVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ddpYKVt2T+qDF0KPxBaulcgHP06J4XJyuUh3EQkCVoAqu710e0Teq4gJHX0cyUKPl3j6egWe1ZsuKnWm4mReNw++XEj9QoyCcuuoBW5TWDKVujpawj/1OpyTk4+pSV/YYLJAi+LGO1lEHu+84WLPJvoqUIRYSQqKoraof3ZH5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exiaYOvd; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exiaYOvd"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so20877556eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049371; x=1777654171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOo+PD5GiuApXEZtI+hIHiYvPjKohUv6N0pH8kVj+zs=;
        b=exiaYOvdt9x3HStSsG4NGC9uCdrfkKAxvVsQKb0jRmak2mnMKIO/nIuYLkZBpgT+8w
         j3O/lep3mLM1tOJWKbIR/g0ZzDDJVMlMh9JmZYM6CPzGiilaEuh9V3KhWxUxFWv2VabQ
         dj1LGz2LTIBdCv8iKEsyEnKT+4EBTwpZaCaAXKih4HTnunQCMniqG0YGsfOx8w9Czf2V
         XJh2BvAr5Jky/Pu+l1SNy94FPaOY1ZobJivrhIJkeEbg8EdM+Uxi3SpkW/pmHxMMbAUE
         Rh8ADlAmKSuYJ5ckbhrnZ1MIJ8OueXSmaShUEGnU7XqdYL3T/61it3g6tgtSkoaLptME
         LuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049371; x=1777654171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOo+PD5GiuApXEZtI+hIHiYvPjKohUv6N0pH8kVj+zs=;
        b=WaUlSA1gEr2OpDTzBurqtcTryTInefvm1MGOLv+WtLpA+Iq6DbqXeZXiBQxp501yoF
         rEwAGSanKqqofWDKItfHZles7HaLY/DtxkD4KAIukZUPsfmZcK+DWRCmHTsgUX8EUi3f
         e5muwxx2Zkypqh/Gm/ub0QAKPhLR0RNUBpO2k39MG1EokxwZHR0I4+Xsaey2Ta7xtGQ9
         XBoJQyDhIW6G9KKK8gERIYTcyZ0i95iFLzKFAhBp0w+v3o62vIUp6Fezor3jkq51iZJZ
         IzkZ8qib3cr6oQaCZCs0QgCZfs8BUtcLcBMFwPfOr2pyQIk8I6e0JHgjLYQwaJj1U8Ob
         Pz/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+l3dzNi6fXKLnjMZKN5Qbrr6JB19E4q0be5Cu0jRH/YtxOpSC5X5Y22OS/uE8ONsJCFcdxfHe9h11+ZUYwNQgn@vger.kernel.org
X-Gm-Message-State: AOJu0YzsW/i807PfZr3APyXcXDEVfm97ssM8pdcCJNolefsAxCn1wldt
	LM0xUZ+zOZLkTGxnFaxrpuKKGfhrarRHtxXCLI8xqKx7QLsasiAiNIzbbhcOd5fvzzn1WPUWL/n
	wLXUXzyxeiQ==
X-Received: from dybsc10.prod.google.com ([2002:a05:7301:4b0a:b0:2d9:eac3:9773])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:23a8:b0:2e5:5bf4:8869
 with SMTP id 5a478bee46e88-2e55bf49b47mr14581041eec.21.1777049370562; Fri, 24
 Apr 2026 09:49:30 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:12 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-51-irogers@google.com>
Subject: [PATCH v5 50/58] perf rwtop: Port rwtop to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Port the legacy Perl script rwtop.pl to a python script using the perf
module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing.

It periodically displays system-wide r/w call activity, broken down by
PID, refreshed every interval.

Complications:
- Implemented periodic display based on event timestamps
  (sample.sample_time) instead of relying on SIGALRM, making it robust
  for file-based processing.
- Used ANSI escape codes (\x1b[H\x1b[2J) to clear the terminal.
- Fixed unused imports and indentation issues identified by pylint.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

 - Added Live Session Support: Updated main() to start a LiveSession
   when the input file does not exist (or is the default "perf.data"
   and doesn't exist). It traces read and write entry/exit
   tracepoints.

 - Fixed Live Mode Comm Resolution: Fixed a bug in process_event()
   where it would attempt to use self.session to resolve the command
   name when running in live mode (where self.session is None ). It
   now falls back to f"PID({pid})" when in live mode or if resolution
   fails.

 - Fixed Substring Matching: Replaced loose substring checks like if
   "sys_enter_read" in event_name: with exact matches against
   "evsel(syscalls:sys_enter_read)" and
   "evsel(raw_syscalls:sys_enter_read)" using str(sample.evsel) . This
   prevents unrelated syscalls with similar names (like readv or
   readahead ) from being incorrectly aggregated. Similar fixes were
   applied for exit events and write events.

 - Inlined Handlers and Tracked Errors: Inlined the _handle_sys_*
   helper methods into process_event() . Now, if a sample lacks
   expected fields, it is added to the self.unhandled tracker instead
   of being silently ignored.

 - Fixed Write Byte Counting: Updated the write exit handler to use
   sample.ret to count actual bytes written on success, and tracked
   requested bytes separately in the enter handler, matching the read
   behavior.

 - Added Error Tables to Output: Added tables to display failed reads
   and writes by PID in print_totals() , which were previously tracked
   but never displayed.

 - Fixed Offline Output (Ghosting): Removed the hardcoded ANSI
   clear-screen escape codes in print_totals() , as they corrupted
   output when processing offline trace files at CPU speed or when
   piping the output.

 - Code Cleanup: Fixed a bug where fd was printed instead of pid in
   the read counts table, and broke long lines to satisfy pylint.
---
 tools/perf/python/rwtop.py | 219 +++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100755 tools/perf/python/rwtop.py

diff --git a/tools/perf/python/rwtop.py b/tools/perf/python/rwtop.py
new file mode 100755
index 000000000000..952d178e99c5
--- /dev/null
+++ b/tools/perf/python/rwtop.py
@@ -0,0 +1,219 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Periodically displays system-wide r/w call activity, broken down by pid."""
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
+        self.session: Optional[perf.session] = None
+        self.last_print_time: int = 0
+
+    def process_event(self, sample: perf.sample_event) -> None:  # pylint: disable=too-many-branches
+        """Process events."""
+        event_name = str(sample.evsel)
+        pid = sample.sample_pid
+        sample_time = sample.sample_time
+
+        if self.last_print_time == 0:
+            self.last_print_time = sample_time
+
+        # Check if interval has passed
+        if sample_time - self.last_print_time >= self.interval_ns:
+            self.print_totals()
+            self.last_print_time = sample_time
+
+        try:
+            comm = f"PID({pid})" if not self.session else self.session.process(pid).comm()
+        except Exception:  # pylint: disable=broad-except
+            comm = f"PID({pid})"
+
+        if event_name in ("evsel(syscalls:sys_enter_read)", "evsel(raw_syscalls:sys_enter_read)"):
+            try:
+                count = sample.count
+                self.reads[pid]["bytes_requested"] += count
+                self.reads[pid]["total_reads"] += 1
+                self.reads[pid]["comm"] = comm
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif event_name in ("evsel(syscalls:sys_exit_read)", "evsel(raw_syscalls:sys_exit_read)"):
+            try:
+                ret = sample.ret
+                if ret > 0:
+                    self.reads[pid]["bytes_read"] += ret
+                else:
+                    self.reads[pid]["errors"][ret] += 1
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif event_name in ("evsel(syscalls:sys_enter_write)",
+                            "evsel(raw_syscalls:sys_enter_write)"):
+            try:
+                count = sample.count
+                self.writes[pid]["bytes_requested"] += count
+                self.writes[pid]["total_writes"] += 1
+                self.writes[pid]["comm"] = comm
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif event_name in ("evsel(syscalls:sys_exit_write)", "evsel(raw_syscalls:sys_exit_write)"):
+            try:
+                ret = sample.ret
+                if ret > 0:
+                    self.writes[pid]["bytes_written"] += ret
+                else:
+                    self.writes[pid]["errors"][ret] += 1
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        else:
+            self.unhandled[event_name] += 1
+
+    def print_totals(self) -> None:
+        """Print summary tables."""
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
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
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
+    args = parser.parse_args()
+
+    analyzer = RwTop(args.interval)
+    try:
+        if not os.path.exists(args.input) and args.input == "perf.data":
+            # Live mode
+            events = (
+                "syscalls:sys_enter_read,syscalls:sys_exit_read,"
+                "syscalls:sys_enter_write,syscalls:sys_exit_write"
+            )
+            try:
+                live_session = LiveSession(events, sample_callback=analyzer.process_event)
+            except OSError:
+                events = (
+                    "raw_syscalls:sys_enter_read,raw_syscalls:sys_exit_read,"
+                    "raw_syscalls:sys_enter_write,raw_syscalls:sys_exit_write"
+                )
+                live_session = LiveSession(events, sample_callback=analyzer.process_event)
+            print("Live mode started. Press Ctrl+C to stop.", file=sys.stderr)
+            live_session.run()
+        else:
+            analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+    except KeyboardInterrupt:
+        print("\nStopping live mode...", file=sys.stderr)
+        if analyzer.reads or analyzer.writes:
+            analyzer.print_totals()
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.545.g6539524ca2-goog

