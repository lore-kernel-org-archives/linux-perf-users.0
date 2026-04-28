Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67133D47A0
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360819; cv=none; b=aI5ixQTKEiI3F0bGgbzibr3ZpZu/qDYHXEM/OfzOs0evdl/ezyHyVubcEQuXMkhehMIJP/jkNQnUUMGap5vCO1SuhYDGvPImoHwkj6Ig28M/dWYLb1Ujzw5zDDO580qJYrR4Ys/22NG6iilzIa2XlsQlgmaL6lMmhShftGiAibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360819; c=relaxed/simple;
	bh=u5c/am2jfjZWYiMa5qBJlKPhc8lQ2M2Vd/M2zXOpRq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lWdrhiLqS19qJosfFWVgvqYb0eSBBwDsrQZXhXjz3U7ONTHenDC18/TZqUF9AxlN3hu7ozpMvW3vR8W/wDXSFNgA6q60gqFfWHfICoGv1cgNZ3CAuqy2advsjmB5D3w/dti0pFEzizGdzo9rKcqvjMEmldY7Wcc4ziMcDuPo1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwR2zJQt; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwR2zJQt"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2e60238adb1so27753191eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360817; x=1777965617; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkP+7Ld+msio4991lavZB6N3kEKOAmCVypgwmqxtk64=;
        b=vwR2zJQteGe7pgPojtR+Jl8WPP50g9WKbp/vdy0VqKc+h1NoZCJUkNZ/ncleW2a5dM
         /Hqe7yaVgNQfZDIigBP/sAuRNBtp1TmvbyzRVBbvUIbLw46fQoq7cX+LpW8OUzqn/bT8
         B4g6OpV2GrQobzi9uMOLmyoE0mwql5sx8bjEKTSZvI/LhhUHB3ri1LykjzcByHOvNCfd
         43P6TEWt/v4l/N0LggnVwvWnrmjiDj02kSK649WHw8PQ2h3a4aABZ2lCVdBorlcmvBm0
         +Iy1zYM7AwVlyCfPJfHgls1K5aDd21i7NUg7yedkvd5aPbcuRFdbyJzbRZZJB3gBoiiw
         7ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360817; x=1777965617;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkP+7Ld+msio4991lavZB6N3kEKOAmCVypgwmqxtk64=;
        b=F0u2yntKfiOluVrUcIlG7CbiEpmUFKW9IiL6KTMIDFSVBW285+ePBxpen00pJlFRLq
         SyJRf9GOtMM1UgY/lPOIIEBsyL0TUSZv/ccO4DlMQ5gRtVG7q7GGnz5du9/B5J//tnL3
         B6cqKeTgDzBTPYtnRc6b9EfsVQMBaeNQ9Wx4ozCbPCc2JQcZWcCvXVuquEzfGSqtmSI8
         l0OhCO4axl2t10oN3UvdyvFHKz2b2aksE5w9RgUhtv0FJoV3T6HN0iWLHIM0AwvZ+wxG
         K//umUpEjN7PsZLHGRi6tciEZkh4v3bDHd5iIExqIKpds8QLQUYJ9Ew6czUZaRUuHmVV
         n6hg==
X-Forwarded-Encrypted: i=1; AFNElJ8ellDhYeu/IH3xRBu/pJ5fkZAJxBs3qzh/zVbVDweeVrw4w/gt6hIh+2AO4iGNYt/y3t8BGTRSpaZY4tT+GAei@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd5SLnVZsCybwNiKcOZfvZ3O8B9AN2KCH53L1ZZYNc/9VP7lxw
	cbRsQbr6YfT3jH+kQNkYtjE3/uT66ZrrShZ31h/zsbX3G6GrgK1rrcCsqGCEoHetPMbjI/wzm1R
	tRxYRADRl3Q==
X-Received: from dycol2.prod.google.com ([2002:a05:7301:db82:b0:2dd:8e19:2d13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:bb07:b0:2db:2089:460f
 with SMTP id 5a478bee46e88-2ed0a0cc6ccmr948754eec.19.1777360816818; Tue, 28
 Apr 2026 00:20:16 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:34 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-30-irogers@google.com>
Subject: [PATCH v8 29/58] perf futex-contention: Port futex-contention to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

v8:
- Fixed process name resolution in handle_start to fall back to
  'unknown' instead of early return to prevent data loss.
---
 tools/perf/python/futex-contention.py | 87 +++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100755 tools/perf/python/futex-contention.py

diff --git a/tools/perf/python/futex-contention.py b/tools/perf/python/futex-contention.py
new file mode 100755
index 000000000000..021dd3c2aa2f
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
+                process_names[tid] = "unknown"
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

