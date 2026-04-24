Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DE3ECBCC
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049348; cv=none; b=hVsJqW/0J9wcJyifh1Ijh68jiIP/FCND+82kiPk7o/T/OMP1mYzoPsYqzzNG3//esydes6CQVixHxDs/dCPDXa6uS9n2RJrbCjafHw0+Nvslqscjix2KyLOTeXUt+62UeAO629s1KSaWZsp6Cmrg6EN3NcvycNOWjaZlt1ButlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049348; c=relaxed/simple;
	bh=MS0yvLdwksr/0p9LKlMRRGuqKVzUwHz2xDld33PavQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EZIGatDKD4apRhg2v9jnUKHpVGq7+WTBAImDXrZxBXr6mPgGBITVTqYDJxuJaaYveYNyUrZNl5Wc1N86PQEMKpVvFq4i5oBWYMY/naAHFDOEVLd/f0p5PzkdKb6YHJvrmLfTSft5f3AJbWIitQWbQpOugADXsQdZncISe2K2+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VVDwvQN/; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVDwvQN/"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c8de02a4dso9866903c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049345; x=1777654145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k73fGGVkXWNX8HDud6GwbWbiqkfMF7AuYUe+cubGpoI=;
        b=VVDwvQN/eQGZsEs4csuM7JgRDUYcEPAUccJlwDKzPuhEevTNg9FHzPjKNGB7SSNn59
         2i1gqyVgbUvOeLPrvepZyVSpcJ4smMx5c6hE3RKp6guHu9uGlUPJ6cdubh2jGuXagySB
         apymCrCd3/CZpFNTNH08Vwnh/tQOxpSqpZjnsipBgZAl3MplwGRD0j88IWXb1TMT/Hjx
         N9AqjgHzuLXa6HbGLVVU3YYGsfdjf2VkcZsDMddKMizaDjuSUmyQcUionxtTlJsUWjZ5
         V0rikSvZqDTSLE+0nnlg2nk3l3SGSxv52ul2YzbiYJzq8QYv3L68ZzTM5viCfezHK9Z+
         /taQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049345; x=1777654145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k73fGGVkXWNX8HDud6GwbWbiqkfMF7AuYUe+cubGpoI=;
        b=pCvMJ8WA4v5LLjbK166ZfXN7Ty+ZUtijoB1k8h8RHQ6GoDrR7m/oM/9n6nlQ5iPUvj
         FcJ2XaJuDQoOoa0CjTQ87eBU9JfTj6xnCK3+1J8iOxsj992IoyJK5s9g6TPBZlQz8cA8
         TUZDtK2MrznFvsLTsMcS4608AR+kiTFUUQT/MHUviO9AD9L9i6T5OiQirCNFrD+UQko0
         sNnxtDssoZP/uAJJSaG4oZDRw6MHg+JhEo16kj+eLzNsGNnRv3YW7WuVF3UYDkfMEb39
         L2Fp7rvByVWtQQHcH5EYM0uuuYi4FS2r/uDUgEiTl1VQwtEVcgMLhTJP7wwHA7YodCi2
         7mAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BufpxF8g0Hk8De1E8gNsZQxEiLiu0NdNgUba/ZT1sjTlVN5g2NkDo7mbCLpDmtWZySZHE2+q1Jtl0502ujlfY@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYJtrJ3sLZpXJWvbZFhxJFivMl8IJy74HzU7IkCclQcHNLPnF
	saPSaeCgXljWC1rkanMwSJSM1uDi/kewKhJg0YUo3sxDU2+X9EM48KZnJpbO9PgBvnN920juVQc
	Fg8JXX6GdoA==
X-Received: from dlbvg2.prod.google.com ([2002:a05:7022:7f02:b0:12a:9ef0:93ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ff45:b0:128:d2a5:709c
 with SMTP id a92af1059eb24-12c73fb3381mr19393812c88.33.1777049345271; Fri, 24
 Apr 2026 09:49:05 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:00 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-39-irogers@google.com>
Subject: [PATCH v5 38/58] perf failed-syscalls-by-pid: Port
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
index 000000000000..1a8c9bb7e90c
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
+            comm = self.session.process(pid).comm()
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

