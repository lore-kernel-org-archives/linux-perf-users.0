Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD23EE1E7
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049361; cv=none; b=QV92vl9oM1UWNVb5q7w3Pdt3DSCfBAhcx9g0xp8iq0TEf9IuPdH2h1sNPWXyNZ6apw9gULsm8bqMbRMn9eLX8EdQaTHPbKNHeaBjV7aIKB3hjBoX0+nW7THeRnxz5T27VSVIfUS9dDocLpZiYci6n8u/cuFq0yOatfFDV6qAdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049361; c=relaxed/simple;
	bh=XroRpweqrFN2Waw0bQrCq2urTtV/aqXkb+903DZr6Hw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RAJR9YaRyJXxGBTEO3ARtKhN1CHXRDMrj2sDuAUniOXgqon9rBW85NGZl8VAD35cJeBFkjKxE8Nv9IGT6o5+2U4XK2D5wBjfTiYslQ7RR4ho56fiMto4p8J7xFeah40S6MgPOiByCU7EqCbpiigKAFR+9vEcYiD5HFmZXsiA/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGdpIUUp; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGdpIUUp"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so12543351eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049358; x=1777654158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWpfQspTuHMw7nQ4RI+J7bB0lzo0yDBeexGW3s3bnr0=;
        b=uGdpIUUpGyP5cUbb43neN2WGE/w9FafSo+RqeqEzOl63xtNLQh7d2fX9+WD7UtUHWC
         oXJUmc92BWKaGN3Y/3S/2r4bdYF9RAJpddqE9mxGmqJSXFf6w1kn1AuofiscVgDhK8wD
         aaPkpnpjyK0ReFhWB+jWJDDGKP8zNIs1LieNj3edMiYBlTD2rATWcNjBloGU5/0KJ0ym
         7BVDHf7ErZiQ8lY7eNWj3q0HePRKwUHxJY+c8mXItImCqPfnR39vsbqRyL7uThTfPu/5
         pAUrSR3I86aQx/kts2lyHLL27Qmi02hVwAZW3ZSBaHe9ThELRDAbymeaEeqt8AuxwMJa
         tbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049358; x=1777654158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWpfQspTuHMw7nQ4RI+J7bB0lzo0yDBeexGW3s3bnr0=;
        b=ZlIYQbdNxsE4vXM4Ow6E9wxl3zV1tNsVK18anTZL1d+uH96EoaiHkCamnebk++Tg3t
         irE3ZyIrKcWscPelfx4sji2dnCsh91w4OPkTadNoT/Wh+1KV6X2AYFFvQrpOEXKIg6hT
         J1Bz/3Ux7BDW36pWW2wSzHOf3q3yBthl+jN7sdVopdNi/is0SBLzEu9rdoDoo4iOStDS
         5/Zdxh3DhP2YdTzVpyrk6mbGgq7I0VxGzHPIGcCsg22KoXkRYN93vrRnI/VXeSEnE+P0
         EK9Xj7hVmkH+qxfOWHFIjxiUrulRUOgUGvj90ZXzVZDPISEsR0zcrA6boGViU8gudtrh
         dESw==
X-Forwarded-Encrypted: i=1; AFNElJ91aWAqvEEfMAbWHhvYOPdXE7id+vD0zzqxR0Qt1QrT7jRsuwbEmetjxX7Ew7Pxk8j7C+pdTfT89O4yK+BDuYp6@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVQcUojmABp7tZvy4WgGf4c31WFnFRmMWi2JNMN4RpMbg+2Q2
	OXnYamBV4OkYdxOASf9dlp/Qx0DszdwnONcCSvNVM97k6hUIoDm1N98LJ+CPJ+YCh3hLGRnfUm6
	ppJ520wlJzw==
X-Received: from dybso7.prod.google.com ([2002:a05:7301:6907:b0:2d8:e3a6:d707])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:168a:b0:2d1:815f:19c1
 with SMTP id 5a478bee46e88-2e479c0427dmr15814195eec.15.1777049357757; Fri, 24
 Apr 2026 09:49:17 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:06 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-45-irogers@google.com>
Subject: [PATCH v5 44/58] perf sctop: Port sctop to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
2.54.0.545.g6539524ca2-goog

