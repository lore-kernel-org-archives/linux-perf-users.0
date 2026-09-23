Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49653A885
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187254; cv=none; b=TCBRtF3XeV6VzvN6F3eCFypksD+Pyw7w1YRoZdjEV/qpQy/unNAYZ5XYK993RMSEx75Z5vU9WgBb0ErQYiecQJLoSo0YtkgNtm69HOQJ0L9wOfl/QtX+TsehbxImZq/1uoPnt57wzloAjc/1s4BU1So/Dzwa+E4Iz1Qt7/Dhkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187254; c=relaxed/simple;
	bh=KLjM+N6MPRxOJOoy9Z9V0g2UBOOWYvycyoZyhHsIAtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tYcQmFTmB3Fm1KSgauyTQ4O0pCdwFDQCl0GJRRMtcn+Z6jLQ915S/XiK+HyTZ4gFBZxG3JG5S1YJzBT4CnTAflfCCp8h69XMsJgrkllyvx49c2+Gry+BCdv84MEAKlllHbCwW7F5p7NFr9+I2HkJpgv4sC7hyWRvP0GemS1nFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvfOA/vB; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvfOA/vB"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-32b8c2b30c4so1798335eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187241; x=1790792041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPSJbGLVY/Zp7RjcfhA2dByfGTd2Q+F0hv6EA1bOUyA=;
        b=bvfOA/vBJt/Iobkdj5wORMky+j+YxBt3caNmdCZa7mEBKEkAOaU78bTza3y4BX/vPd
         uzgXRHgpcNEoLoAH1SLunNyfX2zT/zHVAzLKCcU3d2dGn/vd2Q9F5dv2gHsuSeAH4RPY
         IDE20OZKX+xji3UTXpTnw7IHHJ03jiJtQ6raq36KAjEND/NOYAcKWwqt1q9s1/1BfFfC
         RaFA2YlspZf2SFyw4+jxcY6XMOKSy1iqromHKU5saWH9Cc/RNbfSTSH8LKPxBNElJi9T
         Qs9nIHmqtaNazgUzgje48IXeT2c++zxCpFgpbsaYyRLIJavhTcg6/nHp+ZCnfHdfZvuq
         FadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187241; x=1790792041;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gPSJbGLVY/Zp7RjcfhA2dByfGTd2Q+F0hv6EA1bOUyA=;
        b=su3mqFGHaZXoJjjOpB45KRgg5YSoikEEUnS2sfdm9sphe0pPYsmElA/5CHSsxIs4ip
         XIvspQumXepV2IG6lko/6tMpqhb1N9pyKGlV4ilQkUmUdKdV7QjssfmdTXdos0W5EiKZ
         bISJYSHsKQCjKby3r6X+bLcMjnx13IQACc5Pse9ouyxc4oVzAEFO3fuYtC6YSrvfvtAS
         1KJp8Gj49vr9RrRRz+9CJIuiHViWK9g/CK29IqR7cQJWdObIGMXbkAo5b0Atro/ghUme
         PXuiLCOTME0DZPQrfiMShcdXkRqrte0xy734kPRFWXr2x3+xhENbM95pszBE3oDZXTWy
         3wgQ==
X-Forwarded-Encrypted: i=1; AKwUvBz91o8nL986RWfe5Valen/YY5p2QQ05JeVChycJhrBFVtXauZSVoEXPRY34pMKsiHYgwqPzCQjZH5usDizDelLk@vger.kernel.org
X-Gm-Message-State: AFuF++kf9Aj6a4osdZZqfdtd9TOO9vh/0WUIgi/nK82FmDA8hdNKHvT7
	kMI0jbpxAzunlWZ1kx8euLhhv3QWwXylVR/9VIxOYKyWgESTcgzimpvra1y6ztR64Hlgt/gsc5G
	eCI3+yI36RQ==
X-Received: from dlbps14.prod.google.com ([2002:a05:7023:88e:b0:144:db24:c0ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:a47:20b0:143:2979:c87e
 with SMTP id a92af1059eb24-144f91dd4cemr2995725c88.33.1790187241054; Wed, 23
 Sep 2026 11:14:01 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:47 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-25-irogers@google.com>
Subject: [PATCH v3 24/49] perf python: Port failed-syscalls-by-pid to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port failed-syscalls-by-pid.py to a standalone script in
tools/perf/python/ using the perf module:
- Resolve architecture-aware syscall names using
  perf.syscall_name(id, session.e_machine) instead of host python-audit
  tables, supporting cross-architecture perf.data files without external
  dependencies.
- Translate negative syscall return values into symbolic E* error names
  using perf.arch_strerrno(ret, session.e_machine), leveraging the
  auto-generated trace beauty architecture errno tables.
- Encapsulate aggregation in a SyscallAnalyzer class using
  collections.defaultdict and add argparse filtering by comm, PID, and
  -i/--input.

Add a shell test (test_failed_syscalls_by_pid_python.sh) to verify the
standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/failed-syscalls-by-pid.py   | 161 ++++++++++++++++++
 .../test_failed_syscalls_by_pid_python.sh     |  95 +++++++++++
 2 files changed, 256 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls-by-pid.py
 create mode 100755 tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh

diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/python/failed-syscalls-by-pid.py
new file mode 100755
index 000000000000..51824a929ea4
--- /dev/null
+++ b/tools/perf/python/failed-syscalls-by-pid.py
@@ -0,0 +1,161 @@
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
+import os
+import sys
+from typing import Optional
+import perf
+
+
+def strerror(nr: int, e_machine: Optional[int] = None) -> str:
+    """Return error string for a given errno, accounting for target e_machine."""
+    return perf.arch_strerrno(nr, e_machine) or f"Unknown {nr} errno"
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
+        # Tracepoint fields may be exposed as unsigned 32-bit or 64-bit integers.
+        # Guard the 32-bit 0xfffff000..0xffffffff conversion with 'not is_64_bit' so valid
+        # 64-bit user-space addresses in that range (e.g. mmap/brk) are not misclassified.
+        if ret > 0:
+            if not is_64_bit and 0xfffff000 <= ret <= 0xffffffff:
+                ret -= 0x100000000
+            elif ret >= 0xfffffffffffff000:
+                ret -= 0x10000000000000000
+
+        # Linux kernel syscalls only return error codes in the [-4095, -1] (-MAX_ERRNO)
+        # range; other negative signed values are valid unsigned user-space pointers.
+        if -4095 <= ret < 0:
+            syscall_id = getattr(sample, "__syscall_nr", -1)
+            if not (0 <= (syscall_id & ~0x40000000) <= 0xffff):
+                syscall_id = getattr(sample, "nr", -1)
+            if not (0 <= (syscall_id & ~0x40000000) <= 0xffff):
+                syscall_id = getattr(sample, "sys_id", -1)
+            if not (0 <= (syscall_id & ~0x40000000) <= 0xffff):
+                syscall_id = getattr(sample, "id", -1)
+
+            # Mask out the x86_64 x32 ABI bit (__X32_SYSCALL_BIT = 0x40000000).
+            raw_sc_id = syscall_id & ~0x40000000
+            if 0 <= raw_sc_id <= 0xffff:
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
+                raw_sc_id = syscall_id & ~0x40000000
+                try:
+                    if emach:
+                        name = perf.syscall_name(raw_sc_id, emach) or str(syscall_id)
+                    else:
+                        name = perf.syscall_name(raw_sc_id) or str(syscall_id)
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
+    session = None
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
+        # Break reference cycles between perf.session and analyzer.process_event
+        # because perf.session is a C extension type without cyclic GC (tp_traverse).
+        analyzer.session = None
+        session = None
diff --git a/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh b/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
new file mode 100755
index 000000000000..5bbd1a0adb1e
--- /dev/null
+++ b/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
@@ -0,0 +1,95 @@
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
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, failed-syscalls-by-pid.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_dir=$(mktemp -d /tmp/perf-failed-syscalls-by-pid-XXXXXX)
+temp_data="${temp_dir}/perf.data"
+temp_out="${temp_dir}/perf.out"
+
+cleanup() {
+	rm -rf "${temp_dir}"
+}
+
+trap 'cleanup' EXIT TERM INT
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
+	elif ! grep -n -q "err = ENOENT" "${temp_out}"; then
+		echo "Failed to find expected failed syscalls"
+		cat "${temp_out}"
+		err=1
+	elif ! "$PYTHON" "$script_path" -i "${temp_data}" "ls" > "${temp_out}.comm" || \
+	     ! grep -q "err = ENOENT" "${temp_out}.comm"; then
+		echo "failed-syscalls-by-pid comm filter test failed."
+		cat "${temp_out}.comm"
+		err=1
+	else
+		ls_pid=$(sed -n 's/^ls \[\([0-9][0-9]*\)\].*/\1/p' "${temp_out}.comm" | head -n 1)
+		if [ -z "${ls_pid}" ] || \
+		   ! "$PYTHON" "$script_path" -i "${temp_data}" "${ls_pid}" > "${temp_out}.pid" || \
+		   ! grep -q "err = ENOENT" "${temp_out}.pid"; then
+			echo "failed-syscalls-by-pid PID filter test failed."
+			cat "${temp_out}.pid" 2>/dev/null || true
+			err=1
+		else
+			echo "failed-syscalls-by-pid test passed."
+		fi
+	fi
+	rm -f "${temp_out}" "${temp_out}.comm" "${temp_out}.pid"
+}
+
+test_file_mode
+
+exit $err
-- 
2.56.0.rc1.310.g51773c2048-goog

