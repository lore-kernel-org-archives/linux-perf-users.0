Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829CF376494
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967285; cv=none; b=MQ5moHNm5ehWwqjruopWYiK2bICP9dZYgUl790CxrOaYV03wCT2OZWuWfUslE+WFY7JfmkO4wAGkrs9PtBX2SVuFLB3Nyr9a8yx9jSspQN9+dOs7WfhxShFOeepBCvOTwDqkNkb9jMpXriZvllk9M3n5cgII+PCkTZ3Mzc6iwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967285; c=relaxed/simple;
	bh=g/Ve/Dz69mVwYwXZQzraubamdEWfFNRLZJALekTvCjY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nisKhXI89EHNdhM/Yn7RyWt+egvzhoFto6TNYoLeI/HaFwYRwq4yrRVN5YwyEmin3e7YSpyKImpkeq+PYumUDMk5NZkg82v3BqClgwvTgwGk2Da4umNvj6e9Nma3xtK5i7RACPAWc+FvVNMjyTl/rXAeCuXo0mH2opufsMNEJu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uz/tbdYU; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uz/tbdYU"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so9473905a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967282; x=1790572082; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5UI4iSuLKOX6kWPkIhUzutGnx8W1EyKbX4t+3Dj7gUk=;
        b=uz/tbdYU/FFbjnGtsevZa2CCfdODFQK2PIB71wU0z68trFrdS9w2NJ1Hdbk762aRqe
         pXwUA/oaoZhgetB09fnhw8riPaAFDDEjrK1xChMpLijan6fvfhgggQf94N9aOsFsD5yt
         crqS/eqUnC0Q/mZnppsJSEoHTCkizV294NHd2FUQnWhgsBGsdf833/e1nsvhKYr/KqYo
         GZGgqI6kICtF4+7iEkwRRAFif88re43JGKWAb4OZwBNx26mf+lujvr49SibMmDBqc/hj
         zmM9nCAse+eXLLdsPNN3Tt93FHoPxphIjZ+hD6trhhISPpQNt17W9pYdOZ/9x8nqI4xE
         Keyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967282; x=1790572082;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UI4iSuLKOX6kWPkIhUzutGnx8W1EyKbX4t+3Dj7gUk=;
        b=M607rIcsRwhCf+ovZ/qxA3cGtui/pu/asqK6Q2bzu4wfBg+st+aZ7l48Io2UaIKYGI
         s3rklr28drCKvf95DDYu/oBUYuGWipVbqU/NCOqMrAut0CM4Gppo48G6h9mz2dOmeVi9
         UtEzyU++Zgu5OdZtwFWdj61PNdNeWKAfACpYzIuXH/0Fgcosn1kNheFMBy0Nhx5xwkrc
         Dmt572JkIej2vdniw76FEdrvPOruThZ1hiXaRstAb7HXD8WcP037/rseP9CricQ4x/hv
         PXVzkOVuDQclWhVZr73BGZoWDJdfcBstGce18jRL8HJO2D+8NQNqw4vmMPEcNRYLUVcZ
         nnig==
X-Forwarded-Encrypted: i=1; AKwUvBzOmAPpf+wBAkT3aNSJVBY+fzn4H4bVeoZpNuwS6sawyaH8UkiEaKt5ezVTsB220uW5Nd4aQYrTE5R2LDI76R4y@vger.kernel.org
X-Gm-Message-State: AFuF++lycLaGBdehcXEA820+GHla9CFMrtr8pf1Kfox4Xc+T1Qvm9jXW
	L+XgzgX7Tdnt7Ize4Z1puT9zEhdD9xmaJt/0+dnmrnKzQi8BEsDPxqUf29yRP3whVcwW6QuEniy
	iBOqxpPQFyg==
X-Received: from dlea1-n1.prod.google.com ([2002:a05:701b:4201:10b0:144:bfb6:b5b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58c5:b0:39e:6c69:9b97
 with SMTP id 98e67ed59e1d1-39e6c69b286mr8789887a91.60.1789967282417; Sun, 20
 Sep 2026 22:08:02 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:41 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <5a832d20b1a04c97e8f3a68db4c89925516d5e81.1789966896.git.irogers@google.com>
Subject: [PATCH v2 23/49] perf python: Port syscall-counts-by-pid to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
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
 tools/perf/python/syscall-counts-by-pid.py    | 97 +++++++++++++++++++
 .../test_syscall_counts_by_pid_python.sh      | 81 ++++++++++++++++
 2 files changed, 178 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts-by-pid.py
 create mode 100755 tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh

diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/python/syscall-counts-by-pid.py
new file mode 100755
index 000000000000..26b5dc57d6e0
--- /dev/null
+++ b/tools/perf/python/syscall-counts-by-pid.py
@@ -0,0 +1,97 @@
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
+    if event_name.startswith("evsel(raw_syscalls:sys_enter"):
+        sc_id = getattr(sample, "id", -1)
+    elif event_name.startswith("evsel(syscalls:sys_enter"):
+        sc_id = getattr(sample, "__syscall_nr", None)
+        if sc_id is not None and not (0 <= (sc_id & ~0x40000000) <= 0xffff):
+            sc_id = None
+        if sc_id is None:
+            sc_id = getattr(sample, "nr", -1)
+    else:
+        return
+
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

