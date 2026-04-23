Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5F3D3D0B
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916634; cv=none; b=V62QjwvVcq+RYDu+oET7o84zMrUY5J9VhDFBLjdk4RvpOAGoKZTX8CBQI4bxgIfPYvm+FqteV/RGDBZMMVqCnnZQkA9twjsoRdUCKZFhMrBwM2orZ6R7axLOjQzQnFk+R9JVINcIrKQfSkEJDCjERdbTy1VPBvDKXKD1ngdF8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916634; c=relaxed/simple;
	bh=n6BvA06tSpkd3LpKfsiugECZw0lT8BinBnN7xm4Ot50=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tDTJhApumN+htY4fWTzNiaFN4+AzCTDyeXaj2MYYgRR3ls3SvyL3594NjCDR5nlikXYhPfNFAgQGFZwo4D5Q7J6pij1gtJKGDoiWoLGnEfbS6dWfnIfmDF9r+1EoC7FR26yTedz31lu63yaQ/ppK7m0w7TcU2oSc2M89Y5P1RdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSt0mlm1; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSt0mlm1"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so9747115eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916632; x=1777521432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EH3X7h8/l/JSkjkiCISMMRzqqkX9HLaGF+oKvO7d0Ao=;
        b=iSt0mlm1zPZkEJ+Y7GjORmMj6ACDwckRUmuwl8LuXWn8jz4lrqap+Zv7nKr573e+Np
         n1PM8yBWJ1Gvd3JmcRHPVYj9AcWN4NFUjMoEzyCPBaHFEfKWpguacmm+T5IA2dcuAqu/
         zx7vPoFvocNg+vgRXlxBo4usdY/ErDDLF33kYHqiYr8Rw1fSISSHC9pbw375GEcGBDF2
         QhVsWge2U3qVr3UsVeK8svNifYUx1Cb2llBHGvI9JF9v+jYUkimmgvT3kA5N7qeZp22L
         o9aZCeFWRDZ5pBl00g6V++fiClB4F0rTXXjz+AVt66UZTKKhwtkGp+vloLs+6Fevwp62
         /Y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916632; x=1777521432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EH3X7h8/l/JSkjkiCISMMRzqqkX9HLaGF+oKvO7d0Ao=;
        b=igDYRin1bq9V5oqU5Lq2dxhuKURLK9dessMyb9k3UAcCsfrLWo8SJL8xuBY4hzA9ak
         u1Psl70DBO3RcXHIM47jG2lDDQ5fdHVp3Fl8Yzs5BecL5O1AdczwqqQ2qumaVF10Zdh2
         PZz6Fwg8lVJN49wh5vv1iB26NT6jEeHdaSx/3X/XdA2BmaQKDY+eKD968CdwTR4TmIBN
         INwNGCFMeuCW2VgYVrdV8m+SsPwLZnp/m5cGTuvIXm+1b3RqZWTq6L9rvWoa0xghhOuO
         XDeg5KlvFYBW5QO7Y/AqN+AMIcPPpuP6DEcbCaAxCzHHslGh58hm8kYwLctA2SmDdS0l
         U2GQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dj1scMS67Ct3JFnFsIvXGBFgDl7e3JvQguzuwWtCuDwakd8CVZEbI8Mq2l9WhnJnfY+LVQixq6f8lLtGm4PWM@vger.kernel.org
X-Gm-Message-State: AOJu0YxSMHkxirhqAQZPIDnTe/QzU/x7NMrBWGXKC8h/+4Zgr3ZlxOsB
	H9jnbB1qZ8rKu5tCl4b17RESUtnKXVZ8nOMuMHHYlFQak9rFfsE9tRPTcLN1aJxpyOCP+7glKin
	Hd2waSzfkYg==
X-Received: from dycqb7.prod.google.com ([2002:a05:7300:fe87:b0:2df:9320:a159])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ca4:b0:2e2:d94d:6186
 with SMTP id 5a478bee46e88-2e477c9aad8mr11782881eec.11.1776916631917; Wed, 22
 Apr 2026 20:57:11 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:11 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-45-irogers@google.com>
Subject: [PATCH v2 44/58] perf sctop: Port sctop to use python module
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
v2:

 - Fixed Missing Final Batch: Extracted the printing logic into a
   dedicated print_current_totals() method. Updated
   print_syscall_totals() to call this method one last time after the
   stop_event is set, ensuring that events accumulated since the last
   interval are not dropped.
 - Fixed Offline Mode Intervals:
   - Added an offline flag to SCTopAnalyzer to distinguish between
     live and offline modes.
   - In offline mode ( -i option), instead of relying on a wall-clock
     timer in a background thread, process_event() now checks the
     sample timestamp ( sample.time ). It triggers a print when the
     trace time advances by the specified interval.
   - Only starts the background thread when running in live mode.
   - Ensured the final batch is printed in the finally block for
     offline mode.
---
 tools/perf/python/sctop.py | 174 +++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100755 tools/perf/python/sctop.py

diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
new file mode 100755
index 000000000000..d7ac922da510
--- /dev/null
+++ b/tools/perf/python/sctop.py
@@ -0,0 +1,174 @@
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
+    def __init__(self, for_comm: str | None, interval: int, offline: bool = False):
+        self.for_comm = for_comm
+        self.interval = interval
+        self.syscalls: dict[int, int] = defaultdict(int)
+        self.lock = threading.Lock()
+        self.stop_event = threading.Event()
+        self.thread = threading.Thread(target=self.print_syscall_totals)
+        self.offline = offline
+        self.last_print_time: int | None = None
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
+        syscall_id = getattr(sample, "id", -1)
+
+        if syscall_id == -1:
+            return
+
+        if hasattr(self, 'session') and self.session:
+            comm = self.session.process(sample.sample_pid).comm()
+        else:
+            comm = getattr(sample, "comm", "Unknown")
+
+        if name in ("evsel(raw_syscalls:sys_enter)", "evsel(syscalls:sys_enter)"):
+            if self.for_comm is not None and comm != self.for_comm:
+                return
+            with self.lock:
+                self.syscalls[syscall_id] += 1
+
+        if self.offline and hasattr(sample, "time"):
+            interval_ns = self.interval * (10 ** 9)
+            if self.last_print_time is None:
+                self.last_print_time = sample.time
+            elif sample.time - self.last_print_time >= interval_ns:
+                self.print_current_totals()
+                self.last_print_time = sample.time
+
+    def print_current_totals(self):
+        """Print current syscall totals."""
+        # Clear terminal
+        print("\x1b[2J\x1b[H", end="")
+
+        if self.for_comm is not None:
+            print(f"\nsyscall events for {self.for_comm}:\n")
+        else:
+            print("\nsyscall events:\n")
+
+        print(f"{'event':40s}  {'count':10s}")
+        print(f"{'-' * 40:40s}  {'-' * 10:10s}")
+
+        with self.lock:
+            current_syscalls = list(self.syscalls.items())
+            self.syscalls.clear()
+
+        current_syscalls.sort(key=lambda kv: (kv[1], kv[0]), reverse=True)
+
+        for syscall_id, val in current_syscalls:
+            print(f"{self.syscall_name(syscall_id):<40s}  {val:10d}")
+
+    def print_syscall_totals(self):
+        """Periodically print syscall totals."""
+        while not self.stop_event.is_set():
+            self.print_current_totals()
+            self.stop_event.wait(self.interval)
+        # Print final batch
+        self.print_current_totals()
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
+    analyzer = SCTopAnalyzer(for_comm, interval, offline=bool(args.input))
+
+    if not args.input:
+        analyzer.start()
+
+    try:
+        if args.input:
+            session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+            analyzer.session = session
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
+        if args.input:
+            analyzer.print_current_totals()
+        else:
+            analyzer.stop()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.rc2.533.g4f5dca5207-goog

