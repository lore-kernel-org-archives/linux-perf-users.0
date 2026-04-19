Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B11341AB1
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643266; cv=none; b=ob2VOxuyUhUNPytNEt54QXsVCBedeg0aGS1EEJna0Z9GioFSG5YImzLQTg/P9AK81iSpRg9zmFRtXUHHk1zcsh6VK1QMfMXzdBZtpwBJkv6BEh/zAncrukvT65SPezEdsgHT10mVjIZb3CH0cTWJG3ILBOSDnY0IJmhfHOGEHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643266; c=relaxed/simple;
	bh=rMqFIYIkvaaGFeMjdFBR/Cc+MYTocflKxBPL52q09TE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kLbq3tzsGRAeQxuxRtXhcA2ckK5oKhYqK9onmSPGYcRSASTOXYEcHuvIeEfIwPEwmXF2ISqjJtT0XW88+4MB3yr3AUq1wR2Gm+DDLauxRdavje0VX2S9lXRHKYvVRSK0To60SMNg+p3zOMmGvGW2tTSi+IAef+rKd46v9uvw+Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzUpZLZq; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzUpZLZq"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d93379001eso819389eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643263; x=1777248063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6Z3uLzqcBo0688zE8JUqYPeXg2WRmZzgQJbIPTtO/o=;
        b=dzUpZLZqXjfIbc+Va1mjx/zRfsLTjZ+bCtb3/aN97uedsAC+vQ6aPibnF1ZPZxVgBL
         0Z6c5fAvXbKiCd5r9GMeAPY0MCHgnovF7rSH5oq0+/cSdmvKCx28S9HYQ+qCQRLzF+vl
         y4l6cC3rtIzhi4m1zJeE9ZzmnvhAebIumPhWJji4/kRPjlkevvBQT6pxD35+GyOOJYC0
         eic9QdAxNR1s09TUIq+/WqpXwk5+iLsnhRTglJHpA1jO0EltwD/MiHWlhsCfidrNVw9u
         E6STuG0bvf9NZkj6czTotFJ+qm+DBZMnie6l5bsbhLE9/scOSZh2O+8CafpccDmlogh7
         olEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643263; x=1777248063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6Z3uLzqcBo0688zE8JUqYPeXg2WRmZzgQJbIPTtO/o=;
        b=SoXCSWWJGMllp5TG6sDLK1n8zCPlwbwhIVXCaYPfLNXC1XNcsfTiq6vacQA9LqNv0k
         0IMi9cDeIO0yOddYwNnV2S1KpBxMG6qkrRoW54dkFRu5kUTfxQOPw7w4qBGap+GruuOZ
         xGZBcHTE/1bfSO1djNSfRhbu90eb1u5dRKoOYttIUceJXa7kUlu+tMRXESBKZN76fbxb
         TIOddwU46QCaUCCCktuGmD0Ub6v3GI3K5tqrDxOMTUTv0gbVB5/U5jqU2c8qVwxgn7NO
         6bv+PNsncAK9csUOWQg3JosndrCyqQP+/T8V+zUs4MiUv+tHUR8GzW3KUmAHVsIOvMCl
         puBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2r9K0pv6ZaVvL5aJs5b+bkAkTGeuFKCqYJTdM5TUkdZ29iaTJ15LaJQXeiqElOSEbjkup3eqHELxNxH02v78j@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSVMeUbXEHLcErEZlJ6SGqCAzJEDFm9pAskXoL/wrQVEM5VgO
	T0xNpahaBDzDV7d2yjr7+1fjCanMWZ0wux79zBhF1XPSPTjMip3eEwj79towwqEEOftFp2TmD0/
	Gkdydfuo7iw==
X-Received: from dycpp12.prod.google.com ([2002:a05:7301:dd8c:b0:2dc:7d1e:d0e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ed18:b0:2d8:7302:d3b
 with SMTP id 5a478bee46e88-2e4788392e5mr6224287eec.18.1776643262867; Sun, 19
 Apr 2026 17:01:02 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:56 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-45-irogers@google.com>
Subject: [PATCH v1 44/58] perf sctop: Port sctop to use python module
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

Port sctop.py from tools/perf/scripts/python/ to tools/perf/python/,
refactoring it to use a class-based structure (SCTopAnalyzer) and the
perf.session API.

Also add support for live mode using the LiveSession helper when no
input file is specified, with a fallback strategy for tracepoint names
(raw_syscalls:sys_enter or syscalls:sys_enter) to support different
systems.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/sctop.py | 149 +++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100755 tools/perf/python/sctop.py

diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
new file mode 100755
index 000000000000..6daa5f0a3b21
--- /dev/null
+++ b/tools/perf/python/sctop.py
@@ -0,0 +1,149 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+System call top
+
+Periodically displays system-wide system call totals, broken down by
+syscall.  If a [comm] arg is specified, only syscalls called by
+[comm] are displayed. If an [interval] arg is specified, the display
+will be refreshed every [interval] seconds.  The default interval is
+3 seconds.
+
+Ported from tools/perf/scripts/python/sctop.py
+"""
+
+import argparse
+from collections import defaultdict
+import sys
+import threading
+import perf
+from perf_live import LiveSession
+
+
+
+
+class SCTopAnalyzer:
+    """Periodically displays system-wide system call totals."""
+
+    def __init__(self, for_comm: str | None, interval: int):
+        self.for_comm = for_comm
+        self.interval = interval
+        self.syscalls: dict[int, int] = defaultdict(int)
+        self.lock = threading.Lock()
+        self.stop_event = threading.Event()
+        self.thread = threading.Thread(target=self.print_syscall_totals)
+
+    def syscall_name(self, syscall_id: int) -> str:
+        """Lookup syscall name by ID."""
+        try:
+            return perf.syscall_name(syscall_id)
+        except Exception:  # pylint: disable=broad-exception-caught
+            pass
+        return str(syscall_id)
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Collect syscall events."""
+        name = str(sample.evsel)
+        comm = getattr(sample, "comm", "Unknown")
+        syscall_id = getattr(sample, "id", -1)
+
+        if syscall_id == -1:
+            return
+
+        if name in ("evsel(raw_syscalls:sys_enter)", "evsel(syscalls:sys_enter)"):
+            if self.for_comm is not None and comm != self.for_comm:
+                return
+            with self.lock:
+                self.syscalls[syscall_id] += 1
+
+    def print_syscall_totals(self):
+        """Periodically print syscall totals."""
+        while not self.stop_event.is_set():
+            # Clear terminal
+            print("\x1b[2J\x1b[H", end="")
+
+            if self.for_comm is not None:
+                print(f"\nsyscall events for {self.for_comm}:\n")
+            else:
+                print("\nsyscall events:\n")
+
+            print(f"{'event':40s}  {'count':10s}")
+            print(f"{'-' * 40:40s}  {'-' * 10:10s}")
+
+            with self.lock:
+                current_syscalls = list(self.syscalls.items())
+                self.syscalls.clear()
+
+            current_syscalls.sort(key=lambda kv: (kv[1], kv[0]), reverse=True)
+
+            for syscall_id, val in current_syscalls:
+                print(f"{self.syscall_name(syscall_id):<40s}  {val:10d}")
+
+            self.stop_event.wait(self.interval)
+
+    def start(self):
+        """Start the background thread."""
+        self.thread.start()
+
+    def stop(self):
+        """Stop the background thread."""
+        self.stop_event.set()
+        self.thread.join()
+
+
+def main():
+    """Main function."""
+    ap = argparse.ArgumentParser(description="System call top")
+    ap.add_argument("args", nargs="*", help="[comm] [interval] or [interval]")
+    ap.add_argument("-i", "--input", help="Input file name")
+    args = ap.parse_args()
+
+    for_comm = None
+    default_interval = 3
+    interval = default_interval
+
+    if len(args.args) > 2:
+        print("Usage: perf script -s sctop.py [comm] [interval]")
+        sys.exit(1)
+
+    if len(args.args) > 1:
+        for_comm = args.args[0]
+        try:
+            interval = int(args.args[1])
+        except ValueError:
+            print(f"Invalid interval: {args.args[1]}")
+            sys.exit(1)
+    elif len(args.args) > 0:
+        try:
+            interval = int(args.args[0])
+        except ValueError:
+            for_comm = args.args[0]
+            interval = default_interval
+
+    analyzer = SCTopAnalyzer(for_comm, interval)
+    analyzer.start()
+
+    try:
+        if args.input:
+            session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+            session.process_events()
+        else:
+            try:
+                live_session = LiveSession(
+                    "raw_syscalls:sys_enter", sample_callback=analyzer.process_event
+                )
+            except OSError:
+                live_session = LiveSession(
+                    "syscalls:sys_enter", sample_callback=analyzer.process_event
+                )
+            live_session.run()
+    except KeyboardInterrupt:
+        pass
+    except IOError as e:
+        print(f"Error: {e}")
+    finally:
+        analyzer.stop()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

