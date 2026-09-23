Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9355C305
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187270; cv=none; b=ZNdbG+3yX6/QJjyM21Sbtu5WyCkLkSLVWy2D1bolWcBboDS61pbX8ozkUb3WDvT3jZL7AZ1lSWqDDeD/fm+eLD5Xg6fZnKfhGwp7RPhsoIIBBCHqDr66+upkO5OHolGBVWHzVEAwTTWh75AmQTSAKA4WA4FIWCcdBB7DRKVATUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187270; c=relaxed/simple;
	bh=D7mHfkJZGmpCgmnuSmVmwJlDlWYIp4EmUfdaZx0vOIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SwJsj5BV97yAVwHIwa5PgbvuiftlpwCcq0GzxTvrbfx9YOPaW0vGsH3QoDQPa4oePB81kMN6NkJn/usbSy4t01HtzkdBat4UHBGzZYROSWv9CXkHRp+NdB6yZ6K6Vt6g19NhCRv8LzbADIkxRXFmupQZiYhfshasbhx4zm6LmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S19TVgVM; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S19TVgVM"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33310847fcaso2106370eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187264; x=1790792064; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=22nImBXUTtgNCV0RoR9YGrAxDBAJvu+tLjxkWm5Ubg8=;
        b=S19TVgVMZCf4GTPL2iU3NJzsnHwuvTqvpBuQeVY3v6Xkne31OKRLvUK3Gnpiw12BEN
         MaHZyAroPpEC74EOurPlEvxQNzutsS2uoFfg4FqXWbY76vmIf+HWtqBf2RbgBZmWmyjV
         u3KQN33KSq7n9bD/CBqlUBuQ5MM+f6Pzb7wdjHlBDNOrWp63tmqqBhpfyPG1EUOgQEl2
         h3ectmGq8BzXoouYnucZ5F5uc3Tqp8O9p9UebhPu+5qQfbmQCAKgVfRXGF/UPvVyfLQJ
         15p2aLIda9m+dv5puIiwz0JhFTMFNLu0Dh5uhRD8GOX7HtIdBeOL4n8Xus7Z+xy3caYo
         zZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187264; x=1790792064;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=22nImBXUTtgNCV0RoR9YGrAxDBAJvu+tLjxkWm5Ubg8=;
        b=CDG//1SsK/+82gfqgvqPJRmPpvydIkZIQXGToAX4yFc42sRVZTTTeGfuas9r8ssKw8
         JweIru/pL3JDHAoFk+U88FiBA8hWyuCZuPYdGd/JRGgCUbzeYJjqAmzANZt81nK6D1J2
         L8+ElsD/VJUeRToGtsssAaKzhSF6rly4p0NGCxqub3LXJeioizcXj8i5e6QEDy2rsHoG
         7CZ30W44w4NGJvI2ZYhnl4/tUzSuEQxVb8ASiuZ8KC4Aju43YQR8MYlXb9RkP8j9XgVK
         41Uhgc7/8a7z/4I8+6vXHCrIkWM6WIxyFswICPQpnOe8EOPRCjEl4i+LLbAimyilKrNL
         HPjA==
X-Forwarded-Encrypted: i=1; AKwUvBzBRzMzjbcC3AprOmDmp4ZINEIZAz/jf97gG5CEUn7ndaCcbiswR/b/9MhezLKdxbcAALrV9FNbfWU42onMB5GP@vger.kernel.org
X-Gm-Message-State: AFuF++ldE6xeaozkH100KOAsJw6ZFDMQwrzyBAh/w9wmPTqChZfB6S4W
	Jb2CAc4kEO3EZuHFC8ePgOYQvitRcJyDACchJUafYQDRyRCMUAxdhj5UVAWJBK/NnwPl0x6HV92
	ABj5O5B7RXg==
X-Received: from dybim48.prod.google.com ([2002:a05:7301:2d30:b0:33e:5482:b701])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1803:b0:334:3227:652a
 with SMTP id 5a478bee46e88-33e8e6a1233mr3365775eec.41.1790187263593; Wed, 23
 Sep 2026 11:14:23 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:53 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-31-irogers@google.com>
Subject: [PATCH v3 30/49] perf python: Port futex-contention to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
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
 tools/perf/python/futex-contention.py         | 107 ++++++++++++++++
 .../shell/test_futex_contention_python.sh     | 115 ++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100755 tools/perf/python/futex-contention.py
 create mode 100755 tools/perf/tests/shell/test_futex_contention_python.sh

diff --git a/tools/perf/python/futex-contention.py b/tools/perf/python/futex-contention.py
new file mode 100755
index 000000000000..097663d929b7
--- /dev/null
+++ b/tools/perf/python/futex-contention.py
@@ -0,0 +1,107 @@
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
+# Mask out FUTEX_PRIVATE_FLAG and FUTEX_CLOCK_REALTIME so variants such as
+# FUTEX_WAIT_PRIVATE (0 | 128) match the base FUTEX_WAIT command.
+FUTEX_CMD_MASK = ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+
+
+def handle_start(pid: int, tid: int, uaddr: int, op: int, start_time: int) -> None:
+    """Handle a futex sys_enter event."""
+    if (op & FUTEX_CMD_MASK) != FUTEX_WAIT:
+        return
+    try:
+        if session:
+            process = session.find_thread(pid, tid)
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
+    if event_name.startswith("evsel(") and event_name.endswith(")"):
+        event_name = event_name[6:-1]
+    if event_name.startswith("syscalls:sys_enter_futex"):
+        uaddr = getattr(sample, "uaddr", None)
+        op = getattr(sample, "op", None)
+        if uaddr is None or op is None:
+            return  # Tracepoint fields missing, skip silent attribution to 0
+        handle_start(getattr(sample, "sample_pid", sample.sample_tid),
+                     sample.sample_tid, uaddr, op, sample.sample_time)
+    elif event_name.startswith("syscalls:sys_exit_futex"):
+        handle_end(sample.sample_tid, sample.sample_time)
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Measure futex contention")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    try:
+        session = perf.session(perf.data(args.input), sample=process_event)
+        try:
+            session.process_events()
+        except KeyboardInterrupt:
+            pass
+
+        for ((t, u), stats) in sorted(durations.items()):
+            avg_ns = stats.avg()
+            print(f"{process_names.get(t, 'unknown')}[{t}] lock {u:x} contended "
+                  f"{stats.count} times, {avg_ns:.0f} avg ns "
+                  f"[max: {stats.max_time} ns, min {stats.min_time} ns]")
+    finally:
+        # Break the reference cycle between the global session and the
+        # process_event callback so the C perf.session object is freed.
+        session = None
diff --git a/tools/perf/tests/shell/test_futex_contention_python.sh b/tools/perf/tests/shell/test_futex_contention_python.sh
new file mode 100755
index 000000000000..26b13d263d20
--- /dev/null
+++ b/tools/perf/tests/shell/test_futex_contention_python.sh
@@ -0,0 +1,115 @@
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
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, futex-contention.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+temp_out=""
+
+cleanup() {
+	rm -f "${temp_data}" "${temp_out}"
+}
+
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_out=$(mktemp /tmp/perf.out.XXXXXX)
+
+test_synthetic() {
+	echo "Testing futex-contention.py synthetic events..."
+	if ! "$PYTHON" - "$script_path" << 'EOF'
+import importlib.util
+import sys
+from types import SimpleNamespace
+
+spec = importlib.util.spec_from_file_location("futex_contention", sys.argv[1])
+mod = importlib.util.module_from_spec(spec)
+spec.loader.exec_module(mod)
+
+enter_sample = SimpleNamespace(
+    evsel="evsel(syscalls:sys_enter_futex:k)",
+    sample_pid=1234,
+    sample_tid=1234,
+    uaddr=0xdeadbeef,
+    op=mod.FUTEX_WAIT | mod.FUTEX_PRIVATE_FLAG,
+    sample_time=1000,
+)
+exit_sample = SimpleNamespace(
+    evsel="evsel(syscalls:sys_exit_futex:k)",
+    sample_pid=1234,
+    sample_tid=1234,
+    sample_time=2500,
+)
+
+mod.process_event(enter_sample)
+mod.process_event(exit_sample)
+
+stats = mod.durations.get((1234, 0xdeadbeef))
+assert stats is not None and stats.count == 1, f"Unexpected stats: {stats}"
+assert stats.min_time == 1500 and stats.max_time == 1500 and stats.avg() == 1500.0
+line = (f"{mod.process_names.get(1234, 'unknown')}[1234] lock {0xdeadbeef:x} "
+        f"contended {stats.count} times, {stats.avg():.0f} avg ns "
+        f"[max: {stats.max_time} ns, min {stats.min_time} ns]")
+expected = "unknown[1234] lock deadbeef contended 1 times, 1500 avg ns [max: 1500 ns, min 1500 ns]"
+assert line == expected, line
+EOF
+	then
+		echo "Synthetic test failed."
+		err=1
+	else
+		echo "Synthetic test passed."
+	fi
+}
+
+test_file_mode() {
+	echo "Testing futex-contention.py..."
+	# Some systems might not have syscalls:sys_enter_futex
+	if ! perf list | grep -q syscalls:sys_enter_futex; then
+		echo "Skipping file mode test, syscalls:sys_enter_futex not found"
+		return
+	fi
+
+	# Generate some futex events
+	if ! perf record -e syscalls:sys_enter_futex,syscalls:sys_exit_futex -a -o "${temp_data}" \
+		-- sleep 0.5 2>/dev/null; then
+		echo "Skipping file mode test (record failed)"
+		return
+	fi
+
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+		echo "File mode test failed."
+		err=1
+	else
+		echo "File mode test passed."
+	fi
+}
+
+test_synthetic
+test_file_mode
+
+exit $err
-- 
2.56.0.rc1.310.g51773c2048-goog

