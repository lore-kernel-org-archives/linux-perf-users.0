Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AFC361DA6
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967283; cv=none; b=szqssWtpiLw8XLjtSYdDZc1+2QQsvqNtV1rRQ/4W73n+YGuuIrSfLAa7QtLEu40hBJkYkx37dEIwHfumEolARmytOFPkgtAyuj/p2CbJiO3O7zX2IpamlBWKyQe373m3Nv2PjhMq4+8kOba4B6jRDe1EmVN7n34jPAn04yzcE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967283; c=relaxed/simple;
	bh=jvAYegJhhMwNPe25KzeBo21Y4+gjFm5wh+YAvXPFNek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ANHCXMnG/ifYsd5Ol0d+ITUK2hGN17nzsMOU2P6rVK/HOwwc8E6OX/Cpadrz9YJppwjqfGoT46GrB8R5ktDNnN6HoEmWfU023FZNr3otHPPYptoj3DJ7edLgIfrE82qeYhvEn2NNkJtU+l5H7VloXkllGw+Ha+PCNxGXTeyDdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ADvwBQMb; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADvwBQMb"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so6788568a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967281; x=1790572081; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRIZXBc9ahZv64Jercgw0kSWAoaTTCM2Y4VJXdWtU9U=;
        b=ADvwBQMbZPOWYf8RrsaD6D4fi9PjPztFkYdLhfoPH8Y3OCZqsJdTy9/rJbpdPPIoYt
         966RQ0cRo4EKRi4Jz9gQSI6pfoGMhDs7biYrCxZtomvnACGlMAsqO+TeY8yqgoy/h3mj
         y4a+XPBr/tEIu2WLtgCpPKrGX8HTvG4r3UooLe0XXk6jvUabwCIOhL4ZIUNBzEcmnbpZ
         a4KF2dRSQKd+syxeBgE8nvOKMnMWEXavqx6Php/qrIxv91taa7D/37agvLququYhRNb9
         D3uOKgnMaNQ47g/woHOJ45iijprW8gQfhgZ2jGMuEdpfqtrL7xl2PrGM1sOZF20rYOM/
         z9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967281; x=1790572081;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRIZXBc9ahZv64Jercgw0kSWAoaTTCM2Y4VJXdWtU9U=;
        b=swnZQ+DfH5ICA6CYeyZhq8Lux+5WnymDiGinnr5eJWxUuNzfwtwTVm2PF1FL7/nPyu
         vTsIfsrZlnXCMIq8/O1SUm7bnUopKTZm9yNL9iTARfI8C23xKqWDQYe4AHRFzMpgUIYt
         qDYxFutIJ9S4t/0RI8Rmzxfu2YFceanfD0xRsEm/jS7Dm7mMApqryIkIGLdvfmRDju8r
         BtOLz1y0hnn0Ytxo34u6ffK+UCgpicmLpUrqBy9dgbx+XA0diIIWTh7EQt/xWvPKktby
         spxINUUP6s9PE07zpftJwskHBa/80ZnOeEuPbsxT2OWFQ5ufqoFnbVWuXVy8qHobIYYk
         72ZA==
X-Forwarded-Encrypted: i=1; AKwUvBzqLWt8wyb3k2pUIRo1Fe1wnZZARHMYSa8e5AqqD5GxuJB/JQ/rfLNerz57sovobaZoxUest0gYBZFZOHRgAnDc@vger.kernel.org
X-Gm-Message-State: AFuF++lU8iGWtoOYUIYcFDxUKCWTLY/aiaUyFo0UkzMwBGIXUi/RSu2q
	nFIP5RiTjPMMQGtPPOB99LLskGYGYFH8VkdO29c/OGQVny7kA2UtyJKCwDShpIoD4LZ9rkMLJzB
	XQYpTefLnMQ==
X-Received: from dlbro10.prod.google.com ([2002:a05:7022:158a:b0:143:91fd:56cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d40e:b0:39e:6c6a:656f
 with SMTP id 98e67ed59e1d1-39e6c6a6787mr7976160a91.50.1789967280583; Sun, 20
 Sep 2026 22:08:00 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:40 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <358959ec80e586129cc202a45190f8fa6443801f.1789966896.git.irogers@google.com>
Subject: [PATCH v2 22/49] perf python: Port syscall-counts to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port tools/perf/scripts/python/syscall-counts.py to a standalone script
in tools/perf/python/ using the perf module. Avoiding the embedded
interpreter and per-event dictionary allocation overhead improves
execution speed by ~4x:

```
$ perf record -e raw_syscalls:sys_enter -a sleep 1
...
$ time perf script tools/perf/scripts/python/syscall-counts.py perf
...
real    0m3.887s
user    0m3.578s
sys     0m0.308s
$ time python3 tools/perf/python/syscall-counts.py perf
...
real    0m0.953s
user    0m0.905s
sys     0m0.048s
```

Additional improvements compared to the legacy script:
- Resolve syscall names using perf.syscall_name(id, session.e_machine)
  instead of host python-audit / Util.py tables, enabling accurate
  cross-architecture perf.data analysis without external dependencies.
- Support both raw_syscalls:sys_enter (sample.id) and individual
  syscalls:sys_enter_* tracepoints (sample.__syscall_nr / sample.nr),
  filtering out invalid/corrupt (> 0xffff or negative) syscall numbers.
- Add argparse CLI options (-i/--input and optional comm filter).

Add a shell test (test_syscall_counts_python.sh) to verify the
standalone script. The legacy script and its bin wrapper are retained
temporarily during the transition to maintain bisectability and are
removed once all scripts are migrated.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/syscall-counts.py           | 80 +++++++++++++++++++
 .../tests/shell/test_syscall_counts_python.sh | 74 +++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts.py
 create mode 100755 tools/perf/tests/shell/test_syscall_counts_python.sh

diff --git a/tools/perf/python/syscall-counts.py b/tools/perf/python/syscall-counts.py
new file mode 100755
index 000000000000..d25a53c54428
--- /dev/null
+++ b/tools/perf/python/syscall-counts.py
@@ -0,0 +1,80 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Displays system-wide system call totals, broken down by syscall.
+
+If a [comm] arg is specified, only syscalls called by [comm] are displayed.
+"""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+from typing import DefaultDict
+import perf
+
+syscalls: DefaultDict[int, int] = defaultdict(int)
+for_comm = None
+session = None
+
+
+def print_syscall_totals():
+    """Print aggregated statistics."""
+    if for_comm is not None:
+        print(f"\nsyscall events for {for_comm}:\n")
+    else:
+        print("\nsyscall events:\n")
+
+    print(f"{'event':<40} {'count':>10}")
+    print("---------------------------------------- -----------")
+
+    for sc_id, val in sorted(syscalls.items(),
+                             key=lambda kv: (kv[1], kv[0]), reverse=True):
+        e_machine = getattr(session, "e_machine", 0) or 0
+        raw_sc_id = sc_id & ~0x40000000
+        if e_machine:
+            name = perf.syscall_name(raw_sc_id, e_machine) or str(sc_id)
+        else:
+            name = perf.syscall_name(raw_sc_id) or str(sc_id)
+        print(f"{name:<40} {val:>10}")
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
+    comm = "unknown"
+    try:
+        if session:
+            proc = session.find_thread(sample.sample_tid)
+            if proc:
+                comm = proc.comm() or "unknown"
+    except (TypeError, AttributeError):
+        pass
+
+    if for_comm and comm != for_comm:
+        return
+    syscalls[sc_id] += 1
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("comm", nargs="?", help="Only report syscalls for comm")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+    for_comm = args.comm
+    session = perf.session(perf.data(args.input), sample=process_event)
+    session.process_events()
+    print_syscall_totals()
diff --git a/tools/perf/tests/shell/test_syscall_counts_python.sh b/tools/perf/tests/shell/test_syscall_counts_python.sh
new file mode 100755
index 000000000000..e1c6e2820cce
--- /dev/null
+++ b/tools/perf/tests/shell/test_syscall_counts_python.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# syscall-counts python test
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
+script_path="${script_dir}/syscall-counts.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, syscall-counts.py not found at $script_path"
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
+	echo "Testing syscall-counts.py..."
+	# Some systems might not have raw_syscalls:sys_enter (e.g. stripped kernels or permissions)
+	if ! perf list | grep -q raw_syscalls:sys_enter; then
+		echo "Skipping test, raw_syscalls:sys_enter not found"
+		exit 2
+	fi
+
+	# Generate some syscall events
+	if ! perf record -e raw_syscalls:sys_enter -o "${temp_data}" -- sleep 0.5 2>/dev/null; then
+		echo "perf record failed (permissions?), skipping file mode test."
+		exit 2
+	fi
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
+}
+
+test_file_mode
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

