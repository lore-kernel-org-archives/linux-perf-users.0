Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F528322B7D
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643274; cv=none; b=nun7zecGAOrkF+aembXPnhs7Azuooiamby7HlXJ3WBP0jrRJYpVCsL1ZIdovF4h5gfbIaKI+Q3ApT5Zt2X7oj0eKMKFZPbRq64sxYcyuV6GnkQSROUeRtJxNW7JEzgaNPHJ+7EWHwCtrkN8Y5eNeOOjMXR++8ZM+44Juicmno6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643274; c=relaxed/simple;
	bh=R3JKOqhEu8sgwJM4Xt3epq3GmKysXNDeBggtXdx0Q74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wzkv6ehnDzdynGGsAzX8YKRicoEok9rywCDN4W2lOMQsc5xvPY5zZcUchMyxspvlbq6MLbPkZi2kJBuWNTubl5rzCK9QswL7apEcAawABdoQ33XQZ42AHfP8Fwj67y4+w3fxA7sxVrzLUoPt1ZjQ88L3FUZVUj9I9vQ6Q4i23nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e019ViEj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e019ViEj"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b249541063so20864555ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643273; x=1777248073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5T42Jp6ZOPaVIxNDv3o/B9XfowWGowL4d8glPuDAX8=;
        b=e019ViEjYNmmHxgovja/FFr24xpvH32MmGstqi1GLZuuQLXS63QY6qjvq7GOd8do69
         81V5YGcYftqbTlZr1TNYSgJTy+VbqVZH+2DEGXp81pYU5DEGIvB/BigrRY2l+lA+6at/
         KaOaHWShzqOvFOiFhKfEXUxfqBsXjeQxPYRmn3lqNbNb/dxzcHe5Gs7QWsmat1urr15Q
         wLvNcXW3JGjkkHpnMtDWzxeQtIL+Qd+4pVIYRNzhfi5igf1d60A+PhsKBAv0LuQSSXBB
         q6qZ9ngyZS0o4OQDGCvBoadkqNJbdekjWRchtRBnoyCOrQ2u2A9ue1fKg6W4UsbflRG0
         B4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643273; x=1777248073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5T42Jp6ZOPaVIxNDv3o/B9XfowWGowL4d8glPuDAX8=;
        b=AadB1FJbN0KU3+9XOmciDSMes86fR4i1kBCfb76hgaZxu8eWEpTXfPg2UQWO74l7SX
         vKXaATY96I2YD6NMYVssPifrgee+H76WLpnu83Fp0NOizMFhQtx6VdQouaD15dEL3KXl
         4EOhsBpLATbh4+hPo/uAiMoLSjN2rHP0enSgULQvGoqqsDrwUJEV8jKfK5XqyRmZ/adg
         hGdfB5OjZbMNAOrRQWW4XOZkA22PPBlyrOka3lOgdGA+q5WytjDLLLaf2is0GvwZH0VT
         re+rEUXoL0Pjtz8gRHEpOsBgGAm4SOvwST6VtuUCncvG9dRrXY2SRRyAMa9yhe/HLIzk
         ljbQ==
X-Forwarded-Encrypted: i=1; AFNElJ93FDo4nQEF9+CcFqUwsi160BvMvEoTlWdh4qckEgoJjk06dn4DpGH1Ltyt0vxuOiYrmCqiljv9PmCPFEQce5JF@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFYHi4URyNGUKomhA5DRtiLJBCky5pMQTTP8YOtxQzvp+8BIm
	Bwx+5gYLVN3IkCpLdwqJOk6kEL6KWEIZAxXDEiyxoM6XTt3lzH6rH02PeG90soaFYpiiC/zLbAp
	XlBvUMGa7qA==
X-Received: from plhy8.prod.google.com ([2002:a17:902:d648:b0:2ae:bcb3:c8d1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:6905:b0:2b2:49a7:a5bd
 with SMTP id d9443c01a7336-2b5f9e770c5mr78194615ad.1.1776643272446; Sun, 19
 Apr 2026 17:01:12 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:59:00 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-49-irogers@google.com>
Subject: [PATCH v1 48/58] perf rw-by-file: Port rw-by-file to use python module
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

Port the legacy Perl script rw-by-file.pl to a python script using the
perf module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing.

It tracks read and write activity by file descriptor for a given
program name, aggregating bytes requested/written and total counts.

Complications:
- Had to split long lines in __init__ to satisfy pylint.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/rw-by-file.py | 103 ++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100755 tools/perf/python/rw-by-file.py

diff --git a/tools/perf/python/rw-by-file.py b/tools/perf/python/rw-by-file.py
new file mode 100755
index 000000000000..4dd164a091e2
--- /dev/null
+++ b/tools/perf/python/rw-by-file.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Display r/w activity for files read/written to for a given program."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional, Dict
+import perf
+
+class RwByFile:
+    """Tracks and displays read/write activity by file descriptor."""
+    def __init__(self, comm: str) -> None:
+        self.for_comm = comm
+        self.reads: Dict[int, Dict[str, int]] = defaultdict(
+            lambda: {"bytes_requested": 0, "total_reads": 0}
+        )
+        self.writes: Dict[int, Dict[str, int]] = defaultdict(
+            lambda: {"bytes_written": 0, "total_writes": 0}
+        )
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = str(sample.evsel)
+
+        pid = sample.sample_pid
+        assert self.session is not None
+        try:
+            comm = self.session.process(pid).comm()
+        except Exception: # pylint: disable=broad-except
+            comm = "unknown"
+
+        if comm != self.for_comm:
+            return
+
+        if "sys_enter_read" in event_name:
+            try:
+                fd = sample.fd
+                count = sample.count
+                self.reads[fd]["bytes_requested"] += count
+                self.reads[fd]["total_reads"] += 1
+            except AttributeError:
+                return
+        elif "sys_enter_write" in event_name:
+            try:
+                fd = sample.fd
+                count = sample.count
+                self.writes[fd]["bytes_written"] += count
+                self.writes[fd]["total_writes"] += 1
+            except AttributeError:
+                return
+        else:
+            self.unhandled[event_name] += 1
+
+    def print_totals(self) -> None:
+        """Print summary tables."""
+        print(f"file read counts for {self.for_comm}:\n")
+        print(f"{'fd':>6s}  {'# reads':>10s}  {'bytes_requested':>15s}")
+        print(f"{'-'*6}  {'-'*10}  {'-'*15}")
+
+        for fd, data in sorted(self.reads.items(),
+                               key=lambda kv: kv[1]["bytes_requested"], reverse=True):
+            print(f"{fd:6d}  {data['total_reads']:10d}  {data['bytes_requested']:15d}")
+
+        print(f"\nfile write counts for {self.for_comm}:\n")
+        print(f"{'fd':>6s}  {'# writes':>10s}  {'bytes_written':>15s}")
+        print(f"{'-'*6}  {'-'*10}  {'-'*15}")
+
+        for fd, data in sorted(self.writes.items(),
+                               key=lambda kv: kv[1]["bytes_written"], reverse=True):
+            print(f"{fd:6d}  {data['total_writes']:10d}  {data['bytes_written']:15d}")
+
+        if self.unhandled:
+            print("\nunhandled events:\n")
+            print(f"{'event':<40s}  {'count':>10s}")
+            print(f"{'-'*40}  {'-'*10}")
+            for event_name, count in self.unhandled.items():
+                print(f"{event_name:<40s}  {count:10d}")
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
+        self.print_totals()
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace r/w activity by file")
+    parser.add_argument("comm", help="Filter by command name")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = RwByFile(args.comm)
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

