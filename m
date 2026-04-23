Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F13AC0E7
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960670; cv=none; b=Q9Awxqn2FoZ0MmVzdHMtIvjFeWYPYBGqSAZa2DAncGaIApfksXUHmCfqNj4j9IZf0q3DCT7vHEOz4TSiJ3hp4sQseQkvROK4EDEZTBSz+34WPR6MJpx0cpcxF8tqSTt9mXtFMVCadeY4CWnTRp0g9PT/G5Z2EYZXnvOFMgSvJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960670; c=relaxed/simple;
	bh=OYv4zaUPaqpE4bB6sOH2vYIPz0Hv5QaIWWSyHOE1dvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=el6kmao6d8HacnH14LInmlzzXOLTZaFYJHpK5komSIPagzGYV06qB2b1c2wefewS2+hf1qzXUGT/PEMN2fKK/hMiegEGhwd+3egQO/SNLbDO0swEibdAoGQK9w5dqWgY8CBGRW3eVwMZ0m0jow1+D3x4PFACcSqG17bas0hxaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N55vxbgt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N55vxbgt"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da1c703d1so8366058a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960668; x=1777565468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcIdOgL+7uarIK1UbnVrTv+/pxGdH2WlwKMAxRVHpls=;
        b=N55vxbgtdvEs4XoNdt4REQRTsAtUc80xtVS4F1/5mjCPxeMivD3OL5MNracoBPnDP/
         PhzCH43XPJjL7SsKyIWuFSqcUH+o/URhSsVBxnB1mndmE6F3vIblpYR+D1MFsAGbE74N
         M/ackekl2NNjfWubZtwp56z8AgQAXyBNfLlXe4mhZSrS1xCAiOlbcFvnNbl6ESzh95tI
         8lMWtVUW3rPr53B9qHSmhhCY6gW/6LSbFlluCoYNpgJZKypiHoWXT7Nh6SyJQP7g0wPV
         kT7G6r8KMMD0tIYZpP0THwiumdyPPEXriT6wxnWc6ClxQgC9r3qFQJAdUud4XvA5MSH9
         6oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960668; x=1777565468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcIdOgL+7uarIK1UbnVrTv+/pxGdH2WlwKMAxRVHpls=;
        b=TQqfM/zap1Eb6mKbW9eTuKMWAa7M1aD/kRxZarGhoJu+HoIla11336rXc16rT8yF01
         lDbwVKoIkzHxJlkWn2Pou3HocZ160vrGdVzDirKqUQRO5KKZbKkjvwYl76aPX3RVRfPb
         yiLWV1xgRys57pJ6v4Z90EK3qOMsQ008qt72tZDeLj3Wn2nXU4ljAoUUq9T3V+WjSy8Z
         yxHW3euDX5x/jdSsLSF9KwUF7YVqPX4t3vib4DEzdengYX70CqR1rsYS5rJwCWTUaGfQ
         /c0o/X5kI4wbjfHZPgvTYrQNC5gtMFiUJwOauYxeLacigoUJa49D1/1JlsiM7f/1YRMY
         hpMg==
X-Forwarded-Encrypted: i=1; AFNElJ80tL5roVmg/vyVPhoKyP+18CF+08BSa+J9iXHO6UHMh87Eq2povfpe9Bfqt5cA82KPLAE30Jh/3D+P/AtTTwv/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxie5gHMpZ2w2d3GFyFrEsIYuBw5XaKeZdBNTtqHQudB3V3imWH
	yzg/voRUFdDK1VCLQPEkYHrYQMERN1a13ruzV/z9xfusjlPy5A2mr/E5YuYZ1lQVgpqU69ZGrI2
	AGkjUgfK5QQ==
X-Received: from pgmn17.prod.google.com ([2002:a63:5c51:0:b0:c79:7697:e441])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5890:b0:35e:5723:85e3
 with SMTP id 98e67ed59e1d1-361403f12ddmr28906454a91.9.1776960667983; Thu, 23
 Apr 2026 09:11:07 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:35 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-29-irogers@google.com>
Subject: [PATCH v3 28/58] perf futex-contention: Port futex-contention to use
 python module
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
2.54.0.rc2.533.g4f5dca5207-goog

