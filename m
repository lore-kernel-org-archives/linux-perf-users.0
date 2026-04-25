Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E938E12B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157112; cv=none; b=jRaIb1rPU9CxwruYgMhjfFK17UXwakk7rAaPUbO9M1e6OHJZNLAcHGFjudBwSlMc2ooQMShfNkppZ1hm3jfO0DGn2Tblb4t1tR1H3AhAEWDcA6BooSbkAewyjbcnxB9IzFqwnHz8trckdHwn/Kr8KetNUFxS6RMwJ67AIJ+nLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157112; c=relaxed/simple;
	bh=3OzyHhDflAGnhfcPd/Cdhu5Dl9jWi1PgdqDYN/G82GU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LW/PGVGG3dQlssh0jipxLT9y0aosYHm7xjyHrYp6Yac4quik+hwg28XfgQTrU6Ts+YHztjZwacM1I0WBZTxb+2oyHfum+0ReHleZsSL3DHHrlfVCJFW9KMZWEnyH8QjPlC/ErBytG77Ni2EgVPT6Uv4yicbJDqrnuCBPGviil08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zg0CjAhO; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zg0CjAhO"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dbf4f678eso132021c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157110; x=1777761910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1LwLJ/S5+yYNXf1JRm+e96X+YoT2PYO4quJ+4E0ZMc=;
        b=Zg0CjAhOiPCxsgVHITSzXIiKxPTO5tFxf/M7aZa9jcsF/6gkTU4/K7vwR8ZWk004hd
         ady6nasoHqXc5rr5IBoRPRPaEFDJrpMGGf3KigEowZbViMEam3779j46bXhhu6PRF7B8
         8ppA8yj18GhoSd9y2x2Ek38V0AVS3VMUmS2nvG6myRyBdKu0a1qC/YnKa3UNOvt6Ex0X
         yLth/L27U8rBR8L9hJTSsOzt2Q6dPeLTNUIsz7txqv74O6jITWF4rtRxR+bLaYSEl6DU
         R0/CdA3PsqsQvimk+9EpAC7ff4keoRr/lyN8d+vP8tOELiLsqWkhGTdg3IjqczqfCjVm
         or1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157110; x=1777761910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1LwLJ/S5+yYNXf1JRm+e96X+YoT2PYO4quJ+4E0ZMc=;
        b=He+mJdKLoSf+QsNCF6g1p0iYv+6igIfrl0NKbrHt5hWTvmg6RuQnZNjED+L62yg++t
         yG13CjZ8ru23m4/YmaWH1q8X4+mds/amJ/JfTAXdTDdyvd9gKPpcMuY0k7zQoshCrmNu
         T84d3w3Byi1pdheixDaKwnnsy5qtDHupNoox+ckNTF8RY6oRMq78T5O6lMkE/IZgy+sK
         tZM5cdR1eZUQb1K9YpiWilUxPzrkYN8bVXR8QP/o75Pinm7ymyfTICnK2ERVOViYCg8d
         KtaD1+fCsDXT5Arq9kl0lVQr6dnXL7svm8m48aoWRZaUnyrx03IWqaPHvSUiUONHyYL0
         8dTA==
X-Forwarded-Encrypted: i=1; AFNElJ9J1ztzCKJEWSZRG2tZ5DLH772/EdpkmSZg818NOOZEU6jCr2GnsDRrLxikqzmvJrSukxbwJyohPkmAM+KW63pd@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/C/dUM+S0SWZgmtemzW7FCj9+7AaHAH6TcSH26nK9rfSwd9p
	Ks95kAK+1pcldDyEbCUPehGtzBMRRLcNf7p7DG3roCxlUZGT/RgLrVgB2ulkKDeQxvnpCUYONoW
	L+ofxAiGRDQ==
X-Received: from dlam20-n1.prod.google.com ([2002:a05:701b:2094:10b0:12d:bd4b:5b09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ff45:b0:128:ca6f:adf2
 with SMTP id a92af1059eb24-12c73fae276mr24695803c88.32.1777157109909; Sat, 25
 Apr 2026 15:45:09 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:44:48 -0700
In-Reply-To: <20260425224503.170337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224503.170337-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224503.170337-2-irogers@google.com>
Subject: [PATCH v7 44/59] perf sctop: Port sctop to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit ports sctop.py from tools/perf/scripts/python/ to
tools/perf/python/ using a class-based structure. It also adds live mode
support using the LiveSession helper with a fallback strategy for
tracepoint names.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
1. Fix Fallback Logic: Check `__syscall_nr` and `nr` fields for syscall ID
   if `id` is missing on fallback tracepoints.
2. Fix Thread Lookup Crash: Added try-except block around `session.process()`
   to handle missing PIDs gracefully.
---
 tools/perf/python/sctop.py | 186 +++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100755 tools/perf/python/sctop.py

diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
new file mode 100755
index 000000000000..b94f66a8307d
--- /dev/null
+++ b/tools/perf/python/sctop.py
@@ -0,0 +1,186 @@
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
+from typing import Optional
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
+        self.session: Optional[perf.session] = None
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
+        if syscall_id == -1:
+            syscall_id = getattr(sample, "__syscall_nr", -1)
+        if syscall_id == -1:
+            syscall_id = getattr(sample, "nr", -1)
+
+        if syscall_id == -1:
+            return
+
+        comm = "Unknown"
+        if hasattr(self, 'session') and self.session:
+            try:
+                proc = self.session.find_thread(sample.sample_pid)
+                if proc:
+                    comm = proc.comm()
+            except (TypeError, AttributeError):
+                pass
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

