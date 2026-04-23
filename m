Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4883ACF10
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962117; cv=none; b=l6XkMyB0oRxWl7wt9KDqHiKiuNfkPD+Oo7K5aHaGCmrcOMs8fXQpFb76SVHwGN0PvlFfsifwlsfu4EfAnieSsqpnSIuQeLsBXM827wNUSuJErXNCLRdMoI+HzjO0ZARYQXiFZFQseAUt6C0IIifFShdQW8ZYFzBoWixzM9gogEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962117; c=relaxed/simple;
	bh=GxiLTOS6AgfVbFa/NQFl6HiqDXtnk5e0OJgS+giWpf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XhUgffbuYZWradiobvI/Foo6/pzNiBioMAyvBeAi03n4m71Q2Fq2+hY9hXFpkTUgrZ3zS/TEtRJeblQDKk6pvZ22JhNsBN4/j9smlk1FhTk3vWJH8/DI05jMn3rPvqhGt48QFTU6GP2r5CPSLs1gc2cdb8Vk9WQZoFE5rFeEHnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvXa+0CC; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvXa+0CC"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d8a677cdfaso7285929eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962115; x=1777566915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWP7NPE2eXJdGRUDstXRiHFum4kassMtgfTCQ5VQzQo=;
        b=FvXa+0CC32XeCoPwNGlkHnY2YQqh5+xHg8GEbNCciO0geoNcouliw4+enHDFPsHYlk
         JHKkITgsTebSVdPByQ06K33RHnhNuvUYXcjYvDpJxPLTZJn0X09pjMS9zbGpmkwll0Ph
         jirx+ckETggnnFjcXKRxMfRZDJ1+6OdMje44WRiW6rOC+Pt6VaHhcgx2VBgoQPfaQAMn
         tQRkO0gCanfpWNjPH6krLVKfkQHkPYi/uYUHPetdX44CPWX4SV5bjvFrQgUE1c0nwXDN
         YumB6TuHZvBJDyUkj2F4hy/4bFAI/lseysr3kRCkkfZk/LvtlnOiAdCEl16zerkbvZ9b
         tDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962115; x=1777566915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWP7NPE2eXJdGRUDstXRiHFum4kassMtgfTCQ5VQzQo=;
        b=bsErO38PS0HPoNQf4qfHnz8lYPluoUMsiXRiXATzsJ1568/SwjmbCElpkOtHB4CLoX
         ij7rLHCbanVC0V8eRjUqkCQxaw5L2O+zjmvzLeDT8V15sOO5YL8PCIYBcIeutROOW9KC
         Z8NUcGzZFBDDfayUcauCNwzyOcTSV2+QnHwvl+kkXsYMjr/DCDKFpz/HBL+Qn1Lq5ATE
         56QnooBm1Kz2Zewfjf65BmrPOxVKGctbJWAUZSeihwep/SP+jAK78J61Zrz8DsSTO0JB
         Lj/rEOMyu8sEjgZ/GKKxy4LXkGrhqYTbBIWQnqcRTMRrn8KJ6MB6d3nd4wLeRBtZRIzK
         na1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/YjEsbTiofcjsNFutx9N+KMOE/yXOFn8hyzwmUxf1wokMoviKrp4vhBYIlp1mAI3Uw/B3zzRQo2+JWgQR70XQh@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFALD/V4hBjNkaET6tHliUfH6DNJEHCZmFUVvlw/kj708PTEP
	sg1kjNDspsxCg3j7rxlkbse8nFap54j1EX0qSnF/nz2Z2ovVSvjr7W2R5hPfj8E2uKnKJ/BXqpm
	G6Jr5zaKJBg==
X-Received: from dybkz15.prod.google.com ([2002:a05:7301:1a0f:b0:2d9:cb4f:864d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4591:b0:2d9:6373:ad24
 with SMTP id 5a478bee46e88-2e479214a0emr15065672eec.26.1776962115177; Thu, 23
 Apr 2026 09:35:15 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:35 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-28-irogers@google.com>
Subject: [PATCH v4 27/58] perf syscall-counts: Port syscall-counts to use
 python module
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
index 000000000000..cdeae6c1e9f9
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
+            proc = session.process(sample.sample_pid)
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
2.54.0.rc2.533.g4f5dca5207-goog

