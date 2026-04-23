Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FE3AF641
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960707; cv=none; b=OU8NnQNIAdnILpSnXkClVOyNC/lWuYifC1aR2ED2f115NYOwJn6TW+qzjVW5zMiYEB4pMY6EGOn8j1tyP+HO/RmICa+fyXXFjynIg/EasIBlvZLHrhcOKrXyrb1cL2akNOUGj+ACd8nTo3MI2E3lerG+qSaiUb7BIeaqAM/D2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960707; c=relaxed/simple;
	bh=8L3pWcvrZlwU9FCkhipBlN7VEA72eUbhAtwnbnYEv98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cf38H18L+dkgCTYDG7VhNgo6RTMqkKTe7i7bTp2mCEFkbnWvhuz8m0eWX19PWcB0Wy9kXl2OVGzJNJryFpVzEqXd/Jq1fJnqjSHR6mQT20AucyBjif3Finvd4CgpG8kIG+XxkpdhsUxN1kH+CP8AARYS591T6KvLE1rR56MPZfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NcTNGM6v; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NcTNGM6v"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c35f2c09dso8335133c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960705; x=1777565505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeTpPm0LatWfpwEFzMHs4FJxcdU49VvKm+U0tJhYnl0=;
        b=NcTNGM6vY/mMTyuBmYPYAzZwjvkWlmhuMjCkpu9b2YJzu1IvsJVA2wB1cy2vgT0k89
         ZJMR9mH3+gdMDMmzWv9lqjv/CaBJF9kQYVaIUV4hJgEJVJ8ps7/nIipfFbXetexzXXgf
         4wbgJEiQTn2VYLbGVwGkq2IGJYwz/AG1w0Aw8Ni5s6jDouczWNw448zHguBmTd/Ug9MY
         G1Ty5PpeTLA4v+kzmNG8ybJHH6qTLIGpx8yh3tNx5yPICUoUda4U4RzvzBoU2kvkYIai
         S0D/81tQp1OaOz//J+sVrsOMws+Dbs+vUi/SRmzUz1gCm5hcWI3KiZonfPzILmFn9QNl
         sjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960705; x=1777565505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeTpPm0LatWfpwEFzMHs4FJxcdU49VvKm+U0tJhYnl0=;
        b=RYLeqHDQKsuBavJkIO6AL8PufUNywxh+L71BTFzm+KTG78PEYRXIpV79bz3bgIBhBi
         aoqRpuIeznuOqBwTreaBm/do2sgou0x/uMNgJflSIzLoeMuxunDJCA1O68m7kw/TAzEd
         sJg+FoZaRq/WmpUNVUV3mjn2njUA9FgdsJ9YB/iS5YRJGrQCWotQ6X6KOqpcTfJEanuc
         b6RpNcZOUyoDZtD0n8WX6+Bq8Xuuv1ucgM5ZY8VuekM666Xm4JAzPN4of2dBkg5C7CCh
         iqJfa0F1pYuWRJGbm95isUSzpXBjIYrmyB2+m5KdYCp0IJjoscLRf+c0L5JsCdx5Nosx
         5fiw==
X-Forwarded-Encrypted: i=1; AFNElJ+7ppIU8CmjxmkBNOoRK0rFgjFXLOCI3/9xQjWJRnysY28QpQ2Vh1s9YxT3fESaDV5sXLNgR8N01ic70Oq9WOQJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7liTU6BPxIG3UaPiZtBkl2H5kidU7clO+cRBZKaDRiKg+NVs8
	nq0BlBJzdMfzhQ10GNcaJHb75uKz03oOo/J4ctbg/ZPVGM0BjPQroy32j9oCsQB/kACUTUNpZJm
	AeYX8q6H1AQ==
X-Received: from dlbpv3.prod.google.com ([2002:a05:7023:903:b0:12c:9097:2891])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e22:b0:119:e56c:18ab
 with SMTP id a92af1059eb24-12c73f90bffmr14071745c88.19.1776960704781; Thu, 23
 Apr 2026 09:11:44 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:53 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-47-irogers@google.com>
Subject: [PATCH v3 46/58] perf failed-syscalls: Port failed-syscalls to use
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

