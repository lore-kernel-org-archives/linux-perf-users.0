Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045F3DA5AB
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881804; cv=none; b=R0G9pAwcJap5dBkFBx7dzjCyySI4nVDMsZQcwIJFHqPzfai8kZzyIjQb04RMlfDZjiPlqHCBMKnFkr0oMKwRpqpWXVAbw1lAJ+k0JdK0CuakrfkyIYhm3004VtL5cF5+FX2rndFFqYXt8KRzdY8uj9ZzvxsbiH08wEkV9ZJxaMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881804; c=relaxed/simple;
	bh=LIbpegpgK9tXBWddCbG60HRMQoPJgrhRDz2SoXbfwM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JgxUKqphMGmFW3pXAfkYEpjHZbwuDXGQOOmba5DCaE/Dp6xJtkriM+tCVjNg/q/3Gh+5MyHpFEWAszvtxu28iMtKfifbxTnMN5bvTBQmu2VSBbbrdMl1VSxn7oJsm5LJbAU5kVLKnEgIEFn8VNDG+rg+O5KvpPS5cuY4t2Ayy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kfpN4+TE; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfpN4+TE"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d55d8cd938so36049355ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881799; x=1790486599; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3t/WaIyWiiJ9+DosDBhsw56u/o2aVtnBSQXi/PqXDI=;
        b=kfpN4+TEPHgKEF1/oEtVV5MGLPrtKQwGXEKKzl1NJTsML86MXdMTSuozNAZc5a4VOz
         VH2Xwrf8YeT6DqRJRp4KNRhwfESDmqCJ/Rz4Vo/9sgrbpdLSlKXMfEk6+iWySQDIIdk+
         pXk56hVcNfIc4sc4tlDy9t1I7F3VzQZI+fArsA4js2nRKjwBdxyJqSPnVmKsM+BxnG2G
         hOQypUIqVKetmizg+MvX+wqPf3Y0SoD9Jt3ftPuzuVgc19xPesPFf4MnomIN4pRbJRvF
         cEiospnxgHUIW/hUDXtG/8pbML/L/jRBA1ndGT93jA0/ceoMx4s9z6+DMT3wRpH3DSUl
         SrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881799; x=1790486599;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3t/WaIyWiiJ9+DosDBhsw56u/o2aVtnBSQXi/PqXDI=;
        b=ijnlVZowFDhB8nH46SOj1S1zowuIWMTq1t/TukFdCeHNO4LkR/bqoWw5PVdgHDfCW0
         ibtsJe8mMoIT5OBvrNBm2W7BZP/rTF0+3wLIRe7P8C6JDV2YqUchiptwIzD6Lm6vAdK3
         U2GgYrdqVW7j8Zs5yY9/4j1MZ0KxcQgpU0KHnXdF2HGNg6vuSulrsAGcuQ94grLKTPA5
         XKJYdjx50lW/Kxcl2MB4SvJnGQ83y+G9JMwlLxsSRNO8mE5ZWUbIbxiz59zCUg/mWsUB
         LJV1xqKB4LULHoJTgf1aaKsumfWZYVY3dpRpiWA+/xx0weIRsOW4hoSG/+CfQIkvL4na
         x6Dg==
X-Forwarded-Encrypted: i=1; AKwUvBzJowEOlusf+dTmEdbYNZCU/mLCYpIyjiRH03q2mr7ESuXUtWV4Oh4zopMoaQkm6f6wv8WDdm2JLlWQo0hruPDN@vger.kernel.org
X-Gm-Message-State: AFuF++mxY1zceJ5iclWJBYt+jH3hDkHRFwkHcgo8ah3XNe0D5XlREhT7
	5plh1a4yYV3AaXS8x+Z1Xg/qgJ2epUOqI5h9CwPFOv3BC9ncF+mOEq9/ohATQZCIyAn3VO7bYHI
	eyB5y9cEu9A==
X-Received: from dybpk15.prod.google.com ([2002:a05:7301:428f:b0:32b:9b32:ea2a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db06:b0:2dd:ad74:ac7f
 with SMTP id d9443c01a7336-2ddb1bbf158mr123390515ad.26.1789881798692; Sat, 19
 Sep 2026 22:23:18 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:15 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <beae673fc7309dcb3d51dfd729cc1b78ec97d97a.1789880842.git.irogers@google.com>
Subject: [PATCH v1 23/49] perf python: Port syscall-counts-by-pid to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
 tools/perf/python/syscall-counts-by-pid.py    | 100 ++++++++++++++++++
 .../test_syscall_counts_by_pid_python.sh      |  81 ++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts-by-pid.py
 create mode 100755 tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh

diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/python/syscall-counts-by-pid.py
new file mode 100755
index 000000000000..6e340e8e71df
--- /dev/null
+++ b/tools/perf/python/syscall-counts-by-pid.py
@@ -0,0 +1,100 @@
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
+    sorted_keys = sorted(syscalls.keys(), key=lambda k: (k[0], k[1], -syscalls[k], -k[2]))
+    current_comm_pid = None
+    for comm, pid, sc_id in sorted_keys:
+        if current_comm_pid != (comm, pid):
+            print(f"\n{comm} [{pid}]")
+            current_comm_pid = (comm, pid)
+        e_machine = getattr(session, "e_machine", 0) or 0
+        if e_machine:
+            name = perf.syscall_name(sc_id, e_machine) or str(sc_id)
+        else:
+            name = perf.syscall_name(sc_id) or str(sc_id)
+        print(f"  {name:<38} {syscalls[(comm, pid, sc_id)]:>10}")
+
+
+def process_event(sample):
+    """Process a single sample event."""
+    event_name = str(sample.evsel)
+    if event_name.startswith("evsel(raw_syscalls:sys_enter"):
+        sc_id = getattr(sample, "id", -1)
+    elif event_name.startswith("evsel(syscalls:sys_enter"):
+        sc_id = getattr(sample, "__syscall_nr", None)
+        if sc_id is not None and (sc_id < 0 or sc_id > 0xffff):
+            sc_id = None
+        if sc_id is None:
+            sc_id = getattr(sample, "nr", None)
+            if sc_id is not None and (sc_id < 0 or sc_id > 0xffff):
+                sc_id = None
+            if sc_id is None:
+                sc_id = getattr(sample, "id", -1)
+    else:
+        return
+
+    if sc_id < 0 or sc_id > 0xffff:
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
+            proc = session.find_thread(pid)
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
+    session = perf.session(perf.data(args.input), sample=process_event)
+    session.process_events()
+    print_syscall_totals()
diff --git a/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh b/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
new file mode 100755
index 000000000000..0c67e7d24a6c
--- /dev/null
+++ b/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
@@ -0,0 +1,81 @@
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
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, syscall-counts-by-pid.py not found at $script_path"
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
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" >/dev/null; then
+		echo "File mode test failed."
+		err=1
+	else
+		echo "File mode test passed."
+	fi
+
+	# Test with a comm argument
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" "sleep" >/dev/null; then
+		echo "Comm filter test failed."
+		err=1
+	else
+		echo "Comm filter test passed."
+	fi
+
+	# Test with a numeric PID filter argument
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" "$$" >/dev/null; then
+		echo "PID filter test failed."
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
2.55.0.1082.g2b9226bbc0-goog

