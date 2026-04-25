Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112B3A380A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157472; cv=none; b=bHfqKuvs4ehoCxBWN89u26Mt4leIAJJePCrydf9foTpB+AzvWwdJy7OKXuP8tDJ7fKyeePpnnf5qWZ+OGOnsJ7vkakRzDEef0e+ZLaluozEDeXY1D58UdtFUBLWgz8r2nSA9yy1LDTxbwqoxgGdGIqzaRGDRmiNhoqwb1uM4PGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157472; c=relaxed/simple;
	bh=FsZbTBhM56M9pIEzMOPTGuMLNalT4O3LRdQk+/cVt2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AA7W/enXpUD/cCs62wjoGOFmKbgeIS0HGmi2kUske8HXcwrjSs7fXr3ZE5CiGZ688036QokYhKqISFiUUdiFkcaG1wLgAlOZ2h++RKn6QpOOMdEagbbMGwSBDGnB+qgToc9U+p35pazwsVtCITR7ZapBZCWQkn2QM5cxg2YxyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MubysIR/; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MubysIR/"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so7738887eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157469; x=1777762269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUuqjywSMoBiuUZB5eMXpVGDru/SJ2JbsKc572+eD7Q=;
        b=MubysIR/kSxBn6QgX7eHXUXIyP84eSGa3ztp0el2XbREFRNc4f307ZWkNA9jsDnMon
         lYa82GjkRwoRUtXQgyxo5Yy2yQKawr3i62zAXHNLCxWb3o1vV4/89QewY78oIOAuLuyl
         bk5kNp/O3ANb4j7Zm97Au5W4v/w/C5SYBcrROKVeCpQ03Cs5CtBRzdLw/NEuLrTKlbjZ
         SJjq2rm7giR96uvIYhiH9HZM505QxVQ9nWBMohKCyki9r5e0sKkoivu6xGl8s0CGNrL/
         EvbEvEmYQZbsgR/9cLqMnwQPGnmw7MgUbdnwgNKs7ZXZwrbFIKmDpxsHsDxznlal8L8o
         fMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157469; x=1777762269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUuqjywSMoBiuUZB5eMXpVGDru/SJ2JbsKc572+eD7Q=;
        b=b78Mmbtfm3fRibzGVbNm1TZ54Wcl7A7N+hGNHzHdacCtoYf5v8d7lQiy2Es5HDzn90
         t6wKKyKIbh83TdK3aQMTVjg6HKDgsuzsIptjzJq8o/JuedaqrDKfGjaZewtGmglI4i0K
         k9HbFWaeUX4xqv99GXz7ypMwNJRlqDJ0xzkMqsaedzN59AlRiMAHDabKscvlVSqSWRTf
         GCnrHDfznOhEY0dk44xc0KGElryfvmcocTGyPOIuKKP43lqjdENds9YGpAX8m7Vk48qg
         oKItMmvRRyF4Ti49aA24NYJUjgqpdTpTFXnGv+/BGgyJPa6/hs7YwKVs6JJXcnn/xEO7
         eWGw==
X-Forwarded-Encrypted: i=1; AFNElJ8qXmFVvpEKDranIIhdSe62qXKprbad0Ch7+pdA9juNRatyOPxGt6obZ+bbCvmIuM6UGQTGjz2AKVrbnZ7NP9pJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhKvi32Q0RLgXMe7g1Ahh5RTEqnS7I2YKfPJSc4Feiginv4YC
	//wu4mUSr4QGx5IWeQpZ8SBIkw32HsZWjwYJ08m5oDGbfVSvRBbcexj+KTRWRmVzYmAc8R42mJ+
	WrFCGpRir+w==
X-Received: from dybmx9.prod.google.com ([2002:a05:7300:d409:b0:2d7:d4ce:8994])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3d19:b0:2d1:9b35:4edb
 with SMTP id 5a478bee46e88-2e41a1e3fb6mr14598532eec.0.1777157469044; Sat, 25
 Apr 2026 15:51:09 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:19 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-28-irogers@google.com>
Subject: [PATCH v7 27/59] perf syscall-counts: Port syscall-counts to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rewrite tools/perf/scripts/python/syscall-counts.py to use the python
module and various style changes. By avoiding the overheads in the
`perf script` execution the performance improves by more than 4x as
shown in the following (with PYTHON_PATH and PERF_EXEC_PATH set as
necessary):

```
$ perf record -e raw_syscalls:sys_enter -a sleep 1
...
$ time perf script tools/perf/scripts/python/syscall-counts.py perf
Install the python-audit package to get syscall names.
For example:
  # apt-get install python3-audit (Ubuntu)
  # yum install python3-audit (Fedora)
  etc.

Press control+C to stop and show the summary
Warning:
1 out of order events recorded.

syscall events for perf:

event                                          count
 --------------------------------------  ------------
1                                             538989
16                                                32
203                                               17
3                                                  2
257                                                1
204                                                1
15                                                 1
7                                                  1
0                                                  1

real    0m3.887s
user    0m3.578s
sys     0m0.308s
$ time python3 tools/perf/python/syscall-counts.py perf
Warning:
1 out of order events recorded.

syscall events for perf:

event                                         count
 -------------------------------------- ------------
write                                        538989
ioctl                                            32
sched_setaffinity                                17
close                                             2
openat                                            1
sched_getaffinity                                 1
rt_sigreturn                                      1
poll                                              1
read                                              1

real    0m0.953s
user    0m0.905s
sys     0m0.048s
```

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Fallback for Unknown Syscalls: If perf.syscall_name() returns None
   for an unmapped ID, the script now falls back to using the numeric
   ID string. This prevents a TypeError when applying string alignment
   formatting.

2. Fallback for Syscall Number Attribute: The script now checks for
   __syscall_nr first, and if not present (as on some older kernels),
   falls back to checking for nr .

3. Robust Process Resolution: Added a try-except block around
   session.process(sample.pid).comm() . If the process lookup fails
   (returning NULL/None), it falls back to "unknown" instead of
   letting a TypeError crash the script.

4. Support for Custom Input Files: Added a -i / --input command-line
   argument to allow processing arbitrarily named trace files,
   removing the hardcoded "perf.data" restriction.
---
 tools/perf/python/syscall-counts.py | 72 +++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts.py

diff --git a/tools/perf/python/syscall-counts.py b/tools/perf/python/syscall-counts.py
new file mode 100755
index 000000000000..ef2bd8c7b24c
--- /dev/null
+++ b/tools/perf/python/syscall-counts.py
@@ -0,0 +1,72 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Displays system-wide system call totals, broken down by syscall.
+
+If a [comm] arg is specified, only syscalls called by [comm] are displayed.
+"""
+
+import argparse
+from collections import defaultdict
+from typing import DefaultDict
+import perf
+
+syscalls: DefaultDict[int, int] = defaultdict(int)
+for_comm = None
+session = None
+
+
+def print_syscall_totals():
+    """Print aggregated statistics."""
+    if for_comm is not None:
+        print(f"\nsyscall events for {for_comm}:\n")
+    else:
+        print("\nsyscall events:\n")
+
+    print(f"{'event':<40} {'count':>10}")
+    print("---------------------------------------- -----------")
+
+    for sc_id, val in sorted(syscalls.items(),
+                             key=lambda kv: (kv[1], kv[0]), reverse=True):
+        name = perf.syscall_name(sc_id) or str(sc_id)
+        print(f"{name:<40} {val:>10}")
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
+    comm = "unknown"
+    try:
+        if session:
+            proc = session.find_thread(sample.sample_pid)
+            if proc:
+                comm = proc.comm()
+    except (TypeError, AttributeError):
+        pass
+
+    if for_comm and comm != for_comm:
+        return
+    syscalls[sc_id] += 1
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("comm", nargs="?", help="Only report syscalls for comm")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+    for_comm = args.comm
+    session = perf.session(perf.data(args.input), sample=process_event)
+    session.process_events()
+    print_syscall_totals()
-- 
2.54.0.545.g6539524ca2-goog

