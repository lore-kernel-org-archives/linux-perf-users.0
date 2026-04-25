Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE937F72D
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139420; cv=none; b=QZzG4dwRzxQEBa32UuEm6k28wnppFhb3pOCPs/XBU1vyWqcK1vQIFy9PMatHOyDtlz5U3jf6MaqsqOfAmS9QTIEXy1wEsL0eyIDqMGgjbCVn5QwrU8WE1m/LClDGvwxIgz3luHCtANr+OpNM+G6EQ7nbkT/dQ8aQ41F6Jg9QyRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139420; c=relaxed/simple;
	bh=vrmI/s7KhPIklUg2QjhZARYD8GKL4cL6BYS9LwAcJ20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g8Pr99/XatOrS6W8E9Gjf70kthwaRNt7WwiOcoqXunfxqNu0NjY94FZIcW8qJP4VTkayCLofriVVot40L+1yzwehXyD4oIBQCLzxIos1zvA7EYn0HE0t0tzH+gKOXLjRuR3aQSceuAmdw0ZF+eLmSTYrH4Peu1Vnj6+UXca1Q6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFUAhccb; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFUAhccb"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so8702343eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139417; x=1777744217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1ZQn0wiqS3ZLhKCfNDpGe4fGnfL2Ccr7WxKmLqZsJ4=;
        b=DFUAhccbaDWU5jsaG7lRVVw/MfqFauB+rMf763qQFjXRNuCK7VwOkoocPXYfH2lC4L
         Zl8VfKUaaXo/bcJxRsl5kvAfNccqo1cb0Uidmrw+sawQmm6iNIkmTfrL5Y6aAng0y5BT
         UphMHuqBH/sghtNzawKwdMLqVprKX3lMQK+jddYJvaW/htXK3mr9Pa5clvPPAtoTPdKx
         V88MY1uEN3olirHwr9GEZzu9bZLslfnnkmjZQ9kEVSHccqqHTyQdW9E7qnOyu8nKq2QM
         XkEQUVknHQ9WBRfAV5mrSdnNFsj1oe1LOeB4Knfw1DOyt5Dh5MSI4Jovq5Kh1e6SXDtR
         tK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139417; x=1777744217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1ZQn0wiqS3ZLhKCfNDpGe4fGnfL2Ccr7WxKmLqZsJ4=;
        b=OICNgS4r7tJrHrlRIIOx6U1d3W58TVWDRD6BlX4VZnP3BUR+lvp/NyGw4HhLjwLgce
         7Qk4L3vw+pTeQHVw/aohUnOyyM3zaSoTL0gixoiBPUrHPSaBhKw6vk27LFHvgniWHT4E
         cLYDTOKlmdVPtX5oZGJ85KlUDsVqVvdkEnzzScElAyFkyLWKtoo+b9uqA40/CRDA9QGa
         MoYtZdiogGmCOVEsmbEzY7/V2nMPQNbFKZanUOmCcwJlEZB3LZeb7myWQ7KD2HmpCqvR
         NmIUil7ByZnCa+DfFY99y06m7OlxaSHFnlfdMLLuIhYZCSuwVfSnlXPl/2rse7cagAup
         b6kA==
X-Forwarded-Encrypted: i=1; AFNElJ9w3mrojm/L8+gZqxOSMCxk5TUWEeUAFR/y8c0jl/qeCKbGrszrQ1HU3XHktDzz7LtWX3+55RGu+I8P71Kj4qUb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7yoY9/wsUUSMnTspIOslgLEq0cfvgDeOVWsDGjktHkn1FH6Af
	Ma2yQ9tQMhTpLXG008p7u6LBcAkgmWOfl7vxD89f5sBdmzVbbGh5WZvLNCENO+0pQmy8m/u9SWY
	fUfERd55V4w==
X-Received: from dlea13-n1.prod.google.com ([2002:a05:701b:420d:10b0:12d:bf5c:266])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f99:b0:128:d219:e169
 with SMTP id a92af1059eb24-12c73f712acmr19351213c88.10.1777139417071; Sat, 25
 Apr 2026 10:50:17 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:36 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-39-irogers@google.com>
Subject: [PATCH v6 38/59] perf failed-syscalls-by-pid: Port
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
---
 tools/perf/python/failed-syscalls-by-pid.py | 119 ++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls-by-pid.py

diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/python/failed-syscalls-by-pid.py
new file mode 100755
index 000000000000..f57b13c5d34f
--- /dev/null
+++ b/tools/perf/python/failed-syscalls-by-pid.py
@@ -0,0 +1,119 @@
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
+        self.unhandled: dict[str, int] = defaultdict(int)
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
+            else:
+                self.unhandled[event_name] += 1
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

