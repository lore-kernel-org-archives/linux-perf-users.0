Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D44331213
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643228; cv=none; b=ZFFMTzJ6BEOyD3eXsMCTnjm60yWf+6aNJ1PquxI1oSH2XLTqjgIjqyqXk/ESM/ylV3d/A+VYmMEnRWy2EEUMKYNbKNPPR3XO7zEs5M6CHDXE2OMnGP3CKyuaxdOBwR5EEyv4a8d9v1SyB/H3tpDsZ3h1WYAKGsQmKo5IMfqdZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643228; c=relaxed/simple;
	bh=DzB75MX46r8NYOZ8kRddsMuCMasac1w7ZyRDwYztpOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mvvn8/HOzrlLAwFVrWCGIgbFxIWr/d3xG6xZCQebbG0hytnGwnQ2/ozNu2K9HSugQrGtXuA05EtWYGlMS7rVuXpw6LakbjqWvjN2ODXDFoQ4/YAevmd1g5gB3KgsX5e/DXfTnCCJw/QTLfeMc4sEGi2OMsxr4gAANbsQlqIBwmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uj7Xo2xI; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uj7Xo2xI"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d93379001eso818273eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643227; x=1777248027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9qsHMN9tAhuUL70nibwzRG0VKjYsgSCZZlqinKu7Ls=;
        b=Uj7Xo2xI7YVJI5HHyKmFU2vFo06xzH8c+Hu+MTP23X0e1G5PufjKGd3DNcHhu/bWmy
         xzWOQcFpZ7MvE3oz/pHmN4j0dGLkgb2b5zvtzPPfTyZ0zBjTwn1X/C2v14pQXbiOQWPR
         RAkK4W1cc8PHVEfSXh29Wgu/4o5LSwG9BpmYoovKlQF7ASfNh1iNYTkNL2SuLkP4swd9
         1Vb5XOCbNaCk/KVm2kTcAc7t4un99rmMi/4ZsKcZZ5+eLghZHzCUR3Ea1mdcKm1qv0zt
         MEg/AYdqYi6BF5iZsibVVNVnHfLIWkATvLALcrAIl8b5Ov9a0vSSaFpabTWu+VezJ8EE
         dLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643227; x=1777248027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9qsHMN9tAhuUL70nibwzRG0VKjYsgSCZZlqinKu7Ls=;
        b=rK0EL0oNUCldunl5JgxvH7Rn19462palEQxvmw5Rh6mxmc/lKjl9gmKEUvRcSVQc9s
         WE5PERDtE7FLNMJZj0i5Ds61hwSmUXfpwvnULjbbxHpooRqiWvlR84LSiC1uzeu6GMxV
         cmjAeJktFSV8mdHk1L1kVcrSbRbW7ljRvu9PqFpKKq9e1xHQayFN0KSxYSp7T587o88s
         0PgOvwOaBllRsxHiLui/+8VTgt7bnTqQJj/LCQz+JYEDY2rQZ7l0doVCscyCzxuFmYFN
         qXYMygHMKFYvaDxEL0TBqkI1aKvDeq0Rax8pvyzk80uuvUwLDjoiFDLF9b6xGL4CDyqo
         eycg==
X-Forwarded-Encrypted: i=1; AFNElJ/KEuG+imPvHYdc9Ocd7p0ZgmXXqJzPa3e+lFBM0jrAELHX7Ga/vqmtuGZbK0dmEJ6XwUyTZOQped5Ai6gczpoi@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPP40OwW2shFa7OvVgvnFDPjhyRE7TpCzu8QYVFOWxKCld0WH
	xggh5SfanTpRzmlJDXTUsS19gBzbX1EbVHCHr4BxfI6EPKq6yotjjjdxt8FBCyoEGWJ8FEGJwoo
	90kvhYazr9A==
X-Received: from dybml37.prod.google.com ([2002:a05:7301:1525:b0:2db:47a8:4b3c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72cc:b0:2cb:8d2f:e247
 with SMTP id 5a478bee46e88-2e478839116mr5041963eec.13.1776643226195; Sun, 19
 Apr 2026 17:00:26 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:40 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-29-irogers@google.com>
Subject: [PATCH v1 28/58] perf syscall-counts-by-pid: Port syscall-counts-by-pid
 to use python module
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/syscall-counts-by-pid.py | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts-by-pid.py

diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/python/syscall-counts-by-pid.py
new file mode 100755
index 000000000000..a5d91060b18d
--- /dev/null
+++ b/tools/perf/python/syscall-counts-by-pid.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Displays system-wide system call totals, broken down by syscall.
+# If a [comm] arg is specified, only syscalls called by [comm] are displayed.
+
+import argparse
+from collections import defaultdict
+import perf
+
+syscalls = defaultdict(lambda: defaultdict(lambda: defaultdict(int)))
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
+    print(f"{'comm [pid]/syscalls':<40} {'count':>10}")
+    print("---------------------------------------- -----------")
+
+    comm_keys = syscalls.keys()
+    for comm in comm_keys:
+        pid_keys = syscalls[comm].keys()
+        for pid in pid_keys:
+            print(f"\n{comm} [{pid}]")
+            id_keys = syscalls[comm][pid].keys()
+            for id, val in sorted(syscalls[comm][pid].items(),
+                                  key=lambda kv: (kv[1], kv[0]), reverse=True):
+                print(f"  {perf.syscall_name(id):<38} {val:>10}")
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
+    pid = sample.sample_pid
+    comm = session.process(pid).comm()
+    if for_comm and comm != for_comm:
+        return
+    syscalls[comm][pid][id] += 1
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

