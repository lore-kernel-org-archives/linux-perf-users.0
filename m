Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA3237A825
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967298; cv=none; b=uDTZNZuZ41DiaM1QRr3v8xcb/wKEQpLvkdVfL1vfuAyt9rJxMhjShqWlfcM2q4fo9J+o02z6ULt2LwjtkXHSQ8VFiXaafLl+Uj/CNh+0G9UX56j1Ich1sixWw2q6yAHZgz/8imJ5MtBHHbR4YF8YXkJEJ8gQRLcEbl6ALwuuJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967298; c=relaxed/simple;
	bh=8Bk1bWXRTEwDqS7ftQKTbckk62xuO8EolOOidt6VleQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sAhpuHveAUBm9PA/GHv26k+eQQBAPfrp77qufPrnBPX0csBwOJ8OMjvI1Pls11ccrgnB0z400ogINi+JpS0TvAwuLSFEzALIB5RHUiaEyWMICzKElIk8l429BrHH2OgrsZ04r2GUvMnq3mIMl6lXmy5sIUK73RInIdtK6w5yREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YnUSkE9s; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YnUSkE9s"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so3998825a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967296; x=1790572096; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJp30NLDE6VMNo04VO3UNO5Lbt1RIBaIrW7mzsnW58Q=;
        b=YnUSkE9sWFTYVJGZZ5FPzJbXGklL5EJu4e/NvWCyKvZTh6Y0bHb6Fp7sBX64uA3//d
         En5Kq5dIRipxHePRwwuJxX7fyAol4v6JXSfXEw/AfLwnKBH2Ab5YT5RBBsbjZM0cQJUO
         jcz4zAL+a7/MJLxw2FILyAaw7fVqoq+MjguaVzXKHGqoUXQk8tsW8RGDIDSTSD4qbbOT
         tJSWtgw3UG5K3V2hRqCiJyHNXN56Zkz0Y6VyWOCrG/lYjBWLx3zcoH6P+uwGnsZPY17o
         JpoIHpU9O1AyL8ViSyHlU5ZQ+pkKd7Fm2CMMi0yP1thNGSlLOw24YQdrEUOM5rsWSUjP
         25eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967296; x=1790572096;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJp30NLDE6VMNo04VO3UNO5Lbt1RIBaIrW7mzsnW58Q=;
        b=fuG0e880cGUWYUYkvSF8nxmcOE3QKMsP7vIxehYWHX7ld2mlu8vdazdMV3pSr97zkp
         /J+LDS7a+UjfYBNmb2lAVNQQhNrsIeuRhcc5OAds167wmmW6V0+crGW4ddi29v4c2Oyh
         0hqPHpJM/R3c232L/EUfbw49qFifkBjhcbhxV3ij72aZX5qUUkUVmk0GNWuJoN8eS/wx
         zpNwrkLyutANyKZntxegvFebrdDEbsEsEoR9AmKu1t7YX1kVOfCQ/QZA13WUmbi8SqE2
         nK9mCAXBsrykfIjH1lEx4Knbr6noG95PhKCRB02vmST3itnrsyiDdu6c9lDusKEtzYPY
         Kbjg==
X-Forwarded-Encrypted: i=1; AKwUvBx2KYW3aCsgAV3vSk6OP1k+45AvlGMsPwT56OJ6zBJ8tX76uI/FWw5ocm+vGoDB7IDJPQMpb2K3pxP4Z/5jMl6Z@vger.kernel.org
X-Gm-Message-State: AFuF++lqHQzHYccV6d3cRbs8prDEesRUkISnUgs7iGu022BTAaE6SWFH
	hwNHxqQ0whgDMKp9XjCAdlngFlexE2epGgf/Lfx0aBqXVKPkZuiTapHmVrqQb2rWNA6pHkLyU5l
	4rpg+eCiaxg==
X-Received: from dldz19-n1.prod.google.com ([2002:a05:701b:4193:10b0:143:9704:de05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1ccc:b0:39e:3bcd:9130
 with SMTP id 98e67ed59e1d1-39e3bcd9601mr16445457a91.20.1789967295633; Sun, 20
 Sep 2026 22:08:15 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:48 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <d3193a91aae805cf91f36cc2201fbe824cd91c73.1789966896.git.irogers@google.com>
Subject: [PATCH v2 30/49] perf python: Port futex-contention to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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

