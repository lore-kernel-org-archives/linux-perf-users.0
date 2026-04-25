Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD737BE89
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139399; cv=none; b=es+FdNvd7YpIHDpeDRV818GsoJZRaD7XqpxxaFMHy+ldqqEJjYk1Iyfj2jclWWvid+a4K6AwKwSoG9kCRLdiqIXsd3i5C4bwy/9Mv/N0RBAztoVK9vde5rvoL/EbIt82v5lwpwFFTpvLCsbwKIQjhXtMl9azbriEz4qCIBx8E5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139399; c=relaxed/simple;
	bh=tx0Y+ZL/2KY67zQgnrtOWDh6Wuqzo7a1zM65iqPR+1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M5jJ0gH63yJvBjYF2LPvaJ22sNURvC/YW/54xbZllKTA0WJhxbwHYapWQmdWaOw3NiFY/vaefH+Cpu15vmMuBYjQDTwH7rAy1wqPSLfJvj/ZxtNuZsNWWfL3iOdnV7a9RZMA/3FrW9Mt6sjUHp1iDyVlVum06/KiwyHK3Vax2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q25EpgXK; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q25EpgXK"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12db218e265so14120336c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139397; x=1777744197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FIUPQnj9Sm31hxCjwi2GzFaWFVwRkKGchfSFKojE+/g=;
        b=Q25EpgXKWdjEfv4GqFpH6XSiLvZ0+WZb0HbAB4QVMgMC0eOC1/D75udVAvPJaARgau
         s1+S9T40ootdZpaqGLDcmk+b8NvNttCy14DhKd1s6mZDudVxmnrU981R9I99AXXmAxn2
         gVm88nJhXD8d6u0vhGjCET17dY42/mtZx4ZNRYp+o3g1k1tqIfBVb9nbYni5Gp9hw/fO
         wIAb+3Ye6Ognv1jEeE3IurX7fdcNM0C+ez7gTzvvZGv5ADFb94R59skzEAOdL9oa8hyF
         UzdI8UY/IIWueMv+d7n43vVGnaFPt4+iqRKj/rKTQY55ah2Lf6Ti9Fmz4v4epP4iFanv
         413A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139397; x=1777744197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIUPQnj9Sm31hxCjwi2GzFaWFVwRkKGchfSFKojE+/g=;
        b=Diz43gQbbxbWcSsKlOA/i3hewNBYbrmC1Onxf7jCRekXWUZ1EuwuxpVzyAZSAKVzM9
         yeiaOHLRJCC1d8Ld6wh1cc8aajnNMOT1Y/+dgEB3H6CeIHTHh8SRteLUYV7miB/IC2EU
         /NThjvSx5IYM710INamgXPmedKuwY85oeT6tEqN9xuQx9d4c/t2J/8reCQxj7fAEUpVF
         C8bLgeebM1Je/+99z7RAzUxMtJbjOVqeUs4bMiC8xBs2pcgFUeF8eQKQSksw7tlETh3F
         UAsu+YDdeILJ/bT8Sha+YCuas9faT81NWN1Up4gz/bAJ+S9VY5shWyqvg0HALj4EDlb/
         Gisw==
X-Forwarded-Encrypted: i=1; AFNElJ+eHnnGadJvWZTfG4iqD4IDol/uAfLXodfCtbV7QCHjccXl2O3KjtKrirdImtaad9Kf0xshEi+LdtxkwpMmLN1E@vger.kernel.org
X-Gm-Message-State: AOJu0YzggMLtQul13dBr+OR8OlWzWJSZviov2xVZ0k2F1U8sFILJfUSA
	NKlBkmr73JV+nKl1BQHvb/GbFJ/m8qsB6BqTcJw+MjvY/VZg/OCP11SQWK3OZ9zbhf6g/pl6dRs
	Dgv+V5DVInQ==
X-Received: from dlbpt10.prod.google.com ([2002:a05:7022:e80a:b0:12d:b1c5:1596])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2512:b0:12d:c039:65d1
 with SMTP id a92af1059eb24-12dc03968d7mr4725972c88.1.1777139396731; Sat, 25
 Apr 2026 10:49:56 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:26 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-29-irogers@google.com>
Subject: [PATCH v6 28/59] perf syscall-counts-by-pid: Port syscall-counts-by-pid
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
index 000000000000..ff962334a143
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
+            proc = session.find_thread(pid)
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
2.54.0.545.g6539524ca2-goog

