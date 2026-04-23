Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C11346E50
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776973475; cv=none; b=smQm3cDWwm+ZuPoDzF7vropOFlcivSngeF8/sLzoxsAse2vgJoxF5LZxRUdazRWNTIIV1o7PC6mfuQNluLWyjv858KYHDxJj3lodHNIhPXKW21bK9h4iRQPRm2tycGVO0a9VlnRzFeTPwfuvvvlR9Izu1mw4eak74aGw95iSPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776973475; c=relaxed/simple;
	bh=hRYdsGq1DPzw9AKaXyVeVKZ33G9R2FbH1Ha6Xy7mqH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tm5mFTWf27vzqaKo+QLcRmT8dkEqc24BYGcYUBnVueSjtsBAMR0jZGJlRpSa1mbqUazp3lDRI4hoUeG5akPOJNz+dyiGtR/G8H+Sjo2WSYylIvbwhzY07+pt0hSPcXx5QnoaWL2/vabkcIL1oyolH8/SK29JCjuBYXvq/HLJhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjL5BDTn; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjL5BDTn"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8de02a4dso4342624c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776973472; x=1777578272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jh1fu2b+Mu/f91JhQcIvoSz3dYZEeq4RNZS+9V85IHQ=;
        b=wjL5BDTnx3FRXNuCdczAFDGVVcSS5BF+JVZYPy0e/hdezsCi4zxxYZ8sVLSl2szRz/
         orI7f7VocKp643ij85/ap97sBa7SC3mIOZFbaADYj47KpukDtCUjsreS2VET1PWSwqfL
         SP7+t+lK9ebtvh6WEvCtT2TzB6lJ2qFInoz2xL5Wvao//eB17Q+SjqWoCc2urUc3hnuk
         CHs596f4GrFyHubu9uUWD4jSk5Tp6ITPSkJQ1xyzZDu86hQJzF8YwLPaeJbT13p/RPjQ
         xs5PDrxWSYpq50FPUZsIWUlDZSUFZ2eFTRP4rQEhO2leg1lgxqbJTD1uyBz6tzSD5Uz6
         tdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776973472; x=1777578272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jh1fu2b+Mu/f91JhQcIvoSz3dYZEeq4RNZS+9V85IHQ=;
        b=O1Rx5EuVWzm1hSfPGpDxwx28US91DxxR4TUklbErKpnbbndpTnJcqlQ05BtTrFObp8
         WRecK1MBXvt+huAnGIK0MxRByDQMcI/A/aIwNezCFoXVbsJFr9VEYqBvtsa7aYeZ1YhX
         1mW9BsiIHixU0QdbPkD45+3OW21nQBZZ7KIHav2TtJivG9Z2Y+n1dJRSWPdURnfJm0el
         tkkIVXg+PehaAwIhh9q7qFDJ2JO0P1ro3LC0G6P42rIrfrVL+4S2nDHXwJOqxkxLvAiH
         kMX3yuL3OOq60JNHxqZMxunkirlUSjIGNBIjGVh6E425xn1XAqTiAnB0yyt4eFrLFrjp
         BNXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8w6GV9sgSkM5PpresGAvN9kYVJBnOEUGs3YaCixe7xyX2c9d7fT4IzKfGJme5Yl0ZTN9B2gVtG0vsXWMJA3G6J@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iCnLXD5nGdHOW0GpUJiebP1aNxuyjQeVzf6axEVZzhv8YScs
	sQ4kML4dMh3sLBGrTac3QQmm5r1nv43ClnTn5jc+WiqI7VUwFCV9yTl6TC8S8/of0JlvIcgc7qx
	D+eY8fWn3yQ==
X-Received: from dlber13.prod.google.com ([2002:a05:7022:264d:b0:12c:1286:e1ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f016:b0:12c:44a5:fb54
 with SMTP id a92af1059eb24-12c73f66c7fmr14080662c88.7.1776973471658; Thu, 23
 Apr 2026 12:44:31 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:43:57 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423194428.1846255-1-irogers@google.com>
Subject: [PATCH v4 28/58] perf syscall-counts-by-pid: Port syscall-counts-by-pid
 to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rewrite tools/perf/scripts/python/syscall-counts-by-pid.py to use the
python module and various style changes. By avoiding the overheads in
the `perf script` execution the performance improves by more than 3.8x
as shown in the following (with PYTHON_PATH and PERF_EXEC_PATH set as
necessary):

```
$ perf record -e raw_syscalls:sys_enter -a sleep 1
...
$ time perf script tools/perf/scripts/python/syscall-counts-by-pid.py perf
Install the python-audit package to get syscall names.
For example:
  # apt-get install python3-audit (Ubuntu)
  # yum install python3-audit (Fedora)
  etc.

Press control+C to stop and show the summary
Warning:
1 out of order events recorded.

syscall events for perf:

comm [pid]/syscalls                            count
 ---------------------------------------  ----------

perf [3886080]
  1                                           538989
  16                                              32
  203                                             17
  3                                                2
  257                                              1
  204                                              1
  15                                               1
  0                                                1

perf [3886082]
  7                                                1

real    0m3.852s
user    0m3.512s
sys     0m0.336s
$ time python3 tools/perf/python/syscall-counts-by-pid.py perf
Warning:
1 out of order events recorded.

syscall events for perf:

comm [pid]/syscalls                           count
 --------------------------------------- -----------

perf [3886080]
  write                                      538989
  ioctl                                          32
  sched_setaffinity                              17
  close                                           2
  openat                                          1
  sched_getaffinity                               1
  rt_sigreturn                                    1
  read                                            1

perf [3886082]
  poll                                            1

real    0m1.011s
user    0m0.963s
sys     0m0.048s
```

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Removed Unused Variable: Removed id_keys which was assigned but
   never read.

2. Fallback for Unknown Syscalls: If perf.syscall_name() returns None
   for an unmapped ID, it now falls back to the numeric ID string to
   prevent TypeError crashes during string formatting.

3. Fallback for Syscall Number Attribute: It now checks for
   __syscall_nr first, and if missing, falls back to checking for nr .

4. Robust Process Resolution: Added a try-except block around
   session.process(sample.pid).comm() to handle untracked PIDs
   gracefully instead of crashing on a TypeError .

5. Restored PID Filtering: The script now attempts to parse the
   positional argument as an integer to filter by Process ID. If that
   fails, it treats it as a command name (COMM) string to filter by,
   restoring behavior from the original legacy script.

6. Support for Custom Input Files: Added a -i / --input command-line
   argument to support arbitrarily named trace files, removing the
   hardcoded "perf.data" restriction.
---
 tools/perf/python/syscall-counts-by-pid.py | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts-by-pid.py

diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/python/syscall-counts-by-pid.py
new file mode 100755
index 000000000000..45a98e6e8e01
--- /dev/null
+++ b/tools/perf/python/syscall-counts-by-pid.py
@@ -0,0 +1,88 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Displays system-wide system call totals, broken down by syscall.
+If a [comm] arg is specified, only syscalls called by [comm] are displayed.
+"""
+
+import argparse
+from collections import defaultdict
+import perf
+
+syscalls: dict[tuple[str, int, int], int] = defaultdict(int)
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
+    sorted_keys = sorted(syscalls.keys(), key=lambda k: (k[0], k[1], k[2]))
+    current_comm_pid = None
+    for comm, pid, sc_id in sorted_keys:
+        if current_comm_pid != (comm, pid):
+            print(f"\n{comm} [{pid}]")
+            current_comm_pid = (comm, pid)
+        name = perf.syscall_name(sc_id) or str(sc_id)
+        print(f"  {name:<38} {syscalls[(comm, pid, sc_id)]:>10}")
+
+
+def process_event(sample):
+    """Process a single sample event."""
+    event_name = str(sample.evsel)
+    if event_name == "evsel(raw_syscalls:sys_enter)":
+        sc_id = getattr(sample, "id", -1)
+    elif event_name.startswith("evsel(syscalls:sys_enter_"):
+        sc_id = getattr(sample, "__syscall_nr", None)
+        if sc_id is None:
+            sc_id = getattr(sample, "nr", -1)
+    else:
+        return
+
+    if sc_id == -1:
+        return
+
+    pid = sample.sample_pid
+
+    if for_pid and pid != for_pid:
+        return
+
+    comm = "unknown"
+    try:
+        if session:
+            proc = session.process(pid)
+            if proc:
+                comm = proc.comm()
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
-- 
2.54.0.rc2.533.g4f5dca5207-goog

