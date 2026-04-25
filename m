Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83963A0E8E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157468; cv=none; b=o6mIm/rADHoBsM2OzcnuXnS8o7Fqeus8PAx6Xn8ZgDwKXT4MEAAbwgw9IxcxBnzuG27a7wBe6gUoniZSqxPJH5TZaOLbWyIjjPM0rponImtzZTBGf3v0rWB42NT7idGTgsoaLfnKZw6LLDZXtXJltng0YPQI47GPwH7Vex3NCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157468; c=relaxed/simple;
	bh=eJ9kVepVnSBQCHOyn4G/66b2UzKOBaVMlZphDP73+zk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hh+TLSljUIvhYVmk77Lo70TU5Rew7rX9Tsx0IVo3CQfu9M3Lu4ozkukyc84Lvw4vruIlU+rPgIUsr47kCmvm7jvpSnrjPl+bmhzsc1BeAahPS2dsFXF0OVSoRZ7Rlzm9BujqbFMijqhSb/TSVOurVXMAYm4MAvEtxNQnHcOoWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUkOMUAC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUkOMUAC"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24611696eso61950275ad.3
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157465; x=1777762265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNEC1d+XQU6xcwJqo0QpL4AVBd93i989y6KjyJp07QI=;
        b=mUkOMUACwco5bvOeeJyQGnU7ilpBVtqjjlO8JB1EO1myXfwkV3tIyDxS/wYOvywsvJ
         kl5bPPtEeHOBHXWyjvDzFszJ/ETstDkl0zV3YDuH+WSN0rQi0JvsrcdGZLz6KXoEBr8d
         L2SjSvmXtxNMGcNwphM+7sQbWueS7uZAGLDsO4KyvYxxwqT6Mqr3q+YLS+cgrBAH1Qzp
         RHOdqDaShmDQXabQLZPa2z7/ZdaCd/ZqfB83RKZuKJklGPB1yagwGNx8ZTKx4I/MEApt
         EpW+ulxDWd1+wkw/v2CAzoLCbD205Vsr0ntXJY8GNJerYSkbt6QixJ336Gw/oUVuForp
         6jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157465; x=1777762265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNEC1d+XQU6xcwJqo0QpL4AVBd93i989y6KjyJp07QI=;
        b=DQCUiFH4sUVMBXmiBBC3ugFY0KA+Gs4k5cxqyEe6RJbLSpgtxFxRAJNo+sYHGEU8Os
         Jcf1bIclOCzR3qn5FdPMaCYdJgLGgjJXnotkSSB1t6wHYg2vDJGoYPIfr3EebzJm0Ne/
         PTSN0JXit3uOp2lmKw8hiGDn/KNoFJXXeTKp+EGhqnhTRTChAu3aXtoCtfIaNOF3SMEs
         AduRM3QlmgwS4jlbuEVYT9C9ToqLGgjjw0vsZ8hHTxdTRqDhs+GmC+JZgdIbbE5wf3Fa
         8ziTx/02nt8G5ZaPdZlvA4ARG3H9hYzeLcVxgtmS5o/+jjrlRp35HH93Ll+HDE58O2UB
         /EbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HsHC2qLIZ0PaefHCBq74vf6D84hjgQBHTr4W83oPz75GQzFIG2ULp6eJqNVbWG//Z5UEF9ObWjZhyHcaHDY3B@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHusXFurEhkfj7Y7Y2JlVeeNGlB5wfsCTCgzN4N7fbk2NWgP1
	y4YxJzJOyEw8fcKZiwdmfT8lVtRpR5R8DhE/sCUWYhy1z56hbzW9qrDblhW5c3EgduwjVBHhtCC
	TYuiWztyiww==
X-Received: from plfh1.prod.google.com ([2002:a17:902:f541:b0:2b7:f9d8:3d1b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ac6:b0:2b2:5840:808e
 with SMTP id d9443c01a7336-2b5f9ee9487mr368769035ad.10.1777157465041; Sat, 25
 Apr 2026 15:51:05 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:17 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-26-irogers@google.com>
Subject: [PATCH v7 25/59] perf stat-cpi: Port stat-cpi to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Port stat-cpi.py from the legacy framework to a standalone script.
Support both file processing mode (using perf.session) and live mode
(reading counters directly via perf.parse_events and evsel.read). Use
argparse for command line options handling. Calculate and display CPI
(Cycles Per Instruction) per interval per CPU/thread.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Accurate CPI Calculation (Multiplexing Support):
  - Before: The get() method returned the raw counter value directly,
    ignoring whether the counter ran for the full interval.

  - After: The get() method now scales the raw value by the ratio of
    enabled time to running time ( val * (ena / float(run)) ) when run
    > 0 . This handles cases where PMU counters are overcommitted and
    multiplexed.

2. Per-Interval CPI in File Mode:
  - Before: store() saved absolute counter values as read from
    PERF_RECORD_STAT . Since these are cumulative from the start of
    the trace, and data.clear() was called every round, the script
    computed cumulative CPI rather than per-interval CPI.

  - After: store() now computes the delta between the current absolute
    value and the value from the previous interval. It saves this
    delta in self.data and retains the absolute value in self.
    prev_data for the next delta computation.

3. Prevention of Dummy Output (Cartesian Product Fix):
  - Before: self.cpus and self.threads lists accumulated all unique
    CPUs and threads seen independently. The nested loops in
    print_interval() then created a Cartesian product of all seen CPUs
    and threads, querying data for combinations that might never have
    occurred.
  - After: Replaced lists with a self.recorded_pairs set that stores
    (cpu, thread) tuples only when a sample actually records them. The
    output loop now iterates strictly over these verified pairs.
---
 tools/perf/python/stat-cpi.py | 151 ++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100755 tools/perf/python/stat-cpi.py

diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
new file mode 100755
index 000000000000..4b1f1f69c94a
--- /dev/null
+++ b/tools/perf/python/stat-cpi.py
@@ -0,0 +1,151 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Calculate CPI from perf stat data or live."""
+
+import argparse
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
+    def store(self, event: str, cpu: int, thread: int, counts: tuple[int, int, int]) -> None:
+        """Store counter values, computing difference from previous absolute values."""
+        self.store_key(cpu, thread)
+        key = self.get_key(event, cpu, thread)
+
+        val, ena, run = counts
+        if key in self.prev_data:
+            prev_val, prev_ena, prev_run = self.prev_data[key]
+            cur_val = val - prev_val
+            cur_ena = ena - prev_ena
+            cur_run = run - prev_run
+        else:
+            cur_val = val
+            cur_ena = ena
+            cur_run = run
+
+        self.data[key] = (cur_val, cur_ena, cur_run)
+        self.prev_data[key] = counts # Store absolute value for next time
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
+                self.store(event_name, event.cpu, event.thread, (event.val, event.ena, event.run))
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
+                                   (counts.val, counts.ena, counts.run))
+                    except OSError:
+                        pass
+
+    def run_file(self) -> None:
+        """Process events from file."""
+        session = perf.session(perf.data(self.args.input), stat=self.process_stat_event)
+        session.process_events()
+
+    def run_live(self) -> None:
+        """Read counters live."""
+        evlist = perf.parse_events("cycles,instructions")
+        if not evlist:
+            print("Failed to parse events", file=sys.stderr)
+            return
+        try:
+            evlist.open()
+        except OSError as e:
+            print(f"Failed to open events: {e}", file=sys.stderr)
+            return
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
-- 
2.54.0.545.g6539524ca2-goog

