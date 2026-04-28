Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193A3F1656
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360838; cv=none; b=tXjiNewATettrxgG/FJpoZr5dMj2qRtkRG49iaYTV3Sj4++WC8su+GDAyWndcKshImZA8s0pdAydZU1cmvGm3+yottBdywT2q1Jes9TByy0qFbQQaTWUwSi99R6afq1FHHC/SBxcPVXZrDKfsmGi9gZ6FuhETLmdJ+uu3ZY2lVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360838; c=relaxed/simple;
	bh=cskMJqUjMN8z5wW286c546Yg+5Pr06NDcX4mICkIag4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E6zWlXPXXkQltuhK+6Q0IGxFRGYbetvPy2P4HmO1h25u8OktPpspo+mXWox7+YbYQBk1W7tlF0y64tMPFbB4R3twfe3RZfxRKtzIGsmmxZiNDV8sm8+yw9dWK4fB770hWHlVCb5odIuDVPOsPivx/RIVH6SaJhXlwdFiuVbQU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UWu1+9CK; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWu1+9CK"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso14401463eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360836; x=1777965636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1e9d0GFF8QSKEFlq8avcbJMHsTR7P2tC3S887pI/aQ=;
        b=UWu1+9CKN+1sEcCgIlu4dtY15QOUkcZgGMC+TCZ4bN6Ca0/J7cqIrkVfCSYhSbaZxC
         zh+kAfWhB+837jWcfHT+Wzzf2yQlPPBpP+VSLHgEueRpbXWIuuF7+u77CGD6Zl2YjCMB
         qoanThxyh8izIDgJLlxIBjTLfnqXqol/EL6Sw/1FHPp6xiuu8J4xrY86Gao5JqrpfDMf
         1VhZQAAHHyZjEMjOpkrHn+yk/6doJ0qXDNXJdSj8PUi2tDWFAlcH20Vsp1wQ8F6thvKy
         dtOWqPTyXBTmV3NyyMgHFOR/Jfzu3ZHir6tzawjdZXh6hf4mZMdSfI8RA/zHUy3NxMZT
         zP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360836; x=1777965636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1e9d0GFF8QSKEFlq8avcbJMHsTR7P2tC3S887pI/aQ=;
        b=eLqXLarQubt2Bvx/EwLAZmA5rzx9ho2WoRW+vrzcy5gaR/TeVRLF7WTne9GySPHoBq
         fxbWBROLJjYcTrBfHSa+MY1Bvt0qzzKHKDt4MLZd3jceNj5P83l1hTZr7XVPflL1eEr/
         GXSGo/C4d1gKJyjJCBFv8HoDqWvYurl1pmCetQUmBMEdnb5jMLiBPma5+po9Poatxx7u
         vFlN9jKScb8IVpqutjKwAw7dBMK2unMGQKIc9jQbphPtKqoeE5WGTA1aoJa2vCFBsln7
         1+YXQ1HEcbpqu63j20gtJDWicOVuMEmaMX8IfOMCI8k2QMNFxCZ9EKT9gYSK5iwcixcR
         D8QA==
X-Forwarded-Encrypted: i=1; AFNElJ8u4buSAVFDyO1/dSlY0re+6c7UdMVD8U/M92AUw00oZ+IVmX1U+ORQcicxlhfmi9zYER0CVOTntNf2LYc9UKzs@vger.kernel.org
X-Gm-Message-State: AOJu0YyhylMkmyZa21BLs6IsIuz4X1tHOO2bX1a7beMBmZgsgDslZwZE
	teknlgYO/1jkejEvN6IODoHTZi7uQyKpMlEPtrVT3mEoxzV7ontOpW67PniFxEDoyLhM0vdxznO
	wUGMjFj0gHQ==
X-Received: from dlaf13.prod.google.com ([2002:a05:701b:240d:b0:12d:b8e9:7851])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:927:b0:12d:de3e:86b4
 with SMTP id a92af1059eb24-12dde3e8939mr426608c88.36.1777360835574; Tue, 28
 Apr 2026 00:20:35 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:43 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-39-irogers@google.com>
Subject: [PATCH v8 38/58] perf failed-syscalls-by-pid: Port
 failed-syscalls-by-pid to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

