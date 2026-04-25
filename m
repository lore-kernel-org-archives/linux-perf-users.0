Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CE3A3E7A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157474; cv=none; b=SIPkNa4faYqxrloLPWFp+Q38WQ3Xssxdu60T6ledLBhzOeVRiu+2OS68Z+wuJ3vRW1liCO9Hwej1wyLR54xnok4Rg9ESifyUcZR8sqgH4GsP+AjF0aeP3F1UA8xA5Y5tKLHbBI1FiUpG3oGKo2wHql/Pn6W4Rv6UlEu2EDXsHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157474; c=relaxed/simple;
	bh=tx0Y+ZL/2KY67zQgnrtOWDh6Wuqzo7a1zM65iqPR+1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=myTixri+k9tCHBjOyNw4RNFTKOwqIt4C7PV/N1mVoMlKPx15ehx3oOPO7jSsa/ms76nZpCxNpL4Ac2TKbZqR2wXN1F1fzhl4In+dqCo/6ApZiGHuDhrq2pkTRRO1dpvF4WOsQZRZX9PIBvQYmiOxT7ui/ZKMZCzvAJ4EkdFFirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ET6ZpZ04; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ET6ZpZ04"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so10459537eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157471; x=1777762271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FIUPQnj9Sm31hxCjwi2GzFaWFVwRkKGchfSFKojE+/g=;
        b=ET6ZpZ04ISwQpemA8jXF8ad5D8atVAphHh4aHE7nvBcpH6FUFnjh2wz+QiYIWqoPsg
         HKWAeWoIY75jMwWdK7l/bQe/K5uKethZeWoyAbVyNFp0wHmIHVCi6lCO9/XNjIONQnBT
         xGo0kePPVFuTuPxgX1WI3KsIP7akcOaZ/gp6SaCNvNgYULcS7/Ot6Sy8f6KmegWe4wFE
         9RAU3s7dfCOLHDfLOiP16HDCCaD+GEkxOez8LmSoOkrW0hQnmXhZWfHObomLEk/QOTWb
         +Ye/iVyaPN48g2xj20fFn5JDfJ7gqc6wqP/guOUqK8HCdXnm53azpHeh3I5xTjM7ScNn
         BIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157471; x=1777762271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIUPQnj9Sm31hxCjwi2GzFaWFVwRkKGchfSFKojE+/g=;
        b=tC/Tx2VrxM2YS/Jv17PuJ7fLlOUt+6ymB+8kYlgWnnyg2tytesRVgrPnys3hOo552h
         LRExD1BLyyvVgTZYYsBUixWWzsXBVw68855fTpr61NbPxHVnpHjs0SIaDYJ3hef2+lsa
         naGg24fMtap6vbAUKaI6Rw11EIQva4WTQnVyg+N4JzhWbKIAxQoBi2taYLB0WTLvEHCW
         gtRv56sPpA+zAt0yrBK2rpodx4RlGklZ7ZjVph/HBWt1KMri0vZwjuNFdQSSJxhSoTNV
         hqNXHo2npTSBkdyXw1VUX4GJhEFkh1kEZDHOim2sivPpy+VpzQTYx4HAsym8AoOD3HzJ
         YKOA==
X-Forwarded-Encrypted: i=1; AFNElJ/eLmhfm+SooCoT309gdlGg6D12jrJc5T6murcTXSEb1KBXCtOZ/RRxUjb2Jce8iqfmAgYZmGA8cz8YOybb+6Tz@vger.kernel.org
X-Gm-Message-State: AOJu0YydMEVFqjxVrozhQtiLRTWremPtMbHFhLYfSUqyP0VEWPXXc6uY
	lj8dGus241ePFSsQDsAx6yc2NItk0A9AsvAyyRoL1/Ojo8d30m1tHWRB6PjZW+9m7JXMBSCZNSG
	D3yvRBlG+Ow==
X-Received: from dlbto5.prod.google.com ([2002:a05:7022:3b05:b0:12c:1f83:7b4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eac8:b0:128:d375:f1cc
 with SMTP id a92af1059eb24-12c73f759e5mr20700173c88.12.1777157471136; Sat, 25
 Apr 2026 15:51:11 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:20 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-29-irogers@google.com>
Subject: [PATCH v7 28/59] perf syscall-counts-by-pid: Port syscall-counts-by-pid
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

