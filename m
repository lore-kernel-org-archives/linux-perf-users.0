Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DD3A6B71
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403707; cv=none; b=RswxYhUgIRo/Yikya7pVe1QJcDlGwuD4CmvxBudjIyPDPK/Fy8Hq+xZ8HaUfqIK54troRnWJNb+0giFdvwOsuuUHNa97uVyS6KIGyUl7asO2Jrj4EGkMgKVy9sHxgisvbYtOEFHQLlXzr2SOiNCzdG2ByxFInsGY8XATF4uf4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403707; c=relaxed/simple;
	bh=UEBgJw1PnH7QpEOKqSEgOFMjxwdOqKh/aOssIfCCtMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UW+E2CuUaWikN3EERsNUgpGGWkzdsW4yGp4n7R6TNy+nYlLlVQFumx2fyW1utuPTwadSv+g19+km7YCHrgWnjijJONntL+oOngKBEI5KrR5O3uFGN2ArXRqbHnZyeaHOefXZRYpUeHZwSeCDN9ZBodJa1M+HHJkvVnzuWD6Yqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXsJ8M/9; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXsJ8M/9"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1416f32fe11so1214909c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403704; x=1791008504; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MyXzkjyzTz4ArfRGi5jELivwASXQj1VC4djHF8qyKE0=;
        b=qXsJ8M/9xwMFsRptxWcbaSYr34lf3ir6b9/5xh1bv9w6okOcxt+XRK3Vj7HguI5GZD
         pwTMq/Ay09GsIGxsPwh9V/0BydjJCw5dVLZVRMypnfmem1l6T+CJHGYROjNoeQCAwgyo
         Q3o6dCDolRrcHzCFMOfhX3zoqE6xlPyn0bTfToExbygH7nTJounN8cwzCdIlp+itOuZp
         FGWKvV9YTf0BE+oGdiRaDasAa+dq18S//TVr+ufsTSWTuiY/x+fCKGXDuf5aybO6sd1p
         WMnUO8WIl2QWS6Qp8WhF7wQQb/z7ntX+ToPiuHHxh3YzoeZW1j5P/Ry0EMp3cRxSDuxB
         m7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403704; x=1791008504;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MyXzkjyzTz4ArfRGi5jELivwASXQj1VC4djHF8qyKE0=;
        b=CCs4C1einsQYUBbE2BWqamkCf2YVE2G7A28549LsPQkvHpcuC8Bbo3cN27F6fsSKLy
         JtE5HYy+mxX2vNnUgcb9ANU0LkaMr+J5YfiNCNRKjtBKQ3WdsWJbU9GQIez0+KmXG+n8
         9L3vKlonAHkcBTNhVWbiTzpzGMI0CoV/jH93kxcXJOrrkBMbO765v8bc7zUwyJKw5Jab
         /m/pOEsx2t/tgms8kXwQdDZLdLqwbCQZHZ5+c4ObABzFdxmBhTk1nXxvVu9ikTO3hyRm
         8zBS/VnNtHpssRxu65vp6CDNQnkfhpwAZ6liiiQXPrb+mfGaKVewCgDo4ZbPHgMNkTSP
         m7Mg==
X-Forwarded-Encrypted: i=1; AKwUvBw2xCNr8vRt+W1+cBVxXOCtdMeUU/l1/i3UKuc6jZQfvRvXobtLPSs7cc7+d13UeT/sfQSCzmwbElBXX76Brpcb@vger.kernel.org
X-Gm-Message-State: AFuF++n+cQtN7w+nqTho4yJlsf6EGuPNQZb3UFcl6n0TLDVsc7mesmhx
	oma8ZJCf3SVyU2cnCZiHuA2YSjK83lnxW/r84ljy3zM5HOphJ2mZuGxGxDjw1EVD06KeQ7Qss26
	krdxIMCG5AQ==
X-Received: from dlag22.prod.google.com ([2002:a05:701b:2516:b0:146:f03f:918])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:28a:b0:143:26f6:ba7a
 with SMTP id a92af1059eb24-146d03a0f22mr2329838c88.32.1790403703634; Fri, 25
 Sep 2026 23:21:43 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:50 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-24-irogers@google.com>
Subject: [PATCH v4 23/49] perf python: Port syscall-counts-by-pid to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port tools/perf/scripts/python/syscall-counts-by-pid.py to a standalone
script in tools/perf/python/ using the perf module. Avoiding the
embedded interpreter and per-event dictionary overhead improves
execution speed by ~3.8x:

```
$ perf record -e raw_syscalls:sys_enter -a sleep 1
...
$ time perf script tools/perf/scripts/python/syscall-counts-by-pid.py perf
...
real    0m3.852s
user    0m3.512s
sys     0m0.336s
$ time python3 tools/perf/python/syscall-counts-by-pid.py perf
...
real    0m1.011s
user    0m0.963s
sys     0m0.048s
```

Additional improvements compared to the legacy script:
- Resolve architecture-specific syscall names via
  perf.syscall_name(id, session.e_machine) instead of host python-audit
  tables.
- Support both raw_syscalls:sys_enter and individual syscalls:sys_enter_*
  tracepoints, and filter out invalid (> 0xffff or negative) syscall IDs.
- Support filtering by numeric PID as well as command name (comm), and
  resolve process command names via session.find_thread(pid).

Add a shell test (test_syscall_counts_by_pid_python.sh) to verify the
standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/syscall-counts-by-pid.py    | 112 ++++++++++++++++++
 .../test_syscall_counts_by_pid_python.sh      |  92 ++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts-by-pid.py
 create mode 100755 tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh

diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/python/syscall-counts-by-pid.py
new file mode 100755
index 000000000000..fc0ec1bf7ca1
--- /dev/null
+++ b/tools/perf/python/syscall-counts-by-pid.py
@@ -0,0 +1,112 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Displays system-wide system call totals, broken down by syscall.
+If a [comm] arg is specified, only syscalls called by [comm] are displayed.
+"""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+from typing import (Dict, Tuple)
+import perf
+
+syscalls: Dict[Tuple[str, int, int], int] = defaultdict(int)
+for_comm = None
+for_pid = None
+session = None
+
+
+def print_syscall_totals():
+    """Print aggregated statistics."""
+    if for_comm is not None:
+        print(f"\nsyscall events for {for_comm}:\n")
+    elif for_pid is not None:
+        print(f"\nsyscall events for PID {for_pid}:\n")
+    else:
+        print("\nsyscall events:\n")
+
+    print(f"{'comm [pid]/syscalls':<40} {'count':>10}")
+    print("---------------------------------------- -----------")
+
+    sorted_keys = sorted(syscalls.keys(), key=lambda k: (k[0], k[1], -syscalls[k], k[2]))
+    current_comm_pid = None
+    for comm, pid, sc_id in sorted_keys:
+        if current_comm_pid != (comm, pid):
+            print(f"\n{comm} [{pid}]")
+            current_comm_pid = (comm, pid)
+        e_machine = getattr(session, "e_machine", 0) or 0
+        # Mask out the x86_64 x32 ABI bit (__X32_SYSCALL_BIT = 0x40000000) before
+        # resolving the syscall number in the architecture's syscall table.
+        raw_sc_id = sc_id & ~0x40000000
+        if e_machine:
+            name = perf.syscall_name(raw_sc_id, e_machine) or str(sc_id)
+        else:
+            name = perf.syscall_name(raw_sc_id) or str(sc_id)
+        print(f"  {name:<38} {syscalls[(comm, pid, sc_id)]:>10}")
+
+
+def process_event(sample):
+    """Process a single sample event."""
+    event_name = str(sample.evsel)
+    # Per-syscall syscalls:sys_enter_* tracepoints expose '__syscall_nr' (or 'nr')
+    # and may have an unrelated syscall argument named 'id', whereas
+    # raw_syscalls:sys_enter (and legacy pre-2.6.35 syscalls:sys_enter) expose 'id'.
+    if event_name.startswith("evsel(syscalls:sys_enter_"):
+        sc_id = getattr(sample, "__syscall_nr", None)
+        if sc_id is not None and not (0 <= (sc_id & ~0x40000000) <= 0xffff):
+            sc_id = None
+        if sc_id is None:
+            sc_id = getattr(sample, "nr", -1)
+    elif event_name.startswith(("evsel(raw_syscalls:sys_enter", "evsel(syscalls:sys_enter")):
+        sc_id = getattr(sample, "id", -1)
+        if not (0 <= (sc_id & ~0x40000000) <= 0xffff):
+            sc_id = getattr(sample, "__syscall_nr", -1)
+        if not (0 <= (sc_id & ~0x40000000) <= 0xffff):
+            sc_id = getattr(sample, "nr", -1)
+    else:
+        return
+
+    # Mask out __X32_SYSCALL_BIT (0x40000000) when validating the syscall ID range.
+    if not (0 <= (sc_id & ~0x40000000) <= 0xffff):
+        return
+
+    pid = sample.sample_pid
+
+    if for_pid is not None and pid != for_pid:
+        return
+
+    comm = "unknown"
+    try:
+        if session:
+            proc = session.find_thread(sample.sample_pid, sample.sample_tid)
+            if proc:
+                comm = proc.comm() or "unknown"
+    except (TypeError, AttributeError):
+        pass
+
+    if for_comm and comm != for_comm:
+        return
+    syscalls[(comm, pid, sc_id)] += 1
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("filter", nargs="?", help="COMM or PID to filter by")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    if args.filter:
+        try:
+            for_pid = int(args.filter)
+        except ValueError:
+            for_comm = args.filter
+
+    try:
+        session = perf.session(perf.data(args.input), sample=process_event)
+        session.process_events()
+        print_syscall_totals()
+    finally:
+        # Break the reference cycle between session and process_event (whose module
+        # globals reference session) since perf.session lacks cyclic GC (tp_traverse).
+        session = None
diff --git a/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh b/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
new file mode 100755
index 000000000000..9f2ad27751a2
--- /dev/null
+++ b/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
@@ -0,0 +1,92 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# syscall-counts-by-pid python test
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
+script_path="${script_dir}/syscall-counts-by-pid.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, syscall-counts-by-pid.py not found at $script_path"
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
+test_file_mode() {
+	echo "Testing syscall-counts-by-pid.py..."
+	# Some systems might not have raw_syscalls:sys_enter
+	if ! perf list | grep -q raw_syscalls:sys_enter; then
+		echo "Skipping test, raw_syscalls:sys_enter not found"
+		exit 2
+	fi
+
+	# Generate some syscall events
+	perf record -e raw_syscalls:sys_enter -a -o "${temp_data}" \
+		-- sleep 0.5 >/dev/null 2>&1 || \
+		{ echo "Skipping test, perf record failed"; exit 2; }
+
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+		echo "File mode test failed."
+		err=1
+	elif ! grep -E -q "^  [a-zA-Z0-9_]+ +[0-9]+$" "${temp_out}"; then
+		echo "File mode output validation failed."
+		err=1
+	else
+		echo "File mode test passed."
+	fi
+
+	# Test with a comm argument
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" "sleep" > "${temp_out}"; then
+		echo "Comm filter test failed."
+		err=1
+	elif ! grep -E -q "^  [a-zA-Z0-9_]+ +[0-9]+$" "${temp_out}"; then
+		echo "Comm filter output validation failed."
+		err=1
+	else
+		echo "Comm filter test passed."
+	fi
+
+	# Extract sleep PID from "sleep [<pid>]" header and test with a numeric PID filter argument
+	sleep_pid=$(sed -n 's/^sleep \[\([0-9]\+\)\]$/\1/p' "${temp_out}" | head -n 1)
+	if [ -z "${sleep_pid}" ] || ! "$PYTHON" "$script_path" -i "${temp_data}" "${sleep_pid}" > "${temp_out}"; then
+		echo "PID filter test failed."
+		err=1
+	elif ! grep -E -q "^  [a-zA-Z0-9_]+ +[0-9]+$" "${temp_out}"; then
+		echo "PID filter output validation failed."
+		err=1
+	else
+		echo "PID filter test passed."
+	fi
+}
+
+test_file_mode
+
+exit $err
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

