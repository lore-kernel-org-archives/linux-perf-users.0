Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811138E8AD
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403706; cv=none; b=gd1fjyUXbQFMhG0PVWtLjVm1m42KqmKO3rXEAPe2tC0qO1OZOYbHKD3kwe6Xo5Ev210z0Wl1gxy4+SIKYMzy7YL0W/UYUJklLMbZye8lY6NQQ9PxNE7PSH/5PPdxQIOr7o4ya2oNk0181NmzmELwiBCdYKQV47d4tGb2A/63VxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403706; c=relaxed/simple;
	bh=6ag33SxA7J4ELTIrogvicm6odv/pg7jUslFyUaGBIe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QcFLVvgOrqBFmhAIXWBjHiNr7+fxtc4A78BwYfEg4JI7kFVukgCeJAG6S4Bik2JXDEzXx6M3PKtuUPjp0ORxIHbnxRTxGBExI6WOG6Z/aGeb28LIfmch8ZW4JAGpEb+AXTkKrXsyyeLHbM5KmCx8LQTvjsNvX746Uo5I/qaAW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRfASWeW; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRfASWeW"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1438fef603cso2048829c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403702; x=1791008502; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqmuF391ZspJnHR9y5O7VpXeFvgfyBsk3g1IkronqOI=;
        b=mRfASWeWgZa0pHmoHuQ2aJ523t+Fg5sSbcQPI0bjZPVYbUvnYVaBlWNR69u4bNeIXG
         RYhhNNw8MnOMx1n38yo/D6gk8XWCMo50VC5tqxAFIXzMnRzukvqcF395fNneWvgt181H
         b0rzZzeawyuCwzetl132ecDmonHASbXpc/+3iL1vIy7us2/160X2HanqHxZKDc0MkRyh
         WFZcy6nfW5VJ8TYNtGdqUw7h4UOBGy0NPZCFM0Le6qh0K7L0XikT2qBjbWZxzUMMK1WD
         RADlNt3l4PAahnRvm/u3cgdjQIeZgkdLS+TMvDO3l7+TS/TvhInPNocrXJ05loR+HED6
         /EwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403702; x=1791008502;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fqmuF391ZspJnHR9y5O7VpXeFvgfyBsk3g1IkronqOI=;
        b=NoqI7bnf+u/FrfrEsPt0Hwz81nHxLuyqIf8+pGtTizxY6OedV0cSCIe2v9c1bNjNpP
         FuXHY52PldN6WnXFPULhDr7tLDkTd8xw/EX5S4fC/37xd/S29SxcWi7VUE+FjzM8fnSV
         P8lXg8Z7x5H43T8jalcc8C0f5/Nlf7r/Il5zqgCPnbk4ivdWchIMf8MZvwppEEtUOVsv
         u5Pow1rnANr3T3N5rRu8NPKspgd5VQ0ZPjmpyTfhac0vQCeEfL629cm4zgQ3Zt2z78p9
         ftSeSW4UFG/idez6/8k6yjrIZJS98PY2SR5iQPd9ioG3ncE8Vk7Y+BBsQF8LAInQQuUr
         vOMA==
X-Forwarded-Encrypted: i=1; AKwUvBzEc2nx9GLn/O2eOmnS3848Zxsxfvfn4+GEJPA87DVeQWPYZBaQHtdm9tRfQUcgBXJtgNXIFnL/Zsqr0huuuM9D@vger.kernel.org
X-Gm-Message-State: AFuF++kQLdDI1dsGLK+Fpcjuzhrm/8KtsvAazsM8rV5SsR22dqGZwcAG
	wefqkKfPwaJ6RbkgyxGh4owQ6XVbm9jdJWwRfNCgyz8uoLuf4KPaDo3vun6JoUVPwG6X9BYI5zC
	NckHd8T19lQ==
X-Received: from dlbek9.prod.google.com ([2002:a05:7022:c89:b0:143:9538:71e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:c083:b0:144:c112:5f24
 with SMTP id a92af1059eb24-146cfbdd167mr2141541c88.25.1790403701654; Fri, 25
 Sep 2026 23:21:41 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:49 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-23-irogers@google.com>
Subject: [PATCH v4 22/49] perf python: Port syscall-counts to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
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
 tools/perf/python/syscall-counts.py           | 95 +++++++++++++++++++
 .../tests/shell/test_syscall_counts_python.sh | 81 ++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts.py
 create mode 100755 tools/perf/tests/shell/test_syscall_counts_python.sh

diff --git a/tools/perf/python/syscall-counts.py b/tools/perf/python/syscall-counts.py
new file mode 100755
index 000000000000..3ddb1bcc27e0
--- /dev/null
+++ b/tools/perf/python/syscall-counts.py
@@ -0,0 +1,95 @@
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
+                             key=lambda kv: (-kv[1], kv[0])):
+        e_machine = getattr(session, "e_machine", 0) or 0
+        # Mask out the x86_64 x32 ABI bit (__X32_SYSCALL_BIT = 0x40000000) before
+        # resolving the syscall number in the architecture's syscall table.
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
+    # Per-syscall syscalls:sys_enter_* tracepoints expose '__syscall_nr' (or 'nr')
+    # and may have an unrelated syscall argument named 'id' (e.g. sys_enter_clock_gettime),
+    # whereas raw_syscalls:sys_enter (and legacy pre-2.6.35 syscalls:sys_enter) expose 'id'.
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
+    syscalls[sc_id] += 1
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("comm", nargs="?", help="Only report syscalls for comm")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+    for_comm = args.comm
+    try:
+        session = perf.session(perf.data(args.input), sample=process_event)
+        session.process_events()
+        print_syscall_totals()
+    finally:
+        # Break the reference cycle between session and process_event (whose module
+        # globals reference session) since perf.session lacks cyclic GC (tp_traverse).
+        session = None
diff --git a/tools/perf/tests/shell/test_syscall_counts_python.sh b/tools/perf/tests/shell/test_syscall_counts_python.sh
new file mode 100755
index 000000000000..0c4b75499209
--- /dev/null
+++ b/tools/perf/tests/shell/test_syscall_counts_python.sh
@@ -0,0 +1,81 @@
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
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, syscall-counts.py not found at $script_path"
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
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+		echo "File mode test failed."
+		err=1
+	elif ! grep -E -q "^[a-zA-Z0-9_]+ +[0-9]+$" "${temp_out}"; then
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
+	elif ! grep -E -q "^[a-zA-Z0-9_]+ +[0-9]+$" "${temp_out}"; then
+		echo "Comm filter output validation failed."
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
2.56.0.rc1.315.gc6ed9934b7-goog

