Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D93B7B80
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960714; cv=none; b=k2dFtvulbNafK2Y96S5k6u+PhAliueWCCKrHD9DiPdxdqkO+6wCQ+3FLNVBoPYJwk63ThKHJtXUBSUNfQGNL/T95WlTGvhmULsfJHgdMaApRPFp9xf4oKKXEjH3J3LhLNKISljx6SjhkHuOBEY60zJkY2PdXhWIlXytWtrUGtnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960714; c=relaxed/simple;
	bh=uMcVqY3tLFf/EBgLaCY85EAcAR6+CrqpmehkhosaJ6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=opdBPOi2rThUaxmIeQDjhFl5MqoW6Ne/XOIW5Rf7Y1PliXUITy5cMf8kt0ZP6ijh+gaLJfkeAA8Oyj7afMsua+ySKcgmiCIZhxi8tdMMGdKZFy2YPYMIAILCxOp55shwChf9X88weRUj64BwBPYmWPPtHP2VoEcEvPKSSeyIhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wj7IQrM7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wj7IQrM7"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso8654564eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960712; x=1777565512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kptrmifDisWizsrGAKahHsaLZwGfXMmsel5Fko6HAYA=;
        b=wj7IQrM7QI1N+2x5qJeRLX+Ve3ZlThT/50wr+XutLiOfTO0kKfvXo4wkQY5EaIv2mj
         BEWDecdIeOuaPPrLtrKgdNEDmWkXCfGFcqSQSLfUJbmPu8J7hpN4Roymo4YOFno/Nv/W
         29rA02JHvSrPOs7/WAbencdl4MGMlkRSsMRLdb+m+Vb9NqedpBxQltJciz7SqPNemnoU
         7h79jFmCjfyD2ezMNwcU1PiimdPOvgXAjwriE69s2EI35WcsYZsZT2c8sBdKKrqWrFMj
         Xm29SHRGZ5SlZiAEvNE3Z956PBbZ56md8GBa8nzj4+beZ6BJZeudFmCi3oSvhsFep4+B
         8bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960712; x=1777565512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kptrmifDisWizsrGAKahHsaLZwGfXMmsel5Fko6HAYA=;
        b=RCPF83WM1deA52RD++gYMaPsBohMOdsZTpmLHTmUPnxi0WLLRCfhpLORu4c+2IdnjV
         S1Ncods/Z/BnAP3b+tUBHlV6pMdyNpwAXooHGXy2d3zbt3xhdUXKgfZbfqucqU89/1q9
         zhtNsSsf47IBXs04uY+4BXYj0uZwY8ff8vXaiD0h1OnCy87lsWc0FYWL0mzL7kyXkun0
         zmDauxX/Dc8wSLlTNXFUcN0qS3UJ4HN05FCIQ4oNg4NQ0fU0Ayb5ayOfJWC/A1R8f30O
         HVRN18wkTYqK81Bb0U4YU0kER6KXzk868Hl7GnNuY/U1mtjE5OODuBLklIh8QgD0T+pb
         rTzw==
X-Forwarded-Encrypted: i=1; AFNElJ/GeOCs7umMxOmyMOe2eJ1Ph0S2ZHtsq7LKnQwXeLxs3QpLapFymcc5QhCgkx/PdNu1/FrFw2oaj++6VQJ9hLwY@vger.kernel.org
X-Gm-Message-State: AOJu0YySX+L3eYmeUAATYd+AkYBx12SUaCrbkkGwVSwy3sfhJ5FjJZgu
	zhWFkRKxfWtFfAKMwBPSvWcJV9j82YrUpALOtrXHgqKdUTnE/v+8+FWJ3YzCZUyG2jc0zWZ+Wkt
	/mDdTh/6FmA==
X-Received: from dybdm8.prod.google.com ([2002:a05:7300:bb08:b0:2d8:5557:aec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1351:b0:2de:2f38:a7cb
 with SMTP id 5a478bee46e88-2e4788392f0mr15257672eec.18.1776960711165; Thu, 23
 Apr 2026 09:11:51 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:56 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-50-irogers@google.com>
Subject: [PATCH v3 49/58] perf rwtop: Port rwtop to use python module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

