Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E23E8665
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049325; cv=none; b=P/pXfzz55Swxh3fJRiBesmUljT7RMQ/f2SFEciVGU/SpRd+77jgQzeAeWklL5+l5ruGzLjR+VprLWfHdga4GkhwpBC46p4JiZkH61FHNqzvZIK8jtVCRCPHjVeaLTu3A0qagKN8Kjvva5WR+L7k4sD/4LjiquM1ULS7fzixcV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049325; c=relaxed/simple;
	bh=t1JaY7d7NRaZg/rWzVLxxLlQ5Z8m4JcB8iHj5vV8bwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MIij9knskZ/A1AMnNXn+qPE+i8shNqXrn3xHhJpfhkOSe7D+8t1xciNORpqKHoTF5aNxQxg2afIMvyD42Yfs4tDVT63fhuTcwy7JrK12RNDPjPo5DRBXYKLOOYItcbbGpErPceBxyFejkYkMmq54C1FLBQSNL1kX1IgfS91d53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjfPWug/; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjfPWug/"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8d7d4a79so6120590c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049323; x=1777654123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dar8RcVbwujwoHVhUhWW4I6oSfgck4eWT0xYDgV+730=;
        b=sjfPWug/9Ipb6e+1/3rHLK7Dt2LceyGVAKadT5mWGQCK2krf0TxWvhroSHz8NXZ0cY
         UjyVAL7KF2tQXpRCB8gk1EptGdD9I8jxuGvfS005CTsCmhIbThpywegn7wwWSzljOehy
         KhDRBN2ojepEdIPQ/5OTIUa139WkZ0IyiiozI42sDtJzDjpbHFlys3OMg6DKCz8hFHyc
         BhyCmENId9N+d/xyt8nH3y7aMY3OHxdtTnDAAMrdqmEitTLefwfDnWP2zAM3teP0E7TZ
         tf+DlbVHUocG0UuKdN3zoZTcAyYkA2c6ZigmUs22aj551JW8pKLj1ZUmGX+ka88LDGhc
         egbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049323; x=1777654123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dar8RcVbwujwoHVhUhWW4I6oSfgck4eWT0xYDgV+730=;
        b=o/YlDLAD5MzsrCZmpfJTBW5swEFrOsI4wNOsh7WgQ/tmEFdxdsCIJoCzhJF4KXlNY6
         Xxoh1bxKn7A+SaPoIFmMlmaL3EBRR21JWZQHK5aOc0pOvr3HomrcAlibJ6pOg2GkhVW0
         WC3Ril1BRfops4vgnvjplSo3GgCCscHfUshdBQ5qwK+I0tXN9zV7Zjaiijacwr43rh/Z
         ofnLzwc4KWES+QTOV9iRIBCAJTWnfP1tOghAQt2a82pQ+W09haGGT84Vb+BcGES1+j0O
         pKjkwptsDf6uzL2rpC/neoa1L4stA04TX7QdBYHlh977kDjtjBUvmB3vM4cVPpDnnJgS
         f9xg==
X-Forwarded-Encrypted: i=1; AFNElJ8nKH04yxuK32EplTG9z0+xWW83Zt8hBC5jd27OMeMJxCk8p2jIHBmdaD07rAvyw5bEf+lRUA0JRn+Ocpvh2W83@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIrhHZ7c6MRSC/qzhgHJaQDtaFGEY1/+Ye76e6xAjGQtmSPFu
	1Q6hrVC7kEhSXT2DevYN2mt0Alpr1pzyWz0kTkwEgK/itYxvozU7/UuUW/YVVUsbv+YsI+g/CqE
	VDYplfSkDhA==
X-Received: from dldz5-n2.prod.google.com ([2002:a05:701b:4185:20b0:12c:20df:7530])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60f:b0:12b:ed30:5a32
 with SMTP id a92af1059eb24-12c73f6e183mr16502030c88.5.1777049322965; Fri, 24
 Apr 2026 09:48:42 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:49 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-28-irogers@google.com>
Subject: [PATCH v5 27/58] perf syscall-counts: Port syscall-counts to use
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
2.54.0.545.g6539524ca2-goog

