Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0A36308E
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967287; cv=none; b=GLKLCNuTkeCs/EQBDG3ALZOpkgrzvrhqepcrh3c7mW/lbUacblfilu9p3UjfIdAZZskZ7Twn9QT77NhOPra3ZCzSmWZld79yNYwuoMoI74P7pE/FQXMLrs0ZWjtRbCXUtMSXJt//lsBQue0FU49MI98XDOPvzglI4f9XmnRnjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967287; c=relaxed/simple;
	bh=bvt1mQxJL6YqSovH332SP+uMntTfNqIxZBdgIHqWrho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihnddsATGxGzwouLN2rjEc15L/3WetAQHiu1X2DElmiFaXjciMNaC3VbkyeLmyHbDQgeRe2p81CT4gnEB3aZPiALY3OtusLHpHUfOeMBv9aOq+sFgianv1axtqBtxyBBdy21bLo+0oN2ZdkGPbryL7YWDCXiNEL/3dnOmLZE/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gR1h+eq1; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gR1h+eq1"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so9473984a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967285; x=1790572085; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kT88BpjRt2OBHWsTKrbPpUDLZzIf08eSBspPRDXJRN0=;
        b=gR1h+eq1u4EBn6tp7oTaAqW6OdHxxOmXgCk4+ab9Hz/ZFj2mmOAImtDjG7xchAk0G4
         8U+DbUU7Q5dyKVbOU8JBEYVMSnN7t89xNc1amEp5tbHteNtWQ4r0RvPzJfSbDNIm6BPw
         iwdyChGEplNkgZVx7M+ZszNUNUY80hOAb2HXlMq6MFVcMLz4bSSrdlSZuNqme/rGBjkc
         /vmePYPlZPmekkICCRge9dxYu1IYBe9eecfMHsLU67s0rz3GbAhASmKvwfQEkmK2DZlF
         g1oVeK8WeYOxKKJnDHWcOI2GuRDIywr3JmgW7FX0YrwNBOdVa0vKRdxaUBegEF5xAoue
         Sb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967285; x=1790572085;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kT88BpjRt2OBHWsTKrbPpUDLZzIf08eSBspPRDXJRN0=;
        b=g2h9YSz9KjblO6VRjYi7G28xJc6rYLMxCFimCYnSnFKsKSwknzEAFvsjG1ExTUmWa0
         C3tXVD0YwBXff/9yxBQo/5AQkwmP8qEj4gHj+TVaDYNQxWGbsth+BgS/SCrxTYPmn37R
         KbpbGOzYPPT88SL7tb6SlJjTEUuh94dsJHK//AY65lZhJS/xTqH6RoagEWhImJ8bvLf3
         Gaao5RBqSa1Jko5YMjRjlGlgu9mG4bysAxkfdSvNu2nW0iKB+uVrecoSJ2TvoFIF8Tmf
         6NJoVEdXrnI4fhwyDmPTelKMSfWBbF8TbdKC4DQ0XDa2fcHmNaBaQ2jKVTJnl2fT6Tvk
         Rm8Q==
X-Forwarded-Encrypted: i=1; AKwUvBz9Qe456IqqxKLkanpMXJTQbbuAYwroFhnTe+isfg43ajIzw9gu8wgi9S+Gq1gA9zXcshdXHfrzDAZg0VH7PtcF@vger.kernel.org
X-Gm-Message-State: AFuF++lKXGQTBFuEMW2GjwBpTp2Ml6y3XxE9d3S2G789Eee5eZ4qrvS3
	kYJlqhvb2nNMu7q6vt9sBbrDCi8Xs3Nelz8gdAXsMH0+4IjPT4JlTRDuAxn8q4ohaZL/JiHUXkl
	VgyNN1wFLuw==
X-Received: from dldyq18-n2.prod.google.com ([2002:a05:701b:4552:20b0:143:80d3:9880])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2709:b0:39e:6c69:9b8e
 with SMTP id 98e67ed59e1d1-39e6c69b257mr8474981a91.51.1789967284491; Sun, 20
 Sep 2026 22:08:04 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:42 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <72106f17ecaeaf9a5c000c284c18b58f6988a8ba.1789966896.git.irogers@google.com>
Subject: [PATCH v2 24/49] perf python: Port failed-syscalls-by-pid to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port failed-syscalls-by-pid.py to a standalone script in
tools/perf/python/ using the perf module:
- Resolve architecture-aware syscall names using
  perf.syscall_name(id, session.e_machine) instead of host python-audit
  tables, supporting cross-architecture perf.data files without external
  dependencies.
- Translate negative syscall return values into symbolic E* error names
  using errno.errorcode and architecture-specific session.e_machine
  overrides.
- Encapsulate aggregation in a SyscallAnalyzer class using
  collections.defaultdict and add argparse filtering by comm, PID, and
  -i/--input.

Add a shell test (test_failed_syscalls_by_pid_python.sh) to verify the
standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/failed-syscalls-by-pid.py   | 176 ++++++++++++++++++
 .../test_failed_syscalls_by_pid_python.sh     |  92 +++++++++
 2 files changed, 268 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls-by-pid.py
 create mode 100755 tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh

diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/python/failed-syscalls-by-pid.py
new file mode 100755
index 000000000000..30332062f89a
--- /dev/null
+++ b/tools/perf/python/failed-syscalls-by-pid.py
@@ -0,0 +1,176 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Displays system-wide failed system call totals, broken down by pid.
+If a [comm] or [pid] arg is specified, only syscalls called by it are displayed.
+
+Ported from tools/perf/scripts/python/failed-syscalls-by-pid.py
+"""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+import errno
+import os
+import sys
+from typing import Optional
+import perf
+
+
+_GENERIC_ERRNO_OVERRIDES: dict[int, str] = {
+    11: "EAGAIN", 35: "EDEADLK", 36: "ENAMETOOLONG", 37: "ENOLCK",
+    38: "ENOSYS", 39: "ENOTEMPTY", 40: "ELOOP", 42: "ENOMSG",
+    45: "EOPNOTSUPP", 60: "ENOSTR", 61: "ENODATA", 78: "EREMCHG",
+    87: "EUSERS", 89: "EDESTADDRREQ", 90: "EMSGSIZE", 110: "ETIMEDOUT",
+    111: "ECONNREFUSED", 122: "EDQUOT",
+}
+
+_ARCH_ERRNO_TABLES: dict[int, dict[int, str]] = {
+    2: {35: "EAGAIN", 36: "EINPROGRESS", 37: "EALREADY", 78: "EDEADLK", 87: "ENOMSG"},
+    8: {35: "ENOMSG", 45: "EDEADLK", 89: "ENOSYS", 90: "ELOOP", 122: "EDQUOT"},
+    15: {35: "ENOMSG", 45: "EDEADLK", 246: "EAGAIN", 251: "ENOSYS"},
+    43: {35: "EAGAIN", 36: "EINPROGRESS", 37: "EALREADY", 78: "EDEADLK", 87: "ENOMSG"},
+    0x9026: {35: "EAGAIN", 11: "EDEADLK", 60: "ETIMEDOUT", 61: "ECONNREFUSED"},
+}
+
+
+def strerror(nr: int, e_machine: int = 0) -> str:
+    """Return error string for a given errno, accounting for target e_machine."""
+    err_num = abs(nr)
+    if e_machine in _ARCH_ERRNO_TABLES:
+        if err_num in _ARCH_ERRNO_TABLES[e_machine]:
+            return _ARCH_ERRNO_TABLES[e_machine][err_num]
+    elif e_machine != 0 and err_num in _GENERIC_ERRNO_OVERRIDES:
+        return _GENERIC_ERRNO_OVERRIDES[err_num]
+    try:
+        return errno.errorcode[err_num]
+    except KeyError:
+        return f"Unknown {nr} errno"
+
+
+class SyscallAnalyzer:
+    """Analyzes failed syscalls and aggregates counts."""
+
+    def __init__(self, for_comm: Optional[str] = None, for_pid: Optional[int] = None):
+        self.for_comm = for_comm
+        self.for_pid = for_pid
+        self.session: Optional[perf.session] = None
+        self.syscalls: dict[tuple[str, int, int, int], int] = defaultdict(int)
+        machine = os.uname().machine
+        self.host_64_bit = ("64" in machine or machine in ("s390x", "alpha")
+                            or sys.maxsize > 0xffffffff)
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process raw_syscalls:sys_exit and syscalls:sys_exit events."""
+        event_name = str(sample.evsel)
+        if "raw_syscalls:sys_exit" not in event_name and "syscalls:sys_exit" not in event_name:
+            return
+
+        pid = sample.sample_tid
+        comm = "Unknown"
+        if hasattr(self, 'session') and self.session:
+            try:
+                thread = self.session.find_thread(sample.sample_pid, pid)
+                if thread:
+                    comm = thread.comm() or "Unknown"
+            except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError):
+                pass
+
+        if self.for_comm is not None and comm != self.for_comm:
+            return
+        if self.for_pid is not None and pid != self.for_pid:
+            return
+
+        ret = getattr(sample, "ret", 0)
+        is_64_bit = (getattr(self.session, "is_64_bit", self.host_64_bit)
+                     if self.session else self.host_64_bit)
+        if ret > 0:
+            if not is_64_bit and 0xfffff000 <= ret <= 0xffffffff:
+                ret -= 0x100000000
+            elif ret >= 0xfffffffffffff000:
+                ret -= 0x10000000000000000
+
+        if -4095 <= ret < 0:
+            syscall_id = getattr(sample, "__syscall_nr", -1)
+            if syscall_id < 0 or syscall_id > 0xffff:
+                syscall_id = getattr(sample, "nr", -1)
+            if syscall_id < 0 or syscall_id > 0xffff:
+                syscall_id = getattr(sample, "sys_id", -1)
+            if syscall_id < 0 or syscall_id > 0xffff:
+                syscall_id = getattr(sample, "id", -1)
+
+            if 0 <= syscall_id <= 0xffff:
+                self.syscalls[(comm, pid, syscall_id, ret)] += 1
+
+    def print_summary(self) -> None:
+        """Print aggregated statistics."""
+        if self.for_comm is not None:
+            print(f"\nsyscall errors for {self.for_comm}:\n")
+        elif self.for_pid is not None:
+            print(f"\nsyscall errors for PID {self.for_pid}:\n")
+        else:
+            print("\nsyscall errors:\n")
+
+        print(f"{'comm [pid]':<30}  {'count':>10}")
+        print(f"{'-' * 30:<30}  {'-' * 10:>10}")
+
+        sorted_keys = sorted(
+            self.syscalls.keys(),
+            key=lambda k: (k[0], k[1], k[2], -self.syscalls[k])
+        )
+        current_comm_pid = None
+        current_syscall = None
+        emach = getattr(self.session, "e_machine", 0) or 0
+        for comm, pid, syscall_id, ret in sorted_keys:
+            if current_comm_pid != (comm, pid):
+                print(f"\n{comm} [{pid}]")
+                current_comm_pid = (comm, pid)
+                current_syscall = None
+            if current_syscall != syscall_id:
+                try:
+                    if emach:
+                        name = perf.syscall_name(syscall_id, emach) or str(syscall_id)
+                    else:
+                        name = perf.syscall_name(syscall_id) or str(syscall_id)
+                except AttributeError:
+                    name = str(syscall_id)
+                print(f"  syscall: {name:<16}")
+                current_syscall = syscall_id
+            err_str = strerror(ret, emach)
+            count = self.syscalls[(comm, pid, syscall_id, ret)]
+            print(f"    err = {err_str:<20}  {count:10d}")
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(
+        description="Displays system-wide failed system call totals, "
+                    "broken down by pid.")
+    ap.add_argument("-i", "--input", default="perf.data",
+                    help="Input file name")
+    ap.add_argument("filter", nargs="?", help="COMM or PID to filter by")
+    args = ap.parse_args()
+
+    F_COMM = None
+    F_PID = None
+
+    if args.filter:
+        try:
+            F_PID = int(args.filter)
+        except ValueError:
+            F_COMM = args.filter
+
+    analyzer = SyscallAnalyzer(F_COMM, F_PID)
+
+    try:
+        print("Press control+C to stop and show the summary")
+        session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+        analyzer.session = session
+        session.process_events()
+        analyzer.print_summary()
+    except KeyboardInterrupt:
+        analyzer.print_summary()
+    except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError) as e:
+        print(f"Error processing events: {e}")
+        sys.exit(1)
+    finally:
+        analyzer.session = None
diff --git a/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh b/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
new file mode 100755
index 000000000000..d5fab922b8a9
--- /dev/null
+++ b/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
@@ -0,0 +1,92 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# failed-syscalls-by-pid python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/failed-syscalls-by-pid.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, failed-syscalls-by-pid.py not found at $script_path"
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
+	echo "Testing failed-syscalls-by-pid.py..."
+
+	# Check if syscalls:sys_exit is supported/readable
+	if ! perf record -e syscalls:sys_exit -o /dev/null -- true >/dev/null 2>&1; then
+		if ! perf record -e raw_syscalls:sys_exit -o /dev/null -- true >/dev/null 2>&1; then
+			echo "Skipping test, no syscalls:sys_exit or raw_syscalls:sys_exit event"
+			exit 2
+		else
+			EVENT="raw_syscalls:sys_exit"
+		fi
+	else
+		EVENT="syscalls:sys_exit"
+	fi
+
+	# Generate some events by running a command that should fail at least some syscall
+	# (e.g. failing stat on non-existent file).
+	# Using '|| true' because 'perf record' returns the exit code of 'ls',
+	# which fails with ENOENT
+	perf record -e "${EVENT}" -o "${temp_data}" -- ls /does_not_exist >/dev/null 2>&1 || true
+	if [ ! -s "${temp_data}" ]; then
+		echo "Skipping test, perf record failed to create data"
+		exit 2
+	fi
+
+	# Run the script and check output
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+		echo "failed-syscalls-by-pid test failed."
+		err=1
+	elif ! "$PYTHON" "$script_path" -i "${temp_data}" "ls" >/dev/null; then
+		echo "failed-syscalls-by-pid comm filter test failed."
+		err=1
+	elif ! "$PYTHON" "$script_path" -i "${temp_data}" "$$" >/dev/null; then
+		echo "failed-syscalls-by-pid PID filter test failed."
+		err=1
+	else
+		if ! grep -n -q "err = ENOENT" "${temp_out}"; then
+			echo "Failed to find expected failed syscalls"
+			cat "${temp_out}"
+			err=1
+		else
+			echo "failed-syscalls-by-pid test passed."
+		fi
+	fi
+	rm -f "${temp_out}"
+}
+
+test_file_mode
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

