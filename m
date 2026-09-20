Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F93D8908
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881814; cv=none; b=DzEUauAHXqEAzFwPLbasKnotAJJYCQiJUWvEazzR7z7mZyMm+fQq26MC72ePrJnbNS0wh1incFgjfunDfN5qv2OSYvoX8s3lvQv7o7oqAK9S3jhwpW97VfTdoESpgmTpsZwkE/Re2HE7UcphQDARoMhrkFncLuCWRjSeGW1msHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881814; c=relaxed/simple;
	bh=8Bk1bWXRTEwDqS7ftQKTbckk62xuO8EolOOidt6VleQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TSpCIskegGTh2V9Jdyyxl8Mm3V1cqpez5ibvX8aAQv0/o72ZkGMoMVVYV6Uh8uCr7nA8uE/QNV02AQdcMemAHZ7EUd4B8peyG8tLDmHVEjDNe6QbhRaUG3mma4iiKucD3SrmezfmocxuSasW1rWR/ZKENRERXIp0bn+9befn0us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTHhqTQK; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTHhqTQK"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6fed0652bso23828215ad.2
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881812; x=1790486612; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJp30NLDE6VMNo04VO3UNO5Lbt1RIBaIrW7mzsnW58Q=;
        b=pTHhqTQKckfcxD7IcX4OJnmYx/pGfOva8WVArqHkd1VtHSN2liNivg8oO7twrFy5bM
         uUnKgGwXk4wukkThTKVwJLrbOVjE1J/JTfI25KJJDqt2zS9ppgTgJ8wmiPS+z9eULU9w
         SNsQpJZ9lu5lRcDjOeih/UPH7naJMd0kEwwCBLGsPxYcuVxUi+qwKyNW70044F44Z4MD
         nZt7DIi1bIeN+alHS2z85Yk2bnyAfHOE7WKIjNfifJVcInbLauk9DafUYGCoyGzwrSko
         ZuIh59FDwSqMIywTH5SPihTVPTmQQ3QX+x55UQ00Lv2zSgYBRJzC2vmkpQHT7/Ap8uHI
         5kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881812; x=1790486612;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJp30NLDE6VMNo04VO3UNO5Lbt1RIBaIrW7mzsnW58Q=;
        b=GC70KkIV1yXiObkrRMKc15CJTKTDcEq8XjHVBMKS0I+hY90QC6Y6k3/1xwUQdpTfNr
         drogJfgX7/BFxu3/S0d2R37dFI6FjR7By5Vh479VzPH4yJb3F0PV17+FR9w59kCTmQLg
         KODfE1daoEBDEwFeqWH9oj36cR6Si7UAARKsTh2BbQ3K9HRYOGtoCMxIYhv/yrroCl2l
         Z9yXkzXcFEiTJeI63xQW1NJNJlR5uu/YVogKt9xAJrVGDTLjTq+WKMIYcvRE9qsNZ5DR
         a+CZluMC9ckJ7AypK9630QtgY/LtbUBEaiPGHmNrZ1yIyDA9K7b3+vvH5J+2y68awyPm
         JqGw==
X-Forwarded-Encrypted: i=1; AKwUvByTsKkr7SbUBPN0Xfbsv3vpoaKKw5yvOVeSFsbeeKh7EkBnzvQQTdWSZvoZMJ4y+aaClmojTic/8jS7zNAKDNJF@vger.kernel.org
X-Gm-Message-State: AFuF++kcws3YJcVX4c7sBozpQTReOrShng/SusEP9M6XDs9ZuPMmBil0
	hLgtThccgpXssLbV9zOWmLFKz6Ei8aDSMiQi4KiLApOIJzFDNgf2a9R25J2vQ8GFT713CczqYG+
	bkAMR8R5cag==
X-Received: from dyrt38.prod.google.com ([2002:a05:7300:4f26:b0:339:6b44:abf5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce92:b0:2d9:1dee:43e3
 with SMTP id d9443c01a7336-2ddb1b796demr128361985ad.18.1789881812422; Sat, 19
 Sep 2026 22:23:32 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:22 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <b15cf471e3d41c77f5697301e3e425053e1fb89c.1789880842.git.irogers@google.com>
Subject: [PATCH v1 30/49] perf python: Port futex-contention to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port tools/perf/scripts/python/futex-contention.py to a standalone
script in tools/perf/python/ using the perf module. Avoiding the
embedded interpreter overhead improves execution speed by ~3.2x:

```
$ perf record -e syscalls:sys_*_futex -a sleep 1
...
$ time perf script tools/perf/scripts/python/futex-contention.py
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

Additional improvements compared to the legacy script:
- Consolidate per-(tid, uaddr) contention count, total_time, min_time,
  and max_time into a single LockStats class instead of maintaining
  three separate dictionaries.
- Validate that uaddr and op tracepoint attributes are present on
  syscalls:sys_enter_futex samples rather than silently attributing
  missing fields to uaddr=0, op=0 (FUTEX_WAIT).
- Add -i/--input CLI option support via argparse and full type
  annotations.

Add a shell test (test_futex_contention_python.sh) to verify the
standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/futex-contention.py         | 93 +++++++++++++++++++
 .../shell/test_futex_contention_python.sh     | 67 +++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100755 tools/perf/python/futex-contention.py
 create mode 100755 tools/perf/tests/shell/test_futex_contention_python.sh

diff --git a/tools/perf/python/futex-contention.py b/tools/perf/python/futex-contention.py
new file mode 100755
index 000000000000..d5bb8ca19699
--- /dev/null
+++ b/tools/perf/python/futex-contention.py
@@ -0,0 +1,93 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Measures futex contention."""
+from __future__ import annotations
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
+FUTEX_PRIVATE_FLAG = 128
+FUTEX_CLOCK_REALTIME = 256
+FUTEX_CMD_MASK = ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+
+
+def handle_start(tid: int, uaddr: int, op: int, start_time: int) -> None:
+    """Handle a futex sys_enter event."""
+    if (op & FUTEX_CMD_MASK) != FUTEX_WAIT:
+        return
+    try:
+        if session:
+            process = session.find_thread(tid)
+            if process:
+                process_names[tid] = process.comm() or "unknown"
+    except (TypeError, AttributeError):
+        pass
+    if tid not in process_names:
+        process_names[tid] = "unknown"
+
+    start_times[tid] = (uaddr, start_time)
+
+def handle_end(tid: int, end_time: int) -> None:
+    """Handle a futex sys_exit event."""
+    if tid not in start_times:
+        return
+    (uaddr, start_time) = start_times[tid]
+    del start_times[tid]
+    durations[(tid, uaddr)].add(end_time - start_time)
+
+def process_event(sample: perf.sample_event) -> None:
+    """Process a single sample event."""
+    event_name = str(sample.evsel)
+    if event_name.startswith("evsel(syscalls:sys_enter_futex)"):
+        uaddr = getattr(sample, "uaddr", None)
+        op = getattr(sample, "op", None)
+        if uaddr is None or op is None:
+            return  # Tracepoint fields missing, skip silent attribution to 0
+        handle_start(sample.sample_tid, uaddr, op, sample.sample_time)
+    elif event_name.startswith("evsel(syscalls:sys_exit_futex)"):
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
diff --git a/tools/perf/tests/shell/test_futex_contention_python.sh b/tools/perf/tests/shell/test_futex_contention_python.sh
new file mode 100755
index 000000000000..b7d6976e4f57
--- /dev/null
+++ b/tools/perf/tests/shell/test_futex_contention_python.sh
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# futex-contention python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+# If we don't have the perf python module, we can't test
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/futex-contention.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, futex-contention.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+
+cleanup() {
+	rm -f "${temp_data}"
+}
+
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+
+test_file_mode() {
+	echo "Testing futex-contention.py..."
+	# Some systems might not have syscalls:sys_enter_futex
+	if ! perf list | grep -q syscalls:sys_enter_futex; then
+		echo "Skipping test, syscalls:sys_enter_futex not found"
+		exit 2
+	fi
+
+	# Generate some futex events
+	if ! perf record -e syscalls:sys_enter_futex,syscalls:sys_exit_futex -a -o "${temp_data}" \
+		-- sleep 0.5 2>/dev/null; then
+		echo "Skipping (record failed)"
+		exit 2
+	fi
+
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" >/dev/null; then
+		echo "File mode test failed."
+		err=1
+	else
+		echo "File mode test passed."
+	fi
+}
+
+test_file_mode
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

