Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373E37AA94
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139397; cv=none; b=WXXmlGHxbi4BEJXcJw1w6NbuZwhkrUOFR9R3ghhU9cBlUaLVIMy8O+17g0oCAMnCp7P+rTNXQmUPPyIsbYAagEO8c0h9W5QtSz4fsIX+zmYfR/i7n1o/QH0LV/ceIAVQyXbNgYErU2AQjQ0gpopzXTeHHmhgW8+h74Z/M4Yt1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139397; c=relaxed/simple;
	bh=FsZbTBhM56M9pIEzMOPTGuMLNalT4O3LRdQk+/cVt2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fUBRLSIZVgxCI+SJqf8HHolK8+sMgGnkHF6/MtiqVyNkL1PfxLEltDrP9AXE2aIYft54nbqY101Ionhi08wF5KoWPB2lFcTRT1jWSuahmcpuC0rkZtD2QaB6xwe6VX/FqHU12tH9C5qx/2dNgLWJBJlf7WIQAeDakItb6T1HRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVpIOmYe; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVpIOmYe"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so8702103eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139395; x=1777744195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUuqjywSMoBiuUZB5eMXpVGDru/SJ2JbsKc572+eD7Q=;
        b=HVpIOmYeKa5qNuEsIsWtm4ykJZy6Et9mHR9Qvcgivj/JBh16Z39Ch6LzLI3SfA9y+v
         DcmJEQztMMo/CO17GJK39Ro7Fu6pcyVWN8kRf3aRS5IS2uqUHYlT4vqiUuTVcpD7J/YI
         07ZW9jnyXUiZhTK25G0yYjItZ4bKJHn2Va/NRWOcEpRHSECzgmJOr8R50RIAW0iq7VVU
         aaZpad9q9/wwrq5wTwRTKY4rkEq1QsI01l+lfDiwvWN90bi3oT0WGzQwhlAOG2hqAxZm
         G9YGv9o4DlU3EfOVG1KlpG4k5yWLkA9SZDOHv8pXN8oQH1JPTxenx2Tmw/LHQI4WYp8h
         kAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139395; x=1777744195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUuqjywSMoBiuUZB5eMXpVGDru/SJ2JbsKc572+eD7Q=;
        b=aPdWVUEbY+TTR4EXBGQXQC7u0boHn171nyqWccMt0/NVcPOrAyzvhIt1G2KWSwyrpr
         rkr4C5seWFToW/jOc8HfGnA6oqQlsmrEDTOQ6MjXhK0DTxOOakp66YmQ94SMLmHSahPz
         HUy5T34VivViEsRp0blscLvrlvXy62j3hQJSYaKFPQ7G68dw2BhlBVHJI9PbWgGUMV+A
         EryUYMOLjDT2P+EVeAcqJDRvvmmqnwavTBR26W9tarD8AHL0BU+lActGjn1CTA49AURl
         qBfarHrK89pLIhRS4Yguc8uks4qWoJiUoxo47WLB6Rgw6lxwkUa50+eWtxSaF4dm0Pm4
         k5vA==
X-Forwarded-Encrypted: i=1; AFNElJ87JnUemsWcBv++fDicOMi3CC7EZhT0OG833PCCWiWiNWwXtxccQoqbtyUZvF7UuIoa30VHGXQvouNrIwCtiNIN@vger.kernel.org
X-Gm-Message-State: AOJu0YxpnxA+le/3w07vhY80NF2y7M2FeIzAu2V3fQpPgONrb03o8E1d
	c+HH1q1ReO1CQuNVy/4DwHlYSzui10DnmGV1+Ty51IzUZOhp0vhUz6zJgqf885Brp3xADe1Kx0y
	eb+I5/9LPvA==
X-Received: from dyfv9.prod.google.com ([2002:a05:7300:8249:b0:2df:7541:1895])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3252:b0:2c4:ec89:bc7
 with SMTP id 5a478bee46e88-2e464dacc71mr20505214eec.10.1777139394510; Sat, 25
 Apr 2026 10:49:54 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:25 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-28-irogers@google.com>
Subject: [PATCH v6 27/59] perf syscall-counts: Port syscall-counts to use
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

