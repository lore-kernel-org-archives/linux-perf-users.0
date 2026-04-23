Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AF369999
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776973477; cv=none; b=GIsO39qSqlp7IvNWxf9lIZFSgcQHDm4Q11WroVSvS95IedX92Dac+UTUe1eOj5XNmAVcz/l3KwY500U8oN76MNoSLFA4FHJpWQJIqcmTwlYDT5E1vYZfmjZPqFuZDWX5AIoyOofV4aznh+EU4rCywwYfS7e4GtruvJUiOV4F+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776973477; c=relaxed/simple;
	bh=OYv4zaUPaqpE4bB6sOH2vYIPz0Hv5QaIWWSyHOE1dvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iC/nWgVPDCtkici85zLV5X724adLNYBV/r/YEj2h88iFpITu688tt0rKKBidJTwApfjRqXhVfMwVFer3MSzd/y5S00G5V52eBIFt0V5WNWcc66r9yeGn85/i7iY2D74MwNnXCaaAcz8nnoAQhP9qux26wvqB1o3la3Fp8jAK1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iU2IwgW3; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iU2IwgW3"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12db37213daso9328139c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776973474; x=1777578274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcIdOgL+7uarIK1UbnVrTv+/pxGdH2WlwKMAxRVHpls=;
        b=iU2IwgW3sj2v+x5zW3zPvbhemcBevGiIK+8girRxhLpeOWD+Rd/Z+o8MQLt/kpH9Ee
         SUXbkSTH8K5dzMgpMMVxn9fGpN1x9qovWYcZmZ85sPG4JVv9nZ4r8dJrhoYAHaAAKZ5V
         JUHAD5oOISrGzNP2HElLu1u5a5ig7ccT7ITcSco0AUUrEFVdsmq5dES1COL12VVEc+XG
         j1rxfy5JQTQISRnWC1BmjijvRhImvm5+Ccy0Csbmhb4bs8XEnLurTwD0IO6OFrx9D9PW
         KkmFMYsUg0/IjdhqOFkmN97ki8GrpGyvf8GqnUNRrW5he6lmmXiByQL+tecWlzd96wm7
         3D9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776973474; x=1777578274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcIdOgL+7uarIK1UbnVrTv+/pxGdH2WlwKMAxRVHpls=;
        b=JXIVoszx8R9HuaZ+9y4G6u7B3jOZQi5OWl8GsLw2V1QfKKUe3ZJxIJnQNygcVgBUyz
         iW9VH9OVDkkIs2S+3EAfo9pyDlTijQ6/WDX/L8jWruBTNSWur9SYKC6Tr0gJhw8w4NEv
         WHQ684Epw68JRzbmEh+MF2XEIWicqZjtcjYHXQ3uQAhL3FE7rfsBwyQx4008OoLQgbr2
         Lt3P5w/x48qfMBJr6+Lz3KC04aJxYHLvSZjQJhca1nV/9gIcDCwvtVQ1evzxoq1uTxol
         tAI2ckoSRLbYZXVoGfLD1ltY3VsrNKEZ+AqLkmRiDaHbBYRCAkdaojUyHEkrgN+DDPWn
         GQMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S/pOk+ztpMmGU051smUwjXsMRCOHvapzVWbfCcbO3wg4T5pFypa1RvhD3FXIqHJeeigk2vWUVEHYAtfMR5jiM@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+9vCBy0YieoEfvk8GCK7mv5h+hT1gaQcD0/n9LG8Y4uXFucA
	Y+8UlZKYRbaNxeUwb08+W/cj/RADgwEosWtgiSNULhSs+9RnWARRVPPJv0Z6UNmCE6GtD79IOkT
	wZ8DhkQpsIQ==
X-Received: from dly15-n1.prod.google.com ([2002:a05:701b:204f:10b0:12a:83c5:a16f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:69a:b0:128:d967:466c
 with SMTP id a92af1059eb24-12c73f9f65fmr15041977c88.24.1776973473698; Thu, 23
 Apr 2026 12:44:33 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:43:58 -0700
In-Reply-To: <20260423194428.1846255-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423194428.1846255-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423194428.1846255-2-irogers@google.com>
Subject: [PATCH v4 29/58] perf futex-contention: Port futex-contention to use
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
2.54.0.rc2.533.g4f5dca5207-goog

