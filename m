Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2793938E5E9
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157496; cv=none; b=rBhTy0qKgzPUcGOuoSzPBclTSvpGz/nSN+tkT1x9n5xwiWQcCj5eRc/IlxfPcJYuf+tBDUZln3VlyAtATjnl0BHC+4xZZ/wa3tENtOcKtOvbk49ddM4HQM0QqonQdFFgfH0ifUGe+kyaqU06ZkKE4bDwJiBJy1VeSK2N0c5Xako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157496; c=relaxed/simple;
	bh=cskMJqUjMN8z5wW286c546Yg+5Pr06NDcX4mICkIag4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SMiBo8EHTWGmbJ67u+19gFqbNDjVO9RUIaG4znW1VU8rytMVQYmQzGN1Ka/aDR8/UPS1SPZ0yNgLmbme1OERVomJhKHYdeaLlYf5yT7X5WCFXZi6UWTycVIjoKJCqznx8AHOX67mYzy29TpId2r657Yo/HQEbAsFCaKi1IGgFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lh+cZ3q0; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lh+cZ3q0"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2de07c12745so25490300eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157492; x=1777762292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1e9d0GFF8QSKEFlq8avcbJMHsTR7P2tC3S887pI/aQ=;
        b=Lh+cZ3q0nrVMYZA2yeVxhhzeA/3FQdNgZJs1aOV8RWSbKYoIQm7fuYcDiCSp2tLznJ
         G8U8b0elILOAWIGfPBDYpEXGc+Kd1ft6nZ37nd43n7pdV5Wy2zXD3YbNGCXEpqIGcNar
         E3yWmQxk2wOCr+Wv/E5VdzfyY8nw8JxOffhATG2CH2Zv6GcpYTH1VaZfsqzckk+20xTd
         qDprlrxaBgeRAcoHR85tAGYJwbjCEF85a0idhMuavAaQpPD3Or+eDHuWVIyLzEX5HW/r
         3+ALoNKWcn19WL8Gs7lMtMrDMntOqkO3ExsjtdxI0fxEqz9jxWXITd+u6IuiVqCbhLjl
         CNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157492; x=1777762292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1e9d0GFF8QSKEFlq8avcbJMHsTR7P2tC3S887pI/aQ=;
        b=lsx56w26JZf4Et6pulvOcMwYyqLJvvxMEnyusOAy8wvOtBZ+8oYa8SaXlW5ZyX9Bnf
         /TVt39+Bv2/YVYTF6+Pd2GTTLMtd3nN9Ha3Pg2i14Ahfg3UTH8frrMvgA/RFh6orxHu7
         cyW081iWPRdHbgOSUi+Y4LPgNIG5AxYAotdbffvtVP9I32dS+VtBIXlVKp3fl57CqeTQ
         6QIbtnb6ybxqfIIeG6NeT+kYyfYQ9a7j5Mf2fDuw8FzwRVWEgfalg2QXtAgpGOeDoNyK
         cdGzrNc31LqzQkgJFv/1ZLaYth9bSvY75ivzFfwSyoseLTY7V93FqTmeZ4DGa3UGtfs7
         /qiw==
X-Forwarded-Encrypted: i=1; AFNElJ99HEmg1qY2J1tkhRMcPiuMabP1GuranUbr5PnEuIXtXdzOO9dVDGcWvFa3mV5VPBEb+IBwegveAhebuChpYWm0@vger.kernel.org
X-Gm-Message-State: AOJu0YwyiS4ceNCrXTbCv+JYfyPMhCdM4+XOK6fBHg1Q1RR5hSredHH8
	NHpI/JlCehWmiSOOt9LMvr7E0rkBsEZH85Y0dpU/4bvGR43DydMRA5tVFvLTWDLBjOTJbmElj7F
	qVUs4BNXusw==
X-Received: from dlbpv4.prod.google.com ([2002:a05:7023:904:b0:12d:b3cc:a807])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ead1:b0:128:c9fa:4c32
 with SMTP id a92af1059eb24-12c73fa7c10mr21126322c88.28.1777157492022; Sat, 25
 Apr 2026 15:51:32 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:30 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-39-irogers@google.com>
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

