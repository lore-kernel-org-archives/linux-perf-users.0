Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCEC3E8C71
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049330; cv=none; b=HWTTv6zV1FDx8/IqOJCGH8PkkLqYf4F+NRy2ZWiBqAzXXbezUOc/E/FljcH3SeizPQUYwvyOs4JL3cnZKTAZtJt5yDNxHCnaFTjM0+4akplVhzqvtb9xzMPa3yGEUM9dHLXKLOu+JBTDdtX1dCcKFdiSmL03SGQOoYOBADZ4kX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049330; c=relaxed/simple;
	bh=/VgSJRCdT+AdLeDlhYt2/5SGeOm3+Hx/UKS6wQZrYwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qPNc4o/qJxECihk6xkFgfa9bS5FhyHogOCGQD5m7ca15ZjkfHDKrADhu2Zvck2dDsNAH3A+IySMqVdoZzTJ3Q1RZlH0qSEHsH3S51GDups1D38HCzdXxyteLwB8joJLSHJjedI58OerrjYP/AD4ZJaQ8Q375tXksWt/4und3KHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJ4Hj086; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJ4Hj086"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so12065426eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049327; x=1777654127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw+O+AQDwk9NdonQ97aK+JyfveIMyyodbwR7BIioANA=;
        b=rJ4Hj086vPzfGNWYh08u3lS8trsyfaYcHE7L8wjOr733OEc8U/gXKumZdnG1BE1CSc
         qV5feSeH/bOS+p2q9HtyVDu7DE9rJ/p69+67yprrX1wlxlynRjo0NPtdsvP/3KmURNMf
         vbbd4EYx0CUZRmH3pvDBdg5yZ6jht6CLIFvQiY9WZDqvE3lNO/fYXY4BnWnNu8snao0H
         BahnTTIQTG2+DvIqHDCdaBWUEFUrcRcUweFz/LZIgRmzJaOe0dGTW6w4i5fGpXEb3I5Q
         xCe7nD/LweJSEjsnxvLqx+peuwcTdTzih5kJLVrgkkbmHofTsBfPsxhXxdpMVuk9K1FK
         MirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049327; x=1777654127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw+O+AQDwk9NdonQ97aK+JyfveIMyyodbwR7BIioANA=;
        b=JohMQS6cysj4wuyqRiRggDWGum2deLD2vSqs7F0wUyzziwE1r5H/0dhqkubRHd3tXO
         g8pV7UKG922iAaTqC3M7iI9p7+u4G7kMl+1qtWgC5y/KgYPLCfzaTbCmObQ2N3M6MRTf
         iG/DVYgFPR77Uo+ITBQuPKS3GZXdVstQzORZXgth0wrka/xCN2fQFpeiPZhKXFqR8kIt
         73vJE8OMhTedTH1GtkFZEOWPxMO2by7hoja0tCdUn/POl2JgsbFfYUVdvMAAjdH6i2aw
         dL8VfVFsGDrk6spwcd2VnBvmipuxHIE0EwBkr07EuAD2NGlcpPcUxr8QXirEuYMcvH7O
         0htg==
X-Forwarded-Encrypted: i=1; AFNElJ9RFHtRCgSuBa3qHDNPnvwWZPsiLRyvtB1JcdOiSAbqbHkA5cVXlhkYgoVXE0N2k0fP8pScmmEpQJYMs/XzpTg/@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWE/yofeqjBaeqmDcWcT452V8shkGBLrq8v86VIHe41wGgUed
	0n0+SHsjBxFsric+2eGP6pT0d1/hkfxjKPw/Xdyi1sxgBsn3t9oPGNP08e1W1+x1hB/+qCPZ1Ae
	PxqcoSFetXw==
X-Received: from dycqr6.prod.google.com ([2002:a05:7300:ff46:b0:2dd:67ce:b8c5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2203:b0:2dd:6937:79d1
 with SMTP id 5a478bee46e88-2e47972451dmr21639108eec.15.1777049327001; Fri, 24
 Apr 2026 09:48:47 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:51 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-30-irogers@google.com>
Subject: [PATCH v5 29/58] perf futex-contention: Port futex-contention to use
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
index 000000000000..7c5c3d0ca60a
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
+                    process = session.process(tid)
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

