Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3771A399036
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156952; cv=none; b=dVctwYb+zWvbYHJXuSh3kmwmRmu9Yzgb4VZTLfklBE5t9V2OoS5Qeh3ARESIIekO0SciYZvX8nER9u/Bfw7P97K12kmD2MBScqF0WswU3eLIdLRHegaUlSIMpm6e78xQ+SMqeUdeljcfUvKPoEFEvSXA44umGnNPcGmwhkiD9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156952; c=relaxed/simple;
	bh=FRJkB1Cquz79cOSRZrWQZxDQ+1Gx96tDBQLRgM6VsPA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nhfqbBo5IPT9uS/Q0Sw22iaN21npw/5ZOH4zgpn0KqI1MbcG+jl/mAu+J1VSHk5+wjT1uQjm3UtONt0m2FrHdmhs+9N2gMaOSzmLGx1KE1HFNAWpDQsSNnU+pZYP1rbzCu2fL1WmVRpTZL/eyYqrMO5PybFInSCOm323INTEfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vivvgnro; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vivvgnro"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso11622239eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156950; x=1777761750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkS04/94NBW5ShfL0EcvB/IZEgEtB93nGkm6zSZzY+Q=;
        b=VivvgnroukHs6AqD1EheEfK0u9/mW3bql25F6iaxZp2dXSOao2bi4FDHbgPGEg0W4S
         GCX84mP+01hFKGDemhOXCLCXyNd7uE+9MTs3C8TCkzE7C5JwO1iBnU7UDGwODa6/aM8q
         6kNMuw26qrJ6kpDrVaUsZfoAQjBp1IBuyvvlzDRV7HaUU5S9xSsVw7Topt0e9VXyG9PR
         KxQ/tihd4e7BDMiz0teyZGniGV4S7dwPDL17/uhDwh67KR7lNzvO1+EUwH4RscRCM8VE
         qjjUaOfCqGSWm+2rC4AVw4QdNRFtNRvfB9iO06KwXVjkzskpC4I5IBcLhHOzV4kwyAjt
         UV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156950; x=1777761750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkS04/94NBW5ShfL0EcvB/IZEgEtB93nGkm6zSZzY+Q=;
        b=g6bWApvReRAzWZZV/3F2jRZOtwYb2gYe3x7uRDXqLNt3mhRMqYdlv9H8RF0eXaz2Ju
         UoBjThfyKD1JhoMktDt/r4gjZDS9I7y4THpBM31SzPu97La0Z2f+jpj7AV/mblmGZkIb
         /xRqwdghYWYH85APNR+6n7Ejw8mg1z5HG0BuqJiZhscjJEU90bUvKVzwasbpboG7QLAQ
         cAUw1r+dpdwkFG9ZdlMqLNgA8XlK+eGthQAljmNzVzO9eMNjH8Ri/EMGzdm9pZLMuUQw
         O6rCt690cX7f3LUU8kZl+ODmyX/+jKlDPiZAoecoMKAtsiv9z4dK+Yc8Vl5cdB+Bmj6w
         w2xA==
X-Forwarded-Encrypted: i=1; AFNElJ/eCoY5B+kVtYBCESKhxCWA9c+i+GV7jNW80UnxAZaX3od2CO5cM5l0xgwV7VcTW28I4PVtYoNqSqbLh6zRI9JQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoz7OuPb3eqLSXkEhCPOWNgog9NJIQQuoLKIvzrFRPrXSfWmH2
	F8OjZbgKi4Cd+dZdidpBNTFITxE0TnzOBaeGVu4D22UpQ1YDIWuhlwPE70KsGOCP5iALPHmab2T
	czeX2H+M7MA==
X-Received: from dybzy3.prod.google.com ([2002:a05:7301:e103:b0:2df:af:8fde])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1c81:b0:2e6:ffa8:ef85
 with SMTP id 5a478bee46e88-2e6ffa8f745mr11894330eec.0.1777156950187; Sat, 25
 Apr 2026 15:42:30 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:54 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-30-irogers@google.com>
Subject: [PATCH v7 29/59] perf futex-contention: Port futex-contention to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rewrite tools/perf/scripts/python/futex-contention.py to use the
python module and various style changes. By avoiding the overheads in
the `perf script` execution the performance improves by more than 3.2x
as shown in the following (with PYTHON_PATH and PERF_EXEC_PATH set as
necessary):

```
$ perf record -e syscalls:sys_*_futex -a sleep 1
...
$ time perf script tools/perf/scripts/python/futex-contention.py
Install the python-audit package to get syscall names.
For example:
  # apt-get install python3-audit (Ubuntu)
  # yum install python3-audit (Fedora)
  etc.

Press control+C to stop and show the summary
aaa/4[2435653] lock 7f76b380c878 contended 1 times, 1099 avg ns [max: 1099 ns, min 1099 ns]
...
real    0m1.007s
user    0m0.935s
sys     0m0.072s
$ time python3 tools/perf/python/futex-contention.py
...
real    0m0.314s
user    0m0.259s
sys     0m0.056s
```

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Fixed Module Import Failure: Corrected the type annotations from
   [int, int] to Tuple[int, int] .  The previous code would raise a
   TypeError at module import time because lists cannot be used as
   types in dictionary annotations.

2. Prevented Out-Of-Memory Crashes: Replaced the approach of storing
   every single duration in a list with a LockStats class that
   maintains running aggregates (count, total time, min, max). This
   ensures O(1) memory usage per lock/thread pair rather than
   unbounded memory growth.

3. Support for Custom Input Files: Added a -i / --input command-line
   argument to support processing arbitrarily named trace files,
   removing the hardcoded "perf.data" restriction.

4. Robust Process Lookup: Added a check to ensure session is
   initialized before calling session.  process() , preventing
   potential NoneType attribute errors if events are processed during
   initialization.
---
 tools/perf/python/futex-contention.py | 87 +++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100755 tools/perf/python/futex-contention.py

diff --git a/tools/perf/python/futex-contention.py b/tools/perf/python/futex-contention.py
new file mode 100755
index 000000000000..1fc87ec0e6e5
--- /dev/null
+++ b/tools/perf/python/futex-contention.py
@@ -0,0 +1,87 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Measures futex contention."""
+
+import argparse
+from collections import defaultdict
+from typing import Dict, Tuple
+import perf
+
+class LockStats:
+    """Aggregate lock contention information."""
+    def __init__(self) -> None:
+        self.count = 0
+        self.total_time = 0
+        self.min_time = 0
+        self.max_time = 0
+
+    def add(self, duration: int) -> None:
+        """Add a new duration measurement."""
+        self.count += 1
+        self.total_time += duration
+        if self.count == 1:
+            self.min_time = duration
+            self.max_time = duration
+        else:
+            self.min_time = min(self.min_time, duration)
+            self.max_time = max(self.max_time, duration)
+
+    def avg(self) -> float:
+        """Return average duration."""
+        return self.total_time / self.count if self.count > 0 else 0.0
+
+process_names: Dict[int, str] = {}
+start_times: Dict[int, Tuple[int, int]] = {}
+session = None
+durations: Dict[Tuple[int, int], LockStats] = defaultdict(LockStats)
+
+FUTEX_WAIT = 0
+FUTEX_WAKE = 1
+FUTEX_PRIVATE_FLAG = 128
+FUTEX_CLOCK_REALTIME = 256
+FUTEX_CMD_MASK = ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+
+
+def process_event(sample: perf.sample_event) -> None:
+    """Process a single sample event."""
+    def handle_start(tid: int, uaddr: int, op: int, start_time: int) -> None:
+        if (op & FUTEX_CMD_MASK) != FUTEX_WAIT:
+            return
+        if tid not in process_names:
+            try:
+                if session:
+                    process = session.find_thread(tid)
+                    if process:
+                        process_names[tid] = process.comm()
+            except (TypeError, AttributeError):
+                return
+        start_times[tid] = (uaddr, start_time)
+
+    def handle_end(tid: int, end_time: int) -> None:
+        if tid not in start_times:
+            return
+        (uaddr, start_time) = start_times[tid]
+        del start_times[tid]
+        durations[(tid, uaddr)].add(end_time - start_time)
+
+    event_name = str(sample.evsel)
+    if event_name == "evsel(syscalls:sys_enter_futex)":
+        uaddr = getattr(sample, "uaddr", 0)
+        op = getattr(sample, "op", 0)
+        handle_start(sample.sample_tid, uaddr, op, sample.sample_time)
+    elif event_name == "evsel(syscalls:sys_exit_futex)":
+        handle_end(sample.sample_tid, sample.sample_time)
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Measure futex contention")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    session = perf.session(perf.data(args.input), sample=process_event)
+    session.process_events()
+
+    for ((t, u), stats) in sorted(durations.items()):
+        avg_ns = stats.avg()
+        print(f"{process_names.get(t, 'unknown')}[{t}] lock {u:x} contended {stats.count} times, "
+              f"{avg_ns:.0f} avg ns [max: {stats.max_time} ns, min {stats.min_time} ns]")
-- 
2.54.0.545.g6539524ca2-goog

