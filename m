Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518223D9DA8
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916640; cv=none; b=TVXv3uBAVIKrflMYuEXY3FRqmZHJxEPL4Auqte2pO1X547AWegSVDbtKpCtNgiuRSEkPfuQGc3SzAH0u0Py4JYSj1VW5hCnRx8liBnHV75tXZ71jIL8f2VloJ6ohDDj0jSjkCLX/sxpXAgzZQo0ebOjRaBjTD0w57teIpPCfeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916640; c=relaxed/simple;
	bh=8L3pWcvrZlwU9FCkhipBlN7VEA72eUbhAtwnbnYEv98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fd0VrJ741PpyU8ZPsi2m+UHk51WH3Uc4l02qojYeRv+294BKuQXoRHCe7SlCrMIXsIWcU+hiGr0T2D/4SH7W2UDv3koVS2xel4l6ds+9zI1r8nUBd4kjIJcYDk30bqCsXmEmSEA5m11H8FcfiGskq7Ki01a1SgxCmPe++0pvdqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2hQq03g; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2hQq03g"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c91ef7009so10464901c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916638; x=1777521438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeTpPm0LatWfpwEFzMHs4FJxcdU49VvKm+U0tJhYnl0=;
        b=e2hQq03gk7gcSQ+Zy4GL+YOsKZbc7bzYKVp+GvjUpS0qHcemBueN8Oh7c/ObFYLHkU
         UWi/8JwoDGIIJ9mUBcO0NHXwLSP/fBK3F+n2iaTr2RnsRnWVYFH6gyfwJ4NX02AC2HKs
         qMHfQjOG88n8U3pwShmU/zQrjgA7CQtuT/ULV3dFkaJVRHqi1XxpVig0cKLOUiBbVRPS
         rD5TQ8NsxRZ+RdKIwH8Kz0wqX6tXNbBIwOHCUcR+RLd8YjLHslMjqEYj0OpMC+cgR0Xk
         18lb0FQg9BPX2X/GKYJVE/UWVlPGQL2j9LtKIF/maTYhMMo7OvyT5PkmABwYr5YQKtbb
         FEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916638; x=1777521438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeTpPm0LatWfpwEFzMHs4FJxcdU49VvKm+U0tJhYnl0=;
        b=UVQ9dFvmOy52S4QoQcPqCaSVHOb3GPgtYX/prCAP+4NocKWhXeQYAxTCnC2fsOOBbp
         26nLolifhyBPbTwuTPYIRIAG2i9kQkY9kqgrpBfhCXqkGyWxS+Y/wfpWDA50qyjuok2T
         voUPfN0UD96wpU1sPcrLQfMyLto3foR+ZC9y2hvwGXKXixA5fb7eiTxr7RaKKHSIHaRV
         tuz4q1eHnUDrRw/8mf7oz5EX4Ngfuoz84pg1AVvb9dERkcJCQi9LL9sMbPMhfnDvjves
         z5imVcjFGqKSGsE13pzPKlqeNa0SqFK5uybwr7fpUEkqSOlEuDxXhw+TDf5I/7M5mmBu
         pbqA==
X-Forwarded-Encrypted: i=1; AFNElJ+Zx3g9g5iW4Cu1xQPg6kvkscnmDlqDbe2t6MBQKmhhTKt+HnfYb+/Nqh/tVHQBhpHJqw3lMcHlFBmGrF0GMYyF@vger.kernel.org
X-Gm-Message-State: AOJu0YzWzYoYZ0ty2owC+LKnNuyWRl+vMegvpNlL4+YA944S6RQrlCns
	l9uxysOX40dTAAtGOAXrccBKje2NnJO4wkdP6Z29UGga5/7yZ/KfrF9NyKsU2HPN6Ut0QuEDTnU
	QDN6/bVF8yw==
X-Received: from dlbui16.prod.google.com ([2002:a05:7022:3d10:b0:12d:b27b:7405])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e09:b0:12c:3d30:37c5
 with SMTP id a92af1059eb24-12c73f75976mr15532981c88.12.1776916638118; Wed, 22
 Apr 2026 20:57:18 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:14 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-48-irogers@google.com>
Subject: [PATCH v2 47/58] perf failed-syscalls: Port failed-syscalls to use
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

Port the legacy Perl script failed-syscalls.pl to a python script
using the perf module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing, making it a standalone script
that reads perf.data files.

It filters for sys_exit events, checks for failed syscalls (where
return value ret < 0), and aggregates counts per command name.

Complications:
- The script is designed for file-based processing using perf.session.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/failed-syscalls.py | 78 ++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls.py

diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/failed-syscalls.py
new file mode 100755
index 000000000000..178c1458430a
--- /dev/null
+++ b/tools/perf/python/failed-syscalls.py
@@ -0,0 +1,78 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Failed system call counts."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional
+import perf
+
+class FailedSyscalls:
+    """Tracks and displays failed system call totals."""
+    def __init__(self, comm: Optional[str] = None) -> None:
+        self.failed_syscalls: dict[str, int] = defaultdict(int)
+        self.for_comm = comm
+        self.session: Optional[perf.session] = None
+        self.unhandled: dict[str, int] = defaultdict(int)
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process sys_exit events."""
+        event_name = str(sample.evsel)
+        if not event_name.startswith("evsel(syscalls:sys_exit_") and \
+           not event_name.startswith("evsel(raw_syscalls:sys_exit_"):
+            return
+
+        try:
+            ret = sample.ret
+        except AttributeError:
+            self.unhandled[event_name] += 1
+            return
+
+        if ret >= 0:
+            return
+
+        pid = sample.sample_pid
+        assert self.session is not None
+        try:
+            comm = self.session.process(pid).comm()
+        except Exception: # pylint: disable=broad-except
+            comm = "unknown"
+
+        if self.for_comm and comm != self.for_comm:
+            return
+
+        self.failed_syscalls[comm] += 1
+
+    def print_totals(self) -> None:
+        """Print summary table."""
+        print("\nfailed syscalls by comm:\n")
+        print(f"{'comm':<20s}  {'# errors':>10s}")
+        print(f"{'-'*20}  {'-'*10}")
+
+        for comm, val in sorted(self.failed_syscalls.items(),
+                                key=lambda kv: (kv[1], kv[0]), reverse=True):
+            print(f"{comm:<20s}  {val:10d}")
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
+        self.print_totals()
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace failed syscalls")
+    parser.add_argument("comm", nargs="?", help="Filter by command name")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = FailedSyscalls(args.comm)
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.rc2.533.g4f5dca5207-goog

