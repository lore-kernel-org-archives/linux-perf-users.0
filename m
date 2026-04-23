Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA173ACA4C
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962113; cv=none; b=A2uqqs4i5sRzPNA9tE2wYcEF3wZ8uaJRyFLM3QlO+Ov3M88hIiRa8mC72SgPcCDWqSd2LAsSSqih2VH9Dtp1FAOjCPPj8NJs/KvICKFucpEPdNmIP05PsEQ1aoNpykB7sIlCyv7FOrunMtpYPNcRH/UkgDHiB1GWj7W/DNcGjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962113; c=relaxed/simple;
	bh=U5ed5UD8ND189hCJocoFAO/xoClwrpfP0M8q93I9pXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l64Ih481QkEsUve6toCNqZtbZ+AZWcgq/0aKW11GTQVlH21iinRUNFqDxEEKU/6aT8jZWVjPiIyfAD5N5hYs2VwRGXw/oY9bVPid9sesbCQQbBKG9Z0FQkkJ2g+WoIqGOm1uRB6ygs69qFSvSOT0XSpk007HMeuIJQAU+63mDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/hX4DP7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/hX4DP7"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso8699171eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962111; x=1777566911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLd765eBKPEXGLkxBjQ8yx3J3rdqDCE01wTvhiGW76I=;
        b=q/hX4DP7SPCBCuL1EBPwo6lJdvxAmphtbnBKRRlRlg/bnepq+Ift6rnhq4j2fxO4MH
         LPm5sLrnbulrjmIUpAWmCo4Q8kZH21PSqaim09e65mCKkd9uQJ2voaK5y/DPuYg5E6w1
         meu42ZTU0K0sewebgRtD4VbA7aX5WQEskI2+T930PXPDicTnKrJn3eRMeJox9/KFdqIe
         p5YB7bP7Q5dug8TfZYvlQuT7QTFkcviJ8pT1rK+LNSbBg5qfaAwBXOv/VVNAuQykyig+
         umANqqA+T0Wx1junKf1BQhCo2kVCBwSyqw6eno2OOS6VcoQmUOJzEi4X58kfv57B4IOl
         E/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962111; x=1777566911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLd765eBKPEXGLkxBjQ8yx3J3rdqDCE01wTvhiGW76I=;
        b=ElqpZbxfT93n76Ky2nbtO/X3daRhyeKIqIFH81wv79yeTg5+b9chmJ35Ejr2sxm31c
         CML1oYaqzGjwbw7AHnXjOcI9KBZBuGPhANyf12X6/NpL725A7aoNlZYYAy53K1uYb/YY
         ojf9kKueYKh4kz4r5/KBS/Cd1lhvBxYL6jB3e5K1zCdWE/E95pMYJaqB0DT8wNEpzV6O
         HvX00r9sbXPRVGCM8JKtXVAUSS3ZM1pQh6jOcPxm8NSQCu1qOvHI6OjGbSFvv58Ajbiv
         ZRk2AB1TECOa0lYeQMk3ALuSUD/TLL9xu5BqJopAxMv9ZhEsGkR87A3FukDwAStemLHn
         qzZw==
X-Forwarded-Encrypted: i=1; AFNElJ+spizm3qNwjDiEhdx4XJREQnhUNNCLaUjN8zcZOv7v5PiEOAY7m1xt0/uFwyxcZ+qnUbSguPplcO4qNO8pbPnq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfaj5UI40mz5PD0+rkNXrKvoykKWYzjEc9QQKmRzbqBHtB7UI2
	TbpNDXNrVRZoTzJNzs9SU3AudmvzTZ4HvKmHCzwJIOhJcco8qFwyr56Ihm4bAWom8yTBbV3il/Q
	nPEOtMettBg==
X-Received: from dlbsw6.prod.google.com ([2002:a05:7022:3a86:b0:12a:7b92:3d63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea31:b0:128:cf5c:5356
 with SMTP id a92af1059eb24-12c73f64327mr14701921c88.5.1776962110809; Thu, 23
 Apr 2026 09:35:10 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:33 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-26-irogers@google.com>
Subject: [PATCH v4 25/58] perf stat-cpi: Port stat-cpi to use python module
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
2.54.0.rc2.533.g4f5dca5207-goog

