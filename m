Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A638C2B0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156949; cv=none; b=rdVoGA28p2A9PJcyNQd/wzqOHE+Aq/1UEYmM13EP1XFjphKA1EyYR8vHf6ZkreJwBiRRGssDswzd2n0765MfV+5ur6+LbeEYlTc2LxMX3LJNqd5T9xfdKIfKnk+rZLqxOXiCZg5mXV1iOcj225oYkyVY+JSkN1e1sF9PfiXCt8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156949; c=relaxed/simple;
	bh=FsZbTBhM56M9pIEzMOPTGuMLNalT4O3LRdQk+/cVt2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tnm02ASmGPZZGX0AezbnVEhPEOs5syV6jwLSPeXdUPmtwGsSbbWCCYwdHZXu9EQtgj567d7vb//sYbC/DwACfqQ3q9mByrHTqNZ96GNVJsOfu28lvU2Bb3BkJD/1hzdvLsSFcas3rqW4fr3A3yOhnPeFkVElnxq9auw+CZlCh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jybj59UN; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jybj59UN"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so13686796eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156947; x=1777761747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUuqjywSMoBiuUZB5eMXpVGDru/SJ2JbsKc572+eD7Q=;
        b=Jybj59UNgv/IYePfKMcEgXqCtbdDCYaWhx90dqes9RJxl3I+Oybsy+ZJ0sET2YekhP
         bImFlshqeTHaPgyjvqQ4qUPkNR2HwXd3ICLNgMFxE0hCoonDkNSzo3jYfbOhFAO1p682
         huIsDskS4ov6SCNTaElgRUqMrYhbj05avreHIf2CFc3edh3BAfi3vfeWY8ZFMYPe6q/V
         fG7nT4os6hSwlzEhiYm0Rn4e2BdEy4rtiYcnvGEa2zc2rCju5+eJX2zdZQ0gxIoqbGNy
         zyRXi9qcIKvz7UW0aPR61j8rW5O576fB/aYt1cIYqgMm97IzSAbQx+ngJ8GIfdNeiTNd
         6FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156947; x=1777761747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUuqjywSMoBiuUZB5eMXpVGDru/SJ2JbsKc572+eD7Q=;
        b=oqoGkTVt92h7TgXjA+MIE8ujNMlu8eT7Z4vgjOOlCNZMFh5/SL2WINcrbRW8ZZIHu7
         ntAO08+34Zoqz5b+Pha0tUjdj1V0qn5FA9FvTmjD/eS7JC7dzVZmHJVCX4k7PfI8wdZ+
         hIMsVgAQIGVtG9fXn71RtfjOGuWWcFHy0jNweNjsQaNLoh9bDWeV8iOI5UjeylMArhj6
         rpPD8ajHHy80UORhhKq6np3RfY6OnuxMowUzM1S8cOLi3bdJKJJGjUvKbzuCOPKMKpPL
         XOqY2i7BEXuW3Zm4mb7pwau96Il5vv9zJ/hSeqGS1hgcoitWxV9XQ4wxV8eZ+YtkUNOm
         g5XA==
X-Forwarded-Encrypted: i=1; AFNElJ+2/jA8EHwpO6YuFH44YazZNqDkHqMZdnaU5NmruuTY3lXEYNBDt3R6xuyiXCrYQQV8PbtZWCo6aJPLhAV1uNHE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf7xymFxmvcpSbJUAspSBIUeA026iIuaYziASsapEgelrxV2UX
	0R2rXjnfbO/herNHg/OD8on0P1tCtxsxUH1qBmqniv1letJDQn+b4A1yJaSxZFtRRg/m2n8kaLT
	4HaTWaONqYQ==
X-Received: from dycnm7.prod.google.com ([2002:a05:7300:d187:b0:2d8:fc66:cd7b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2b04:b0:2e2:a4ba:84ae
 with SMTP id 5a478bee46e88-2e479017499mr20173723eec.25.1777156946642; Sat, 25
 Apr 2026 15:42:26 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:52 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-28-irogers@google.com>
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

