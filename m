Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC03A0B13
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157475; cv=none; b=XFNnD4vZdX8fzOExQeTt3QdEPiAECaMzEcPcItdI8zCl0kQVfCm3u4dMNxyjk6bPLrG3n5ZmPRxOzgawbHhTpg987zmQezbG/o//gYJUEXV+EeZ8Y5W4F2CfK8WcqTlXb/Zz2tT65NFRG8I8K/3T5cCuQleTllJEDCWelo9ZNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157475; c=relaxed/simple;
	bh=FRJkB1Cquz79cOSRZrWQZxDQ+1Gx96tDBQLRgM6VsPA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SvDetVOJ5/U1tcLCZnR5RUjpU7jY7ChA+WelJoahGQlac7Jr2gMu52P492sjLvDTPMDcTbKh6QmOcLFAc/Ynl8fQaQRQRY+62TfwbxocfryQpVYBT5eT1L4Se1sAok/YqJgRhUHxE8preEm/g03wZQmNK3Pzgv70uNqBTBdcJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGoE4g7J; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGoE4g7J"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12db218e265so14789353c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157473; x=1777762273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkS04/94NBW5ShfL0EcvB/IZEgEtB93nGkm6zSZzY+Q=;
        b=OGoE4g7JGm7Qi/1ASQrLmoQ8+iVOn3apmxiCvR3gptEZuqcJ3x9ofWc3PcwnOPqCwe
         plCB/Cw5FUkVFw14O1R6c9uVyy4oTW3JFEQtgMw6Xx9JsyO7nq2WbCNDtmsJFXAEPUGP
         CJpE43YmYVtme08IE6ygA4nQ9E9wRnQkCq/8bKh7tqf7wcJttpgrrRhv0YI8c3wv3xbW
         8aIev3Dn7/TOasnWoj/hIRUcPJl/FdOLTGqmLK28rryhreyc++FOUU1iREEOnly32Dvv
         Ohhvxkrl0tCPxnzoBWIZinspjbxHGAsOF3UKgUxcNo+OAFoGD9qWQaNtA5MDUT83HVTZ
         A1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157473; x=1777762273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkS04/94NBW5ShfL0EcvB/IZEgEtB93nGkm6zSZzY+Q=;
        b=In7TRJD+C1UzioEH1wIufPl9D71/x2yYEi38/dPZvMihVvVn5+Udy3S8Z5S0LTURLb
         e9kNXzWpFc1SY9PXsZjld5zMoIc4vr5Y/wBMRwzauqKpyV9GHjHem8lv4kBLjFTww8Sz
         pfjGtpr57jT1Ko8EapIODsQKYFTz+lHNTjqRUXQcdiW2WLCFfhIoDjFZ4zAv2qR2mCBd
         rS3F6wgJQnAujKoBzjBWZ6qDEv1G2O1+wODm9KyMxp1YTNbl1IV1FIMeSQ6mkKH/76yd
         k0qGIl2Di76/GYdksFLAkzczrt4zIp/wHyPf0/eSzb64Bch2B2fNuFwd7UsrgLdc3Sto
         eQmg==
X-Forwarded-Encrypted: i=1; AFNElJ8A3QonxOEs2z+AFPoIPyrXdixXZtVUnwEBjt0CIzxTv9ResfJC3GFUQ5VoU3Gd+NMXFWQs3UjZ5RfIHlTHNmG0@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRMs4e1eSZbd+kZ6rbCZh7B2Lxpw1az9kXA/JxsTGhFoO08wt
	w2/aZ5aoWufjOcpDM5ySfs3yl3TV/qYMMWeIr9Z5NZrW2Q9/s8cbE6Lh0a7ZJxfoaF8KwQiy13t
	TNxnSzg933A==
X-Received: from dlbtz15.prod.google.com ([2002:a05:7022:eacf:b0:12c:4b32:3177])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f40b:b0:12d:ce36:892a
 with SMTP id a92af1059eb24-12dce3691famr1839408c88.9.1777157473158; Sat, 25
 Apr 2026 15:51:13 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:21 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-30-irogers@google.com>
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

