Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F53AB27F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960668; cv=none; b=aTZPwj0n34zjoc+6f0vXxzG378PAqg5Rm1f5D3pr4TOXYqCcuqyzLBbcjY/RiBTPCHylIO6mj/iiujvcY9LeZfGJLwqda5pL834bmWYzZDk9tu/VzlSmtfYjG5KgSjhmnn9B4QVJJC0sG1NUSxCaFoQHOOtNCqiGLvhHLNoJJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960668; c=relaxed/simple;
	bh=hRYdsGq1DPzw9AKaXyVeVKZ33G9R2FbH1Ha6Xy7mqH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dy0jK9RD24nDhHfNZYuTCyLGNqXR1oOcCXl9zfwI7YVvDE9U1brpjte8+w0Iq5yvG/JLv/eQNnG8djtSfGjT8A0FZoU6UpF8lUq49PlmlPlmtJyBW0fv7HCfrQXy7YoQL8dNqwndRYASowkKXOuofi4kr2GxKmWeGysrpXT9RD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFnt+XyB; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFnt+XyB"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2dd1c74508cso11114311eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960666; x=1777565466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jh1fu2b+Mu/f91JhQcIvoSz3dYZEeq4RNZS+9V85IHQ=;
        b=CFnt+XyBl9SCY1awDpW+nCc7uS/7UlY2PxMgLsCmeLXEPwcw+EYMGPInmffoUmHMKX
         Hq4EcRb1OVSv4pvlfMDG7abzYZHMQTu1gy/cGewkgTuRVhVV2vS2ULu7mNAWT7fEGqK6
         S+a17cuI4C88rd0R9vl4bdhKvzGWKeVPkmPRFsjRgvlZA4BxN1zgv4aZH+8Dzm53QUG0
         eaLKyc18KR+GZqI074C09uKDioThOEtO+K3aqzsdbfKteMiO5/N6/QhrodFtz8fQ+xbz
         jcmryopgXh7+cYNYTk7LtstGRTk/fUN+rSN0mvZzk3qVoM+V9B0EVS9+cZbZfdMx4STZ
         5PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960666; x=1777565466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jh1fu2b+Mu/f91JhQcIvoSz3dYZEeq4RNZS+9V85IHQ=;
        b=qK+2mZkwGqSS1QrV/xXCp6eDHZTAhbhqc4h8OPA0zXs9qi81qKseUR0ORagcFXKMYF
         ejQtUywukfTkmFPmyk/xahRVM2qdorYilUlgWeD7Ebp5Mon07gxXMcSYMzlhjBmYTyIA
         ygg3M808R/Y0JtEfPrz/aBxKv16iazwbR77DSvgSGgd0xf+6e2piMzumintleM6j21rM
         hxaZiXfFjNu55FlST5OYWiJJuqvTSoXzfgdljwyhD0JEa3muBRq5uNnlEK3cnAzL0Aho
         MnkbmlypUQnZcktqI+hHYBCCNoGAsv1jbJnjmQC6PQb5qpNluBe7dZRrlGAwK3t/z3fv
         TjFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MWed1F2y5yMGWTBTmvbZvn/yNTcF3IWIRTPHNlK+GUuQyfqSne3MdlA759YRavPQb89zAhOHt506yikxRtYZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YzfEVMZ4RaRcu5BKhmRhEJRjB1m6WvF1wbdpBiAjd1rtnsVi0Nj
	LC7/TtuoNdAl8rmH1IR84Jx2uCoLi28cINgn/J0w3QLLTYv2ZHidFhkLJmpWBL6qxZC/khgSQUh
	Cw+vNw+o/Hw==
X-Received: from dldz11-n2.prod.google.com ([2002:a05:701b:418b:20b0:12d:c368:c23a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec07:b0:128:cea1:7e3b
 with SMTP id a92af1059eb24-12c73f9b8c7mr12612530c88.23.1776960665552; Thu, 23
 Apr 2026 09:11:05 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:34 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-28-irogers@google.com>
Subject: [PATCH v3 27/58] perf syscall-counts-by-pid: Port syscall-counts-by-pid
 to use python module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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

