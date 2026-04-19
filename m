Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF0C145
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643627; cv=none; b=EembIQzbpadeF188kIFuAVMW17Pr3OtlHkEufO4kpABpOXbmfa8as6/DoRkRevUmGWQKW9sWdze6dTlyjDC4e0k8XyrShP3tPG/8a4LAtjdIWAIZvalMrgV3pYHhPBUiaLm9F6ESZnMoIlflqXzJ+EUxRStJL7i11dDstfyXImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643627; c=relaxed/simple;
	bh=lGdVO9+cr52Pnryq9kYG/lX0HikHA2TFNC7djqZcnb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iNVj+b5WQHfYmCyxSnDz4WtTOhwwRlnbHF238R0nxEFhiK09g9lJmGTFL7GTBmqCEE8XbxK8DgY4Dx+0NbkvLT7CDDp4zt8O4nJAZkBAjy1kxV9HiZmT0VhQ3SCLz4ssTTA4ZJgr0E7wV/ukVtI9f8d5QxA6WMVbvgOv9O2lka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FaRThAqa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FaRThAqa"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35e5791871fso4791275a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643625; x=1777248425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bI2SIpeP78m2dFf3X0Bk4cSbTlDU17jXo3mhkaxloZw=;
        b=FaRThAqat01MTO1VhbI8bliGMJoH0rgB5YV7Hup/3mRs8bTnBT9pkHyr+2GPKQ4qBO
         f/SH0Pq/NFA6+SYqwHMCQ335AFRX8tw1gmGfk0/nel1zmRK8kNjsFqueLudcRLqThCkm
         K1u2K1rCnFCvl6j8EYkmP/4wPcey+ymi/NFZiMtl4erpgaaHk1XQ1sMwrg1VpsdXFc/Y
         gYAH3F4S+pqnxZhNap9so0ZePcKTj6jKanM23Znq0ADZ3rTkY6hYjBq1tfdZ4Qn2rKYq
         KLQ3jh0eLnq7Z7SVdJ0Tew6Y0SLw5mzLB/boFLEHhhXTQdD4MRp7UthyPixt/u77q79L
         K4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643625; x=1777248425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bI2SIpeP78m2dFf3X0Bk4cSbTlDU17jXo3mhkaxloZw=;
        b=ltxR8Yi3pS9DZK9/6oFFFHWb59XbwPG/B5fbW+F68iY+MozUAJIulz1WMK6+6zt2ud
         7oRwJdCVi2dg1QIxGfnu/Y4lWufZB9JQ+zXLecON+Td768DW/3pcAtY7RDQTN25P97X9
         DORXWe1y9PCX138Ra9ORh4DRSCviK09/iW2Im3eziKzJdZScZBp22o+dB5SPlzNLBy3V
         fr9uAzKZCZHkPcG0fPzndIxXZ41VouLiNq0YvDQAN5slyqQyPg7epFiUfXMiI4PKHKpq
         kVBjGcwbp0RcP8Ys+4yxUoXQVEu2dnremJaIJdRyRfVL3+SG1wikkYfMBKjlEiI1VHX/
         2sKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QAqbmsr7LM+Q1sfWFJ78Mi+4bcLUql9SPtPxYEptOUSYZbZJZmH9iD4moq6+pZU9b7suvSKY0kR6dGTNW+RXV@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqgGsEhWjS8X1fW7dTJjgAirL1pP7RP4T3PAoheKF9tnKLCiq
	IjRXNJHltE/cIABWYcQEibnyhstQ0Phx1w/0kcqjq+8GaTQIDarskD1FrfT3usg5DL42+sPpVDV
	WU2te76ziMg==
X-Received: from dycnl14.prod.google.com ([2002:a05:7300:d10e:b0:2da:b59f:1e95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7fa5:b0:2d9:ad46:4a92
 with SMTP id 5a478bee46e88-2e478a2f27amr5951295eec.13.1776643223731; Sun, 19
 Apr 2026 17:00:23 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:39 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-28-irogers@google.com>
Subject: [PATCH v1 27/58] perf syscall-counts: Port syscall-counts to use
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/syscall-counts.py | 49 +++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts.py

diff --git a/tools/perf/python/syscall-counts.py b/tools/perf/python/syscall-counts.py
new file mode 100755
index 000000000000..a2e0994ab736
--- /dev/null
+++ b/tools/perf/python/syscall-counts.py
@@ -0,0 +1,49 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Displays system-wide system call totals, broken down by syscall.
+# If a [comm] arg is specified, only syscalls called by [comm] are displayed.
+
+import argparse
+from collections import defaultdict
+import perf
+
+syscalls = defaultdict(int)
+for_comm = None
+session = None
+
+
+def print_syscall_totals():
+    if for_comm is not None:
+        print(f"\nsyscall events for {for_comm}:\n")
+    else:
+        print("\nsyscall events:\n")
+
+    print(f"{'event':<40} {'count':>10}")
+    print("---------------------------------------- -----------")
+
+    for id, val in sorted(syscalls.items(),
+                          key=lambda kv: (kv[1], kv[0]), reverse=True):
+        print(f"{perf.syscall_name(id):<40} {val:>10}")
+
+
+def process_event(sample):
+    event_name = str(sample.evsel)
+    if event_name == "evsel(raw_syscalls:sys_enter)":
+        id = sample.id
+    elif event_name.startswith("evsel(syscalls:sys_enter_"):
+        id = sample.__syscall_nr
+    else:
+        return
+    if for_comm and session.process(sample.sample_pid).comm() != for_comm:
+        return
+    syscalls[id] += 1
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("comm", nargs="?", help="Only report syscalls for comm")
+    args = ap.parse_args()
+    for_comm = args.comm
+    session = perf.session(perf.data("perf.data"), sample=process_event)
+    session.process_events()
+    print_syscall_totals()
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

