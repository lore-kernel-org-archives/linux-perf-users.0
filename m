Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEC3E1231
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360814; cv=none; b=hxQmq3VK98V/EOj8vScln4pT0i2uhpEjSXfnx5RpCjumJB5EMZZGNcBvL2M0bMS+1dY/1XByhtBChwPHTrX00J03JmUXTpcPer6K46d/uukJHzPPX5KpZgilUzpcMGBhv1jyOZgtgxfa62sKG2r7qHavjOe3LZEpfG/RU7waVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360814; c=relaxed/simple;
	bh=FsZbTBhM56M9pIEzMOPTGuMLNalT4O3LRdQk+/cVt2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VMSu0XNt8jA/E0ycD8NW8ioD99hLXFl/639GgdV+24+s/eCJQgEZYG030rc9WnBw9g9O/RUGMf4CHNmohTG/T++NWO/vMQ/nsApa55bgUejL7y5Tn7+Xj8WYXq5E53/ctpe93/R+S8G8GK0+sNjU+lg4gUpoFVvDrdu+BLtUywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXwhoLPB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXwhoLPB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1273dfdaf5dso9117572c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360812; x=1777965612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUuqjywSMoBiuUZB5eMXpVGDru/SJ2JbsKc572+eD7Q=;
        b=rXwhoLPBH93RkhX+WEwsjpVOtr6wlSqPsR3AUU/J4LgH96/bPZSATWe0tGUFqoGkTc
         pHr5U/L2oC1FJZzC48mRFnVge0Traia48EJ3/T5C0cmNA2mzfrbBSXp+4jUJNmOSb2lQ
         gatMaPIGrAnUdzF1XzE0YA2Hc6yjP2UI5jWNjdCl6KiEbk9pmyNccbuWVyowDxMjI6/W
         iD8klvoJ9ajNGltHCwKjqCTb92EnTLzLYLqeC4zeJlnhgyg2xDAnewaR24yZiA3gs3ah
         GL4cGbm9y/itj5lWsOqABfSJHFx+JemghU8Z2eKXqgbRHUPJPmVvqAPvEiljxOcSJe53
         7AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360812; x=1777965612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUuqjywSMoBiuUZB5eMXpVGDru/SJ2JbsKc572+eD7Q=;
        b=dApS+3xNidIfOVuefu5RRUC9EfodyrJWmEN0Ul0Oet8gNFGAm2qncJE7t29Kjx/FBU
         4iqLl9k8FBEdav7SRyd5aM+jdR9DlWqBzb0CB7iPXnACU7+Oqj+fk+gW7vYiBhL1hmsQ
         B6qwRC3bqiwhypbpwt93McSVtNg2cRjpa+6r463vF3vG2GKYZblcTy1GuGTRcfnkOkt5
         5n7/Nb/JWk3gFgEL2KJUhussecUsw0bcfH9kyoVDQSt/phenr0Tb2XVLYkfPDSc7DMll
         46irs9dZgIqKVBEbtaBhAKurphbabepkclV7XDnP0kwxp4uKOljs6/49QKZfvkS1cJ3F
         cwng==
X-Forwarded-Encrypted: i=1; AFNElJ//qlAnFn3LomJZVT/6MvVuFtK2FSnu/ybmbcT/jAo+g0tbTnma2mdEF9TO4IvwlXyJgWTIAx+9TMXoeG40AixZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzwNMAkTzurbFdUvuJQymMBoanZDwucmi9ksnVkb1yLyoWxqnya
	Ek02POwDLoVyzIfchREUzH1aAu0xboRp7LqTTjIDH2ePzISyoiyPWQNGNE5lD7bNCHPfE7U+4Lz
	05JzufTFKjQ==
X-Received: from dlbpv4.prod.google.com ([2002:a05:7023:904:b0:12d:b3cc:a807])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4584:b0:12c:9037:5126
 with SMTP id a92af1059eb24-12ddda69489mr736767c88.9.1777360812328; Tue, 28
 Apr 2026 00:20:12 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:32 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-28-irogers@google.com>
Subject: [PATCH v8 27/58] perf syscall-counts: Port syscall-counts to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

