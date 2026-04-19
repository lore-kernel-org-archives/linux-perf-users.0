Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630131ED80
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643252; cv=none; b=IQeHMpTVWSPrqT0IExUXNXwHfFr0HsuFIHEX0nOu6U+2Ra3GsjJ6HQi5JZKlAQSWawjF9Nu96OrHQt2YA9O96X62w0/hnX1q07MyIDafiiW+b0xnlQhjdjwmQhwhYTXunQJFnVcaVnUI0sDBuEmxkJgtpdfGBsRPLw17NfgPADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643252; c=relaxed/simple;
	bh=gg8098GiWBxAOkvVNC4h8jqODW6zxfVoT2adv0HDVpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZrCaQycCy4V8lyVy6JvWG4U0ijxSEPdJgQId9Xm8uCdKiXCTB0OM357Y67xCWKs2zB0OL1WDCOnfO7UZ/8gqWZNV84C5yCk1b015k8fjyxEkqaKzl2xdNd4uTkpvdapwhaHEUqgfC5r/PlhXz+qlY0uFudcFQiicPpAdOMBmHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E59p1qrA; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E59p1qrA"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so3410044eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643250; x=1777248050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKzrWGqbp9sMe07seI39FxiQ57lZzIPyYPiV4VUzamQ=;
        b=E59p1qrAf8a2i/S9YdQpUV1xuUrqpZtZOaY4ZCp3rVqoEguRyhXGuUST+Sl+AZc8uK
         vf8CZdpXpucmAKox6QaUlW3WEw95S/1RzooE8EIXcFtZCKDyh2v4SfBQuG4b7QEFUwlQ
         WlDVOD3aIp53pePFP87NwLHjpzErWgPbebal8noPhlZQjf5Egg8i+LI4Srdeq4+KjqgB
         HeVeyPbKopcCVgySUfFYBotIti/KruWcPsqgZ865DbbMj/oLam2OQh/RziQgjEf5glnV
         ea3IeTMIMY2MA8D4WLAMVKqXMEIbm+rLew4IVLz1Lkhv0dBqJy5ia60FXcnSI+WazCA3
         BFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643250; x=1777248050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKzrWGqbp9sMe07seI39FxiQ57lZzIPyYPiV4VUzamQ=;
        b=APDhwZsJFwUhimo9Pq5VdEAm3/UpBrT0Vyn9Z+ro0REwBQJUUPwLKvQj9M/7F4aOsl
         QYml1Z6Z1YrNYVT2sRX8+VGauV3DvS5HyScZzdgy1B6nVyGbGepTokucsTPnPd7BVxwZ
         /ukQC34FQHPlBC/cVZ8/iI4JjCQ01b/EMmwFnDPTOMIjVEgshdHNemrA0396Rubnn0FK
         j6oOAKVvYxfKZiq1XzDoUtjNMfE8eg0MSo5KzAiBAuh/sJtlwkEtPPYbS47jbAlxixmo
         AU30pfivfWAvvA7F1J0MMefaptgp4Bf0auNJdQ+FVbYFaLbntEF3qyF8pEQcgeKmwZuh
         fgqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8l866z+qgzbnA80LBwsbkmbUE09yzCCQwVaVf7sQMCLS7hyUP5Wqjnw0NX/FCCgXaGXRwC0fkbjrM16zofbHoR@vger.kernel.org
X-Gm-Message-State: AOJu0YxshOCQy1Ex4eFLsWsC5F1YKVQrq89GH+Lv8Mld4QE+lscepUJN
	2hIMj+BvcVV1KTEsL98nydcjE8tZSInbMu54tc4SbMm4My2x9EEoigO9AA3e0OJ5VLFMBXk4YEs
	I4oyjmlYekQ==
X-Received: from dybpk10.prod.google.com ([2002:a05:7301:428a:b0:2e6:52c7:6f4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4308:b0:2dd:8a02:e8bb
 with SMTP id 5a478bee46e88-2e479110945mr6010380eec.27.1776643249432; Sun, 19
 Apr 2026 17:00:49 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:50 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-39-irogers@google.com>
Subject: [PATCH v1 38/58] perf failed-syscalls-by-pid: Port
 failed-syscalls-by-pid to use python module
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

Ported from tools/perf/scripts/python/failed-syscalls-by-pid.py to use
the perf Python module API.

Key changes:
- Used perf.syscall_name() to resolve syscall names instead of legacy
  Util library.
- Used standard collections.defaultdict for nested statistics
  aggregation.
- Used errno.errorcode for resolving error strings.
- Supported optional filtering by COMM or PID via command line
  arguments.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/failed-syscalls-by-pid.py | 121 ++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls-by-pid.py

diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/python/failed-syscalls-by-pid.py
new file mode 100755
index 000000000000..3873cff947bc
--- /dev/null
+++ b/tools/perf/python/failed-syscalls-by-pid.py
@@ -0,0 +1,121 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Displays system-wide failed system call totals, broken down by pid.
+If a [comm] or [pid] arg is specified, only syscalls called by it are displayed.
+
+Ported from tools/perf/scripts/python/failed-syscalls-by-pid.py
+"""
+
+import argparse
+from collections import defaultdict
+import errno
+from typing import DefaultDict, Optional
+import perf
+
+# Type alias to avoid long lines
+SyscallDict = DefaultDict[str, DefaultDict[int, DefaultDict[int, DefaultDict[int, int]]]]
+
+
+def strerror(nr: int) -> str:
+    """Return error string for a given errno."""
+    try:
+        return errno.errorcode[abs(nr)]
+    except KeyError:
+        return f"Unknown {nr} errno"
+
+
+class SyscallAnalyzer:
+    """Analyzes failed syscalls and aggregates counts."""
+
+    def __init__(self, for_comm: Optional[str] = None, for_pid: Optional[int] = None):
+        self.for_comm = for_comm
+        self.for_pid = for_pid
+        # Structure: syscalls[comm][pid][syscall_id][ret] = count
+        self.syscalls: SyscallDict = defaultdict(
+            lambda: defaultdict(
+                lambda: defaultdict(
+                    lambda: defaultdict(int)
+                )
+            )
+        )
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process a single sample event."""
+        if str(sample.evsel) not in ("evsel(raw_syscalls:sys_exit)", "evsel(syscalls:sys_exit)"):
+            return
+
+        comm = getattr(sample, "comm", "Unknown")
+        pid = sample.sample_pid
+
+        if self.for_comm and comm != self.for_comm:
+            return
+        if self.for_pid and pid != self.for_pid:
+            return
+
+        ret = getattr(sample, "ret", 0)
+        if ret < 0:
+            syscall_id = getattr(sample, "id", -1)
+            if syscall_id == -1:
+                # Try to get it from another field name if available
+                syscall_id = getattr(sample, "sys_id", -1)
+
+            self.syscalls[comm][pid][syscall_id][ret] += 1
+
+    def print_summary(self) -> None:
+        """Print aggregated statistics."""
+        if self.for_comm is not None:
+            print(f"\nsyscall errors for {self.for_comm}:\n")
+        elif self.for_pid is not None:
+            print(f"\nsyscall errors for PID {self.for_pid}:\n")
+        else:
+            print("\nsyscall errors:\n")
+
+        print(f"{'comm [pid]':<30}  {'count':>10}")
+        print(f"{'-' * 30:<30}  {'-' * 10:>10}")
+
+        for comm in sorted(self.syscalls.keys()):
+            for pid in sorted(self.syscalls[comm].keys()):
+                print(f"\n{comm} [{pid}]")
+                for syscall_id in sorted(self.syscalls[comm][pid].keys()):
+                    try:
+                        name = perf.syscall_name(syscall_id)
+                    except AttributeError:
+                        name = str(syscall_id)
+                    print(f"  syscall: {name:<16}")
+
+                    items = self.syscalls[comm][pid][syscall_id].items()
+                    # Sort by count (descending), then by return value
+                    sorted_items = sorted(items, key=lambda kv: (kv[1], kv[0]), reverse=True)
+                    for ret, val in sorted_items:
+                        print(f"    err = {strerror(ret):<20}  {val:10d}")
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(
+        description="Displays system-wide failed system call totals, broken down by pid.")
+    ap.add_argument("-i", "--input", default="perf.data",
+                    help="Input file name")
+    ap.add_argument("filter", nargs="?", help="COMM or PID to filter by")
+    args = ap.parse_args()
+
+    F_COMM = None
+    F_PID = None
+
+    if args.filter:
+        try:
+            F_PID = int(args.filter)
+        except ValueError:
+            F_COMM = args.filter
+
+    analyzer = SyscallAnalyzer(F_COMM, F_PID)
+
+    try:
+        print("Press control+C to stop and show the summary")
+        session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+        session.process_events()
+        analyzer.print_summary()
+    except KeyboardInterrupt:
+        analyzer.print_summary()
+    except Exception as e:
+        print(f"Error processing events: {e}")
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

