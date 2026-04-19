Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF03451B0
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643274; cv=none; b=t+kRx4v8mc4joZs+GQvAYsCl9FUr+xms/tcwKQTold8uLnMtS8ij3q/4+aBrXScVwyX6HzihLHZuqdhfK0u1nVjotFJA8DPzyNzfNBvBQ+RhZZgYj1grd9dMqvjI1+O19F0mYo25l/BkqyRc8KvgSNdij4h1YoSE0XvYdH9uOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643274; c=relaxed/simple;
	bh=+soTokGEH917iOExkd8/dQWx2KCkcesbIM1UXYHJxks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CCpj2+35gzup5Kplvx/K9LmS2tiz9vCEardA51KdXajkK+8lSgi9mVr3fY+POcD4nt2cyKpQWooD63z5LwuW0EKbBr+p7uQ1B5roozskpIZ8InomPH/BU8TWPX50FYprvJmMcVonli8K2WvivvwTkav+p5JV3e0YHHFkoWnkQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwgxig/A; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwgxig/A"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so3410540eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643270; x=1777248070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yu2K4DXlGrU0zQ+YamCMHLt6iJTp6z6SrZNyGBVGdFI=;
        b=dwgxig/AkjkY1gBGU6RexsD4Y8GIFxhyeG7asY931pyNV3yu3iMavnhYcB346i64JY
         BKqZ0OilA1My0Y0V4MRNKy9UlVlP0BGfbh37Mzgbto+jIpP0c4Qh2TWfN/QqucOUtJ5m
         RuF3eNA3LjYVWKxyDh+J+PFaNJT9bGTAt2uSAV3DlCQH0PQ6tZFcpJ5ExJf923Qb7gcJ
         IjHG6DOoOdbDuAJvUXKtiJLmlGvK/FjY+CfuR3vKu1pxazNB2QdWCuCgP6oW/nmnQGkU
         hftZOBfIVz0pAlQjr/avkQEY0PY3WZ7Ip0LrkgaD/aF5s6vpf2vznfU0FlliyctG6BIn
         RLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643270; x=1777248070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yu2K4DXlGrU0zQ+YamCMHLt6iJTp6z6SrZNyGBVGdFI=;
        b=CWhKWWGRA0vCNeS2KmR1rfLIZJIofLvEOkBcrtfmxEVhZqqQGiH4hQPeWELJ/jZxGg
         yKc6zFMzLV/b20I8lNQ9ZxqKmFf2qX2T8rk/CVuXb+DKUPqxucQmobixKEHr5867TblH
         Vi0Q55VSebkDIIoG5iOc1XIPrZF23yD/Bp7Oft9Qv9erb/gTxQ7s9F3UuS5KzHnOb8/d
         5YDfGG/j/j5gbbVUmT2+YIra6MRGPFiIG+ddB7qZrQ9VdC89xzzgBwBoek/6N4l5DHem
         HCfb4ootFS39OInhky/nWKmT18HfpIUePl4bcOzMAsPHbXPeCY008EYbGs67W86Spb2U
         JV0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ZaPnhkEXG1Y9gJ7ntNWFOKwv+x5dpnQ3f02jV1pxuAQ1lQ8m2CT/OScLM6Oga7jIdje7te22gVTp38ueExYwi@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcSohBTgv7tgXBAqKzfiagHqqqezFnl6Dlx9qwcA8xif+XeKk
	4KZgxOtyiaMrFL8ounYFKsoMz+nthmpMsKjEAHTJxgX4f0cbO7zjVtMWs46U9nr7Kng8+j8JI/H
	RTnRqMQ7zyw==
X-Received: from dyoy21.prod.google.com ([2002:a05:7300:3715:b0:2d7:dc51:72ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c0f:b0:2c1:6cfd:73ee
 with SMTP id 5a478bee46e88-2e47901911amr5693908eec.24.1776643269887; Sun, 19
 Apr 2026 17:01:09 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:59 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-48-irogers@google.com>
Subject: [PATCH v1 47/58] perf failed-syscalls: Port failed-syscalls to use
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
 tools/perf/python/failed-syscalls.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls.py

diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/failed-syscalls.py
new file mode 100755
index 000000000000..fe2a3fab0b7a
--- /dev/null
+++ b/tools/perf/python/failed-syscalls.py
@@ -0,0 +1,75 @@
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
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process sys_exit events."""
+        event_name = str(sample.evsel)
+        if "sys_exit" not in event_name:
+            return
+
+        try:
+            ret = sample.ret
+        except AttributeError:
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
2.54.0.rc1.513.gad8abe7a5a-goog

