Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBD33A6E9
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049328; cv=none; b=uvCXnOZ8dksk9Tpx8w0IoHRMxmcMkw6DkNwdPnCnHB6GH9xvFssmE2fi1VCRgXXW0Y2LJcIqV9Tbwo5ruL9ka4h+AOeZj4BUYFXmUWSEHebAFm4yWQN1AgEkCryjQWds+34r3RaFXimSAgagP+eF54WmnOUFDaUQfhJtp5QlpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049328; c=relaxed/simple;
	bh=a3KBuFmfoUSXDWkH9VZj5u31fDPvo5sY3043XKlc2po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bd9Je6A3k42T2ptijEICZ9ca3R4XVhYoA0613dMdWlQ929JbGvHgw5qxyFGmlZmaMg9MF5p902FA/LrVrjeSMyrXa6oGQtLgKZ8EHVNGxaw6LG5EW9Pk4W8tcAaHkRyw2/WVkg0xS9PPHQb7uAqTxmC+FkXauEX+/vd/0gU0TSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0z6GwU+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0z6GwU+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so11150214eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049325; x=1777654125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFZnICrUGM5HdiGtclFFSrRR5EMO67SGzR+2zeCgTNs=;
        b=N0z6GwU+/OMS+4Zc05tNGs/PIfqAYMtK08UwaxwzyjBzvtKUFfW4rASBjH5F7FrFF0
         iVHYRSDcxrgNFZKSkdxE4i9x1VYp/gPt4z3Vw15FZeNi1zuiZcRuxHnebO+ZZcW8CaSD
         9I/c4PzU6WZNeV6I71T8r587bG6mXE9w1AJ1eO1dsSPMlB411+VCB9PskuKbzFigPVCG
         193NnFoC5sCh+Xmd1TiarHzPRFd7YP4viW2jA8xShDvUww8RPjKYEHFL1avBZG6l0n+F
         fZKCtRcXltT8I/wruJhohY86wirPHCiCOqDW8vZE644enRJmFeExPmvFiZkj6zvVoZgI
         NxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049325; x=1777654125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFZnICrUGM5HdiGtclFFSrRR5EMO67SGzR+2zeCgTNs=;
        b=fadBpjfk7Tp6q+/9drSymyfh+JGvmzYrEthD7e9fHdLGhAlFNIDIbparq0pHHcAyBH
         ZopgCh1rsCeGt1ejhHSsGH0rCIlWRoqIlBnzgxu5+4nhB137ia9+jz8vi+H6i4QFCFsO
         tiXEXgGkf0IPbig6US7m3a/VsT684+Ett9oaTFDgTnfzid2wi77SKmYF4cWUGphuEI0J
         QAgE1vcbg12Z+E6NDUC6n4f0Rte+GbcPntYD6Jyf+ikRAZ52AlXjaVqVhXxZeAkq1HhR
         svcU7q3zAv2EDbbnOeAsb0v1iJtUkwxA0uzeH9j/NFHsPbTs8Tn+bzepbL/hwsAVryw/
         +Pyw==
X-Forwarded-Encrypted: i=1; AFNElJ+t/sBlHKwtOZKdy8ekZT01nLzu/ERNJslHpBTCpzYggeSGyXQIDpHfVdL6cg5bCUyYQ7Gia63ZdRm4ANvv5K+H@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhXU+43KTcScx6Kt/HJ4O0wfTDjzf1B19QcNKpgIrXPD3DEHh
	tzWURj0lKx+cx7TwrBfAdqSAI+xCXTMu7ZR8WMBGwtY+z+7K0Tp8yNXGrbXaSZaC2y1TiIzrac+
	y+/ZLUvpkZQ==
X-Received: from dyer22.prod.google.com ([2002:a05:7300:2316:b0:2d9:e328:e0db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1292:b0:2c0:c415:cfd6
 with SMTP id 5a478bee46e88-2e47873bca2mr17943223eec.13.1777049324782; Fri, 24
 Apr 2026 09:48:44 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:50 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-29-irogers@google.com>
Subject: [PATCH v5 28/58] perf syscall-counts-by-pid: Port syscall-counts-by-pid
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
2.54.0.545.g6539524ca2-goog

