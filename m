Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA539D6E9
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156971; cv=none; b=jiuFiCYs/U7F3LN3vXsLqCuSmvzW44g0wAquhG6hDqy81EwTmuxwEtFeFNON9c7/jxOkKPne7H7Zi6euNfLwPBLsPYsqESNx+gt4kzxJnTiKqjRYfK71XsrOW57Y52ZlM/mUuHxEDUDvN2LIbo89ucStAEzFmn4Bnos1CyfK7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156971; c=relaxed/simple;
	bh=cskMJqUjMN8z5wW286c546Yg+5Pr06NDcX4mICkIag4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jKOtmWsaCIhdGZL+xqpmVc4M09bUCVO3tabWugwUKkL4kaey9oN7fKNHVCpdhFYlph4rKWrDBPqWUO/2jLv7328orkAMY+ISzGiDP4rpKYFRRmS57kSz63HHszojsgK/cp2jXyDYco2Guxoec3Guwl8rhfMgtl/WwdoFN/t+tdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYtwzgVx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYtwzgVx"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa366fb79so8800286b3a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156969; x=1777761769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1e9d0GFF8QSKEFlq8avcbJMHsTR7P2tC3S887pI/aQ=;
        b=jYtwzgVxYCuUg4GNfRhNj+yccRmAgx55QYd2JpHSenFo5CDow3Qtjgqj+UKLi/cccM
         7pG2x7HWbaj1qZqKxhsfA5QJ/MiFhAwvorUxFqQVZayvNB1pnNDwE0x+wbEACVZbhMBs
         aCFt4NU51eoJuFzs16jtBW9jA5dDmmwnhS47D6xUKEahdWe0YARNkMUdSLJwbDXyxjB/
         1cQi3zSP6Nl4zImJqp/xqouJDAud0PsR5MPC65npt4y7RMvHXoTrNkQrPUK0UVcWdwY9
         XY/shKTStalUHDPmxxcOo6HUr3lYsPggNuBNw9fWlqpQ/B7sIezalVHKAcCPRSA7nP0C
         WXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156969; x=1777761769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1e9d0GFF8QSKEFlq8avcbJMHsTR7P2tC3S887pI/aQ=;
        b=UvHx7Dtn9qyt93/+sGIMc45jMBA3ziIkEEEjr+NHkzbBHIcnEtibyzV5ey3Pp8e5iE
         ph5cex84WQh9WVaioSmW1N4BFD7TGaCu5TCeHxhNvkXDsKxIFPhNgcOWxl8MUrKvNwHF
         IV4MAQnkmQQFggRv/mp/byg1VGck9eX/J5c/7Vjy+TyywFfZcz10PhJm5UGVq9AVTW0G
         Wmw7jnwZfdbHAAD1xOPB6BhprDWkEZbkxKYdXAca8GKKzrZh5AXcMMW4Qdt9UrIIxwk+
         F+6mlNohm6AyNvmgCLROqg6BSNzheygLAWQWynPfO3XvcpTLnG3fQts3IN3wSr930ljO
         uyxA==
X-Forwarded-Encrypted: i=1; AFNElJ/mQDcoib+3pN54FU4RAqfhjSo8iwlTa9IO7gfdeBkznXqrLkgaiBpd+NBOHOeXctl4DZBal7Z9NsMORxWgSR4R@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdBhN5pY0hEegts5H02X5AgoXjbFiDAs6J1YV4JBTO+xyEK/l
	orbnuq/qelpuDi/ngnLcJ/LZGheLgLrrCUHc5FbrKbqnS7ZgI9WI/4g9xm2FCqFkJf5ANAmGesZ
	vePSa2P+/EA==
X-Received: from pfaq12.prod.google.com ([2002:a05:6a00:a88c:b0:82a:108d:4308])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:90a7:b0:82c:9c90:54cf
 with SMTP id d2e1a72fcca58-82f8c95bec4mr37522938b3a.43.1777156968868; Sat, 25
 Apr 2026 15:42:48 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:41:03 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-39-irogers@google.com>
Subject: [PATCH v7 38/59] perf failed-syscalls-by-pid: Port
 failed-syscalls-by-pid to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ported from tools/perf/scripts/python/failed-syscalls-by-pid.py to use
the perf Python module API.

Key changes:
- Used perf.syscall_name() to resolve syscall names instead of legacy
  Util library.
- Used standard collections.defaultdict for nested statistics
  aggregation.
- Used errno.errorcode for resolving error strings.
- Supported optional filtering by COMM or PID via command line
  arguments.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Fixed Syscall Name Fallback: Handled the case where
    perf.syscall_name() returns None , falling back to the string
    representation of the syscall ID to avoid TypeError during string
    formatting.

v7:
- Removed dead code (unused self.unhandled dictionary).
---
 tools/perf/python/failed-syscalls-by-pid.py | 116 ++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls-by-pid.py

diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/python/failed-syscalls-by-pid.py
new file mode 100755
index 000000000000..eecd553cbf8f
--- /dev/null
+++ b/tools/perf/python/failed-syscalls-by-pid.py
@@ -0,0 +1,116 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Displays system-wide failed system call totals, broken down by pid.
+If a [comm] or [pid] arg is specified, only syscalls called by it are displayed.
+
+Ported from tools/perf/scripts/python/failed-syscalls-by-pid.py
+"""
+
+import argparse
+from collections import defaultdict
+import errno
+from typing import Optional
+import perf
+
+
+def strerror(nr: int) -> str:
+    """Return error string for a given errno."""
+    try:
+        return errno.errorcode[abs(nr)]
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
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process a single sample event."""
+        event_name = str(sample.evsel)
+        if "sys_exit" not in event_name:
+            return
+
+        pid = sample.sample_pid
+        if hasattr(self, 'session') and self.session:
+            comm = self.session.find_thread(pid).comm()
+        else:
+            comm = "Unknown"
+
+        if self.for_comm and comm != self.for_comm:
+            return
+        if self.for_pid and pid != self.for_pid:
+            return
+
+        ret = getattr(sample, "ret", 0)
+        if ret < 0:
+            syscall_id = getattr(sample, "id", -1)
+            if syscall_id == -1:
+                syscall_id = getattr(sample, "sys_id", -1)
+
+            if syscall_id != -1:
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
+        sorted_keys = sorted(self.syscalls.keys(), key=lambda k: (k[0], k[1], k[2]))
+        current_comm_pid = None
+        for comm, pid, syscall_id, ret in sorted_keys:
+            if current_comm_pid != (comm, pid):
+                print(f"\n{comm} [{pid}]")
+                current_comm_pid = (comm, pid)
+            try:
+                name = perf.syscall_name(syscall_id) or str(syscall_id)
+            except AttributeError:
+                name = str(syscall_id)
+            print(f"  syscall: {name:<16}")
+            err_str = strerror(ret)
+            count = self.syscalls[(comm, pid, syscall_id, ret)]
+            print(f"    err = {err_str:<20}  {count:10d}")
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(
+        description="Displays system-wide failed system call totals, broken down by pid.")
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
+    except Exception as e:
+        print(f"Error processing events: {e}")
-- 
2.54.0.545.g6539524ca2-goog

