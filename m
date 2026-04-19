Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41AF33D6ED
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643232; cv=none; b=sezwVDAFR1fRMayj90UNzM90TGQLgv98Qcang/kdwWkOBYzg2l3rIHfwS+xDs/C4NJMLF8E0y/bnfEPvx7mKimJHs/dOQSg8yeVF26QKvimzAXGFf9Joy56IrkY2gj4tZ+CuMYNBP5f6XF8GcMq1hg4HV9Hze2+DJNW8w++/rYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643232; c=relaxed/simple;
	bh=cDuFLi2du+A89h0gYkjo9peFw+CrlxGqdX81Q3lgXHE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V/DvopaFbDNJyd4wIIYU3LFupOAhN+Ih54SaRoASuJZOtP5NJ3MSTjIcCM14JrvqVgjW86cZe2rJbyKnWWVL7OPgQoza7rRQ9JrGQSu3dI6M/U1CoEtrhfro4OhGb1iNQ7/4eEJBoDbbzjY3FVzQ02yOS93N7+nEzcYIj4n7B0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jP8UnuB9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jP8UnuB9"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35d9278587bso2937619a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643229; x=1777248029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVsg/jCIPX02y9A0P2mg9Ec+DDgRaIKZvPz/ydAVnaQ=;
        b=jP8UnuB94x5L9GSaM91sg+cet9ThhkUyuyE3AOpjRtim1SGf8IyWHHWlwn76sMQ7Af
         Nh/9Vt6mvf9AfkgR1qcPu4YMWHcrhtMsc83WYu8IvS1UgWZbOrW9yOitdQiL/0Z3aCWI
         eDY0+AfHqUf155HSNrE3jPo/Y+6Llo1uH3nLhQ4hGTZP4Ielb5Ynd4FA+4y34DOPXVFG
         KzPHl0QZm2ameMjMO5BfYAQrNLQoQHCleJOGU6sSqCwpSyU2MzC+tUKtR9L1A+QgbvX4
         iaXYZ7bT/ZRk/fl1MF8HSwV8fnu49N8CaJsaw8tK25I+8ICH894y70hsV69YCoMZ2BQy
         I1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643229; x=1777248029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVsg/jCIPX02y9A0P2mg9Ec+DDgRaIKZvPz/ydAVnaQ=;
        b=MhU+ZT994AW5OeaClOyORvhyjNfF/lbXX2sGKyqlRSoaw5pSm64vD0qwucX9jwaAQs
         lCvoyH53K8Yae/yFCYMlk9NG6M02QFkrxrMxyrCC4f22Kbsw4J7FkI0JDT0OUOBrOTbo
         rU2xQ1rXiPcanoyt0Wo5sfYLwzcsq3rwooD7S2rD33cMU8TorTw6glyqPBCMgSq9ZA4l
         lwnNlqbj6i66xuiAWxAkJUJH/uUNVBSZ3QK1IG67giD7MCxevWHLaM5Xqt1lOr1AoXk0
         mjSJNfp0Gi8XGPVLQcy0ejAEM88VWCjWQuOT5Qt744E/CWKT1etyvEJW7AfU29XoeUId
         M56w==
X-Forwarded-Encrypted: i=1; AFNElJ9Eo9KbQuhqxV8cFRJGb9Z/Hvb+aLYAVAhleM+b4RUpJS2bIikELnvIsLw35TGvoXsufAdDRmVW0fIjptf+/5Yh@vger.kernel.org
X-Gm-Message-State: AOJu0YysOQIARKqhc7etz7TzDYFSry39UnKGo1a9Amgb4SZqNzTkT6iN
	JfeJxTmdA4+vPwun8/Oowm7YlVZtGAbIDDSWtUBEA1uBRHbtkhl+pdspVhwGeDEvtViu3RA3Z9+
	r0NKrI5gkXg==
X-Received: from pjre11.prod.google.com ([2002:a17:90a:b38b:b0:35d:ae01:8b69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c8c:b0:35f:c1cc:fef0
 with SMTP id 98e67ed59e1d1-36140473e42mr11974997a91.13.1776643228258; Sun, 19
 Apr 2026 17:00:28 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:41 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-30-irogers@google.com>
Subject: [PATCH v1 29/58] perf futex-contention: Port futex-contention to use
 python module
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rewrite tools/perf/scripts/python/futex-contention.py to use the
python module and various style changes. By avoiding the overheads in
the `perf script` execution the performance improves by more than 3.2x
as shown in the following (with PYTHON_PATH and PERF_EXEC_PATH set as
necessary):

```
$ perf record -e syscalls:sys_*_futex -a sleep 1
...
$ time perf script tools/perf/scripts/python/futex-contention.py
Install the python-audit package to get syscall names.
For example:
  # apt-get install python3-audit (Ubuntu)
  # yum install python3-audit (Fedora)
  etc.

Press control+C to stop and show the summary
aaa/4[2435653] lock 7f76b380c878 contended 1 times, 1099 avg ns [max: 1099 ns, min 1099 ns]
...
real    0m1.007s
user    0m0.935s
sys     0m0.072s
$ time python3 tools/perf/python/futex-contention.py
...
real    0m0.314s
user    0m0.259s
sys     0m0.056s
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/futex-contention.py | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100755 tools/perf/python/futex-contention.py

diff --git a/tools/perf/python/futex-contention.py b/tools/perf/python/futex-contention.py
new file mode 100755
index 000000000000..153583de9cde
--- /dev/null
+++ b/tools/perf/python/futex-contention.py
@@ -0,0 +1,54 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Measures futex contention.
+from collections import defaultdict
+from typing import Dict
+import perf
+
+process_names: Dict[int, str] = {}
+start_times: Dict[int, [int, int]] = {}
+session = None
+durations: Dict[[int, int], list] = defaultdict(list)
+
+FUTEX_WAIT = 0
+FUTEX_WAKE = 1
+FUTEX_PRIVATE_FLAG = 128
+FUTEX_CLOCK_REALTIME = 256
+FUTEX_CMD_MASK = ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+
+
+def process_event(sample):
+    def handle_start(tid: int, uaddr: int, op: int, start_time: int) -> None:
+        if (op & FUTEX_CMD_MASK) != FUTEX_WAIT:
+            return
+        if tid not in process_names:
+            try:
+                process = session.process(tid)
+            except Exception:
+                return
+            process_names[tid] = process.comm()
+        start_times[tid] = (uaddr, start_time)
+
+    def handle_end(tid: int, end_time: int) -> None:
+        if tid not in start_times:
+            return
+        (uaddr, start_time) = start_times[tid]
+        del start_times[tid]
+        durations[(tid, uaddr)].append(end_time - start_time)
+    event_name = str(sample.evsel)
+    if event_name == "evsel(syscalls:sys_enter_futex)":
+        handle_start(sample.sample_tid, sample.uaddr,
+                     sample.op, sample.sample_time)
+    elif event_name == "evsel(syscalls:sys_exit_futex)":
+        handle_end(sample.sample_tid, sample.sample_time)
+
+
+if __name__ == "__main__":
+    session = perf.session(perf.data("perf.data"), sample=process_event)
+    session.process_events()
+    for ((tid, uaddr), vals) in sorted(durations.items()):
+        avg = sum(vals) / len(vals)
+        max_val = max(vals)
+        min_val = min(vals)
+        print(f"{process_names[tid]}[{tid}] lock {uaddr:x} contended {len(vals)} "
+              f"times, {avg} avg ns [max: {max_val} ns, min {min_val} ns]")
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

